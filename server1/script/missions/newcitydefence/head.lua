----------------------------------------------------------------
--FileName:	head.lua
--Creater:	firefox
--Date:		2005-08-28
--Comment:	Weekend Event: City Defense War
--			Function: Event header file custom functions
-----------------------------------------------------------------
--Include("\\script\\global\\pgaming\\missions\\bosshoangkim\\bossdai\\lib\\serverlib.lua")
Include("\\script\\battles\\battlehead.lua")
Include("\\script\\missions\\newcitydefence\\headinfo.lua")
Include([[\script\tong\tong_award_head.lua]]);-- Guild weekly goal contribution by Zhi Shan
--Include("\\script\\lib\\tireddegree.lua")
Include("\\script\\task\\task_addplayerexp.lua")

function cloudopen_defence()
	local weekdate = tonumber(date("%w"))
	if (weekdate ~= FIRE_OPENDAY_SATURDAY and weekdate ~= FIRE_OPENDAY_SUNDAY) then
		return nil
	end
	return 1
end

------------------------------------------------------------------------------------------
function GetIniFileData(mapfile, sect, key)
	if (IniFile_Load(mapfile, mapfile) == 0) then 
		print("Load IniFile Error!"..mapfile)
		return ""
	else
		return IniFile_GetData(mapfile, sect, key)	
	end
end

function GetTabFileHeight(mapfile)
	if (TabFile_Load(mapfile, mapfile) == 0) then
		print("Load TabFileError!"..mapfile);
		return 0
	end
	return TabFile_GetRowCount(mapfile)
end;

function GetTabFileData(mapfile, row, col)
	if (TabFile_Load(mapfile, mapfile) == 0) then
		print("Load TabFile Error!"..mapfile)
		return 0
	else
		return tonumber(TabFile_GetCell(mapfile, row, col))
	end
end
------------------------------------------------------------------------------------------------
-- Convert seconds to minutes and seconds, e.g. 62s = 1m2s
function GetMinAndSec(nSec)
nRestMin = floor(nSec / 60);
nRestSec = mod(nSec,60)
return nRestMin, nRestSec;
end;
-----------------------------------------------------------------------------------------------

-- "123,234" -> 123, 234, convert coordinate string to two numeric variables
function bt_str2xydata(str)
	m = strfind(str,",")
	x = tonumber(strsub(str,0,m-1))
	y = tonumber(strsub(str,m+1))
	return x,y
end
------------------------------------------------------------------------------------------------

-- Randomly get a coordinate from coordinate file
function bt_getadata(file)
	local totalcount = GetTabFileHeight(file) - 1;
	id = random(totalcount);
	x = GetTabFileData(file, id + 1, 1);
	y = GetTabFileData(file, id + 1, 2);
	return x,y
end

-- Generate all trap points based on trapfile's coordinate table, and link with scriptfile script
function bt_addtrap(trapfile, scriptfile)
	local count = GetTabFileHeight(trapfile);
--	scriptid = FileName2Id(scriptfile);
--print(scriptfile)	
	ID = SubWorldIdx2ID(SubWorld);
	
	for i = 1, count - 1 do
		x = GetTabFileData(trapfile, i + 1, 1);
		y = GetTabFileData(trapfile, i + 1, 2);
		AddMapTrap(ID, x,y, scriptfile);
	end;
end;

-- Generate all dialog NPCs with template ID tnpcid based on npcfile's coordinate table, and link with scriptfile script
function bt_adddiagnpc(npcfile, scriptfile, tnpcid, name)
	addcount = 0;
	local count = GetTabFileHeight(npcfile);
	
	for i = 1, count - 1 do
		x = GetTabFileData(npcfile, i + 1, 1);
		y = GetTabFileData(npcfile, i + 1, 2);
		if (name ~= nil or name ~= "") then
			npcidx = AddNpc(tnpcid, 1, SubWorld, x, y, 1, name)			
		else
			npcidx = AddNpc(tnpcid, 1, SubWorld, x, y);
		end

		if (npcidx > 0) then
			SetNpcScript(npcidx, scriptfile)
			addcount = addcount + 1
		else
			print("error!can not add dialog npc !tnpcid:"..tnpcid.." ["..SubWorldIdx2ID(SubWorld)..","..x..","..y);
		end
	end;
	return addcount
end;	
function bt_add_a_diagnpc(scriptfile, tnpcid, x, y, name)
		if (name ~= nil or name ~= "") then
			npcidx = AddNpc(tnpcid, 1, SubWorld, x, y, 1 , name);
		else
			npcidx = AddNpc(tnpcid, 1, SubWorld, x, y )
		end
		
		if (npcidx > 0) then
			SetNpcScript(npcidx, scriptfile)
		else
			print("error!can not add dialog npc !tnpcid:"..tnpcid.." ["..SubWorldIdx2ID(SubWorld)..","..x..","..y);
		end
		return npcidx
end


function cd_addfightnpc(npcfile, ss, ee, npcid, level, npcname, boss, npccamp, npcscript, boss4)
	local posx = 0
	local posy = 0
	local npcindex = 0
	local s_npcid = npcid
	for i = ss, ee do
		posx = GetTabFileData( npcfile, i + 1, 1 );
		posy = GetTabFileData( npcfile, i + 1, 2 );
		if (boss4 ~= nil) then
			s_npcid = npcid + random(0,1)
		end
		npcindex = AddNpc( s_npcid, level, SubWorld, posx, posy, 1, npcname, boss )
		if( npcindex > 0 ) then
			--SetNpcCurCamp( npcindex, npccamp )
			SetNpcDeathScript( npcindex, npcscript )
		end
	end
end


function cd_buildfightnpc_old()
	-- Get map's corresponding settings file name
	local mapfile = GetMapInfoFile(mapid)
	local citysection = "MapInfo"
	local npcfile = GetMissionS( MS_S_CMNPCFILE )
	local filehigh = GetTabFileHeight( npcfile ) - 1
--print(filehigh.."==filehigh")
	if ( filehigh <= 0 or filehigh == nil ) then
--		print("commonfile error ")
		return
	end
	
		-- Place guards
	local weibingfile = GetIniFileData(mapfile, citysection, "weibing");
	
	-- Place city defense generals
	local jiangjunxy;
	for i = 1, 3 do
		jiangjunxy = GetIniFileData(mapfile, citysection, "jiangjun"..i);
		x, y = bt_str2xydata(jiangjunxy);
		
	end;
	
	local citycamp = GetMissionV( MS_CITYCAMP )
--print(citycamp.."==citycamp")
	local npccamp = 1
	local npcname = "Qu©n Tèng"
	if ( citycamp == 1 ) then
		npccamp = 2
		npcname = "Qu©n Kim"
	end
	local npccount_1 = floor( filehigh * 0.82 )		--1886
	local npccount_2 = floor( filehigh * 0.12 )		--276
	local npccount_3 = floor( filehigh * 0.06 )		--138
	
	cd_addfightnpc(npcfile, 1, npccount_1, tbTNPC_SOLDIER[npccamp][1], tbSOLDIER_LEVEL[1], npcname..tbSOLDIER_NAME[1], 0, npccamp, tbFILE_NPCDEATH[1])
	
	cd_addfightnpc(npcfile, npccount_1 + 1, npccount_1 + npccount_2, tbTNPC_SOLDIER[npccamp][2], tbSOLDIER_LEVEL[2], npcname..tbSOLDIER_NAME[2], 2, npccamp, tbFILE_NPCDEATH[2])

	cd_addfightnpc(npcfile, npccount_1 + npccount_2 + 1, npccount_1 + npccount_2 + npccount_3, tbTNPC_SOLDIER[npccamp][3], tbSOLDIER_LEVEL[3], npcname..tbSOLDIER_NAME[3], 1, npccamp, tbFILE_NPCDEATH[3])
	
end

function GameOver()
	local oldPlayerIndex = PlayerIndex
	local citycamp = GetMissionV(MS_CITYCAMP)
	local campname = ""
	if ( citycamp == 1 ) then
		campname = "Qu©n Tèng"
	else
		campname = "Qu©n Kim"
	end
	local isWin = 0;-- Record whether victory - by Zhi Shan
	if ( GetMissionV(MS_CITYDEFENCE) == 1 ) then
		isWin = 1;-- by Zhi Shan
		-- Victory
		cd_awardall(campname, isWin)
		AddGlobalNews("tr¶i qua chiÕn ®Êu quyÕt liÖt, "..campname.."b¶o vÖ thµnh c«ng thµnh tr×!")
		Msg2MSAll( MISSIONID, "tr¶i qua chiÕn ®Êu quyÕt liÖt, "..campname.."b¶o vÖ thµnh c«ng thµnh tr×!" )
		--cd_writelog(date("%m-%d,%H:%M;")..campname.."Thñ thµnh thµnh c«ng, sè ng­êi=="..GetMSPlayerCount(MISSIONID, 0))
	else
		-- Defeat
		cd_awardall(campname, isWin)
		AddGlobalNews("Tr¶i qua cuéc chiÕn kÞch liÖt, dï ®· cè g¾ng nh­ng cuèi cïng b¹n bªn b¹n chèng kh«ng l¹i ®Þch, thñ thµnh thÊt b¹i……")
		Msg2MSAll( MISSIONID, "Tr¶i qua cuéc chiÕn kÞch liÖt, dï ®· cè g¾ng nh­ng cuèi cïng b¹n bªn b¹n chèng kh«ng l¹i ®Þch, thñ thµnh thÊt b¹i……" )
		--cd_writelog(date("%m-%d,%H:%M;")..campname.."Thñ thµnh thÊt b¹i, sè ng­êi=="..GetMSPlayerCount(MISSIONID, 0).."; sè l­îng npc cßn l¹i, "..tbSOLDIER_NAME[1]..":"..GetMissionV(MS_MAXCOUNTNPC_1)..";"..tbSOLDIER_NAME[2]..":"..GetMissionV(MS_MAXCOUNTNPC_1+1)..";"..tbSOLDIER_NAME[3]..":"..GetMissionV(MS_MAXCOUNTNPC_1+2)..";"..tbSOLDIER_NAME[4]..":"..GetMissionV(MS_MAXCOUNTNPC_1+3)..";"..tbSOLDIER_NAME[5]..":"..GetMissionV(MS_MAXCOUNTNPC_1+4)..";")
	end
	--cd_WinLadder(isWin) -- Ranking
	local tbPlayer = {};
	local idx = 0;
	local pidx = 0;
	for i = 1 , 300 do 
		idx, pidx = GetNextPlayer(MISSIONID,idx, 0);
		if( pidx > 0 ) then
			tbPlayer[ getn(tbPlayer) + 1 ] = pidx
		end
		if (idx <= 0) then 
	 		break
	 	end;
	end 	
 	
 	for i= 1, getn(tbPlayer) do 
	 	PlayerIndex = tbPlayer[i];
	 	citycamp = GetMissionV(MS_CITYCAMP);
 		--tongaward_citywar(isWin);-- Guild weekly goal by Zhi Shan
		camp = GetCamp();
		SetCurCamp(camp);
		DisableTeamChangeCamp(0)
		SetTaskTemp(200,0);
		SetLogoutRV(0);
		SetDeathScript("");
		SetFightState(0)		-- Change to non-combat state after battle (by Dan_Deng)
		SetPunish(1)
		ForbidChangePK(0);
		SetPKFlag(0)
		SetRevPos(tbDEFENCE_SIGNMAP[citycamp], random(3))
		NewWorld(bt_getsignpos(citycamp))
	end
	PlayerIndex = OldPlayerIndex
end

function cd_join(camp)
	LeaveTeam();
	local mapid, posx, posy = cd_getjoinpos(camp);
	NewWorld( mapid, posx, posy );
	AddMSPlayer(MISSIONID,camp);
	EnterChannel(PlayerIndex, GetMissionS(MS_S_CD_NAME))
	SetRevPos(tbDEFENCE_SIGNMAP[camp], 1)
	SetCurCamp(camp);
	DisableTeamChangeCamp(1)
	SetTaskTemp(200,1);
	SetLogoutRV(1);
	SetPunish(0);
	SetFightState(0);
	SetPKFlag(0);
	ForbidChangePK(1);
	SetTempRevPos(mapid, posx * 32, posy * 32);
	SetTask(TSKID_PLAYER_ZHANGONG, 0)
	SetTask(TSKID_PLAYER_OLDRANK, 1)
	SetDeathScript( FILE_PLAYERDEATH );
	if GetTask(TASKID_HOUR_PHLT) ~= tonumber(GetLocalDate("%m%d%H")) then
		SetTask(TASKID_HOUR_PHLT, tonumber(GetLocalDate("%m%d%H")))  -- Record hour of participation in City Defense
		SetTask(TASKID_COUNT_PHLT, GetTask(TASKID_COUNT_PHLT) + 1)
		-- Reset battle points and rank for new mission
		SetTask(TSKID_PLAYER_ZHANGONG, 0)
		SetTask(TSKID_PLAYER_OLDRANK, 1)
	end
	
	if (GetMissionV(MS_STATE) == 2) then
		Msg2Player("B¹n ®· gia nhËp <color=white>"..GetMissionS(MS_S_CD_NAME).."<color> phe. T­íng lÜnh thñ thµnh hiÖn lµ "..GetMissionV(MS_SHOUCHENGWEIBING).."ng­êi, viÖn binh tæng céng"..GetMSPlayerCount(MISSIONID, 0).."ng­êi.")
	else
		Msg2Player("B¹n ®· gia nhËp"..GetMissionS(MS_S_CD_NAME).."phe.")
	end
	DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", "fenghuoliancheng")
end

function cd_awardall(szCampName, isWin)		-- Award for successful city defense
	local tbPlayer = {};
	local idx = 0;
	local base_exp = 20000
	local plus_exp = 1
	local szWeekendBonus = ""
	-- Check if today is Saturday (6) or Sunday (0)
	if isCuoiTuan() == 1 then
		plus_exp = plus_exp * 2
		szWeekendBonus = " <color=pink>(Cuèi tuÇn x2!)<color>"
	end
	if isGioCaoDiem() == 1 then
		plus_exp = plus_exp * 2
		szWeekendBonus = szWeekendBonus.." <color=pink>(Gi¶ cao ®iÓm x2!)<color>"
	end
	
	if isWin == 1 then
		plus_exp = plus_exp * 2
	end
	
	local pidx = 0;	for i = 1 , 300 do 
		idx, pidx = GetNextPlayer(MISSIONID,idx, 0);
		if( pidx > 0 ) then
			tbPlayer[ getn(tbPlayer) + 1 ] = pidx
		end
		if (idx <= 0) then 
	 		break
	 	end;
	end 	
 	
 	oldPlayerIndex = PlayerIndex;
 	
 	for i= 1, getn(tbPlayer) do 
 		PlayerIndex = tbPlayer[i];
 		-- Get battle points
 		local nZhanGong = tonumber(GetTask(TSKID_PLAYER_ZHANGONG)) or 0
 		local nAwardExp = nZhanGong * base_exp * plus_exp
 		if (nAwardExp > 0 and isWin == 1) then
 			AddPlayerExp(nAwardExp);
 			Msg2Player(format("<color=green>%s thñ thµnh thµnh c«ng, ®iÓm tÝch lòy: <color=yellow>%d<color>, nhËn ®­îc <color=yellow>%d<color> ®iÓm kinh nghiÖm. %s", szCampName, nZhanGong, nAwardExp, szWeekendBonus))
		elseif nAwardExp > 0  then
 			Msg2Player(format("<color=green>%s thñ thµnh thÊt b¹i, ®iÓm tÝch lòy: <color=yellow>%d<color>, nhËn ®­îc <color=yellow>%d<color> ®iÓm kinh nghiÖm. %s", szCampName, nZhanGong, nAwardExp, szWeekendBonus))
			AddPlayerExp(nAwardExp)
 		end;
	end
	PlayerIndex = oldPlayerIndex
end

function bt_getsignpos(camp)
	if ( camp ~= 1 and camp ~= 2 ) then
		camp = 1;
	end;
	local a = random(getn(tbSIGNMAP_POS))
	
	return tbDEFENCE_SIGNMAP[camp], tbSIGNMAP_POS[a][1], tbSIGNMAP_POS[a][2]
end

function cd_getjoinpos(camp)
	local mapid = tbDEFENCE_MAPID[camp]
	local a = random( getn(tbREVIVAL_POS) )
	return mapid, tbREVIVAL_POS[a][1], tbREVIVAL_POS[a][2]
end


function OnCancel()
end

-- Add battle points (similar to bt_addtotalpoint in battlehead.lua)
function cd_addtotalpoint(point)
	if (point == 0) then
		return
	end
	
	local nZhanGong = tonumber(GetTask(TSKID_PLAYER_ZHANGONG)) or 0
	if nZhanGong >= 0 then
		SetTask(TSKID_PLAYER_ZHANGONG, nZhanGong + point)
	end
	local curPointTK = tonumber(GetTask(747)) or 0
	if curPointTK > 0 then		
		SetTask(747, curPointTK + (point * 10))
	end
	-- cd_AddSkillTitle()
	return point
end
function getTitleByPoint(playerIdx, point)
	local oldPlayerIndex = PlayerIndex
	PlayerIndex = playerIdx
	local nTitleIndex = 1 -- Default: Soldier
	for i = getn(tbPlAYERER_ZHANGONG), 1, -1 do
		if point >= tbPlAYERER_ZHANGONG[i] then
			nTitleIndex = i
			break
		end
	end
	local szTitleName = tbPlAYERER_NAME[nTitleIndex] or "Binh sÜ"
	PlayerIndex = oldPlayerIndex
	return szTitleName, nTitleIndex
	
end
function getMonPhai(playerIdx)
	local oldPlayerIndex = PlayerIndex
	PlayerIndex = playerIdx
	local szMonPhai = GetFaction()
	if szMonPhai == "shaolin" then
		szMonPhai = "TL"
	elseif szMonPhai == "tianwang" then
		szMonPhai = "TV"
	elseif szMonPhai == "tangmen" then
		szMonPhai = "§M"
	elseif szMonPhai == "wudu" then
		szMonPhai = "N§"
	elseif szMonPhai == "emei" then
		szMonPhai = "NM"
	elseif szMonPhai == "tianren" then
		szMonPhai = "TN"
	elseif szMonPhai == "gaibang" then
		szMonPhai = "CB"
	elseif szMonPhai == "wudang" then
		szMonPhai = "V§"
	elseif szMonPhai == "kunlun" then
		szMonPhai = "CL"
	end
	PlayerIndex = oldPlayerIndex
	return szMonPhai
end
function cd_AddSkillTitle()
	local nZhanGong = tonumber(GetTask(TSKID_PLAYER_ZHANGONG)) or 0
	local citycamp = GetMissionV(MS_CITYCAMP)
	
	-- Get current rank from task (stores previous rank)
	local nOldRank = GetTask(TSKID_PLAYER_OLDRANK) or 1	
	if nZhanGong > 0 then
		-- Calculate title ID: 89-93 (Song), 94-98 (Jin)
		local campnum = 89
		if citycamp == 2 then
			campnum = campnum + 5  -- Jin = 94
		end
		local szTitleName, nTitleIndex = getTitleByPoint(PlayerIndex, nZhanGong)
		local nGuangHuanId = campnum + nTitleIndex - 1
		
		
		-- Activate title according to battlehead.lua standard
		Title_AddTitle(nGuangHuanId, 0, 9999999) -- type=0 (temporary), time=9999999
		Title_ActiveTitle(nGuangHuanId)
		AddSkillState(RANK_SKILL, nTitleIndex - 1, 0, 999999)
	
		-- Process if ranked up OR if current rank doesn't match actual rank (fix for existing players)
		if nTitleIndex > nOldRank then
			-- Save new rank
			SetTask(TSKID_PLAYER_OLDRANK, nTitleIndex)			
			-- Display rank up message			
			Msg2Player(format("Chóc mõng! B¹n ®· thªng cÊp danh hiÖu lªn <color=yellow>%s<color> víi <color=yellow>%d<color> ®iÓm chiªn c«ng", szTitleName, nZhanGong))
		end
	end
end

-- Display player stats when pressing ~ key
function cd_ShowPlayerStats()
	local nZhanGong = GetTask(TSKID_PLAYER_ZHANGONG) or 0
	local citycamp = GetMissionV(MS_CITYCAMP)
	local oldPlayerIndex = PlayerIndex
	-- Determine current title
	local nTitleIndex = 1 -- Default: Soldier
	for i = getn(tbPlAYERER_ZHANGONG), 1, -1 do
		if nZhanGong >= tbPlAYERER_ZHANGONG[i] then
			nTitleIndex = i
			break
		end
	end
	local szTitleName = tbPlAYERER_NAME[nTitleIndex] or "Binh sÜ"
	
	-- Calculate points needed for next rank
	local szNextRank = ""
	if nTitleIndex < getn(tbPlAYERER_ZHANGONG) then
		local nNeedPoints = tbPlAYERER_ZHANGONG[nTitleIndex + 1] - nZhanGong
		szNextRank = format("\n<color=green>§iÓm cÇn ®Ó lªn h¹ng tiÕp theo:<color> <color=yellow>%d<color>", nNeedPoints)
	else
		szNextRank = "\n<color=green>§· ®¹t h¹ng cao nhÊt!<color>"
	end
	
	-- Determine faction
	local szCamp = "Phe Tèng"
	if citycamp == 2 then
		szCamp = "Phe Kim"
	end
	
	-- Display information
	local szMsg = "<color=green>==== Th«ng tin Thñ thµnh ====<color>\n"
	szMsg = szMsg .. format("<color=green>Tªn nh©n vËt:<color> <color=yellow>%s<color>\n", GetName() or "Unknown")
	szMsg = szMsg .. format("<color=green>? doanh:<color> <color=yellow>%s<color>\n", szCamp or "Unknown")
	szMsg = szMsg .. format("<color=green>Danh hiÖu hiÖn t¹i:<color> <color=yellow>%s<color>\n", szTitleName)
	szMsg = szMsg .. format("<color=green>§iÓm chiªn c«ng:<color> <color=yellow>%d<color>", nZhanGong or 0)
	szMsg = szMsg .. szNextRank
	szMsg = szMsg .. "\n<color=green>=========================<color>"
	
	Msg2Player(szMsg)
end

function cd_writelog(str)
	local szFileName = "Logs/citydefence_log_"..date("%m%d")..".log"
	local fu = openfile(szFileName, "a")
	write(fu, str.."\r\n")
	flush(fu)
	closefile(fu)
end

function cd_buildtrapsonroad()	-- Add all traps on monster paths toward city
	local i;
	local trapfile;
	local scriptfile;
	-- Add all traps on first road
	for i = 1, 15 do
		trapfile = [[\settings\maps\newcitydefence\trapline]]..(999 + i)..".txt";
		scriptfile = [[\script\missions\newcitydefence\trap\trapline]]..(999 + i)..".lua";
		bt_addtrap(trapfile, scriptfile);
	end;

	-- Add all traps on second road
	for i = 1, 13 do
		trapfile = [[\settings\maps\newcitydefence\trapline]]..(1999 + i)..".txt";
		scriptfile = [[\script\missions\newcitydefence\trap\trapline]]..(1999 + i)..".lua";
		bt_addtrap(trapfile, scriptfile);
	end;
	
	-- Add all traps on third road
	for i = 1, 14 do
		trapfile = [[\settings\maps\newcitydefence\trapline]]..(2999 + i)..".txt";
		scriptfile = [[\script\missions\newcitydefence\trap\trapline]]..(2999 + i)..".lua";
		bt_addtrap(trapfile, scriptfile);
	end;
end;

function cd_awardItem_cc()
		local itemid = 0
		local sum = 0
		ran = ( random(1000) - 1 ) * 10000 + random(10000)
		for j = 1, getn(TB_CD_AWARDITEM) do
			sum = TB_CD_AWARDITEM[j][2] * CD_BASE_VALUE + sum
			if (sum >= ran) then
				itemid = j
				break
			end
		end
		
		-- Check if no item found (itemid = 0)
		if itemid == 0 or itemid > getn(TB_CD_AWARDITEM) then
			print("cd_awardItem_cc: No item found or invalid itemid =", itemid, "ran =", ran)
			return
		end
		
		itemlist = TB_CD_AWARDITEM[ itemid ][ 3 ]
		if ( getn( itemlist ) == 1) then
			AddEventItem( itemlist[1] )
		elseif ( getn( itemlist ) == 7 ) then
			AddItem( itemlist[1], itemlist[2], itemlist[3], itemlist[4], itemlist[5], itemlist[6], itemlist[7] )
		elseif ( getn( itemlist ) == 2 ) then
			AddGoldItem( itemlist[1], itemlist[2] )
		else
			print("itemparam error!!!! itemid = "..itemid)
		end
		Msg2Player("B¹n nhËn ®­îc<color=yellow>"..TB_CD_AWARDITEM[itemid][1])
end

-- Clear accumulated experience from last city defense event
function cd_clear_lastsumexp()
	if (GetTask(TSKID_FIRE_SUMEXP) ~= 0) then
		SetTask(TSKID_FIRE_SUMEXP, 0);
	end;
end;

-- Record level and experience at registration time
function cd_setsign_levelexp()
	SetTask(TSKID_FIRE_SIGNLVL, GetLevel());
	SetTask(TSKID_FIRE_SIGNEXP, GetExp());
end;
tbPlayers = {}
date_update = 0
-- Broadcast top rankings by battle points to all players in mission
function cd_BroadcastTopRankings()
	local cur_date = tonumber(GetLocalDate("%m%d%H"))
	if cur_date ~= date_update then
		date_update = cur_date
		tbPlayers = {} -- Clear cached player data to avoid stale rankings
	end
	local idx = 0
	local pidx = 0
	local nCountPlayers = 0
	local oldPlayerIndex = PlayerIndex
	-- Collect all players in mission
	for i = 1, 300 do
		idx, pidx = GetNextPlayer(MISSIONID, idx, 0)
		if pidx <= 0 then break end

		PlayerIndex = pidx
		local nZhanGong = GetTask(TSKID_PLAYER_ZHANGONG) or 0
		local szName = GetName()
		local szMonPhai = getMonPhai(PlayerIndex)
		local nCamp = GetCamp()
		if nZhanGong > 0 then
			local szTitleName, _ = getTitleByPoint(PlayerIndex, nZhanGong)
			local exists = 0
			for i = 1, getn(tbPlayers) do
				if tbPlayers[i].name == szName then
					-- Update points if player already exists in list (in case of multiple broadcasts during event)
					tbPlayers[i].points = nZhanGong
					exists = 1
					break
				end
			end
			if exists == 0 then
				-- Store player data
				tbPlayers[getn(tbPlayers) + 1] = {
					name = szName,
					points = nZhanGong,
					camp = nCamp,
					faction = szMonPhai,
					title = szTitleName,
					playerIdx = pidx,
				}
			end
		end
	end
	PlayerIndex = oldPlayerIndex

	--sort(sortList, function(a, b) return a.points > b.points end)
	nCountPlayers = getn(tbPlayers)
	-- Sort players by points (descending)
	for i = 1, nCountPlayers - 1 do
		for j = i + 1, nCountPlayers do
			if tbPlayers[j].points > tbPlayers[i].points then
				local temp = tbPlayers[i]
				tbPlayers[i] = tbPlayers[j]
				tbPlayers[j] = temp
			end
		end
	end
	
	-- Build ranking message
	local szMsg = "<color=green>==== B¶ng xÕp h¹ng ChiÕn c«ng ====<color>\n"
	Msg2MSAll(MISSIONID, szMsg)
	szMsg = "<color=green>Top / Danh hiÖu / M«n ph¸i / Tªn / §iÓm<color>"
	Msg2MSAll(MISSIONID, szMsg)
	local nTopCount = 10
	if nCountPlayers < nTopCount then
		nTopCount = nCountPlayers
	end
	
	if nTopCount == 0 then
		szMsg = "<color=yellow>Ch­a cã ng­êi ch¬i nµo cã ®iÓm chiÕn c«ng<color>"
		Msg2MSAll(MISSIONID, szMsg)
	else
		-- Show top 10 to everyone
		for i = 1, nTopCount do
			local szCampName = "Tèng"
			if tbPlayers[i].camp == 2 then
				szCampName = "Kim"
			end
			
			szMsg = format("<color=yellow>T%d: %s <color=cyan>%s<color> - <color=red>%d<color> ®iÓm\n", 
				i, tbPlayers[i].faction, tbPlayers[i].name, tbPlayers[i].points)
			Msg2MSAll(MISSIONID, szMsg)
		end
		
		-- If there are more than 10 players, show individual rank to those not in top 10
		if nCountPlayers > nTopCount then
			for p = nTopCount + 1, nCountPlayers do
				PlayerIndex = tbPlayers[p].playerIdx
				szMsg = "<color=red>/////////////////////////////<color>"
				Msg2Player(szMsg)
				local szCampName = "Tèng"
				if tbPlayers[p].camp == 2 then
					szCampName = "Kim"
				end
				
				szMsg = format("<color=yellow>T%d: %s <color=cyan>%s<color> - <color=red>%d<color> ®iÓm", 
					p, tbPlayers[p].faction, tbPlayers[p].name, tbPlayers[p].points)
				Msg2Player(szMsg)
				szMsg = "<color=red>/////////////////////////////<color>"
				Msg2Player(szMsg)
			end
		end
	end
	
	szMsg = "<color=green>=======================<color>"
	Msg2MSAll(MISSIONID, szMsg)
	
	PlayerIndex = oldPlayerIndex
end

-- Broadcast individual player points to all players every 20 seconds
function cd_BroadcastPlayerPoints()
	local oldPlayerIndex = PlayerIndex	
	local nZhanGong = GetTask(TSKID_PLAYER_ZHANGONG) or 0
	
	local szTitleName, _ = getTitleByPoint(PlayerIndex, nZhanGong)
	-- Send condensed message (2 lines instead of 6)
	Msg2Player(format("<color=green>[Thñ thµnh]<color> Danh hiÖu: <color=yellow>%s<color> - ChiÕn c«ng: <color=yellow>%d<color>", szTitleName, nZhanGong))
	cd_AddSkillTitle()
	PlayerIndex = oldPlayerIndex
end

-- Calculate accumulated experience gained when leaving mission
function cd_calc_sumexp()
	local nOldLevel = GetTask(TSKID_FIRE_SIGNLVL);
	local nOldExp = GetTask(TSKID_FIRE_SIGNEXP);
	local n_transcount = ST_GetTransLifeCount();
	local nCurSum = tl_countuplevelexp(nOldLevel,nOldExp, n_transcount);
	local nLastSum = GetTask(TSKID_FIRE_SUMEXP);
	
	SetTask(TSKID_FIRE_SUMEXP, nLastSum + nCurSum);
	return nLastSum + nCurSum;
end;


