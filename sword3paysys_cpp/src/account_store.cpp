#include "account_store.h"

#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <cstring>
#include <iostream>
#include <stdexcept>
#include <unordered_map>
#include <vector>

#ifdef HAVE_MYSQL
#include <mysql/mysql.h>
#endif

namespace {

struct OnlineSession {
    std::uint32_t client_id = 0;
    std::time_t login_time = 0;
    std::uint32_t initial_left = 0;
};

bool credential_matches(const std::string& client, const std::string& stored) {
    if (client == stored) return true;
    // The legacy client transmits the uppercase 29-character tail of its
    // 32-character MD5 credential; the database stores the complete digest.
    return stored.size() == 32 && client.size() == 29 && stored.substr(3) == client;
}

std::string trim(std::string s) {
    auto is_space = [](unsigned char c) { return std::isspace(c) != 0; };
    s.erase(s.begin(), std::find_if_not(s.begin(), s.end(), is_space));
    s.erase(std::find_if_not(s.rbegin(), s.rend(), is_space).base(), s.end());
    return s;
}

#ifdef HAVE_MYSQL

// The account config carries the DB endpoint as "host:port"; split it so the
// MySQL client can take a real port number instead of MSSQL's host string.
void split_host_port(const std::string& endpoint, std::string& host, unsigned int& port) {
    host = endpoint;
    port = 3306;
    auto colon = endpoint.rfind(':');
    if (colon != std::string::npos) {
        host = endpoint.substr(0, colon);
        const std::string port_str = endpoint.substr(colon + 1);
        if (!port_str.empty()) {
            port = static_cast<unsigned int>(std::strtoul(port_str.c_str(), nullptr, 10));
            if (port == 0) port = 3306;
        }
    }
    if (host.empty()) host = "127.0.0.1";
}

// MSSQL charset names such as "UTF-8" are not valid MySQL charset identifiers.
std::string mysql_charset(const std::string& configured) {
    std::string lower = configured;
    std::transform(lower.begin(), lower.end(), lower.begin(),
                   [](unsigned char c) { return std::tolower(c); });
    if (lower.empty() || lower == "utf-8" || lower == "utf8") return "utf8mb4";
    return configured;
}

std::int64_t to_int(const std::string& value) {
    if (value.empty()) return 0;
    return std::strtoll(value.c_str(), nullptr, 10);
}

class MysqlAccountStore final : public AccountStore {
public:
    explicit MysqlAccountStore(const AccountConfig& cfg)
        : realtime_charge_(cfg.realtime_charge),
          respect_enddate_(cfg.respect_enddate),
          enforce_password_(cfg.enforce_password),
          windows_schema_(cfg.account_schema == "windows"),
          charge_interval_(std::max(1, cfg.charge_interval)),
          db_user_(cfg.db_user),
          db_password_(cfg.db_password),
          db_name_(cfg.db_name),
          db_charset_(mysql_charset(cfg.db_charset)) {
        split_host_port(cfg.db_server, db_host_, db_port_);
        if (!reconnect()) {
            throw std::runtime_error("MySQL: connect failed for " + cfg.db_server + "/" + cfg.db_name);
        }
        std::cerr << "MySQL connected " << db_user_ << "@" << db_host_ << ":" << db_port_
                  << "/" << db_name_
                  << " account_schema=" << (windows_schema_ ? "windows" : "linux")
                  << " enforce_password=" << (enforce_password_ ? "true" : "false") << "\n";
        reset_online_state();
    }

    ~MysqlAccountStore() override {
        if (conn_) mysql_close(conn_);
    }

    LoginResult login(const std::string& account, const std::string& password, std::uint32_t client_id) override {
        if (!ensure_connection()) {
            LoginResult failed;
            failed.n_return = 2;
            return failed;
        }

        LoginResult result = windows_schema_
            ? login_windows_schema(account, password, client_id)
            : login_linux_schema(account, password, client_id);
        if (result.n_return == 2 && reconnect()) {
            std::cerr << "MySQL: retrying account login after reconnect\n";
            result = windows_schema_
                ? login_windows_schema(account, password, client_id)
                : login_linux_schema(account, password, client_id);
        }
        return result;
    }

    LoginResult login_linux_schema(const std::string& account, const std::string& password,
                                   std::uint32_t client_id) {
        LoginResult result;
        if (!conn_) return result;
        if (account.empty()) {
            result.n_return = 3;
            return result;
        }

        const std::string escaped = esc(account);
        const std::string sql =
            "SELECT a.cPassWord, a.nExtPoint, a.iClientID, "
            "IFNULL(h.iLeftSecond,0), "
            "IFNULL(TIMESTAMPDIFF(SECOND, NOW(), h.dEndDate),0) "
            "FROM Account_Info a "
            "LEFT JOIN Account_Habitus h ON a.cAccName=h.cAccName "
            "WHERE a.cAccName='" + escaped + "'";

        std::vector<std::string> cols;
        bool row_found = false;
        if (!db_fetch_first(sql, cols, row_found)) {
            result.n_return = 2;
            return result;
        }
        if (!row_found) {
            result.n_return = 3;
            return result;
        }

        std::string stored_password = trim(cols.size() > 0 ? cols[0] : "");
        const std::int64_t ext_point = cols.size() > 1 ? to_int(cols[1]) : 0;
        const std::int64_t left_second = cols.size() > 3 ? to_int(cols[3]) : 0;
        const std::int64_t end_remaining = cols.size() > 4 ? to_int(cols[4]) : 0;

        if (enforce_password_ && !stored_password.empty() && !credential_matches(password, stored_password)) {
            result.n_return = 4;
            result.ext_point = ext_point > 0 ? static_cast<std::uint32_t>(ext_point) : 0;
            return result;
        }

        std::uint32_t left = 0;
        if (end_remaining > 0) left += static_cast<std::uint32_t>(end_remaining);
        if (left_second > 0) left += static_cast<std::uint32_t>(left_second);
        if (left <= 0x708) left = 0x57e40;

        const std::string update =
            "UPDATE Account_Info SET iClientID=" + std::to_string(client_id) +
            ", dLoginDate=NOW() WHERE cAccName='" + escaped + "'";
        if (!db_exec(update)) {
            result.n_return = 2;
            return result;
        }

        auto now = static_cast<std::uint32_t>(std::time(nullptr));
        result.n_return = 1;
        result.ext_point = ext_point > 0 ? static_cast<std::uint32_t>(ext_point) : 0;
        result.left_second = left;
        result.end_time = now + left;
        online_[account] = OnlineSession{client_id, std::time(nullptr), left};
        return result;
    }

    void logout(const std::string& account) override {
        auto session_it = online_.find(account);
        std::uint32_t used = 0;
        std::uint32_t client_id = 0;
        if (session_it != online_.end()) {
            client_id = session_it->second.client_id;
            std::time_t now = std::time(nullptr);
            if (now > session_it->second.login_time) {
                used = static_cast<std::uint32_t>(now - session_it->second.login_time);
            }
        }

        if (!commit_logout(account, client_id, used)) {
            std::cerr << "MySQL: atomic logout failed for " << account
                      << "; preserving in-memory session for retry\n";
            return;
        }
        if (session_it != online_.end()) online_.erase(session_it);
    }

    void tick() override {
        if (!realtime_charge_) return;

        std::time_t now = std::time(nullptr);
        if (now - last_charge_time_ < charge_interval_) return;
        last_charge_time_ = now;

        for (auto& [account, session] : online_) {
            if (now <= session.login_time) continue;
            std::uint32_t used = static_cast<std::uint32_t>(now - session.login_time);
            if (update_habitus_usage(account, used)) {
                session.login_time = now;
            }
        }
    }

    const char* backend_name() const override {
        return "mysql";
    }

private:
    // ---- MySQL plumbing -------------------------------------------------

    std::string esc(const std::string& value) const {
        if (!conn_) return value;
        std::vector<char> buffer(value.size() * 2 + 1);
        unsigned long len = mysql_real_escape_string(conn_, buffer.data(), value.c_str(),
                                                      static_cast<unsigned long>(value.size()));
        return std::string(buffer.data(), len);
    }

    bool db_exec(const std::string& sql) {
        if (!conn_) return false;
        if (mysql_query(conn_, sql.c_str()) != 0) {
            std::cerr << "MySQL query failed: " << mysql_error(conn_) << "\n";
            return false;
        }
        if (MYSQL_RES* res = mysql_store_result(conn_)) mysql_free_result(res);
        return true;
    }

    bool db_fetch_first(const std::string& sql, std::vector<std::string>& out, bool& found) {
        found = false;
        out.clear();
        if (!conn_) return false;
        if (mysql_query(conn_, sql.c_str()) != 0) {
            std::cerr << "MySQL query failed: " << mysql_error(conn_) << "\n";
            return false;
        }
        MYSQL_RES* res = mysql_store_result(conn_);
        if (!res) return mysql_field_count(conn_) == 0;
        if (MYSQL_ROW row = mysql_fetch_row(res)) {
            found = true;
            unsigned int n = mysql_num_fields(res);
            unsigned long* lengths = mysql_fetch_lengths(res);
            out.reserve(n);
            for (unsigned int i = 0; i < n; ++i) {
                out.emplace_back(row[i] ? std::string(row[i], lengths[i]) : std::string());
            }
        }
        mysql_free_result(res);
        return true;
    }

    bool db_select_int(const std::string& sql, std::int64_t& value) {
        std::vector<std::string> cols;
        bool found = false;
        if (!db_fetch_first(sql, cols, found)) return false;
        value = (found && !cols.empty()) ? to_int(cols[0]) : 0;
        return found;
    }

    bool reconnect() {
        if (conn_) {
            mysql_close(conn_);
            conn_ = nullptr;
        }
        conn_ = mysql_init(nullptr);
        if (!conn_) {
            std::cerr << "MySQL: mysql_init failed\n";
            return false;
        }
        mysql_options(conn_, MYSQL_SET_CHARSET_NAME, db_charset_.c_str());
        unsigned int timeout = 10;
        mysql_options(conn_, MYSQL_OPT_CONNECT_TIMEOUT, &timeout);
        if (!mysql_real_connect(conn_, db_host_.c_str(), db_user_.c_str(), db_password_.c_str(),
                                db_name_.c_str(), db_port_, nullptr, 0)) {
            std::cerr << "MySQL: connect failed: " << mysql_error(conn_) << "\n";
            mysql_close(conn_);
            conn_ = nullptr;
            return false;
        }
        return true;
    }

    bool ensure_connection() {
        if (conn_ && mysql_ping(conn_) == 0) return true;
        std::cerr << "MySQL: connection is dead; reconnecting\n";
        return reconnect();
    }

    void reset_online_state() {
        if (!conn_) return;
        const std::string sql =
            "UPDATE Account_Info SET iClientID=0, dLogoutDate=NOW() WHERE iClientID<>0";
        if (!db_exec(sql)) {
            std::cerr << "MySQL: reset iClientID=0 failed\n";
        } else {
            std::cerr << "MySQL: reset iClientID=0 for online accounts\n";
        }
    }

    // ---- Billing / logout ----------------------------------------------

    bool commit_logout(const std::string& account,
                       std::uint32_t client_id,
                       std::uint32_t used_seconds) {
        if (account.empty() || !ensure_connection()) return false;
        const std::string escaped = esc(account);
        const std::string used = std::to_string(used_seconds);

        if (!db_exec("START TRANSACTION")) return false;

        bool ok = true;
        if (used_seconds > 0) {
            std::string mutation;
            if (windows_schema_) {
                mutation =
                    "UPDATE View_AccountMoney SET iLeftSecond = iLeftSecond - " + used +
                    " WHERE (cAccName = '" + escaped + "') "
                    "AND (TIMESTAMPDIFF(SECOND, NOW(), dEndDate) <= 0) "
                    "AND (iClientID = " + std::to_string(client_id) + ")";
            } else {
                mutation =
                    "UPDATE Account_Habitus SET "
                    "iUseSecond = IFNULL(iUseSecond,0) + CASE WHEN iLeftSecond >= " + used +
                    " THEN " + used + " ELSE iLeftSecond END, "
                    "iLeftSecond = CASE WHEN iLeftSecond >= " + used +
                    " THEN iLeftSecond - " + used + " ELSE 0 END "
                    "WHERE cAccName='" + escaped + "' AND IFNULL(iLeftSecond,0) > 0";
                if (respect_enddate_) {
                    mutation += " AND TIMESTAMPDIFF(SECOND, NOW(), dEndDate) <= 0";
                }
            }
            ok = db_exec(mutation);
        }

        if (ok) {
            ok = db_exec("UPDATE Account_Info SET iClientID=0, dLogoutDate=NOW() "
                         "WHERE cAccName='" + escaped + "'");
        }

        if (!ok) {
            db_exec("ROLLBACK");
            return false;
        }
        if (!db_exec("COMMIT")) return false;

        if (used_seconds > 0) {
            if (windows_schema_) {
                std::cerr << "[gio] '" << account << "' dung them " << used_seconds
                          << "s theo View_AccountMoney (atomic logout)\n";
            } else {
                std::int64_t after_left = 0;
                if (select_left_second(escaped, after_left)) {
                    std::cerr << "[gio] '" << account << "' dung them " << used_seconds
                              << "s -> con " << after_left << " giay ("
                              << (static_cast<double>(after_left) / 3600.0)
                              << " gio, atomic logout)\n";
                }
            }
        }
        return true;
    }

    bool update_habitus_usage(const std::string& account, std::uint32_t used_seconds) {
        if (windows_schema_) return update_windows_usage(account, used_seconds);
        if (!conn_ || account.empty() || used_seconds == 0) return false;
        const std::string escaped = esc(account);
        const std::string used = std::to_string(used_seconds);
        std::int64_t before_left = 0;
        bool have_before_left = select_left_second(escaped, before_left);
        std::string habitus =
            "UPDATE Account_Habitus SET "
            "iUseSecond = IFNULL(iUseSecond,0) + CASE WHEN iLeftSecond >= " + used +
            " THEN " + used + " ELSE iLeftSecond END, "
            "iLeftSecond = CASE WHEN iLeftSecond >= " + used +
            " THEN iLeftSecond - " + used + " ELSE 0 END "
            "WHERE cAccName='" + escaped + "' AND IFNULL(iLeftSecond,0) > 0";
        if (respect_enddate_) {
            habitus += " AND TIMESTAMPDIFF(SECOND, NOW(), dEndDate) <= 0";
        }
        if (!db_exec(habitus)) {
            std::cerr << "MySQL: Account_Habitus update failed for " << account << "\n";
            return false;
        }
        std::int64_t after_left = 0;
        bool have_after_left = select_left_second(escaped, after_left);
        if (have_after_left) {
            std::cerr << "[gio] '" << account << "' dung them " << used_seconds
                      << "s -> con " << after_left << " giay ("
                      << (static_cast<double>(after_left) / 3600.0) << " gio)\n";
        } else if (have_before_left) {
            std::int64_t estimated = before_left > static_cast<std::int64_t>(used_seconds)
                                         ? before_left - static_cast<std::int64_t>(used_seconds)
                                         : 0;
            std::cerr << "[gio] '" << account << "' dung them " << used_seconds
                      << "s -> con " << estimated << " giay (estimated)\n";
        }
        return true;
    }

    bool select_left_second(const std::string& escaped_account, std::int64_t& left_second) {
        const std::string sql =
            "SELECT IFNULL(iLeftSecond,0) FROM Account_Habitus WHERE cAccName='" + escaped_account + "'";
        return db_select_int(sql, left_second);
    }

    // ---- Windows schema (only when account_schema=windows) --------------

    LoginResult login_windows_schema(const std::string& account, const std::string& password,
                                     std::uint32_t client_id) {
        LoginResult result;
        if (!conn_) return result;
        if (account.empty()) {
            result.n_return = 3;
            return result;
        }

        const std::string escaped_account = esc(account);
        const std::string escaped_password = esc(password);

        std::int64_t current_client = 0;
        if (db_select_int(
                "select iClientID from Account_Info where (cAccName = '" + escaped_account + "')",
                current_client) &&
            current_client > 0 && current_client != static_cast<std::int64_t>(client_id)) {
            result.n_return = 6;
            return result;
        }

        if (enforce_password_) {
            std::vector<std::string> cols;
            bool password_ok = false;
            const std::string password_sql =
                "select cAccName from Account_Info where (cAccName = '" + escaped_account +
                "') and (BINARY cSecPassword = '" + escaped_password + "')";
            if (!db_fetch_first(password_sql, cols, password_ok)) {
                result.n_return = 2;
                return result;
            }
            if (!password_ok) {
                result.n_return = 3;
                return result;
            }
        }

        std::vector<std::string> money;
        bool money_found = false;
        const std::string money_sql =
            "select TIMESTAMPDIFF(SECOND, NOW(), dEndDate), iLeftSecond, nExtPoint "
            "from View_AccountMoney where (cAccName = '" + escaped_account + "')";
        if (!db_fetch_first(money_sql, money, money_found) || !money_found) {
            result.n_return = 5;
            return result;
        }
        const std::int64_t end_remaining = money.size() > 0 ? to_int(money[0]) : 0;
        const std::int64_t left_second = money.size() > 1 ? to_int(money[1]) : 0;
        const std::int64_t ext_point = money.size() > 2 ? to_int(money[2]) : 0;

        std::uint32_t left = 0;
        if (end_remaining > 0) left += static_cast<std::uint32_t>(end_remaining);
        if (left_second > 0) left += static_cast<std::uint32_t>(left_second);
        if (left <= 0x708) left = 0x57e40;

        const std::string update =
            "UPDATE Account_Info SET iClientID=" + std::to_string(client_id) +
            ", dLoginDate=NOW() WHERE cAccName='" + escaped_account + "'";
        if (!db_exec(update)) {
            result.n_return = 2;
            return result;
        }

        auto now = static_cast<std::uint32_t>(std::time(nullptr));
        result.n_return = 1;
        result.ext_point = ext_point > 0 ? static_cast<std::uint32_t>(ext_point) : 0;
        result.left_second = left;
        result.end_time = now + left;
        online_[account] = OnlineSession{client_id, std::time(nullptr), left};
        return result;
    }

    bool update_windows_usage(const std::string& account, std::uint32_t used_seconds) {
        if (!conn_ || account.empty() || used_seconds == 0) return false;
        auto it = online_.find(account);
        std::uint32_t client_id = it == online_.end() ? 0 : it->second.client_id;
        const std::string escaped = esc(account);
        const std::string sql =
            "update View_AccountMoney set iLeftSecond = iLeftSecond - " + std::to_string(used_seconds) +
            " where (cAccName = '" + escaped + "') "
            "and (TIMESTAMPDIFF(SECOND, NOW(), dEndDate) <= 0) "
            "and (iClientID = " + std::to_string(client_id) + ")";
        if (!db_exec(sql)) {
            std::cerr << "MySQL: Windows View_AccountMoney update failed for " << account << "\n";
            return false;
        }
        std::cerr << "[gio] '" << account << "' dung them " << used_seconds
                  << "s theo View_AccountMoney\n";
        return true;
    }

    MYSQL* conn_ = nullptr;
    bool realtime_charge_ = false;
    bool respect_enddate_ = false;
    bool enforce_password_ = true;
    bool windows_schema_ = false;
    int charge_interval_ = 5;
    std::time_t last_charge_time_ = 0;
    std::string db_host_;
    unsigned int db_port_ = 3306;
    std::string db_user_;
    std::string db_password_;
    std::string db_name_;
    std::string db_charset_;
    std::unordered_map<std::string, OnlineSession> online_;
};
#endif  // HAVE_MYSQL

}  // namespace

std::unique_ptr<AccountStore> create_account_store(const AccountConfig& cfg, const std::string& root) {
#ifdef HAVE_MYSQL
    (void)root;
    try {
        return std::make_unique<MysqlAccountStore>(cfg);
    } catch (const std::exception& e) {
        std::cerr << e.what() << "\n";
        throw;
    }
#else
    (void)cfg;
    (void)root;
    throw std::runtime_error("MySQL support is required; libmysqlclient was not found");
#endif
}
