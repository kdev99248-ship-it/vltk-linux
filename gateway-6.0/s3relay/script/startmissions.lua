Include("\\RelaySetting\\battle\\script\\rf_header.lua" )
Include("\\script\\event\\expansion\\201006\\fuguijinhe\\fuguijinhe.lua")
Include("\\RelaySetting\\Task\\hoatdong\\great_seed.lua")
Include("\\RelaySetting\\Task\\makegoldboss\\makegoldboss_0800.lua")
Include("\\RelaySetting\\Task\\makegoldboss\\callboss_incityhead.lua")
Include("\\RelaySetting\\Task\\boss\\small_goldboss_0400.lua")
Include("\\RelaySetting\\Task\\tongkim\\battle_1_honour.lua")
Include("\\RelaySetting\\Task\\hoatdong\\jiefang0804.lua")
Include("\\script\\mission\\boss\\bigboss.lua")
Include("\\script\\gb_modulefuncs.lua")
Include("\\script\\leaguematch\\timetable.lua")
Include("\\script\\leaguematch\\head.lua")
Include("\\script\\leaguematch\\switch.lua")
Include("\\script\\leaguematch\\task.lua")
Include("\\script\\gb_taskfuncs.lua")
Include("\\script\\mission\\sevencity\\war.lua")
Include("\\script\\tong\\tong_header.lua")
IncludeLib("TONG")
IncludeLib("FILESYS")

PLD_MODE_FILE = "/home/jxser/gateway/settings/pld_mode.cfg"

function GetPLDModeRelay()
	local f = openfile(PLD_MODE_FILE, "r")
	if (f == nil) then return 0 end
	local line = read(f, "*l")
	closefile(f)
	if (line == nil) then return 0 end
	local n = tonumber(line)
	if (n == nil) then return 0 end
	return n
end

function SetPLDModeRelay(nMode)
	local f = openfile(PLD_MODE_FILE, "w")
	if (f == nil) then return end
	write(f, tostring(nMode))
	closefile(f)
end

-- Auto reset khi Relay start
SetPLDModeRelay(0)
OutputMsg("[PLD] Auto reset on startup. Mode = "..GetPLDModeRelay())


function loanchiencuuchau()
	local szMsg = "Lo¹n ChiÕn Cöu Cèc ®· ®Õn giê b¸o danh, mäi ng­êi nhanh ch©n ®Õn L©m An gÆp Ch­ëng §¨ng Cung N÷ ®Ó ghi danh."
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 1)", szMsg))
	GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
	OutputMsg("=====> BAT DAU BAO DANH LOAN CHIEN CUU CHAU COC (datusha.lua)")
	RemoteExecute("\\script\\missions\\datusha\\datusha.lua", "DaTuShaClass:Open", 0);
end

function HoatDongDauNguu()
	local szMsg = "§Êu Ng­u ®· ®Õn giê b¸o danh, mäi ng­êi nhanh ch©n ®Õn L©m An gÆp Ch­ëng §¨ng Cung N÷ ®Ó ghi danh."
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 1)", szMsg))
	GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
	local szExec = format("dwf \\script\\missions\\dangboss\\dangbaossclass.lua tbDangBoss:StartGame()")
	--OutputMsg(szMsg)
	GlobalExecute(szExec)
	OutputMsg("=====> HOAT DONG DAU NGUU BAT DAU (dangboss.lua)");
end

function goinhimbeophi()
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            Goi Nhim Beo Phi [GM]");
	OutputMsg( " ========================================================================================");
	local szMsg = "Ho¹t ®éng giÕt NhÝm bÐo ph× ®· më, c¸c ®¹i hiÖp h·y mau nhanh ch©n ®Õn 7 Thµnh thÞ, 8 T©n thñ th«n ®Ó t×m!"
	GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
	GlobalExecute(format("dwf \\script\\event\\birthday_jieri\\200905\\panghaozhu\\addnpc_haozhu.lua birthday0905_addnpc_haozhu(%d)", 15));
end


function GoiHoaDang()
	local nWeek	= tonumber(date("%w"))
	GlobalExecute("dw create_lanterns()");
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            START Hoa Dang");
	OutputMsg( " ========================================================================================");
	GlobalExecute("dw Msg2SubWorld([[Ng­¬i nhanh ®i nói Thanh Thµnh, Vò Di s¬n, §iÓm Th­¬ng s¬n, Hoa S¬n,  chØ cÇn tr¶ lêi ®­îc 3 c©u nhËn ®­îc phÇn th­ëng hÊp dÉn]])");
		
end

function QuaHuyHoang()
	local nWeek = tonumber(date("%w"))
	local nDate = tonumber(date("%Y%m%d"));

	OutputMsg( " ========================================================================================");
	OutputMsg( "                            QUA_HUY_HOANG / QUA_HOANG_KIM [GM]");
	OutputMsg( " ========================================================================================");
	local nNowTime = tonumber(date("%H%M"))

	local nBatch = 2
	local nMapCount = getn(greatseed_configtab);
	for i = 1, nMapCount do
		local strExecute = format("dw Global_GreatSeedExecute(%d, %d, %d, [[%s]], [[%s]],%d)", greatseed_configtab[i][1], greatseed_configtab[i][2], greatseed_configtab[i][3], greatseed_configtab[i][4],greatseed_configtab[i][5],nBatch);
		GlobalExecute(strExecute);
		local szMsg = "";
		if (mod(nBatch,2) == 1) and greatseed_configtab[i][2] ~= 4 then
			szMsg = "H¹t Huy Hoµng"
		elseif greatseed_configtab[i][2] == 4 then
			szMsg = "H¹t Hoµng Kim"
		end; 
		if (mod(nBatch,2) == 0) and greatseed_configtab[i][2] == 1 then
			szMsg = "H¹t Huy Hoµng"
		elseif greatseed_configtab[i][2] == 2 then
			szMsg = "H¹t Huy Hoµng"
		elseif greatseed_configtab[i][2] == 3 then
			szMsg = "H¹t Huy Hoµng"
		elseif greatseed_configtab[i][2] == 4 then
			szMsg = "H¹t Hoµng Kim"
		end; 
		if (mod(nBatch,2) == 1) then
			szMsg = format("<color=0xa9ffe0>Vâ l©m minh chñ §éc C« KiÕm ®· gieo <color=yellow><%s><color> t¹i <color=yellow>%s<color>, 5 phót sau cã thÓ thu ho¹ch!!",
			szMsg,
			greatseed_configtab[i][5]);
			GlobalExecute(format("dw Msg2SubWorld([[%s]])",szMsg));
		elseif (mod(nBatch,2) == 0) then
			szMsg = format("<color=0xa9ffe0>GÆp thêi tiÕt thuËn lîi <color=yellow><%s><color> ®· kÕt qu¶ t¹i <color=yellow><%s><color>, C¸c §¹i HiÖp h·y nhanh chãng thu ho¹ch!!",
			szMsg,
			greatseed_configtab[i][5]);
			GlobalExecute(format("dw Msg2SubWorld([[%s]])",szMsg));
		end
	end;
end


function StartTongKim_3()
Battle_StartNewRound(1,3)
OutputMsg( " ========================================================================================");
OutputMsg( "                            Tong Kim Cao Cap [GM]");
OutputMsg( " ========================================================================================");
zMsg2SubWorld  = "<color=yellow>ChiÕn tr­êng Tèng - Kim ®· ®Õn giê b¸o danh, c¸c nh©n sÜ giang hå nhanh ch©n tham gia ®Çu qu©n, Thêi gian b¸o danh lµ 10 phót."
zAddLocalCountNews = "ChiÕn tr­êng Tèng Kim ®· b¾t ®Çu b¸o danh, c¸c nh©n sÜ giang hå mau ®Õn khu vùc b¸o danh ®Ó tham gia chiÕn tr­êng."
GlobalExecute(format("dw Msg2SubWorld([[%s]])",zMsg2SubWorld))
GlobalExecute(format("dw AddLocalCountNews([[%s]], 1)",zAddLocalCountNews))
end

function StartTongKim_4()
battle_StartNewIssue(2,3);
Battle_StartNewRound(2,3);
OutputMsg( " ========================================================================================");
OutputMsg( "                            Thien Tu [GM]");
OutputMsg( " ========================================================================================");
local szMsg  = format("<color=earth><color=yellow>Thiªn Tö Quèc ChiÕn<color> ®· më. <color=yellow>Tèng Quèc [%s]<color> vµ <color=pink>Kim Quèc [%s]<color>, xin mêi c¸c vÞ t­íng sÜ ®Õn tèng kim ®Ó ghi danh tham chiÕn !", CW_GetOccupant(7), CW_GetOccupant(4));
local szNews = format("dw AddLocalCountNews([[%s]], 2)", szMsg);
local szNewsSub = format("dw Msg2SubWorld([[%s]])", szMsg);
GlobalExecute(szNews);
GlobalExecute(szNewsSub);
end


function Call_BigBoss()
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            Boss Dai Hoang Kim [GM]");
	OutputMsg( " ========================================================================================");
	GlobalExecute("dw Xoa_BigBoss_Cu()")
	if BigBoss ~= nil then
		BigBoss.gold_boss_count = 0
		OutputMsg("GOLD BOSS COUNT RESET: 0")
	end
    TAB_CITY_EMPTY = {}
    qy_makeboss_onlyone_pos()
end

function Call_SmallBoss()
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            Boss Tieu Hoang Kim [GM]");
	OutputMsg( " ========================================================================================");
	GlobalExecute("dw CallBossDown_Fixure()")
end

function PhongLangDo()
	local nCurrent = GetPLDModeRelay()
	if (nCurrent ~= 0) then
		OutputMsg(" ============================================");
		OutputMsg(format("  [PLD] Dang co mode %d chay. Vui long doi mode hien tai chay het roi moi bam mode khac!", nCurrent));
		OutputMsg(" ============================================");
		local zMsg2SubWorld = format("<color=yellow>[GM Warning]<color> §ang cã <color=pink>Phong L¨ng §é mode %d<color> ch¹y, ph¶i ®îi kÕt thóc míi më mode kh¸c!", nCurrent)
		GlobalExecute(format("dw Msg2SubWorld([[%s]])", zMsg2SubWorld))
		return
	end
	SetPLDModeRelay(1)
	GlobalExecute("dwf \\script\\missions\\fengling_ferry\\fldmap_boat1.lua StartPLDNormal()")
	OutputMsg(" ============================================");
	OutputMsg("         Phong Lang Do THUONG [GM]");	
	OutputMsg(" ============================================");
	local szMsg = "BÕn thuyÒn Phong L¨ng §é ®· b¾t ®Çu më cña, c¸c vÞ §¹i hiÖp mau ®Õn bê nam gÆp thuyÒn phu b¸o danh ra tay tiªu diÖt thñy tÆc. CÇn LÖnh Bµi Phong L¨ng §é ®Ó lªn thuyÒn."
	local zMsg2SubWorld = "<color=0xa9ffe0>BÕn thuyÒn <color=yellow>Phong L¨ng §é<color> ®· b¾t ®Çu më cña, cÇn <color=yellow>LÖnh Bµi Phong L¨ng §é<color> ®Ó lªn thuyÒn. Thêi gian b¸o danh lµ <color=pink>1<color> phót."
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
	GlobalExecute(format("dw Msg2SubWorld([[%s]])", zMsg2SubWorld))
end

function PhongLangDoThuyTac()
	local nCurrent = GetPLDModeRelay()
	if (nCurrent ~= 0) then
		OutputMsg(" ============================================");
		OutputMsg(format("  [PLD] Dang co mode %d chay. Vui long doi mode hien tai chay het roi moi bam mode khac!", nCurrent));
		OutputMsg(" ============================================");
		local zMsg2SubWorld = format("<color=yellow>[GM Warning]<color> §ang cã <color=pink>Phong L¨ng §é mode %d<color> ch¹y, ph¶i ®îi kÕt thóc míi më mode kh¸c!", nCurrent)
		GlobalExecute(format("dw Msg2SubWorld([[%s]])", zMsg2SubWorld))
		return
	end
	SetPLDModeRelay(2)
	GlobalExecute("dwf \\script\\missions\\fengling_ferry\\fldmap_boat1.lua StartPLDThuyTac()")
	OutputMsg(" ============================================");
	OutputMsg("         Phong Lang Do THUY TAC [GM]");	
	OutputMsg(" ============================================");
	local szMsg = "BÕn thuyÒn Phong L¨ng §é (§Æc BiÖt) ®· b¾t ®Çu më cña, c¸c vÞ §¹i hiÖp mau ®Õn bê nam gÆp thuyÒn phu b¸o danh. CÇn LÖnh Bµi Thñy TÆc ®Ó lªn thuyÒn."
	local zMsg2SubWorld = "<color=0xa9ffe0>BÕn thuyÒn <color=yellow>Phong L¨ng §é (§Æc BiÖt)<color> ®· b¾t ®Çu më cña, cÇn <color=pink>LÖnh Bµi Thñy TÆc<color> ®Ó lªn thuyÒn. Thêi gian b¸o danh lµ <color=pink>1<color> phót."
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
	GlobalExecute(format("dw Msg2SubWorld([[%s]])", zMsg2SubWorld))
end

function PLDAutoEnd()
	SetPLDModeRelay(0)
end

function CTC_BaoDanh()
	local day = tonumber(date("%w"))
	-- ÖÜÎå
		RemoteExecute(
			REMOTE_SCRIPT,
			"RelayProtocol:StartSignup",
			0)
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            [SEVENCITY] Bat Dau Ghi Danh That Thanh Dai Chien [GM]");
	OutputMsg( " ========================================================================================");
	szMsg  = "<color=0xa9ffe0><color=yellow>[ThÊt Thµnh §¹i ChiÕn]<color> HiÖn T¹i §· Tíi Thêi Gian B¸o Danh, C¸c Bang Chñ H·y Tíi <color=green><NPC TiÕp §Çu C«ng Thµnh ChiÕn><color> T¹i ThÊt §¹i Thµnh ThÞ §Ó B¸o Danh!"
	GlobalExecute(format("dw Msg2SubWorld([[%s]])",szMsg))
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
end


function CTC_KetThucBaoDanh()
	local day = tonumber(date("%w"))
	-- ÖÜÎå
		RemoteExecute(
			REMOTE_SCRIPT,
			"RelayProtocol:CloseSignup",
			0)
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            [SEVENCITY] Ket Thuc Ghi Danh That Thanh Dai Chien [GM]");
	OutputMsg( " ========================================================================================");
	szMsg  = "<color=0xa9ffe0><color=yellow>[C«ng Thµnh ChiÕn]<color> Thêi Gian B¸o Danh §· §ãng.Thêi Gian Cã ThÓ Vµo B¶n §å Lµ <color=pink>20h00<color>"
	GlobalExecute(format("dw Msg2SubWorld([[%s]])",szMsg))
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
end


function CTC_ChuanBi()
	local day = tonumber(date("%w"))
	-- ÖÜÎå
		BattleWorld:Clear()
		RemoteExecute(
			REMOTE_SCRIPT,
			"RelayProtocol:Prepare",
			0)
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            [SEVENCITY] Chuan Bi That Thanh Dai Chien [GM]");
	OutputMsg( " ========================================================================================");
	szMsg  = "<color=0xa9ffe0><color=yellow>[C«ng Thµnh ChiÕn]<color> HiÖn T¹i §· Cã ThÓ Vµo B¶n §å. Thêi Gian Khai ChiÕn ChÝnh Thøc Lµ <color=pink>20h30<color>"
	GlobalExecute(format("dw Msg2SubWorld([[%s]])",szMsg))
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
end


function CTC_BatDau()
	local day = tonumber(date("%w"))
	RemoteExecute(REMOTE_SCRIPT, "RelayProtocol:CloseSignup", 0)   -- dong dang ky
	BattleWorld:Clear()                                             -- reset state
	RemoteExecute(REMOTE_SCRIPT, "RelayProtocol:Prepare", 0)       -- tao Long Tru
	RemoteExecute(REMOTE_SCRIPT, "RelayProtocol:Start", 0)      
	-- ÖÜÎå
	--	RemoteExecute(
	--		REMOTE_SCRIPT,
	--		"RelayProtocol:Start",
	--		0)
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            [SEVENCITY] Bat Dau That Thanh Dai Chien [GM]");
	OutputMsg( " ========================================================================================");
	szMsg  = "<color=0xa9ffe0><color=yellow>[ThÊt Thµnh §¹i ChiÕn]<color> Thêi Gian Khai ChiÕn ChÝnh Thøc B¾t §Çu!"
	GlobalExecute(format("dw Msg2SubWorld([[%s]])",szMsg))
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
end

function CTC_KetThuc()
	local day = tonumber(date("%w"))
	-- ÖÜÎå
		BattleWorld:Close()
		RemoteExecute(
			REMOTE_SCRIPT,
			"RelayProtocol:Close",
			0)
	OutputMsg( " ========================================================================================");
	OutputMsg( "                            [SEVENCITY] Ket Thuc That Thanh Dai Chien [GM]");
	OutputMsg( " ========================================================================================");
	szMsg  = "<color=0xa9ffe0><color=yellow>[C«ng Thµnh ChiÕn]<color> ChiÕn KÕt Thóc. C¸c Bang Chñ Bang ChiÕm Gi÷ §­îc Thµnh Cã ThÓ Tíi GÆp NPC <color=green><NPC TiÕp §Çu C«ng Thµnh ChiÕn><color> §Ó NhËn Th­ëng!"
	GlobalExecute(format("dw Msg2SubWorld([[%s]])",szMsg))
	GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
end

function CTC_XoaDuLieu()
	local day = tonumber(date("%w"))
	local nTongID = TONG_GetFirstTong();--Xãa Task NhËn Th­ëng CTC TungEns 20/09/2023
		while(nTongID and nTongID ~= 0)do
			for i = 5002,5008 do
				TONG_ApplySetTaskValue(nTongID, i, 0);
			end
			nTongID = TONG_GetNextTong(nTongID);
		end	
	-- ÖÜÎå
		BattleWorld:Clear()
		RemoteExecute(
			REMOTE_SCRIPT,
			"RelayProtocol:Prepare",
			0)
	OutputMsg( " ========================================================================================");
	OutputMsg( "                               [SEVENCITY] Xoa Du Lieu [GM]");
	OutputMsg( " ========================================================================================");
end

-- ============================================================
-- [GM] LIEN DAU - MO NHANH
-- ============================================================

--Lay season id hien tai hop le, nil neu khong co
function LienDauGetCurrentSid()
	local n_date = tonumber(date("%y%m%d"))
	local n_sid = 0
	for i, tb in WLLS_SEASON_TB do
		if (i > n_sid and n_date >= tb[2] and n_date <= tb[3]) then
			n_sid = i
		end
	end
	if n_sid == 0 then
		return nil
	end
	return n_sid, n_date
end

--Mo nhanh Lien Dau: ep phase=4, tao tran moi ngay trong 15 phut
function StartLienDauNhanh()
	local n_sid, n_date = LienDauGetCurrentSid()
	if (not n_sid) then
		OutputMsg(" ========================================================================================");
		OutputMsg("  [LIEN DAU] LOI: Hom nay khong nam trong season hop le!");
		OutputMsg("             Kiem tra WLLS_SEASON_TB trong timetable.lua");
		OutputMsg(" ========================================================================================");
		return
	end

	local n_phase = 4  
	local n_matchid = n_date * 100 + 9  

	SetGblInt(RLGLB_WLLS_PHASE, n_phase)
	wlls_set_mid(n_sid, n_matchid)

	--Clear server count
	for i = RLGLB_WLLS_SVRCOUNT+1, RLGLB_WLLS_SVRCOUNT+20 do
		SetGblInt(i, 0)
	end

	--Notify GameServer
	wlls_set_phase(n_phase, n_matchid, n_sid)

	OutputMsg(" ========================================================================================");
	OutputMsg(format("  [LIEN DAU] MO NHANH - Phase=%d  MatchID=%d  SeasonID=%d  Type=%d",
		n_phase, n_matchid, n_sid, WLLS_SEASON_TB[n_sid][1]));
	OutputMsg(" ========================================================================================");
end

