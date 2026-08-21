----------------------------------------------------------------
--FileName:	smalltimer.lua
--Creater:	firefox
--Date:		2005-08-28
--Comment:	ÖÜÄ©»î¶¯£ºÎÀ¹úÕ½ÕùÖ®·é»ðÁ¬³Ç
--			¹¦ÄÜ£º¼ÆÊ±Æ÷£¬Ã¿20Ãë´¥·¢
--				
-----------------------------------------------------------------
Include("\\script\\missions\\newcitydefence\\head.lua")
tbAddNpcCount = {750, 100, 50, 10}
tbNpcAddRadio = {40/100, 30/100, 20/100, 10/100}
TOTALNPCCOUNT = 100  -- So luong goi npc trong 1 lan 
tbGuaiWu = {
	"\\settings\\maps\\newcitydefence\\guai001.txt",
	"\\settings\\maps\\newcitydefence\\guai002.txt",
	"\\settings\\maps\\newcitydefence\\guai003.txt",
}

tbAimPos = {
	"\\settings\\maps\\newcitydefence\\trappos1000.txt",
	"\\settings\\maps\\newcitydefence\\trappos2000.txt",
	"\\settings\\maps\\newcitydefence\\trappos3000.txt",
}
ZHUSHUAI_POSFILE = "\\settings\\maps\\newcitydefence\\zhushuai.txt"
WEIBING_POSFILE = "\\settings\\maps\\newcitydefence\\weibing0001.txt"
JIANGJUN_POSFILE = "\\settings\\maps\\newcitydefence\\jiangjun.txt"
tbPos_BAOTAI = {
		{1828,2663},{1832,2669},{1835,2674},{1842,2679},{2180,2711},{2183,2716},{2186,2721},{2192,2726},{2208,3010},{2214,3017},{2218,3021},{2219,3014}
}
function OnTimer()
	local t = GetMissionV( MS_SMALL_TIME ) + 1
	SetMissionV( MS_SMALL_TIME, t )
	
	local citycamp = GetMissionV( MS_CITYCAMP )
	local cityname = GetMissionS(MS_S_CD_NAME)
	
	if ( t == RUNGAME_TIME ) then	--¿ªÕ½Ê±¼äµ½£¬ÌáÊ¾ÊØ³Ç¿ªÊ¼£¬²¢Ë¢µÚÒ»Åú¹Ö
		RunMission(MISSIONID)
		AddGlobalNews("ChiÕn tranh vÖ quèc ®· b¾t ®Çu, "..tbDEFENCE_ANNOUNCE[citycamp])
		Msg2MSAll( MISSIONID, "<color=yellow>Qu©n ®Þch ®· b¾t ®Çu c«ng thµnh, v× ®Ó b¶o vÖ thµnh chóng ta c¸c T­íng sÜ h·y x«ng lªn!" )
		--cd_writelog(cityname.."B¾t ®Çu.\tsè ng­êi\t"..GetMSPlayerCount(MISSIONID, 0))
		cd_buildfightnpc( t )
		cd_callAttackCarNpc()
		return
	end
	
	if ( t > RUNGAME_TIME ) then
		local RestTime = (TOTAL_TIME - t * SMALL_TIME) / FRAME2TIME
		local RestMin, RestSec = GetMinAndSec(RestTime);
		-- L?y s? l??ng NPC còn s?ng trên b?n ??
		local restnpc_1 = GetMissionV( MS_RESTCOUNTNPC_1 )
		local restnpc_2 = GetMissionV( MS_RESTCOUNTNPC_2 )
		local restnpc_3 = GetMissionV( MS_RESTCOUNTNPC_3 )
		local restnpc_4 = GetMissionV( MS_RESTCOUNTNPC_4 )
		local restnpc_5 = GetMissionV( MS_5THNPC_TCNT )
		
		local total_npc = restnpc_1 + restnpc_2 + restnpc_3 + restnpc_4 + restnpc_5
		local nCountPlayers = GetMSPlayerCount(MISSIONID, 0)
		if nCountPlayers <= 1 then
			nCountPlayers = 1
		end
		local nMaxNpcCount = (nCountPlayers * 5) + MAX_NPC_COUNT
		local nMaxVanguardCount = (nCountPlayers * 2) + MAX_VANGUARD_COUNT
		local nMaxGeneralCount = (nCountPlayers * 2) + MAX_GENERAL_COUNT
		-- In ra console thông tin NPC
		-- print("=== MISSION STATUS ===")
		-- print(format("Players: %d | Defense Guards: %d | Defense Points: %d", 
		-- 	GetMSPlayerCount(MISSIONID, 0), GetMissionV(MS_SHOUCHENGWEIBING), GetMissionV(MS_HOMEDEFENCE)))
		-- print(format("NPCs Alive: %s %d | %s %d | %s %d | %s %d | Total: %d/%d", 
		-- 	tbSOLDIER_NAME[1], restnpc_1, 
		-- 	tbSOLDIER_NAME[2], restnpc_2, 
		-- 	tbSOLDIER_NAME[3], restnpc_3, 
		-- 	tbSOLDIER_NAME[4], restnpc_4, 
		-- 	total_npc, nMaxNpcCount))
		if ( mod( t, 9 ) == 0 ) then
			cd_sendmsg2msall(restnpc_1, restnpc_2, restnpc_3, restnpc_4, restnpc_5)		-- Every 3 minutes, show current NPC count status
		end
		if ( mod(t, 60) == 0 and RestMin ~= 0) then
			cd_sendmsg2global()
		end
		if ( mod( t, 3 ) == 0 ) then
			--cd_BroadcastPlayerPoints()	-- Every 3 minutes, broadcast individual points
			cd_BroadcastTopRankings()	-- Every 3 minutes, broadcast top 10 rankings
		end
		if ( t < LASTREPORT_TIME ) then	--Ã¿¸ô5·ÖÖÓÌáÊ¾½áÊøÊ±¼ä£¬×îºó5·ÖÖÓÃ¿·ÖÖÓÌáÊ¾Ò»´Î
			if ( mod( t, 15 ) == 0 ) then
				Msg2MSAll( MISSIONID, "Thêi gian kÕt thóc thñ thµnh cßn <color=yellow>"..RestMin.." phót" )
			end
		else
			if ( mod( t, 3 ) == 0 ) then
				Msg2MSAll( MISSIONID, "Thêi gian kÕt thóc thñ thµnh cßn <color=yellow>"..RestMin.." phót" )
			end
		end
		if (t >= CALLBOSS_ZHUSHUAI) then
			if ( t == CALLBOSS_ZHUSHUAI) then
				call_boss_zhushuai()
			end
		else
			cd_callnpc(t, nMaxNpcCount, nMaxVanguardCount, nMaxGeneralCount)			--Ã¿1·ÖÖÓ
		end
		if ( mod( t, 15 )) == 0 then	--Ã¿¸ô5·ÖÖÓË¢ÈýÖ»¹¥³Ç³µ
			cd_callAttackCarNpc()
		end
	
	else
		if ( mod( t, 18 ) == 0 ) then	--±¨ÃûÊ±¼äÖÐ£¬Ã¿6·ÖÖÓÌáÊ¾±¨Ãû½áÊøÊ±¼ä£¬²¢·¢¹ö¶¯ÏûÏ¢
			RestTime = (RUNGAME_TIME - t) * SMALL_TIME / FRAME2TIME;
			RestMin, RestSec = GetMinAndSec(RestTime);
			if ( RestMin > 0 ) then
				Msg2MSAll( MISSIONID, "Thêi gian b¸o danh cßn l¹i lµ:<color=yellow>"..RestMin.."phót" )
				AddGlobalNews("Cuéc chiÕn ®· b¾t ®Çu nhËn b¸o danh, cã muèn tham gia kh«ng?"..tbDEFENCE_ANNOUNCE[citycamp].."Thêi gian khai chiÕn cßn"..RestMin.."phót")
			end
		end
	end
end

function cd_callAttackCarNpc()
	local citycamp = GetMissionV( MS_CITYCAMP )
	local npccamp = 1
	if (citycamp == 1) then
		npccamp = 2
	end
	count_1 = cd_addsomenpc(tbTNPC_SOLDIER[npccamp][6], 3, tbGuaiWu, tbAimPos, tbSOLDIER_NAME[6], 1, nil, tbFILE_NPCDEATH[6])
	if count_1 < 3 then
		print(count_1,"Xe háa ph¸o Ýt h¬n 3.")
	end
	Msg2MSAll( MISSIONID, format("<color=yellow>%s cña ®èi ph­¬ng ®ang tiÕn c«ng vµo ®©y, mäi ng­êi h·y ra søc chèng ®ì!!!<color>", tbSOLDIER_NAME[6]))
end


function cd_buildfightnpc(t)
	cd_callnpc(t)
	local count = 0
	local citycamp = GetMissionV( MS_CITYCAMP )
	local npccamp = 1
	if (citycamp == 1) then
		npccamp = 2
	end
	local fileheight = GetTabFileHeight( WEIBING_POSFILE ) - 1
	for i = 1, fileheight do
		posx = GetTabFileData( WEIBING_POSFILE, i + 1, 1 )
		posy = GetTabFileData( WEIBING_POSFILE, i + 1, 2 )
		local npcindex = AddNpc(tbTNPC_SOLDIER[ GetMissionV(MS_CITYCAMP) ][1], 95, SubWorld, posx, posy, 1, "VÖ binh thñ thµnh", 0)
		if (npcindex > 0) then
			SetNpcDeathScript(npcindex, FILE_SHOUCHENG_DEATH[1])
			count = count + 1
			SetNpcCurCamp( npcindex, citycamp )
		end
	end
	SetMissionV(MS_SHOUCHENGWEIBING, GetMissionV(MS_SHOUCHENGWEIBING) + count)

	count = 0
	local fileheight = GetTabFileHeight( JIANGJUN_POSFILE ) - 1
	for i = 1, fileheight do
		posx = GetTabFileData(JIANGJUN_POSFILE, i + 1, 1)
		posy = GetTabFileData(JIANGJUN_POSFILE, i + 1, 2)
		local npcindex = AddNpc(tbTNPC_SOLDIER[ GetMissionV(MS_CITYCAMP) ][2], 95, SubWorld, posx, posy, 1, "T­íng qu©n thñ thµnh", 1)
		if (npcindex > 0) then
			SetNpcDeathScript(npcindex, FILE_SHOUCHENG_DEATH[2])
			count = count + 1
			SetNpcCurCamp(npcindex, citycamp)
		end
	end
	SetMissionV(MS_SHOUCHENGWEIBING, GetMissionV(MS_SHOUCHENGWEIBING) + count)
	SetMissionV( MS_SHOUCHENGJIANGJUN, count)
	local deathscript = tbFILE_NPCDEATH[5]
	for i = 1, getn(tbPos_BAOTAI) do
		if (mod(i, 2) == 0) then
			npcid = 1119
		else
			npcid = 1120
		end
		posx = tbPos_BAOTAI[i][1] * 32
		posy = tbPos_BAOTAI[i][2] * 32
		npcindex = AddNpc(npcid, 95, SubWorld, posx, posy, 1, "ThÇn binh", 1)
		if (npcindex > 0) then
			SetNpcCurCamp(npcindex, npccamp)
			SetNpcDeathScript( npcindex, deathscript )
		end
	end
end

function cd_callnpc(time, nMaxNpcCount, nMAX_VANGUARD_COUNT, nMAX_GENERAL_COUNT)
	local restnpc_1 = GetMissionV( MS_RESTCOUNTNPC_1 )
	local restnpc_2 = GetMissionV( MS_RESTCOUNTNPC_2 )
	local restnpc_3 = GetMissionV( MS_RESTCOUNTNPC_3 )
	local restnpc_4 = GetMissionV( MS_RESTCOUNTNPC_4 )
	local restnpc_5 = GetMissionV( MS_5THNPC_TCNT )
	
	-- DEBUG: Print current NPC count BEFORE spawn
	-- print("=== DEBUG cd_callnpc START ===")
	-- print("Time: "..time)
	-- print("REST NPC on map - Soldier:"..restnpc_1.." Captain:"..restnpc_2.." Vanguard:"..restnpc_3.." General:"..restnpc_4)
	
	if ( GetMissionV(MS_CITYCAMP) == 1 ) then
		npccamp = 2
	else
		npccamp = 1
	end
	
	-- Tính t?ng s? NPC hi?n t?i trên b?n ?? (bao g?m t?t c? lo?i)
	restnpc_total = restnpc_1 + restnpc_2 + restnpc_3 + restnpc_4
	
	-- print("Total NPC on map:", restnpc_total, "/ Target MAX:", MAX_NPC_COUNT)
	
	-- Ki?m tra xem ?ã ??t gi?i h?n ch?a
	if nMaxNpcCount == nil then
		nMaxNpcCount = MAX_NPC_COUNT
	end
	if ( restnpc_total >= nMaxNpcCount ) then
		-- print("Already at MAX_NPC_COUNT, no spawn needed")
		return
	end
	
	-- Tính s? NPC c?n spawn ?? ??t MAX_NPC_COUNT
	local npc_need_spawn = nMaxNpcCount - restnpc_total
	local nTotalNpcLimit = 0
	-- Gi?i h?n s? l??ng spawn m?i l?n (không spawn quá nhi?u m?t lúc)
	nTotalNpcLimit= floor(nMaxNpcCount / 3)

	if npc_need_spawn > nTotalNpcLimit then
		npc_need_spawn = nTotalNpcLimit
	end
	
	-- print("Need to spawn: "..npc_need_spawn.. " NPCs to reach MAX")
	
	-- Phân b? s? l??ng spawn theo t? l? (70% soldiers, 20% captains, 10% vanguards)
	AddNpcC_1 = floor(npc_need_spawn * tbNpcAddRadio[1])  -- 70% soldiers
	AddNpcC_2 = floor(npc_need_spawn * tbNpcAddRadio[2])  -- 20% captains
	AddNpcC_3 = floor(npc_need_spawn * tbNpcAddRadio[3])  -- 10% vanguards
	AddNpcC_4 = floor(npc_need_spawn * tbNpcAddRadio[4])  -- 5% generals for now
	
	local nExtraForCaptain = 0  -- S? NPC d? s? chuy?n thành Captain
	
	-- Check and limit Vanguard spawn (MAX 200)
	if nMAX_VANGUARD_COUNT == nil then
		nMAX_VANGUARD_COUNT = MAX_VANGUARD_COUNT
	end
	if nMAX_GENERAL_COUNT == nil then
		nMAX_GENERAL_COUNT = MAX_GENERAL_COUNT
	end
	if (restnpc_3 + AddNpcC_3 > nMAX_VANGUARD_COUNT) then
		local nCut = (restnpc_3 + AddNpcC_3) - nMAX_VANGUARD_COUNT
		AddNpcC_3 = nMAX_VANGUARD_COUNT - restnpc_3
		if AddNpcC_3 < 0 then 
			nCut = nCut + abs(AddNpcC_3)
			AddNpcC_3 = 0 
		end
		nExtraForCaptain = nExtraForCaptain + nCut
		-- print("Vanguard limit reached, transferring "..nCut.." to Captain")
	end
	
	-- Check and limit General spawn (MAX 50)
	if (restnpc_4 + AddNpcC_4 > nMAX_GENERAL_COUNT) then
		local nCut = (restnpc_4 + AddNpcC_4) - nMAX_GENERAL_COUNT
		AddNpcC_4 = nMAX_GENERAL_COUNT - restnpc_4
		if AddNpcC_4 < 0 then 
			nCut = nCut + abs(AddNpcC_4)
			AddNpcC_4 = 0 
		end
		nExtraForCaptain = nExtraForCaptain + nCut
		-- print("General limit reached, transferring "..nCut.." to Captain")
	end
	
	-- Add extra to Captain
	if nExtraForCaptain > 0 then
		AddNpcC_2 = AddNpcC_2 + nExtraForCaptain
		-- print("Adding "..nExtraForCaptain.. " extra to Captain. New Captain count: "..AddNpcC_2)
	end
	
	-- print("Will spawn - Soldier:"..AddNpcC_1.. " Captain:"..AddNpcC_2.. " Vanguard:"..AddNpcC_3.. " General:"..AddNpcC_4)
	
		count_1 = cd_addsomenpc(tbTNPC_SOLDIER[npccamp][1], AddNpcC_1, tbGuaiWu, tbAimPos, tbSOLDIER_NAME[1], 0, nil, tbFILE_NPCDEATH[1])
		SetMissionV( MS_RESTCOUNTNPC_1, GetMissionV( MS_RESTCOUNTNPC_1 ) + count_1 )
		-- print("Spawned Soldier: "..count_1.."| New REST: "..GetMissionV(MS_RESTCOUNTNPC_1))

		count_2 = cd_addsomenpc(tbTNPC_SOLDIER[npccamp][2], AddNpcC_2, tbGuaiWu, tbAimPos, tbSOLDIER_NAME[2], 2, nil, tbFILE_NPCDEATH[2])
		SetMissionV( MS_RESTCOUNTNPC_2, GetMissionV( MS_RESTCOUNTNPC_2 ) + count_2 )
		-- print("Spawned Captain: "..count_2.."| New REST: "..GetMissionV(MS_RESTCOUNTNPC_2))
		count_3 = cd_addsomenpc(tbTNPC_SOLDIER[npccamp][3], AddNpcC_3, tbGuaiWu, tbAimPos, tbSOLDIER_NAME[3], 1, nil, tbFILE_NPCDEATH[3])
		SetMissionV( MS_RESTCOUNTNPC_3, GetMissionV( MS_RESTCOUNTNPC_3 ) + count_3 )
		-- print("Spawned Vanguard: "..count_3.."| New REST: "..GetMissionV(MS_RESTCOUNTNPC_3))

		count_4 = cd_addsomenpc(tbTNPC_SOLDIER[npccamp][4], AddNpcC_4, tbGuaiWu, tbAimPos, tbSOLDIER_NAME[4], 1, 1, tbFILE_NPCDEATH[4])
		SetMissionV( MS_RESTCOUNTNPC_4, GetMissionV( MS_RESTCOUNTNPC_4 ) + count_4 )
			-- print("Spawned General: "..count_4.."| New REST: "..GetMissionV(MS_RESTCOUNTNPC_4))
			-- print("=== DEBUG cd_callnpc END ===")
	--cd_writelog(date("%m%d%H%M ")..format("call xiaoxiao = %d, call duizhang = %d, call xianfeng = %d, call zhujiang = %d",count_1, count_2, count_3, count_4))
end

function cd_addsomenpc(npcid, num, tbnpcfile, tbaimfile, npctitle, boss, zhujiang, npcdeathfile)
	if ( num <= 0 ) then
		return 0
	end
	local file_num = getn( tbnpcfile )
	local commonxypos = {}
	local tbpos = {}
	local count = 0
	local tolcount = 0
	local posnum = 0
	
	for i = 1, file_num do
		count = 0
		if (i == 2) then
			tolnpc = num - floor( num * 2 / file_num )
		else
			tolnpc = floor( num * 1 / file_num )
		end
		tolcount = cd_addcommonnpc(tolnpc, tbnpcfile[i], tbaimfile[i], npcid, 95, npctitle, boss, zhujiang, npcdeathfile) + tolcount
	end
	-- print("Total spawned "..npctitle..": "..tolcount)
	return tolcount
end

function cd_addcommonnpc(tolnpc, bornfile, aimfile, npcid, npclevel, npctitle, boss, zhujiang, npcdeathfile)
	local count_1 = 0
	local count_2 = 0
	local citycamp = GetMissionV( MS_CITYCAMP )
	local npccamp = 1
	local npcname = "Qu©n Tèng "
	if ( citycamp == 1 ) then
		npccamp = 2
		npcname = "Qu©n Kim "
	end

	local tbborn_pos = {}
	local tbaim_pos = {}
	local bornfilehigh = GetTabFileHeight( bornfile ) - 1
	local aimfilehigh = GetTabFileHeight( aimfile ) - 1
		
	local posx = 0
	local posy = 0
	local npcindex = 0
	local s_npcid = npcid
	for j = 1, tolnpc do
		rannum_1 = random( bornfilehigh )
		posx, posy = bt_getadata(bornfile)

		aimx, aimy = bt_getadata(aimfile)
		
		if (zhujiang ~= nil) then
			s_npcid = npcid + random(0,1)
		end
--if (npctitle == "Õ¨µ¯³µ") then
		--print(npctitle, posx, posy)
--end
		npcindex = AddNpc( s_npcid, npclevel, SubWorld, posx, posy, 1, npcname..npctitle, boss )
		if( npcindex > 0 ) then
			SetNpcCurCamp( npcindex, npccamp )
			count_2 = count_2 + 1
			SetNpcDeathScript( npcindex, npcdeathfile )
			SetNpcAI(npcindex,9,200,-1,-1,-1,-1,-1,0,aimx, aimy);
		end
	end
	return count_2
end

function cd_sendmsg2msall(restnpc_1, restnpc_2, restnpc_3, restnpc_4, restnpc_5)
	
	
	local szMsg = "";
	if (GetMissionV(MS_SMALL_TIME) < CALLBOSS_ZHUSHUAI) then
		if ( restnpc_1 ~= 0 ) then
			szMsg = szMsg..tbSOLDIER_NAME[1].." <color=yellow>"..restnpc_1.."<color> ng­êi "
		end
		if ( restnpc_2 ~= 0 ) then
			szMsg = szMsg..tbSOLDIER_NAME[2].." <color=yellow>"..restnpc_2.."<color> ng­êi "
		end
		if ( restnpc_3 ~= 0 ) then
			szMsg = szMsg..tbSOLDIER_NAME[3].." <color=yellow>"..restnpc_3.."<color> ng­êi "
		end
		if ( restnpc_4 ~= 0 ) then
			szMsg = szMsg..tbSOLDIER_NAME[4].." <color=yellow>"..restnpc_4.."<color> ng­êi "
		end
	end
	if ( restnpc_5 ~= 0) then
		szMsg = szMsg..tbSOLDIER_NAME[5].." <color=yellow>"..restnpc_5.."<color> ng­êi "
	end
	if (szMsg == "") then
	else
		Msg2MSAll(MISSIONID, "<color=green>Thñ thµnh chiÕn th«ng b¸o: HiÖn binh lùc ®èi ph­¬ng lµ:"..szMsg)
	end
	--(date("%m%d%H%M\t")..format("d­ l¹i %s %d\t%s %d\t%s %d\t%s %d\t%s %d\t VÖ binh thñ thµnh %d",tbSOLDIER_NAME[1],restnpc_1,tbSOLDIER_NAME[2],restnpc_2,tbSOLDIER_NAME[3],restnpc_3,tbSOLDIER_NAME[4],restnpc_4,tbSOLDIER_NAME[5],restnpc_5, GetMissionV(MS_SHOUCHENGWEIBING)))
end

function cd_sendmsg2global()
	local szMsg = "VÖ quèc Phong Háa liªn thµnh"..GetMissionS(MS_S_CD_NAME).."ChiÕn tranh ®ang trong giai ®o¹n ¸c liÖt."..tbDEFENCE_ANNOUNCE[GetMissionV(MS_CITYCAMP)]
	AddGlobalNews(szMsg)
end

function call_boss_zhushuai()
	local npcfile = ZHUSHUAI_POSFILE--GetMissionS( MS_S_SRNPCFILE );
	local filehigh = GetTabFileHeight( npcfile ) - 1
	if ( filehigh <= 0 or filehigh == nil ) then
		print("zhushuai file error ")
		return
	end
	local citycamp = GetMissionV( MS_CITYCAMP )
	local npccamp = 1
	local npcname = "Qu©n Tèng"
	if ( citycamp == 1 ) then
		npccamp = 2
		npcname = "Qu©n Kim"
	end
	cd_addgoldennpc(npcfile, tbTNPC_SOLDIER[npccamp][5], tbSOLDIER_LEVEL[5], npcname..tbSOLDIER_NAME[5], 1, npccamp, tbFILE_NPCDEATH[5])
	--cd_writelog(date("%m%d%H%M ")..format(" call yuanshuai = %d", filehigh))

	SetMissionV( MS_BOSS5_DOWN, 1 )
	Msg2MSAll( MISSIONID, "<color=pink>Thñ thµnh chiÕn b¸o:"..npcname..tbSOLDIER_NAME[5].."Tù m×nh xuÊt trËn! C¸c Binh sÜ h·y cÈn thËn phßng thñ!!" )
end

function cd_addgoldennpc(npcfile, npcid, npclevel, npcname, boss, npccamp, deathscript)
	local posx = 0;
	local posy = 0;
	local npcindex = 0;
	local tbNpcpos = {};
	local aimx = 0
	local aimy = 0
	local filehigh = GetTabFileHeight(npcfile);
	for i = 1, filehigh - 1 do
		tbNpcpos[i] = i;
	end
	for i = 1, filehigh - 1 do
		rannum = random(filehigh - 1);
		temp = tbNpcpos[i];
		tbNpcpos[i] = tbNpcpos[rannum];
		tbNpcpos[rannum] = temp;
	end
	for i = 1, filehigh - 1 do
		
		if (tbNpcpos[i] >= 1 and tbNpcpos[i] <= 3) then
			aimfile = tbAimPos[1]
		elseif (tbNpcpos[i] >= 4 and tbNpcpos[i] <= 7) then
			aimfile = tbAimPos[2]
		else
			aimfile = tbAimPos[3]
		end
		posx = GetTabFileData( npcfile, tbNpcpos[i] + 1, 1 );
		posy = GetTabFileData( npcfile, tbNpcpos[i] + 1, 2 );
		aimx, aimy = bt_getadata(aimfile)
		series = floor((i - 1) / 2);
		npcindex = AddNpcEx( (npcid + i - 1), npclevel, series, SubWorld, posx, posy, 1, npcname, boss );
		if( npcindex > 0 ) then
			SetNpcCurCamp( npcindex, npccamp )
			SetNpcDeathScript( npcindex, deathscript )
			SetNpcAI(npcindex,9,20,-1,-1,-1,-1,-1,0,aimx, aimy);
		end
	end
end