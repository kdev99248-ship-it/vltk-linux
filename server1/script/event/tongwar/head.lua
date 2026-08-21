Include("\\script\\event\\tongwar\\headinfo.lua")
Include("\\script\\event\\tongwar\\tongwar_signup.lua")
Include("\\script\\task\\random\\treasure_head.lua");
Include("\\script\\tong\\tong_header.lua");
Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\dailogsys\\dailogsay.lua")
IL("TONG");
_TONGWAR_CITYOWNER = {}


--Èç¹ûÎªnil»ò0£¬·µ»Ø1£¬·ñÔò·µ»Ø0
function FALSE(value)
	if (value == 0 or value == nil or value == "") then
		return 1
	else
		return nil
	end
end

--´´½¨7³ÇÖ÷µÄÁÙÊ±ÁªÃË
function tongwar_create()
	if (getn(_TONGWAR_CITYOWNER) ~= 0 and _TONGWAR_CITYOWNER[1][3] == get_tongwar_season()) then
		return
	end
	local nseason = get_tongwar_season();
	local n_lid = LG_GetFirstLeague(TONGWAR_LGTYPE)
--	if (FALSE(n_lid)) then
--		return
--	end
	for i = 1, 7 do
		_TONGWAR_CITYOWNER[i] = {}
		_TONGWAR_CITYOWNER[i][1] = TONGWAR_CITY[i]
		_TONGWAR_CITYOWNER[i][2] = tongwar_getmember(TONGWAR_CITY[i])
		_TONGWAR_CITYOWNER[1][3] = nseason;
	end
end

--»ñµÃÄ³¸ö³ÇÊÐµÄÁªÃË ·µ»Øtable
function tongwar_getmember(s_lname)
	local tb_member = {}
	local n_lid = LG_GetLeagueObj(TONGWAR_LGTYPE, s_lname)
	local n_count = LG_GetMemberCount(n_lid)
	for i = 0, (n_count - 1) do
		local tongname, n_job = LG_GetMemberInfo(n_lid, i)
		tb_member[getn(tb_member) + 1] = {tongname, n_job}
	end
	return tb_member
end

--±ÈÈü½áÊøºó£¬¸ø7³ÇÖ÷°´»ý·Ö¼°¾²»ý·ÖÅÅÃû´Î
_TONGWAR_ARRRANK = {};
_TONGWAR_ROLELADDER = {};
function tongwar_bigger(lg1, lg2)
	if (lg1[2] == lg2[2]) then
		return lg1[3] > lg2[3];
	end;
	return lg1[2] > lg2[2];
end;

function tongwar_cityrank()
--¶ÔÕ½¼¨×÷ÅÅÐò
	for i = 1, 7 do
		_TONGWAR_ARRRANK[i] = {};
		_TONGWAR_ARRRANK[i][1] = _TONGWAR_CITYOWNER[i][1];
		_TONGWAR_ARRRANK[i][2] = LG_GetLeagueTask(TONGWAR_LGTYPE, _TONGWAR_CITYOWNER[i][1], TONGWAR_LGTASK_RESULT);
		_TONGWAR_ARRRANK[i][3] = LG_GetLeagueTask(TONGWAR_LGTYPE, _TONGWAR_CITYOWNER[i][1], TONGWAR_LGTASK_POINT);
		_TONGWAR_ARRRANK[i][4] = LG_GetLeagueTask(TONGWAR_LGTYPE, _TONGWAR_CITYOWNER[i][1], TONGWAR_LGTASK_TONGID);
	end;
	sort(_TONGWAR_ARRRANK, tongwar_bigger);
	for i = 1, 7 do
		LG_ApplySetLeagueTask(TONGWAR_LGTYPE, _TONGWAR_ARRRANK[i][1], TONGWAR_LGTASK_RANK, i, "", "");
	end;
--	gb_SetTask("TONGWAR_STATION", 1, _TONGWAR_ARRRANK[1][4]);
end;

function get_tongwar_phase()
	return gb_GetTask("TONGWAR_STATION", 2);
end;

function tongWar_SelectCity(strCityName, strCityTongName)
	if tongWar_CanSelectCity() ~= 1 then
		return
	end
	if get_tongwar_phase() ~= 1 then
		return
	end
	
	nseason = get_tongwar_season()
	if (FALSE(LG_GetLeagueObj(TONGWAR_LGTYPE, strCityName))) then
		local nLeagueID = LG_CreateLeagueObj()
		LG_SetLeagueInfo(nLeagueID, TONGWAR_LGTYPE, strCityName)
		LG_ApplyAddLeague(nLeagueID, "", "")
		LG_FreeLeagueObj(nLeagueID)
		LG_ApplySetLeagueTask(TONGWAR_LGTYPE, strCityName, TONGWAR_LGTASK_SEASON, nseason);
		
		if (not FALSE(strCityTongName))then
				nMemberID = LGM_CreateMemberObj()
				--ÉèÖÃÉçÍÅ³ÉÔ±µÄÐÅÏ¢(½ÇÉ«Ãû¡¢Ö°Î»¡¢ÉçÍÅÀµÐÍ¡¢ÉçÍÅÃû³Æ)
				LGM_SetMemberInfo(nMemberID, strCityTongName, 1, TONGWAR_LGTYPE, strCityName)
				LGM_ApplyAddMember(nMemberID, "", "")
				LGM_FreeMemberObj(nMemberID)
				LG_ApplySetMemberTask(TONGWAR_LGTYPE, strCityName, strCityTongName, TONGWAR_LGMTASK_JOB, 1)
		end
		
		
	end
end

function tongWar_CanSelectCity()
	local szTongName = GetTongName();
	
	if szTongName == nil or szTongName == "" then
		return
	end
	
	if (GetTongFigure() ~= TONG_MASTER) then --ÅÐ¶ÏÊÇ·ñÊÇ°ïÖ÷
		return
	end
	--Èç¹ûÒÑ¾­ÓÐÕ½¶ÓÁË¿Ï¶¨²»ÓÃÑ¡³ÇÊÐ
	if not FALSE(LG_GetLeagueObjByRole(TONGWAR_LGTYPE, szTongName)	) then 
		return
	end
	local tb = {}
	for i = 1, 7 do
		if GetCityOwner(i) == szTongName then --Ã»Õ½¶ÓÇÒÊÇÕ¼³Ç°ï»á
			return 1
		end
	end
end

function tongWar_ShowSelectCityMenu()
	local szTongName = GetTongName();
	
	if szTongName == nil or szTongName == "" then
		return
	end
	
	if (GetTongFigure() ~= TONG_MASTER) then --ÅÐ¶ÏÊÇ·ñÊÇ°ïÖ÷
		return
	end
	local tb = {}
	for i = 1, 7 do
		local strCityName = GetCityAreaName(i)
		local strCityTongName = GetCityOwner(i)
		tb[strCityTongName] = tb[strCityTongName] or {}
		tinsert(tb[strCityTongName], strCityName)
	end
	local tbCity = tb[szTongName]
	if tbCity then
		local szTitle = "Lùa chän muèn thay thÕ biÓu tham gia so tµi thµnh thÞ, nÕu nh­ ®¾t gióp chiÕm thµnh phè nhiÒu 1 c¸ chØ cã thÓ ®¹i biÓu mét thµnh phè tham gia ®Ö nhÊt bang."
		local tbOpt = {}
		for i=1, getn(tbCity) do
			
			tinsert(tbOpt, {tbCity[i], tongWar_SelectCity, { tbCity[i], szTongName}})
		end
		CreateNewSayEx(szTitle, tbOpt)
	end
	
end

function tongWar_AddSelectCityOpt(tbOpt)
	
	if tongWar_CanSelectCity() then
		tinsert(tbOpt, 2, "Chän ®¹i diÖn thµnh thÞ mong muèn tham gia cuéc thi/tongWar_ShowSelectCityMenu")
	end
	
end

function tongWar_Start()
	tongwar_create()
	if (getn(_TONGWAR_CITYOWNER) == 0) then
		CreateTaskSay({"<dec><npc>Minh chñ vâ l©m hiÖu lÖnh : ë b¶y ®¹i thµnh thÞ cïng liªn minh gióp chiÕm thµnh ®Ých bang héi cã thÓ tiÕn vµo dµnh riªng khu vùc tranh ®o¹t tµi vËt, tíi ph©n ra c¸i nµo bang héi trë thµnh vâ l©m ®Ö nhÊt bang. §Ö nhÊt bang ®em trë l¹i phong phó t­ëng th­ëng ®· cao quý danh hiÖu","KÕt thóc ®èi tho¹i/OnCancel"});
		return 
	end;
	
	tongwar_clear_rlpoint();
	
	local nDate = tonumber(GetLocalDate("%y%m%d"));
	local szContent = {"<dec><npc>Vâ l©m ®Ö nhÊt bang tranh ®o¹t s¾p b¾t ®Çu. Tr­íc m¾t, c¸c bang bang chñ cã thÓ thay v× h¾n chiÕm thµnh bang chñ liªn minh ®øng lªn tranh tµi. Tranh tµi mét khi b¾t ®Çu th× kh«ng thÓ söa ®æi liªn minh"};
	if (get_tongwar_phase() == 1) then	--×é¶Ó
		
		
		tongWar_AddSelectCityOpt(szContent)
		
		
		tinsert(szContent, "§ång minh gia nhËp bang héi liªn minh/tongwar_onjoin");
		tinsert(szContent, "ChiÕm thµnh bang héi ë c¸c thµnh thÞ/tongwar_cityowner");
		
	elseif (get_tongwar_phase() == 2) then	-- ±ÈÈüÆÚ¼ä
		
		tinsert(szContent, "Ta muèn tham gia tranh tµi/tongwar_want2signup");
		tinsert(szContent, "Xem bang héi chiÕm thµnh liªn minh thµnh tÝch/tongwar_rank");
		tinsert(szContent, "ChiÕm thµnh bang héi ë c¸c thµnh thÞ/tongwar_cityowner");
		
	elseif (get_tongwar_phase() == 3) then	--½±ÀøÊ±¼ä
		
		if (getn(_TONGWAR_ARRRANK) == 0) then
			tongwar_cityrank();
		end;
		tinsert(szContent,"NhËn lÊy danh hiÖu vâ l©m ®Ö nhÊt bang/tongwar_title_talk");
		tinsert(szContent, "NhËn lÊy phÇn th­ëng vâ l©m ®Ö nhÊt bang/tongwar_aword_talk");
		tinsert(szContent, "Xem bang héi chiÕm thµnh ®øng hµng b¶ng/tongwar_query");
		tinsert(szContent, "ChiÕm thµnh bang héi ë c¸c thµnh thÞ/tongwar_cityowner");
	end;
							
	tinsert(szContent, "Ho¹t ®éng vâ l©m ®Ö nhÊt bang/tongwar_detail");
	tinsert(szContent, "KÕt thóc ®èi tho¹i/OnCancel");
	
	CreateTaskSay(szContent);
end

function tongwar_title_talk() --ÁìÈ¡ÌìÏ¢µÚÒ»°ïµÄ³ÆºÅ
	if (GetByte(GetTask(TONGWAR_RLTASK_AWARD),1) == get_tongwar_season()) then --°ïÖ÷³ÆºÅÓÀ¾Ã°ó¶¨
		Msg2Player("B¹n sÏ cã ®­îc danh hiÖu<color=red>vâ l©m ®Ö nhÊt bang<color> nhËn.")
		CreateTaskSay({"<dec><npc>§· nhËn lÊy danh hiÖu<color=red>vâ l©m ®Ö nhÊt bang<color> nhËn.", "KÕt thóc ®èi tho¹i/OnCancel"});
		return
	end;        
	
	local szTongName = GetTong();
	if (FALSE(szTongName)) then
		CreateTaskSay({"<dec><npc>Kh«ng ®ñ ®iÒu kiÖn nhËn lÊy danh hiÖu<color=red>vâ l©m ®Ö nhÊt bang<color>.", "KÕt thóc ®èi tho¹i/OnCancel"});
		return
	end;           
	
	local nLeagueID = LG_GetLeagueObjByRole(TONGWAR_LGTYPE, szTongName);
	if (FALSE(nLeagueID)) then
		CreateTaskSay({"<dec><npc>Kh«ng ®ñ ®iÒu kiÖn nhËn lÊy danh hiÖu<color=red>vâ l©m ®Ö nhÊt bang<color>.", "KÕt thóc ®èi tho¹i/OnCancel"});
		return
	end;
	
	local szLeagueName = LG_GetLeagueInfo(nLeagueID);
	
	if (szLeagueName ~= _TONGWAR_ARRRANK[1][1] or FALSE(tongwar_check_ownerright())) then
		CreateTaskSay({"<dec><npc>ChØ cã xÕp hµng thø nhÊt ®Ých chiÕm thµnh gióp thµnh viªn míi cã thÓ ®¹t ®­îc nªn danh hiÖu.", "KÕt thóc ®èi tho¹i/OnCancel"});
		return
	end;
	
	tongwar_title_award(szLeagueName);
end;

function tongwar_title_award(szlgname)
	SetTask(TONGWAR_RLTASK_AWARD, SetByte(GetTask(TONGWAR_RLTASK_AWARD), 1, get_tongwar_season()));
	if (GetTongMaster() == GetName() and LG_GetLeagueTask(TONGWAR_LGTYPE, szlgname, TONGWAR_LGTASK_MSTITLE) < 1) then
		Msg2Player("§¹t ®­îc danh hiÖu<color=green>minh chñ vâ l©m<color>");
		CreateTaskSay({"<dec><npc>Chóc mõng ngµi ®¹t ®­îc danh hiÖu<color=yellow>minh chñ vâ l©m<color>.", "KÕt thóc ®èi tho¹i/OnCancel"});
		tongwar_addtitle(105);--°ïÖ÷¹â»·
		tongwar_award_log("§¹t ®­îc danh hiÖu minh chñ vâ l©m");
		LG_ApplyAppendLeagueTask(TONGWAR_LGTYPE, szlgname, TONGWAR_LGTASK_MSTITLE, 1);
	else
		Msg2Player("§¹t ®­îc danh hiÖu<color=green>vâ l©m ®Ö nhÊt bang<color>");
		CreateTaskSay({"<dec><npc>Chóc mõng ngµi ®¹t ®­îc <color=yellow> danh hiÖu vâ l©m ®Ö nhÊt bang<color>.", "KÕt thóc ®èi tho¹i/OnCancel"});
		tongwar_addtitle(106);--°ïÖÚ¹â»·
		tongwar_award_log("§¹t ®­îc vâ l©m ®Ö nhÊt bang danh hiÖu.");
	end;
end;

function tongwar_addtitle(n_title)
	local nDate	= tonumber(GetLocalDate("%m%d"));
	local nDay	= mod(nDate,100)
	local nMon	= floor(nDate/100)
	nMon	= nMon + floor((nDay + 30)/30);
	nDay = mod((nDay + 30),30);
	local nTime	= mod(FormatTime2Number(GetCurServerTime()+30*24*60*60), 100000000)--nMon * 1000000 + nDay * 10000	-- 

	Title_AddTitle(n_title, 2, nTime);
	Title_ActiveTitle(n_title);
	SetTask(1122, n_title)
end;

function tongwar_query()
	local szmsg = "<dec><npc>Vâ l©m ®Ö nhÊt bang quyÕt cuéc so tµi ®· kÕt thóc , kÕt qu¶ nh­ sau: \n"
	for i = 1, 7 do
		szmsg = format("%s -  <color=red>%d<color>: <color=yellow>chiÕm thµnh Tæng ®iÓm lµ %s: %d  §iÓm tranh tµi : %d<color>  <enter>",
												szmsg, i, _TONGWAR_ARRRANK[i][1], _TONGWAR_ARRRANK[i][2], _TONGWAR_ARRRANK[i][3]);
	end;
	CreateTaskSay({szmsg, "KÕt thóc ®èi tho¹i/OnCancel"});
end;

function OnCancel()
end

function tongwar_cityowner()
	local tb_Opp = {"<dec><npc>Bang héi chiÕm b¶y ®¹i thµnh thÞ ®· ph©n ra, xin mêi lùa chän muèn xem th«ng tin thµnh thÞ:"};
	tb_Opp[getn(tb_Opp) + 1] = "H«m nay ®èi thñ lµ bang héi liªn minh nµo /tongwar_enemy";
	for i=1,7 do
		tb_Opp[getn(tb_Opp) + 1] = format("chiÕm thµnh bang héi%s/#tongwar_cityowner_qur(%d)",
																			TONGWAR_CITY[i],i);
	end
	tb_Opp[getn(tb_Opp) + 1] = "Trë vÒ/tongWar_Start";

	CreateTaskSay(tb_Opp);
end

function tongwar_cityowner_qur(nSel)
	local cityname = _TONGWAR_CITYOWNER[nSel][1];
	local tb_citymember = _TONGWAR_CITYOWNER[nSel][2];
	local n_lid = LG_GetLeagueObj(TONGWAR_LGTYPE, cityname);
	
	if (FALSE(n_lid)) then
		local szmsg = format("<dec><npc>Kh«ng cã bang héi liªn minh tham gia vâ l©m ®Ö nhÊt bang tµi vËt tranh ®o¹t tranh tµi.", cityname);
		CreateTaskSay({szmsg, "Trë vÒ/tongwar_cityowner", "KÕt thóc/OnCancel"});
		return
	end;
	
	local n_count = LG_GetMemberCount(n_lid);
	if (getn(tb_citymember) ~= n_count) then	--³ÉÔ±ÔÚTempTableÖÐ£¬·ÃÎÊÊ±Èç¹ûÈ·ÈÏ
																						--³ÉÔ±Êý²»ÊÇ×îÐ¢£¬ÔòË¢Ð¢Ï¢
		_TONGWAR_CITYOWNER[nSel][2] = tongwar_getmember(TONGWAR_CITY[nSel])
		tb_citymember = _TONGWAR_CITYOWNER[nSel][2]
	end
	
	local cityowner = ""
	local citymember = ""
	for i = 1, getn(tb_citymember) do
		if (tb_citymember[i][2] == 1) then
			cityowner = tb_citymember[i][1]
		else
			citymember = format("%s\n    <color=yellow>%s<color>", 
														citymember, tb_citymember[i][1]);
		end
	end
	local szmsg = "";
	if (cityowner == "") then
		szmsg = format("<dec><npc>Thµnh %s kh«ng cã bang héi liªn minh tham gia vâ l©m ®Ö nhÊt bang tµi vËt tranh ®o¹t tranh tµi.", cityname);
		CreateTaskSay({szmsg, "Trë l¹i/tongwar_cityowner", "KÕt thóc/OnCancel"});
		return 
	elseif (citymember == "") then
		szmsg = format("<dec><npc>ChiÕm thµnh bang héi %s lµ <color=red>%s<color>, cã liªn minh v× \n <kh«ng cã>", 
															cityname, cityowner);
	else
		szmsg = format("<dec><npc>ChiÕm thµnh bang héi %s lµ <color=red>%s<color>, cã liªn minh v× %s", 
															cityname, cityowner, citymember);
	end
	
	local nResult = LG_GetLeagueTask(n_lid, TONGWAR_LGTASK_RESULT);	--×Ü»ý·Ö
	local nPoint = LG_GetLeagueTask(n_lid, TONGWAR_LGTASK_POINT);		--¾»»ý·Ö
	szmsg = format("%s\n liªn minh tæng ®iÓm: <color=yellow>%d<color><enter>   tæng chia lµm  <color=yellow>%d<color>", szmsg, nResult, nPoint);
	CreateTaskSay({szmsg, "Trë l¹i/tongwar_cityowner", "KÕt thóc/OnCancel"});
end

function tongwar_onjoin()
	if (FALSE(tongwar_check_ownerright(1))) then
		CreateTaskSay({"<dec><npc>ChØ cã <color=red> chiÕm thµnh gióp mét tay chñ <color> míi cã thÓ thµnh lËp bang héi liªn minh.",
										 "KÕt thóc/OnCancel"});
		return
	end;
	CreateTaskSay({"<dec><npc>ChiÕm thµnh gióp mét tay chñ cã thÓ cïng kh«ng chiÕm thµnh gióp ®Ých bang chñ häp thµnh ®éi kÕt minh , muèn thµnh lËp liªn minh sao?",
					 				"Xin cho phÐp gia nhËp liªn minh bang héi/tongwar_want2join",
					  			"KÕt thóc/OnCancel"});
end

--ÅÐ¶ÏÊÇ²»ÊÇÕ¼³Ç°ïµÄ°ïÖ÷
function tongwar_check_ownerright(bmaster)
	local tongname = GetTongName();
	if (bmaster) then
		-- LLG_ALLINONE_TODO_20070802
		if (GetTongFigure() ~= TONG_MASTER) then --ÅÐ¶ÏÊÇ·ñÊÇ°ïÖ÷
			return nil
		end;
	end;
	local n_lid = LG_GetLeagueObjByRole(TONGWAR_LGTYPE, tongname)
	if (not FALSE(n_lid)) then
		local leaguename = LG_GetLeagueInfo(n_lid)
		if (LG_GetMemberTask(TONGWAR_LGTYPE, leaguename, tongname, TONGWAR_LGMTASK_JOB) == 1) then
			return n_lid
		end
	end

	return nil
end

function tongwar_want2join()
	if (GetTeamSize() <= 1) then
		CreateTaskSay({"<dec><npc>ThËt lµ tiÕc nuèi, häp thµnh ®éi v× v« Ých, kh«ng thÓ kÕt lµm liªn minh!",
										 "KÕt thóc/OnCancel"});
		return
	end;
	
	if (IsCaptain() ~= 1) then
		CreateTaskSay({"<dec><npc>ChØ cã <color=red> tæ tr­ëng <color> míi cã thÓ thay v× h¾n bang héi ®Ých bang chñ kÕt lµm liªn minh.", "KÕt thóc/OnCancel"});
		return
	end;
	
	local tb_teammember = tongwar_check_team();
	if (tb_teammember == nil) then
		return
	end
	
	local szmsg = format("Muèn tiÕp n¹p %d trë xuèng bang héi tiÕn vµo liªn minh sao?",getn(tb_teammember))
	for i=1,getn(tb_teammember) do
		szmsg = format("%s\n<color=yellow>%s<color>",szmsg,tb_teammember[i]);
	end
	CreateTaskSay({szmsg, "Muèn/tongwar_sure2join", "Kh«ng cÇn!/OnCancel"});
end

function tongwar_sure2join()
	local tb_teammember, tb_rolename, teamtongid = tongwar_check_team();
	if (tb_teammember == nil) then
		return
	end
	local tongname, mytongid = GetTongName();
	local n_lid = LG_GetLeagueObjByRole(TONGWAR_LGTYPE, tongname)
	if (FALSE(n_lid)) then
		return
	end
	local str_lgname = LG_GetLeagueInfo(n_lid)
	local ncityid = TONGWAR_CITYID[str_lgname];
	if (FALSE(ncityid)) then
		print(format("Error!!! CityName(leaguename) Wrong!!%s",str_lgname))
		return
	end;
	for i = 1, getn(tb_teammember) do
		--¶ÓÓÑ°ï»áÃû£¬¶ÓÓÑÃû£¬Õ½¶ÓÃû£¬¶Ó³¤Ãû£¬¶Ó³¤°ï»áID
		--local szParam = tb_teammember[i].." "..tb_rolename[i].." "..str_lgname.." "..GetName()
		local szParam = tostring(teamtongid[i]).." "..tb_rolename[i].." "..ncityid.." "..GetName().." "..mytongid;
		LG_ApplyDoScript(0, "", tb_teammember[i], "\\script\\event\\tongwar\\event.lua", "tongwar_add", szParam , "", "")
	end
end

--¼ì²é×é¶Ô¶ÓÓÑÊÇ·ñ·ûºÏ¼ÓÈëÁªÃËµÄÌõ¼þ
--·ûºÏ ·µ»Ø tab1(°ï»áÃû),tab2(°ïÖ÷Ãû),tab3(°ï»áid)
--²»¢ú×ã ·µ»Ø nil
function tongwar_check_team()
	local teammember = {};
	local tongmaster = {};
	local teamtongid = {};
	local str_capname = GetName();
	local str_captong = GetTongName();
	local teamsize = GetTeamSize();
	local n_capidx = PlayerIndex;
	for i = 2 , teamsize do
		PlayerIndex = GetTeamMember(i);
		local membername = GetName();
		local tongname, tongid = GetTongName();
		local szmsg = "";
		
		if (FALSE(tongid)) then
			PlayerIndex = n_capidx;
			szmsg = format("<dec><npc>Thµnh viªn %s ë trong ®éi kh«ng ph¶i lµ bang héi thµnh viªn , kh«ng thÓ gia nhËp liªn minh.",
											 membername);
			CreateTaskSay({szmsg, "KÕt thóc/OnCancel"});
			return
		end;
		
		if (GetTongFigure() ~= TONG_MASTER) then
			PlayerIndex = n_capidx;
			szmsg = format("<dec><npc>§èi ph­¬ng kh«ng ph¶i lµ bang chñ , kh«ng thÓ nhËn vµo liªn minh.",
											 tongname, membername, tongname);
			CreateTaskSay({szmsg, "KÕt thóc°/OnCancel"});
			return
		end
		
		--±ÜÃâÖØ¸´¼ÓÈë¶ÓÔ±
		if (not FALSE(LG_GetLeagueObjByRole(TONGWAR_LGTYPE, tongname))) then
			if (LG_GetLeagueObjByRole(TONGWAR_LGTYPE, str_captong) == LG_GetLeagueObjByRole(TONGWAR_LGTYPE, tongname)) then
				szmsg = format("<dec><npc>Bang héi %s vµ %s ®· gia nhËp liªn minh.",
													membername, tongname);
			else
		 		szmsg = format("<dec><npc>Bang héi %s vµ %s ®· gia nhËp nh÷ng kh¸c liªn minh, kh«ng thÓ gia nhËp ngµi ®Ých bang héi liªn minh!",
													membername, tongname);
			end;
		 	PlayerIndex = n_capidx;
		 	CreateTaskSay({szmsg, "KÕt thóc/OnCancel"});
		 	return 
		end
		teammember[i-1] = tongname;
		tongmaster[i-1] = membername;
		teamtongid[i-1] = tongid;
	end
	PlayerIndex = n_capidx
	return teammember, tongmaster, teamtongid
end

function tongwar_calendar()
	local str = "<dec><npc>"
	for i = 1, getn(TONGWAR_CALENDAR) do
		str = format("%s\n%s",str,TONGWAR_CALENDAR[i]);
	end
	CreateTaskSay({str, "KÕt thóc/OnCancel"});
end

function tongwar_detail()
--VLDNB 11 - ¸ü¸ÄÍ¨Öª- Modified by DinhHQ - 20120507
	CreateTaskSay({format("<dec><npc>Tõ <color=green>%s <color> ®Õn <color=green>%s<color>, trõ <color=green>18/05/2012<color>, mçi ngµy lµ mét cuéc tranh tµi bªn ngoµi ( tranh tµi ngµy buæi tèi ®Ých chuÈn bÞ thêi gian tõ <color=green>08: 00~08: 29<color>, tranh tµi thêi gian lµ <color=green>08:30~09:30<color>), mçi ngµy cã 3 trµng ®ång thêi ®Ých tranh tµi, ®ång thêi ®em cã mét bang héi kh«ng cã tranh tµi. Hoa hång bang héi cïng liªn minh cïng nhau chiÕm lÜnh thµnh phè ®em cïng nhau cïng <color=green>6<color> nh÷ng thµnh thÞ kh¸c cïng liªn minh tranh tµi .","16/05/2012", "23/05/2020"), 
		"Xem xÐtchiÕm thµnh bang héi tranh tµi trong ngµy/tongwar_calendar", "Trë vÒ/tongWar_Start", "KÕt thóc!/OnCancel"});
end;

function tongwar_join()
	
end;

function tongwar_enemy()
	local szmsg = ""
	local szTongName = GetTongName();
	if ("" == szTongName) then
		CreateTaskSay({"<dec><npc>Kh«ng gia nhËp bang héi th× kh«ng thÓ tham gia tranh tµi.", "Trë vÒ/tongwar_cityowner", "KÕt thóc/OnCancel"});
		return
	end;
	local HostLeagueID = LG_GetLeagueObjByRole(TONGWAR_LGTYPE, szTongName);
	if (0 == HostLeagueID) then
		CreateTaskSay({"<dec><npc>Ngµi ®Ých bang héi v× gia nhËp bÊt kú liªn minh , kh«ng cã quyÒn tham gia tranh tµi!", "Trë vÒ/tongwar_cityowner", "Trë vÒ!/OnCancel"});
		return
	end;
	
	local szHostcityName = LG_GetLeagueInfo(HostLeagueID);
	local szHostTongNames = tongwar_getnamestr(HostLeagueID);
	--Change schedule VLDNB 11 - Modified by DinhHQ - 20120507
	local nDate = tonumber(GetLocalDate("%d"));
	if (nDate ~= 16 and nDate ~= 17 and nDate ~= 19 and nDate ~= 20 and nDate ~= 21 and nDate ~= 22 and nDate ~= 23) then
		szmsg = format("<dec><npc>H«m nay lµ %d, kh«ng thÓ so víi cuéc so tµi.", nDate);
		CreateTaskSay({szmsg, "Trë vÒ/tongwar_cityowner", "KÕt thóc!/OnCancel"});
		return
	end;
	
	local szGuestCityName = tongwar_getenemycity(szHostcityName, nDate);
	if (nil == szGuestCityName) then
		szmsg = format("<dec><npc>H«m nay lµ %d, kh«ng thÓ so víi cuéc so tµi", nDate);
		CreateTaskSay({szmsg, "Trë vÒ/tongwar_cityowner", "KÕt thóc!/OnCancel"});
		return
	end;
	
	local GuestLeagueID = LG_GetLeagueObj(TONGWAR_LGTYPE, szGuestCityName);
	local szGuestTongNames = ""
	if not FALSE(GuestLeagueID) then 
		szGuestTongNames = tongwar_getnamestr(GuestLeagueID);
	end
	szmsg = format("<dec><npc>Ta liªn minh ( chiÕm thµnh gióp %s): %s <enter> h«m nay ®èi thñ ( chiÕm thµnh gióp %s):  %s", 
										szHostcityName, szHostTongNames,
										szGuestCityName, szGuestTongNames);
	CreateTaskSay({szmsg, "Trë vÒ/tongwar_cityowner", "KÕt thóc!/OnCancel"});
end;

--Change schedule VLDNB 11 - Modified by DinhHQ - 20120507
TAB_CITYNAME = {"T­¬ng D­¬ng", " BiÖn Kinh", "Ph­îng T­êng", "D­¬ng Ch©u", "L©m An", "Thµnh §«", " §¹i Lý"};
TAB_CALENDAR = {
	[16] = {5, 4, 0, 2, 1, 7, 6},
	[17] = {4, 3, 2, 1, 7, 0, 5},
	[19] = {3, 0, 1, 7, 6, 5, 4},
	[20] = {2, 1, 7, 6, 0, 4, 3},
	[21] = {0, 7, 6, 5, 4, 3, 2},
	[22] = {7, 6, 5, 0, 3, 2, 1},
	[23] = {6, 5, 4, 3, 2, 1, 0}
};

function tongwar_getenemycity(szCityName, nDate)
	local i;
	local nCount = getn(TAB_CITYNAME);
	local nPos = 0;
	for i = 1, nCount do
		if (szCityName == TAB_CITYNAME[i]) then
			nPos = i;
			break;
		end;
	end;
	
	if (0 == nPos) then
		return nil;
	end;

	local nEnemyCityIdx = TAB_CALENDAR[nDate][nPos];
	if (nEnemyCityIdx == 0) then
		return nil;
	end;
	return TAB_CITYNAME[nEnemyCityIdx];
end;

function tongwar_querycityrecord(szCityName)
	local LeagueID = LG_GetLeagueObj(TONGWAR_LGTYPE, szCityName);
	local nResult = LG_GetLeagueTask(LeagueID, TONGWAR_LGTASK_RESULT);
	local nPoint = LG_GetLeagueTask(LeagueID, TONGWAR_LGTASK_POINT);
	local szmsg = format("<dec><npc>ChiÕm thµnh gióp liªn minh tæng ®iÓm %s: <color=yellow>%d<color><enter>   chiÕn ®Êu tæng ®iÓm ®¹t: <color=yellow>%d<color>",
												 szCityName, nResult, nPoint);
	CreateTaskSay({szmsg, "Trë vÒ/tongwar_rank", "KÕt thóc!/OnCancel"});
end;

function tongwar_getnamestr(LeagueID)	--µÃµ½Ò»¸ö³ÇÊÐÕ¼Áì°ï»áÃû×ÖµÄÁÐ±í£»
	local nCount = LG_GetMemberCount(LeagueID);
	local szLeagueName = LG_GetLeagueInfo(LeagueID);
	local i;
	local szNames = "";
	local szTongName = "";
	local nMemberTask = 0;
	for i = 0, nCount - 1 do
		szTongName = LG_GetMemberInfo(LeagueID, i);
		if (LG_GetMemberTask(TONGWAR_LGTYPE, szLeagueName, szTongName, TONGWAR_LGMTASK_JOB) == 1) then
			szNames = "<enter>    <color=red>"..szTongName.."<color>"..szNames;
		else
			szNames = szNames.."<enter>    <color=red>"..szTongName.."<color>";
		end;
	end;
	return szNames;
end;


function tongwar_rank()
	local szTongName = GetTongName();
	if ("" == szTongName) then
		CreateTaskSay({"<dec><npc>Kh«ng gia nhËp bang héi , kh«ng thÓ tham gia tranh tµi.", 
											"KÕt thóc/OnCancel"});
		return
	end;
	
	local HostLeagueID = LG_GetLeagueObjByRole(TONGWAR_LGTYPE, szTongName);
	if (FALSE(HostLeagueID)) then
		CreateTaskSay({"<dec><npc>Ngµi ®Ých bang héi kh«ng gia nhËp bÊt kú liªn minh, kh«ng thÓ tham gia tranh tµi!", 
											"KÕt thóc/OnCancel"});
		return
	end;
	
	local szHostcityName = LG_GetLeagueInfo(HostLeagueID);
	local nResult = LG_GetLeagueTask(HostLeagueID, TONGWAR_LGTASK_RESULT);	--×Ü»ý·Ö
	local nPoint = LG_GetLeagueTask(HostLeagueID, TONGWAR_LGTASK_POINT);		--¾»»ý·Ö
	local nPlayerRecord = GetTask(TONGWAR_RLTASK_TOTALPOINT);
	local tab_auerycity = {};
	tab_auerycity[1] = format("<dec><npc>Liªn minh tæng ®iÓm %s: <color=yellow>%d<color><enter>            chiÕn ®Êu tæng ®iÓm ®¹t: <color=yellow>%d<color><enter>    Ng­êi chiÕn ®Êu ®¹t ®iÓm: <color=yellow>%d<color><enter>Xem thµnh thÝch liªn minh kh¸c",
										szHostcityName, nResult, nPoint, nPlayerRecord);
	
	for i = 1, getn(TAB_CITYNAME) do
		local cityname = TAB_CITYNAME[i];
		if (szHostcityName ~= cityname) then
			tab_auerycity[getn(tab_auerycity) + 1] = format("Xem thµnh tÝch liªn minh %s/#tongwar_querycityrecord([[%s]])", cityname, cityname);
		end;
	end;
	tab_auerycity[getn(tab_auerycity) + 1] ="Trë vÒ/tongWar_Start"
	tab_auerycity[getn(tab_auerycity) + 1] ="KÕt thóc ®èi tho¹i/OnCancel"
	
	CreateTaskSay(tab_auerycity);
end;

function tongwar_aword_talk()	--Õâ¸öºóÆÚÀ´×÷
	if (FALSE(tongwar_check_ownerright(1))) then
		CreateTaskSay({"<dec><npc>ChØ cã chiÕm thµnh bang chñ míi cã thÓ nhËn th­ëng", "KÕt thóc ®èi tho¹i/OnCancel"});
		return
	end;
	
	local tongname = GetTongName()
	local n_lid = LG_GetLeagueObjByRole(TONGWAR_LGTYPE, tongname)
	local leaguename = LG_GetLeagueInfo(n_lid)
	
	local nRank = LG_GetLeagueTask(TONGWAR_LGTYPE, leaguename, TONGWAR_LGTASK_RANK);
	if (nRank > 7 or nRank < 1) then
		print("rank wrong")
		return
	end;
	
	local szDescribe = "";
	local arr_Remain = {};
	local isFinished = 1;
	for i = 1, getn(TAB_AWORD_GOOD) do
		arr_Remain[i] = TAB_AWORD_GOOD[i][2][nRank] - LG_GetLeagueTask(TONGWAR_LGTYPE, leaguename, LG_TASK_AWORD[i]);
		if (arr_Remain[i] > 0) then 
			szDescribe = format("%s<enter>%s: <color=yellow>%d<color>",
						szDescribe, TAB_AWORD_GOOD[i][1].szName,arr_Remain[i])
			isFinished = 0; 
		end;
	end;
	if (isFinished == 1) then
		CreateTaskSay({"<dec><npc>§· nhËn th­ëng", "KÕt thóc ®èi tho¹i/OnCancel"});
		return
	end;
	
	
	local tab_AwordItem = {};
	tab_AwordItem = tongwar_getaworditem(nRank, arr_Remain); --Éú³É½±ÀøÎïÆ·µÄÑ¡Ïî
	if (getn(tab_AwordItem) == 0) then
		--Describe(WULINMENG_NPC.."Liªn minh", 1, "KÕt thóc ®èi tho¹i/OnCancel");
		print("tab_AwordItem wrong!")
		return
	end;
	tinsert(tab_AwordItem, 1, format("<dec><npc>Vâ l©m ®Ö nhÊt bang nhËn th­ëng cßn cã %s<enter>. ? dÉn tr­íc cÇn <color=red> söa sang l¹i trang bÞ <color>, ng­¬i nghÜ nhËn th­ëng g×?",szDescribe))
	CreateTaskSay(tab_AwordItem);
end

--
function tongwar_awordtalk_descript(szDescribe, nRemain, szItemName)
	if (nRemain > 0) then
		szDescribe = szDescribe.."<color=yellow>"..nRemain.."<color>"..szItemName;
	end;
	return szDescribe;
end;

function tongwar_getaworditem(nRank, arr_Remain)	--Éú³ÉÑ¡Ôñ½±ÀøÑ¡Ïî
	local tab_AwordItem = {};
	
	for i = 1,getn(arr_Remain) do
		if (arr_Remain[i] > 0) then
			tinsert(tab_AwordItem, format("NhËn lÊy %s",TAB_AWORD_GOOD[i][1].szName)..format("/#tongwar_aword(%d, %d)",i,nRank));
		end;
	end
	tinsert(tab_AwordItem, "KÕt thóc ®èi thoai!/OnCancel");
	return tab_AwordItem;
end;

function tongwar_aword(nItemType, nRank)
	if (GetTaskTemp(PL_TEMPTASK_SECURITY) == 1) then--·ÀÖ¹Ë¢
		return
	end;
	SetTaskTemp(PL_TEMPTASK_SECURITY, 1);
	
	if (FALSE(tongwar_check_ownerright())) then
		SetTaskTemp(PL_TEMPTASK_SECURITY, 0)
		CreateTaskSay({"<dec><npc>ChØ cã chiÕm thµnh bang chñ míi cã thÓ nhËn th­ëng!", "KÕt thóc ®èi thoai!/OnCancel"});
		return
	end;
	
	if (nRank < 1 or nRank > 7) then --ÅÅÃû¼ì²é
		SetTaskTemp(PL_TEMPTASK_SECURITY, 0)
		return
	end;
	
	local tongname = GetTongName()
	local n_lid = LG_GetLeagueObjByRole(TONGWAR_LGTYPE, tongname)
	local leaguename = LG_GetLeagueInfo(n_lid)
	local nTotal = TAB_AWORD_GOOD[nItemType][2][nRank];
	local nAwordedCount = LG_GetLeagueTask(TONGWAR_LGTYPE, leaguename, LG_TASK_AWORD[nItemType]); --ÒÑ¾­½±ÀøµÄÊýÁ¿
	local nRemainCount = nTotal - nAwordedCount;

	local nFreeItemCount = CalcFreeItemCellCount();--°ü¹ü¿ÕÏ¶¼ì²é
	local nMaxAwordCount = 60;
	if (nItemType == 2 or nItemType == 3) then
		nMaxAwordCount = 10;
	end;
	local nGiveCount = nRemainCount;
	if (nRemainCount > nMaxAwordCount) then
		nGiveCount = nMaxAwordCount;
	end;
	
	if (nFreeItemCount < nGiveCount and nFreeItemCount < nRemainCount) then
		SetTaskTemp(PL_TEMPTASK_SECURITY, 0);
		CreateTaskSay({"<dec><npc>Hµnh trang kh«ng ®ñ chç trèng!", "KÕt thóc ®èi thoai!/OnCancel"});
		return
	end;

	local nResult = LG_ApplyAppendLeagueTask(TONGWAR_LGTYPE, leaguename, LG_TASK_AWORD[nItemType], nGiveCount, "", "");
	local str = "";
	if (nResult == 1) then
		str = format("Gióp %s - bang chñ %s nhËn lÊy %s",tongname,GetName(),nGiveCount,TAB_AWORD_GOOD[nItemType][1].szName);
		tongwar_award_log(str);
		Msg2Player(str);
		
		local nItemID;
		local nowdate = tonumber(GetLocalDate("%y%m%d"))
		tbAwardTemplet:GiveAwardByList(TAB_AWORD_GOOD[nItemType][1],"TongWar_Award",nGiveCount);
--		for i = 1, nGiveCount do
--			nItemID = AddItem(TAB_AWORD_GOOD[nItemType][1][1], TAB_AWORD_GOOD[nItemType][1][2], TAB_AWORD_GOOD[nItemType][1][3], 0, 0, 0, 0);
--			if (nItemType == 1) then
--				SetSpecItemParam(nItemID, 1, nowdate)
--				SyncItem(nItemID)
--			elseif (nItemType == 3) then
--				local nExp = 20e8;
--				SetSpecItemParam(nItemID, 1, mod(nExp, 1e8))
--				SetSpecItemParam(nItemID, 2, nExp / 1e8)
--				SyncItem(nItemID)
--			end;
--			
--		end;
		Msg2Player(format(" ºÍ%d %s",(nRemainCount - nGiveCount),TAB_AWORD_GOOD[nItemType][1].szName));
		SetTaskTemp(PL_TEMPTASK_SECURITY, 0);
		return
	end;
	CreateTaskSay({"<dec><npc>NhËn th­ëng thÊt b¹i, xin l¹i mét c¸i!", "KÕt thóc ®èi thoai!/OnCancel"});
	tongwar_award_log(str.."Kh«ng thµnh c«ng, xinmêi thö l¹i!")
	SetTaskTemp(PL_TEMPTASK_SECURITY, 0);
end;

--Ð´Èë½±ÀøÈÕÖ¾
function tongwar_award_log(str)
	WriteLog("[TONGWAR_AWARD]"..date("%y-%m-%d,%H:%M").."\t"..GetAccount().."\t"..GetName().."\t"..str)
end

--·µ»Øµ±Ç°Èü¼¾½×¶Î£¬1-±¨Ãû£¬2-±ÈÈü£¬3-½±Àø
function tongwar_checkinphase()
	local nphase = gb_GetTask("TONGWAR_STATION", 2);
	return nphase;
end

--·µ»Øµ«Ç°Èü¼¾ID
function get_tongwar_season()
	local nseason = gb_GetTask("TONGWAR_STATION", 3);
	return nseason;
end;

--Çå³ýÉÏÒ»Èü¼¾¸öÈË»ý·Ö
function tongwar_clear_rlpoint()
	local nmyseason = GetByte(GetTask(TONGWAR_RLTASK_AWARD), 4);
	local ncurseaon = get_tongwar_season();
	if (nmyseason ~= ncurseaon) then
		SetTask(TONGWAR_RLTASK_AWARD, SetByte(GetTask(TONGWAR_RLTASK_AWARD), 4, ncurseaon));
		SetTask(TONGWAR_RLTASK_TOTALPOINT, 0);
	end;
end;
