RankHook = {	
	RANK_FILE = "../../server1/data/rankexp.txt",
	PHUHAO_FILE = "../../server1/data/rankphuhao.txt",
	
	COL_NAME_START    = 1,
	COL_NAME_END      = 16,
	COL_LEVEL_START   = 18,
	COL_LEVEL_END     = 22,
	COL_EXP_START     = 24,
	COL_EXP_END       = 33,
	COL_TRANS_START   = 68,
	COL_TRANS_END     = 72,
	COL_FNO_START     = 74,
	COL_FNO_END       = 76,
	COL_FACTION_START = 78,
	COL_FACTION_END   = 87,
	
	tbFactionLadders = {
		shaolin  = 10277,
		tianwang = 10278,
		tangmen  = 10279,
		wudu     = 10280,
		emei     = 10281,
		cuiyan   = 10282,
		gaibang  = 10283,
		tianren  = 10284,
		wudang   = 10285,
		kunlun   = 10286,
	},
	
	tbFactionLadders_PhuHao = {
		cuiyan   = 10265,
		emei     = 10266,
		tangmen  = 10267,
		wudu     = 10268,
		tianwang = 10269,
		shaolin  = 10270,
		wudang   = 10271,
		kunlun   = 10272,
		tianren  = 10273,
		gaibang  = 10274,
	},
	
	tbConvertRank = {
		{10489, 10282},
		{10488, 10281},
		{10487, 10279},
		{10486, 10280},
		{10485, 10278},
		{10484, 10277},
		{10483, 10285},
		{10482, 10286},
		{10481, 10284},
		{10480, 10283},
	},
	
	_nAllowConvertRank = 0,
	Write2Logs = 0,
}

function RankHook:UpdateData(Name, Level, Percent, Trans)
	return
end

function RankHook:TrimRight(s)
	if not s then return "" end
	s = gsub(s, "\r", "")
	local i = strlen(s)
	while i > 0 and strsub(s, i, i) == " " do
		i = i - 1
	end
	return strsub(s, 1, i)
end

function RankHook:GetFactionLadderId(factionName, factionNo)
	if self.tbFactionLadders[factionName] then
		return self.tbFactionLadders[factionName]
	elseif factionNo == 10 then
		return 10282 
	end
	return nil
end

function RankHook:FormatMoney(nMoney)
	local van   = floor(nMoney / 10000)
	local luong = mod(nMoney, 10000)
	if van > 0 then
		return format("%d v¹n %d l­îng", van, luong)
	else
		return format("%d l­îng", luong)
	end
end

function RankHook:ReadRankFile()
	local f = openfile(self.RANK_FILE, "r")
	if not f then
		print("=====> Loi: Khong Tim Thay File "..self.RANK_FILE)
		return nil
	end
	
	local tbData = {}
	local lineIndex = 0
	
	while 1 do
		local line = read(f)
		if not line then break end		
		lineIndex = lineIndex + 1
				
		if lineIndex > 1 then			
			local name    = self:TrimRight(strsub(line, self.COL_NAME_START, self.COL_NAME_END))
			local level   = tonumber(self:TrimRight(strsub(line, self.COL_LEVEL_START, self.COL_LEVEL_END)))
			local exp     = tonumber(self:TrimRight(strsub(line, self.COL_EXP_START, self.COL_EXP_END)))
			local trans   = tonumber(self:TrimRight(strsub(line, self.COL_TRANS_START, self.COL_TRANS_END))) or 0
			local fno     = tonumber(self:TrimRight(strsub(line, self.COL_FNO_START, self.COL_FNO_END))) or 0
			local faction = self:TrimRight(strsub(line, self.COL_FACTION_START, self.COL_FACTION_END))
					
			if name ~= "" and level and exp then
				tinsert(tbData, {
					name    = name,
					level   = level,
					exp     = exp,
					trans   = trans,
					faction = faction,
					fno     = fno,
				})
			end
		end
	end	
	closefile(f)
	return tbData
end

function RankHook:ReadPhuHaoFile()
	local f = openfile(self.PHUHAO_FILE, "r")
	if not f then
		print("=====> Loi: Khong Tim Thay File "..self.PHUHAO_FILE)
		return nil
	end

	local tbData = {}
	local lineIndex = 0
	while 1 do
		local line = read(f)
		if not line then break end
		lineIndex = lineIndex + 1
		if lineIndex > 1 then
			local name    = self:TrimRight(strsub(line, 1, 16))
			local money   = tonumber(self:TrimRight(strsub(line, 18, 30)))
			local fno     = tonumber(self:TrimRight(strsub(line, 32, 34))) or 0
			local faction = self:TrimRight(strsub(line, 36, 45))
			if name ~= "" and money and money > 0 then
				tinsert(tbData, {
					name    = name,
					money   = money,
					fno     = fno,
					faction = faction,
				})
			end
		end
	end
	closefile(f)
	return tbData
end

function RankHook:UpdateRank()
	print("=====> Bat Dau Cap Nhat Bang Xep Hang...")
	
	-- =============================================
	-- TOP CAO THU + TOP MON PHAI (Level/Trans)
	-- =============================================
	local tbData = self:ReadRankFile()
	if not tbData or getn(tbData) == 0 then
		print("=====> Khong Co Du Lieu!")
		return
	end	
	sort(tbData, function(a, b)
		if a.trans ~= b.trans then return a.trans > b.trans end
		if a.level ~= b.level then return a.level > b.level end
		if a.exp ~= b.exp then return a.exp > b.exp end
		return a.name < b.name
	end)	
	
	-- Top 10 cao thu tong
	Ladder_ClearLadder(10287)	
	for iTop = 1, 10 do
		if not tbData[iTop] then break end
		local v = tbData[iTop]
		local displayName = format("%d %s", iTop, v.name)
		if self._nAllowConvertRank == 1 then
			Ladder_NewLadder(10287, displayName, tonumber("1."..(11-iTop)), 1)
		else
			Ladder_NewLadder(10287, displayName, v.level, 1, 0)
		end				
	end
	
	-- Top 10 cao thu theo mon phai
	local perFaction = {}
	for i = 1, getn(tbData) do
		local v = tbData[i]
		local ladderId = self:GetFactionLadderId(v.faction, v.fno)
		if ladderId then
			if not perFaction[ladderId] then
				perFaction[ladderId] = {}
			end					
			local displayLevel = v.level + (v.trans * 200)
			tinsert(perFaction[ladderId], {
				name         = v.name,
				level        = v.level,
				exp          = v.exp,
				trans        = v.trans,
				displayLevel = displayLevel,
				fno          = v.fno,
			})
		end
	end
	for ladderId, list in perFaction do
		Ladder_ClearLadder(ladderId)
		sort(list, function(a, b)
			if a.displayLevel ~= b.displayLevel then return a.displayLevel > b.displayLevel end
			return a.exp > b.exp
		end)
		for i = 1, 10 do
			if not list[i] then break end
			local v = list[i]
			local displayName = format("%d %s", i, v.name)
			if self._nAllowConvertRank == 1 then
				Ladder_NewLadder(ladderId, displayName, tonumber("1."..(11-i)), 1)
			else
				Ladder_NewLadder(ladderId, displayName, v.level, 1, v.fno)
			end
		end
	end
	
	print("=====> Xep Hang Hien Tai Co: "..getn(tbData).." Nguoi.")

	-- =============================================
	-- TOP PHU HAO + TOP MON PHAI PHU HAO
	-- =============================================
	local tbPhuHao = self:ReadPhuHaoFile()
	if tbPhuHao and getn(tbPhuHao) > 0 then

		sort(tbPhuHao, function(a, b)
			if a.money ~= b.money then return a.money > b.money end
			return a.name < b.name
		end)

		-- Top 10 phu hao tong
		Ladder_ClearLadder(10288)
		for i = 1, 10 do
			if not tbPhuHao[i] then break end
			local v = tbPhuHao[i]
			local van = floor(v.money / 10000)
			if van < 1 then break end
			local displayName = format("%d %s", i, v.name)
			Ladder_NewLadder(10288, displayName, van, 0)
		end

		-- Build bang phu hao theo mon phai
		local perFactionPH = {}
		for i = 1, getn(tbPhuHao) do
			local v = tbPhuHao[i]
			if v.faction and v.faction ~= "" then
				local ladderId = self.tbFactionLadders_PhuHao[v.faction]
				if ladderId then
					if not perFactionPH[ladderId] then
						perFactionPH[ladderId] = {}
					end
					tinsert(perFactionPH[ladderId], v)
				end
			end
		end

		-- Top 10 phu hao theo mon phai
		for ladderId, list in perFactionPH do
			Ladder_ClearLadder(ladderId)
			sort(list, function(a, b)
				if a.money ~= b.money then return a.money > b.money end
				return a.name < b.name
			end)
			local idx = 0
			for i = 1, getn(list) do
				if idx >= 10 then break end
				local v = list[i]
				local van = floor(v.money / 10000)
				if van < 1 then break end
				idx = idx + 1
				local displayName = format("%d %s", idx, v.name)
				Ladder_NewLadder(ladderId, displayName, van, 1, v.fno)
			end
		end

		print("=====> Xep Hang Phu Hao Hien Tai Co: "..getn(tbPhuHao).." Nguoi.")
	else
		print("=====> Khong Co Du Lieu Xep Hang Phu Hao Nao!")
	end
end

function FALSE(value)
	if (not(value) or value == 0 or value == nil or value == "") then
		return 1
	else
		return nil
	end
end