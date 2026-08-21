#pragma once

#include <cstdint>
#include <memory>
#include <string>

struct RelayConfig {
    std::string backend = "mysql";
    // MySQL connection settings (db_server is "host:port"). Production backend
    // is MySQL, unified with the Linux game database engine.
    std::string db_server = "127.0.0.1:3306";
    std::string db_user = "root";
    std::string db_password;
    std::string db_name = "account_tong";
    std::string db_charset = "utf8mb4";
    // Offline-development safety valve: when true, a ServerList row that exists
    // is accepted even if the peer IP / identity / password do not match. Keep
    // it false for faithful strict verification.
    bool relaxed_verify = false;
};

struct ServerVerifyResult {
    bool ok = false;
    bool found = false;
    bool password_match = false;
    bool ip_match = false;
    bool identity_match = false;
    std::uint32_t id = 0;
    std::string ip;
    std::uint16_t port = 0;
    std::string memo;
};

class RelayStore {
public:
    virtual ~RelayStore() = default;

    virtual ServerVerifyResult verify_server(const std::string& name,
                                             const std::string& password,
                                             const std::string& peer_ip,
                                             std::uint16_t service_port,
                                             const std::string& identity) = 0;
    virtual bool mark_account_online(const std::string& account, std::uint32_t client_id, std::uint32_t user_ip) = 0;
    virtual bool mark_account_offline(const std::string& account) = 0;
    virtual bool account_client_id(const std::string& account, std::uint32_t& client_id) = 0;
    virtual bool account_count(std::uint32_t client_id, bool filter_client_id, std::uint32_t& count) = 0;
    virtual bool get_password(const std::string& account, bool secondary, std::string& password) = 0;
    virtual bool set_password(const std::string& account, bool secondary, const std::string& password) = 0;
    virtual bool set_credentials(const std::string& account,
                                 const std::string& password,
                                 const std::string& secondary,
                                 std::uint32_t user_ip) = 0;
    virtual bool get_account_user_ip(const std::string& account, std::uint32_t& user_ip) = 0;
    virtual bool set_account_user_ip(const std::string& account, std::uint32_t user_ip) = 0;
    virtual bool kickout_account(const std::string& account) = 0;
    virtual bool freeze_account(const std::string& account) = 0;
    virtual bool unlock_account(const std::string& account) = 0;
    virtual const char* backend_name() const = 0;
    // True for the database-backed store that speaks the native Windows Relay
    // protocol to the real gateway. Distinct from backend_name(), which now
    // reports the DB engine ("mysql") rather than the protocol dialect.
    virtual bool native_protocol() const = 0;
};

std::unique_ptr<RelayStore> create_relay_store(const RelayConfig& cfg, const std::string& root);
