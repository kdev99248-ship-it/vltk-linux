--========================
-- Code Rank Edit By VDK 
--========================
Include("\\script\\global\\nobitaxd\\gm\\gm_lib.lua")

RANK_FILE = "data/rankexp.txt"
RANK_FILE_TEMP = "data/rankexp.tmp"
RANK_PHUHAO_FILE = "data/rankphuhao.txt"
RANK_PHUHAO_TEMP = "data/rankphuhao.tmp"

COL_NAME_START, COL_NAME_END = 1, 16
COL_LEVEL_START, COL_LEVEL_END = 18, 22
COL_EXP_START, COL_EXP_END = 24, 33
COL_TIME_START, COL_TIME_END = 35, 54
COL_TICK_START, COL_TICK_END = 56, 66
COL_TRANS_START, COL_TRANS_END = 68, 72
COL_FNO_START, COL_FNO_END = 74, 76
COL_FACTION_START, COL_FACTION_END = 78, 87

trim_right = function(s)
    if not s then return "" end
    s = gsub(s, "\r", "")
    local i = strlen(s)
    while i > 0 and strsub(s, i, i) == " " do
        i = i - 1
    end
    return strsub(s, 1, i)
end

clamp_name16 = function(sz)
    if not sz then return "" end
    if strlen(sz) > 16 then
        return strsub(sz, 1, 16)
    end
    return sz
end

safe_open = function(path, mode)
    return openfile(path, mode)
end

read_all_rank_file_by_name = function(nowTick)
    local byName = {}
    local f = safe_open(RANK_FILE, "r")
    if not f then 
        return byName 
    end

    local lineIndex = 0
    while 1 do
        local line = read(f)
        if not line then break end
        lineIndex = lineIndex + 1
        if lineIndex > 1 then
            local name = trim_right(strsub(line, COL_NAME_START, COL_NAME_END))
            local level = tonumber(trim_right(strsub(line, COL_LEVEL_START, COL_LEVEL_END)))
            local exp = tonumber(trim_right(strsub(line, COL_EXP_START, COL_EXP_END)))
            local timestr = trim_right(strsub(line, COL_TIME_START, COL_TIME_END))
            local lasttk = tonumber(trim_right(strsub(line, COL_TICK_START, COL_TICK_END))) or nowTick
            local trans = tonumber(trim_right(strsub(line, COL_TRANS_START, COL_TRANS_END))) or 0
            local fno = tonumber(trim_right(strsub(line, COL_FNO_START, COL_FNO_END))) or 0
            local faction = trim_right(strsub(line, COL_FACTION_START, COL_FACTION_END)) or ""

            if name ~= "" and level and exp and timestr ~= "" then
                local old = byName[name]
                if (not old) or (lasttk > (old[5] or 0)) then
                    byName[name] = {name, level, exp, timestr, lasttk, trans, faction, fno}
                end
            end
        end
    end
    closefile(f)
    
    return byName
end

write_rank_file_with_purge_name = function(byName, nowTick) 
    
    local arr = {}
    for _, rec in byName do
        tinsert(arr, rec)
    end
    sort(arr, function(a, b)
        local transA = a[6] or 0
        local transB = b[6] or 0
        
        if transA ~= transB then return transA > transB end
        if a[2] ~= b[2] then return a[2] > b[2] end
        if a[3] ~= b[3] then return a[3] > b[3] end
        return a[1] < b[1]
    end)
    local f = safe_open(RANK_FILE_TEMP, "w")
    if not f then return 0 end 
    write(f, format("%-16s %-5s %-10s %-20s %-11s %-5s %-3s %-10s\n",
        "Ten", "Cap", "KinhNghiem", "ThoiGian", "LastTick", "Trans", "FNo", "Faction"))

    for i = 1, getn(arr) do
        local v = arr[i]
        write(f, format("%-16s %-5d %-10d %-20s %-11d %-5d %-3d %-10s\n",
            clamp_name16(v[1] or ""),
            v[2] or 0,
            v[3] or 0,
            v[4] or "",
            v[5] or nowTick,
            v[6] or 0,
            v[8] or 0,
            v[7] or ""))
    end
    closefile(f)
    if os and os.rename and os.rename(RANK_FILE_TEMP, RANK_FILE) then
        return 1
    end
    local f2 = safe_open(RANK_FILE, "w")
    if not f2 then return 0 end
    write(f2, format("%-16s %-5s %-10s %-20s %-11s %-5s %-3s %-10s\n",
        "Ten", "Cap", "KinhNghiem", "ThoiGian", "LastTick", "Trans", "FNo", "Faction"))
    for i = 1, getn(arr) do
        local v = arr[i]
        write(f2, format("%-16s %-5d %-10d %-20s %-11d %-5d %-3d %-10s\n",
            clamp_name16(v[1] or ""),
            v[2] or 0,
            v[3] or 0,
            v[4] or "",
            v[5] or nowTick,
            v[6] or 0,
            v[8] or 0,
            v[7] or ""))
    end
    closefile(f2)
    return 1
end

-- =============================================
-- PHÚ HÀO: Doc/Ghi file rankphuhao.txt
-- =============================================
read_all_phuhao_by_name = function()
    local byName = {}
    local f = safe_open(RANK_PHUHAO_FILE, "r")
    if not f then return byName end

    local lineIndex = 0
    while 1 do
        local line = read(f)
        if not line then break end
        lineIndex = lineIndex + 1
        if lineIndex > 1 then
            local name    = trim_right(strsub(line, 1, 16))
            local money   = tonumber(trim_right(strsub(line, 18, 30)))
            local fno     = tonumber(trim_right(strsub(line, 32, 34))) or 0
            local faction = trim_right(strsub(line, 36, 45))
            if name ~= "" and money then
                byName[name] = {name, money, fno, faction}
            end
        end
    end
    closefile(f)
    return byName
end

write_phuhao_file = function(byName)
    local arr = {}
    for _, rec in byName do
        tinsert(arr, rec)
    end
    sort(arr, function(a, b)
        if a[2] ~= b[2] then return a[2] > b[2] end
        return a[1] < b[1]
    end)

    local f = safe_open(RANK_PHUHAO_TEMP, "w")
    if not f then return 0 end
    write(f, format("%-16s %-13s %-3s %-10s\n", "Ten", "Tien", "FNo", "Faction"))
    for i = 1, getn(arr) do
        local v = arr[i]
        write(f, format("%-16s %-13d %-3d %-10s\n",
            clamp_name16(v[1] or ""), v[2] or 0, v[3] or 0, v[4] or ""))
    end
    closefile(f)

    if os and os.rename and os.rename(RANK_PHUHAO_TEMP, RANK_PHUHAO_FILE) then
        return 1
    end
    local f2 = safe_open(RANK_PHUHAO_FILE, "w")
    if not f2 then return 0 end
    write(f2, format("%-16s %-13s %-3s %-10s\n", "Ten", "Tien", "FNo", "Faction"))
    for i = 1, getn(arr) do
        local v = arr[i]
        write(f2, format("%-16s %-13d %-3d %-10s\n",
            clamp_name16(v[1] or ""), v[2] or 0, v[3] or 0, v[4] or ""))
    end
    closefile(f2)
    return 1
end

getFactionLadderId_PhuHao = function(factionName, factionNo)
    if factionName == "cuiyan" then return 10265 end
    if factionName == "emei" then return 10266 end
    if factionName == "tangmen" then return 10267 end
    if factionName == "wudu" then return 10268 end
    if factionName == "tianwang" then return 10269 end
    if factionName == "shaolin" then return 10270 end
    if factionName == "wudang" then return 10271 end
    if factionName == "kunlun" then return 10272 end
    if factionName == "tianren" then return 10273 end
    if factionName == "gaibang" then return 10274 end    
    return nil
end

capnhat_top_phuhao = function()
    local name = clamp_name16(GetName())
    local factionName = GetFaction() or ""
    local factionNo = GetLastFactionNumber() or 0
    local nMoney = (GetBoxMoney() or 0) + (GetCash() or 0)

    if not name or name == "" then return end

    local szAccount = GetAccount()
    for i = 1, getn(TAB_LIST_GAMEMASTER) do
        if TAB_LIST_GAMEMASTER[i]["Account"] == szAccount then
            return
        end
    end

    local byName = read_all_phuhao_by_name()
    byName[name] = {name, nMoney, factionNo, factionName}
    write_phuhao_file(byName)
end

SaveRank = function()
    local nowTick = GetCurServerTime()
    local name = clamp_name16(GetName())
    local level = GetLevel()
    local exp = GetExp()
    local timestr = GetLocalDate("%Y-%m-%d %H:%M:%S")
    local trans = ST_GetTransLifeCount() or 0
    local factionName = GetFaction() or ""
    local factionNo = GetLastFactionNumber() or 0

    if not (name and level and exp) then return end
    local szAccount = GetAccount()
    for i = 1, getn(TAB_LIST_GAMEMASTER) do
        if TAB_LIST_GAMEMASTER[i]["Account"] == szAccount then
            return 
        end
    end
    local byName = read_all_rank_file_by_name(nowTick)
    byName[name] = {name, level, exp, timestr, nowTick, trans, factionName, factionNo}
    write_rank_file_with_purge_name(byName, nowTick)    
    capnhat_top_phuhao()
end

function SendExpRanking() 
	SaveRank()
    local f = safe_open(RANK_FILE, "r")
    if not f then
        return 0
    end
    
    local tbData = {}
    local lineIndex = 0
    
    while 1 do
        local line = read(f)
        if not line then break end
        lineIndex = lineIndex + 1
        
        if lineIndex > 1 then
            local name  = trim_right(strsub(line, COL_NAME_START, COL_NAME_END))
            local level = tonumber(strsub(line, COL_LEVEL_START, COL_LEVEL_END))
            local exp   = tonumber(strsub(line, COL_EXP_START, COL_EXP_END))
            local trans = tonumber(trim_right(strsub(line, COL_TRANS_START, COL_TRANS_END))) or 0
            
            if name ~= "" and level and exp then
                tinsert(tbData, {name, level, exp, trans})
            end
        end
    end
    closefile(f)
    
    -- Sort theo Trans > Level > Exp > Name
    sort(tbData, function(a, b)
        if a[4] ~= b[4] then return a[4] > b[4] end  -- Trans
        if a[2] ~= b[2] then return a[2] > b[2] end  -- Level
        if a[3] ~= b[3] then return a[3] > b[3] end  -- Exp
        return a[1] < b[1]                            -- Name
    end)
    
    local szData = ""
    for i = 1, getn(tbData) do
        if i == 1 then
            szData = tbData[i][1].."="..i
        else
            szData = szData..","..tbData[i][1].."="..i
        end
    end
    
    local nHandle = OB_Create()
    ObjBuffer:PushByType(nHandle, OBJTYPE_STRING, szData)
    ScriptProtocol:SendData("emSCRIPT_PROTOCOL_EXPRANK_STRING", nHandle)
    OB_Release(nHandle)
end