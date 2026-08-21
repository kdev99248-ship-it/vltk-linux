#pragma once

#include <cstdint>
#include <memory>
#include <string>

struct AccountConfig {
    bool accept_any_login = true;
    bool enforce_password = true;
    bool realtime_charge = false;
    bool respect_enddate = false;
    int charge_interval = 5;
    // MySQL connection settings (db_server is "host:port"). Production backend
    // is MySQL, unified with the Linux game database engine.
    std::string db_server = "127.0.0.1:3306";
    std::string db_user = "root";
    std::string db_password;
    std::string db_name = "account_tong";
    std::string db_charset = "utf8mb4";
    std::string account_schema = "linux";
};

struct LoginResult {
    std::uint32_t n_return = 2;
    std::uint32_t ext_point = 0;
    std::uint32_t left_second = 0;
    std::uint32_t end_time = 0;
};

class AccountStore {
public:
    virtual ~AccountStore() = default;

    virtual LoginResult login(const std::string& account, const std::string& password, std::uint32_t client_id) = 0;
    virtual void logout(const std::string& account) = 0;
    virtual void tick() = 0;
    virtual const char* backend_name() const = 0;
};

std::unique_ptr<AccountStore> create_account_store(const AccountConfig& cfg, const std::string& root);
