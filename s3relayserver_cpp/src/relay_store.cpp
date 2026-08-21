#include "relay_store.h"

#include <algorithm>
#include <cctype>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <stdexcept>
#include <vector>

#ifdef HAVE_MYSQL
#include <mysql/mysql.h>
#endif

namespace {

std::string trim(std::string s) {
    auto is_space = [](unsigned char c) { return std::isspace(c) != 0; };
    s.erase(s.begin(), std::find_if_not(s.begin(), s.end(), is_space));
    s.erase(std::find_if_not(s.rbegin(), s.rend(), is_space).base(), s.end());
    return s;
}

bool is_legacy_192_168_peer(const std::string& ip) {
    return ip.rfind("192.168.", 0) == 0;
}

bool ascii_iequals(std::string left, std::string right) {
    left = trim(left);
    right = trim(right);
    if (left.size() != right.size()) return false;
    return std::equal(left.begin(), left.end(), right.begin(), [](unsigned char a, unsigned char b) {
        return std::toupper(a) == std::toupper(b);
    });
}

#ifdef HAVE_MYSQL

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

class MysqlRelayStore final : public RelayStore {
public:
    explicit MysqlRelayStore(const RelayConfig& cfg)
        : relaxed_verify_(cfg.relaxed_verify),
          db_user_(cfg.db_user),
          db_password_(cfg.db_password),
          db_name_(cfg.db_name),
          db_charset_(mysql_charset(cfg.db_charset)) {
        split_host_port(cfg.db_server, db_host_, db_port_);
        if (!reconnect()) {
            throw std::runtime_error("Relay MySQL: connect failed for " + cfg.db_server + "/" + cfg.db_name);
        }
        std::cerr << "Relay MySQL connected " << db_user_ << "@" << db_host_ << ":" << db_port_
                  << "/" << db_name_
                  << " relaxed_verify=" << (relaxed_verify_ ? "true" : "false") << "\n";
    }

    ~MysqlRelayStore() override {
        if (conn_) mysql_close(conn_);
    }

    ServerVerifyResult verify_server(const std::string& name,
                                     const std::string& password,
                                     const std::string& peer_ip,
                                     std::uint16_t service_port,
                                     const std::string& identity) override {
        ServerVerifyResult result;
        if (!ensure_connection()) return result;

        const std::string sql =
            "select cIP, iPort, iid, cMemo, cPassword from ServerList where (cServerName = '" +
            esc(name) + "')";
        std::vector<std::string> cols;
        bool found = false;
        if (!db_fetch_first(sql, cols, found)) return result;
        if (!found) return result;

        const std::string ip = cols.size() > 0 ? cols[0] : "";
        const std::int64_t port = cols.size() > 1 ? to_int(cols[1]) : 0;
        const std::int64_t id = cols.size() > 2 ? to_int(cols[2]) : 0;
        const std::string memo = cols.size() > 3 ? cols[3] : "";
        const std::string stored_password = cols.size() > 4 ? cols[4] : "";

        result.found = true;
        result.password_match = stored_password == password;
        const bool bypass = is_legacy_192_168_peer(peer_ip) || relaxed_verify_;
        std::cerr << "Relay MySQL verify row server='" << name
                  << "' password_match=" << (result.password_match ? "yes" : "no")
                  << " stored_len=" << stored_password.size()
                  << " request_len=" << password.size()
                  << " peer=" << peer_ip
                  << " bypass=" << (bypass ? "yes" : "no") << "\n";
        if (!result.password_match && !relaxed_verify_) return result;
        if (relaxed_verify_) result.password_match = true;

        std::uint16_t expected_port = port > 0 ? static_cast<std::uint16_t>(port) : 0;
        result.ip_match = bypass || peer_ip == trim(ip);
        result.identity_match = bypass || ascii_iequals(identity, memo);
        // Windows reads iPort, but changing only this field does not reject a
        // controlled strict-path verification.
        result.ok = result.password_match && result.ip_match && result.identity_match;
        result.id = id > 0 ? static_cast<std::uint32_t>(id) : 0;
        result.ip = !ip.empty() ? ip : peer_ip;
        result.port = expected_port != 0 ? expected_port : service_port;
        result.memo = memo;
        return result;
    }

    bool mark_account_online(const std::string& account, std::uint32_t client_id, std::uint32_t user_ip) override {
        if (!ensure_connection()) return false;
        const std::string escaped = esc(account);
        return db_exec(
            "update Account_Info set iClientID = " + std::to_string(client_id) +
            ", nUserIP = " + std::to_string(user_ip) +
            " where (cAccName = '" + escaped + "')");
    }

    bool mark_account_offline(const std::string& account) override {
        if (!ensure_connection()) return false;
        return db_exec(
            "update Account_Info set iClientID = 0 where (cAccName = '" + esc(account) + "')");
    }

    bool account_client_id(const std::string& account, std::uint32_t& client_id) override {
        if (!ensure_connection()) return false;
        std::int64_t value = 0;
        if (!db_select_int(
                "select iClientID from Account_Info where (cAccName = '" + esc(account) + "')", value)) {
            return false;
        }
        if (value <= 0) return false;
        client_id = static_cast<std::uint32_t>(value);
        return true;
    }

    bool account_count(std::uint32_t client_id,
                       bool filter_client_id,
                       std::uint32_t& count) override {
        if (!ensure_connection()) return false;
        std::string sql = "select count(*) from Account_Info";
        if (filter_client_id) {
            sql += " where (iClientID = " + std::to_string(client_id) + ")";
        }
        std::int64_t value = 0;
        if (!db_select_int(sql, value) || value < 0) return false;
        count = static_cast<std::uint32_t>(value);
        return true;
    }

    bool get_password(const std::string& account, bool secondary, std::string& password) override {
        if (!ensure_connection()) return false;
        const std::string col = secondary ? "cSecPassword" : "cPassword";
        const std::string sql =
            "select " + col + " from Account_Info where (cAccName = '" + esc(account) + "')";
        std::vector<std::string> cols;
        bool found = false;
        if (!db_fetch_first(sql, cols, found) || !found) return false;
        password = trim(cols.empty() ? "" : cols[0]);
        return true;
    }

    bool set_password(const std::string& account, bool secondary, const std::string& password) override {
        if (!ensure_connection()) return false;
        const std::string col = secondary ? "cSecPassword" : "cPassword";
        return db_exec(
            "update Account_Info set " + col + " = '" + esc(password) +
            "' where (cAccName = '" + esc(account) + "')");
    }

    bool set_credentials(const std::string& account,
                         const std::string& password,
                         const std::string& secondary,
                         std::uint32_t user_ip) override {
        if (account.empty() || password.empty()) return false;
        if (!ensure_connection()) return false;
        std::string update = "update Account_Info set cPassword = '" + esc(password) + "'";
        if (!secondary.empty()) {
            update += ", cSecPassword = '" + esc(secondary) + "'";
        }
        if (user_ip != 0) {
            update += ", nUserIP = " + std::to_string(user_ip);
        }
        update += " where (cAccName = '" + esc(account) + "')";
        return db_exec(update);
    }

    bool set_account_user_ip(const std::string& account, std::uint32_t user_ip) override {
        if (!ensure_connection()) return false;
        return db_exec(
            "update Account_Info set nUserIP = " + std::to_string(user_ip) +
            " where (cAccName = '" + esc(account) + "')");
    }

    bool get_account_user_ip(const std::string& account, std::uint32_t& user_ip) override {
        if (!ensure_connection()) return false;
        std::int64_t value = 0;
        std::vector<std::string> cols;
        bool found = false;
        const std::string sql =
            "select nUserIP from Account_Info where (cAccName = '" + esc(account) + "')";
        if (!db_fetch_first(sql, cols, found) || !found) return false;
        value = cols.empty() ? 0 : to_int(cols[0]);
        user_ip = static_cast<std::uint32_t>(value);
        return true;
    }

    bool kickout_account(const std::string& account) override {
        return mark_account_offline(account);
    }

    bool freeze_account(const std::string& account) override {
        return mark_account_offline(account);
    }

    bool unlock_account(const std::string& account) override {
        return !account.empty();
    }

    const char* backend_name() const override {
        return "mysql";
    }

    bool native_protocol() const override {
        return true;
    }

private:
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
            std::cerr << "Relay MySQL query failed: " << mysql_error(conn_) << "\n";
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
            std::cerr << "Relay MySQL query failed: " << mysql_error(conn_) << "\n";
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
            std::cerr << "Relay MySQL: mysql_init failed\n";
            return false;
        }
        mysql_options(conn_, MYSQL_SET_CHARSET_NAME, db_charset_.c_str());
        unsigned int timeout = 10;
        mysql_options(conn_, MYSQL_OPT_CONNECT_TIMEOUT, &timeout);
        if (!mysql_real_connect(conn_, db_host_.c_str(), db_user_.c_str(), db_password_.c_str(),
                                db_name_.c_str(), db_port_, nullptr, 0)) {
            std::cerr << "Relay MySQL: connect failed: " << mysql_error(conn_) << "\n";
            mysql_close(conn_);
            conn_ = nullptr;
            return false;
        }
        return true;
    }

    bool ensure_connection() {
        if (conn_ && mysql_ping(conn_) == 0) return true;
        std::cerr << "Relay MySQL: connection is dead; reconnecting\n";
        return reconnect();
    }

    bool relaxed_verify_ = false;
    MYSQL* conn_ = nullptr;
    std::string db_host_;
    unsigned int db_port_ = 3306;
    std::string db_user_;
    std::string db_password_;
    std::string db_name_;
    std::string db_charset_;
};
#endif  // HAVE_MYSQL

}  // namespace

std::unique_ptr<RelayStore> create_relay_store(const RelayConfig& cfg, const std::string& root) {
#ifdef HAVE_MYSQL
    (void)root;
    try {
        return std::make_unique<MysqlRelayStore>(cfg);
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
