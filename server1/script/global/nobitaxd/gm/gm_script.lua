---------------------------------------
-- Script GM Vo Lam Truyen Ky OffLine 
---------------------------------------
IL("TITLE");
IncludeLib("TASKSYS")
IncludeLib("PARTNER");
IncludeLib("BATTLE");
IncludeLib("RELAYLADDER");
IncludeLib("TONG");
IncludeLib("LEAGUE");
IncludeLib("ITEM");
IncludeLib("TIMER");
IncludeLib("FILESYS");
IncludeLib("SETTING");
Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\lib\\remoteexc.lua");
Include("\\script\\lib\\log.lua");
Include("\\script\\lib\\common.lua");
Include("\\script\\task\\system\\task_string.lua");
Include("\\script\\task\\lv120skill\\head.lua");
Include("\\script\\task\\150skilltask\\g_task.lua");
Include("\\script\\tagnewplayer\\fucmain.lua"); 
Include("\\script\\tagnewplayer\\head.lua"); 
Include("\\script\\tagnewplayer\\dispose_item.lua"); 
Include("\\script\\missions\\leaguematch\\npc\\officer.lua");
Include("\\script\\misc\\daiyitoushi\\toushi_function.lua");
Include("\\script\\dailogsys\\g_dialog.lua");
Include("\\script\\dailogsys\\dailogsay.lua");
Include("\\script\\activitysys\\functionlib.lua");
Include("\\script\\gm_tool\\dispose_item.lua");
Include("\\script\\global\\titlefuncs.lua");
Include("\\script\\global\\judgeoffline.lua");
Include("\\script\\global\\fuyuan.lua");
Include("\\script\\global\\skills_table.lua");
Include("\\script\\global\\translife.lua");
Include("\\script\\global\\findboss.lua");
Include("\\script\\global\\nobitaxd\\gm\\gm_lib.lua");
Include("\\script\\global\\nobitaxd\\gm\\gm_help.lua");
Include("\\script\\global\\nobitaxd\\npc\\npcthunghiem.lua")

tbAloneScript = {};
----------------------------------------------------------------------------------
-- NhËp mËt khÈu tr­íc khi sö dông ®­îc chøc n¨ng GM, ng­êi ch¬i ph¶i nhËp mËt khÈu
----------------------------------------------------------------------------------
function tbAloneScript:GMPassword()
	local nResult, nIdx = self:CheckGameMaster()
	if (nResult == 0) then
		Talk(1, "", "B¹n kh«ng ph¶i lµ <color=red>GM<color>, kh«ng thÓ sö dông vËt phÈm nµy");
	return 0 end
	if (GetLevel() < 10) then
		Talk(1, "", "§Ó sö dông ®­îc toµn bé chøc n¨ng bªn trong, vui lßng n©ng lªn <color=red>cÊp 10<color> råi h·y sö dông ®Õn nã");
	return 0 end

	local szName = GetName();
	local szAccount = GetAccount();
	local nIsLogin = GetTaskTemp(TASKTEMP_LOGIN_LBGM);
	if (nIsLogin == 1) then
		self:DialogMain();
	return 1 end
	
	g_AskClientStringEx("", 1, 50, "NhËp mËt khÈu:", {self.EnterGMPassword, {self, nIdx, szAccount, szName}})
end

function tbAloneScript:EnterGMPassword(nIdx, szAccount, szName, szPassword)
	if (TAB_LIST_GAMEMASTER[nIdx]["Password"] ~= szPassword) then
		Talk(1, "", "MËt khÈu kh«ng ®óng, vui lßng kiÓm tra l¹i!");
	return 0 end
	self:DialogMain();
	SetTaskTemp(TASKTEMP_LOGIN_LBGM, 1)
	SetMoveSpeed(100);
	Msg2Player("B¹n ®· nhËp mËt khÈu ®óng, ®¨ng nhËp thµnh c«ng! B©y giê cã thÓ sö dông ®­îc chøc n¨ng dµnh cho GM.")
end
-----------------------------------------------------------
-- Mennu GM ver 01 | 22/03/2023
-----------------------------------------------------------
function tbAloneScript:DialogMain()	
	local szTitle = format("Chµo mõng <color=red>%s<color> tham gia m¸y chñ <color=red>OffLine S¬n Hµ X· T¾c<color>, <enter>§©y lµ lÖnh bµi hç trî dµnh cho GM ®Ó qu¶n lý, ®iÒu hµnh m¸y chñ cña m×nh.", GetName());
	local tbOption = {};
		tinsert(tbOption, {"GM Thö NghiÖm", self.SupportGMTestGame})	-- Done
		tinsert(tbOption, {"GM Qu¶n Lý M¸y Chñ", self.ManagePlayerSystem, {self}})	-- Done
		tinsert(tbOption, {"GM Qu¶n Lý Ng­êi Ch¬i", self.ManagePlayerAccountSystem, {self}})	-- Done
		tinsert(tbOption, {"GM Chøc N¨ng", self.TinhNangGM, {self}})	-- Done
		tinsert(tbOption, {"GM Di ChuyÓn", self.DiChuyenGM, {self}})	-- Done
		tinsert(tbOption, {"GM LÊy Item", self.GM_layitem, {self}})	-- Done
		tinsert(tbOption, {"Reload Files", self.Reloadfiles})	--Done
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end
-----------------------------------------------------------
-- GM Thö NghiÖm - \\script\\global\\NobitaXD\\npc\\npcthunghiem.lua
-----------------------------------------------------------
function tbAloneScript:SupportGMTestGame()
	local tbSay = {"Mêi GM <color=red>"..GetName().."<color> lùa chän TÝnh n¨ng Thö NghiÖm:\n----------------------------------------\n"};
		tinsert(tbSay, "NhËn c¸c lo¹i ®iÓm/pointall")
		tinsert(tbSay, "NhËn tiÒn/moneyall")
		tinsert(tbSay, "NhËn trang bÞ/trangbiall")
		tinsert(tbSay, "NhËn vËt phÈm hç trî/Itemhotro")
		tinsert(tbSay, "NhËn thó c­ìi/ThuCuoi")
		tinsert(tbSay, "Häc kü n¨ng m«n ph¸i/HocKyNangMonPhai")
		tinsert(tbSay, "§iÒu kiÖn t¹o bang héi/DieuKienTaoBangHoi")
		tinsert(tbSay, "TÈy tñy nhanh/TayTuyNhanh")
		tinsert(tbSay, "LÊy th«ng tin NPC/LastNpcTalk")
		tinsert(tbSay, "§ãng./no");
	CreateTaskSay(tbSay);
end
-----------------------------------------------------------
-- GM Qu¶n Lý M¸y Chñ
-----------------------------------------------------------
function tbAloneScript:ManagePlayerSystem()
	local szTitle = format("Mêi GM <color=red>%s<color> lùa chän chøc n¨ng qu¶n trÞ:", GetName());
	local tbOption = {}
		tinsert(tbOption, {"CËp nhËt xÕp h¹ng", self.capnhatbangxephang, {self}})
		tinsert(tbOption, {"Gäi Boss Hoµng Kim", self.Auto_TestBoss, {self}})	-- Done
		tinsert(tbOption, {"Chøc n¨ng th«ng b¸o", self.NotificationManage, {self}})	-- Done
		--tinsert(tbOption, {"DÞch chuyÓn tøc thêi", self.MoveToPosition, {self}})	-- Done
		--tinsert(tbOption, {"LÊy vËt phÈm", self.TakeSpecifiedItem, {self}})	-- Done
		--tinsert(tbOption, {"LÊy th«ng tin NPC", self.LastNpcTalk})	-- Done
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i
-----------------------------------------------------------
function tbAloneScript:ManagePlayerAccountSystem()
	local szTitle = format("Mêi GM <color=red>%s<color> lùa chän chøc n¨ng qu¶n trÞ:", GetName());
	local tbOption = {}
		tinsert(tbOption, {"Qu¶n lý nh©n vËt", self.ManageSystemGlobal, {self}})	-- Done
		tinsert(tbOption, {"NhËp tªn nh©n vËt", self.ManipulationOnPlayer, {self}})	-- Done
		--tinsert(tbOption, {"NhËp tªn tµi kho¶n nh©n vËt", self.ManipulationAccountOnPlayer, {self}})
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end
----------------------------------------------------------
-- GM Chøc N¨ng
----------------------------------------------------------
function tbAloneScript:TinhNangGM()
	local szTitle = format("Mêi GM <color=red>%s<color> lùa chän chøc n¨ng GM:", GetName());
	local tbOption = {}
		if (GetSkillState(1206) == -1) then
			tinsert(tbOption, {"BËt Èn th©n", self.GMHide, {self}})
		else
			tinsert(tbOption, {"T¾t Èn th©n", self.GMShow, {self}})
		end
		if (IsOwnFeatureChanged() == 0) then
			tinsert(tbOption, {"BËt ngo¹i h×nh GM", self.ChangeMask, {self}})
		else
			tinsert(tbOption, {"T¾t ngo¹i h×nh GM", self.RestoreMask, {self}})
		end
		if (Title_GetActiveTitle() ~= 5000) then
			tinsert(tbOption, {"BËt vßng s¸ng GM", self.HaloGM, {self}})
		else
			tinsert(tbOption, {"T¾t vßng s¸ng GM", self.HaloGM, {self}})
		end
			tinsert(tbOption, {"Kü n¨ng", self.SkillsSystem, {self}})
			tinsert(tbOption, {"TÝnh n¨ng hç trî kh¸c", self.SupportFeatureOther, {self}})
			tinsert(tbOption, {"T×m Boss Hoµng Kim", self.GMHelp, {self}})
			tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end
-----------------------------------------------------------
-- GM Di ChuyÓn
-----------------------------------------------------------
function tbAloneScript:DiChuyenGM()
	local szTitle = format("Chµo mõng <color=red>%s<color> tham gia m¸y chñ <color=red>OffLine S¬n Hµ X· T¾c<color>, <enter>§©y lµ lÖnh bµi hç trî dµnh cho GM ®Ó qu¶n lý, ®iÒu hµnh m¸y chñ cña m×nh.", GetName());
	local tbOption = {};
		tinsert(tbOption, {"§Õn ®Þa ®iÓm kh¸c", GM_dichuyen})
		tinsert(tbOption, {"DÞch chuyÓn ®Õn vÞ trÝ", self.MoveToPosition, {self}})
		tinsert(tbOption, {"DÞch chuyÓn ®Õn vÞ trÝ Help", MoveToPosition_help})
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end
function GM_dichuyen()
	local tbOpt =
	{
			{"§Õn Thiªn Tö", GMTONGKIM2},
			{"§Õn Tèng Kim", GMTONGKIM},
			{"VÒ Ba L¨ng HuyÖn", GMBLH},
			{"C«ng Thµnh ChiÕn", MapCTC},
			{"Phong L¨ng §é", go_PLD},
			{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>NobitaXD:<color><enter>Mêi GM <color=red>"..GetName().."<color> lùa chän TÝnh n¨ng Thö NghiÖm:\n----------------------------------------\n", tbOpt)
end
function go_PLD()
	Say("Mêi GM <color=yellow>"..GetName().."<color> chän n¬i ngµi muèn ®Õn.", 7, 
		"Phong l¨ng ®é thuyÒn 1/go_PLD1",
		"Phong l¨ng ®é thuyÒn 2/go_PLD2",
		"Phong l¨ng ®é thuyÒn 3/go_PLD3",
		"Phong Bê B¾c/go_PLDquathuyen",
		"Phong Bê Nam/go_PLDbaodanh",
		"Rêi khái/no"
		);
end


---- PLD thuyen 3
function go_PLDbaodanh()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
NewWorld(336,1304,2943)
end

---- PLD thuyen 3
function go_PLDquathuyen()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
NewWorld(336,1332,2808)
end

---- PLD thuyen 3
function go_PLD3()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
NewWorld(339,1613,3198)
end

---- PLD thuyen 1
function go_PLD1()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
NewWorld(337,1633,3203)
end
---- PLD thuyen 2
function go_PLD2()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
NewWorld(338,1607,3187)
end
----------------------------------------

function GMTONGKIM2()
NewWorld(900,1440, 3334)
end

function GMTONGKIM()
NewWorld(380,1440, 3334)
end

function GMBLH()
NewWorld(53,1621, 3190)
end

function GMCONGTHANH()
NewWorld(930,1764, 3372)
end

function ronglaman()
NewWorld(930,1761, 3398)
end

function rongbk()
NewWorld(927,1755, 3397)
end


function MapCTC()
	Say("ThÇn hµnh phï cã thÓ ®­a ®¹i hiÖp <color=yellow>"..GetName().."<color> ®Õn bÊt cø thµnh thÞ hay th«n trÊn nµo, vui lßng chän n¬i ngµi muèn ®Õn.", 8, 
		"GM go: ChiÕn tr­êng biÖn kinh/MapBK",
		"GM go: ChiÕn tr­êng l©m an/MapLA",
		"GM go: ChiÕn tr­êng ph­îng t­êng/MapPT",
		"GM go: ChiÕn tr­êng t­¬ng d­¬ng/MapTD",
		"GM go: ChiÕn tr­êng thµnh ®«/MapTDo",
		"GM go: ChiÕn tr­êng d­¬ng ch©u/MapDC",
		"GM go: ChiÕn tr­êng ®¹i lý/MapDL",
		"Rêi khái/no"
		);
end

function MapBK()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
	NewWorld(927,1759,3375);
end
function MapLA()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
	NewWorld(930,1756,3373);
end
function MapPT()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
	NewWorld(929,1770,3504);
end
function MapTD()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
	NewWorld(931,1717,3281);
end
function MapTDo()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)
	NewWorld(926,1718,3285);	
end
function MapDC()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
	NewWorld(932,1720,3284);
end
function MapDL()
	SetFightState(0)
	SetCamp(6)
	SetCurCamp(6)	
	NewWorld(928,1720,3283);
end
-----------------------------------------------------------
-- Reload File
-----------------------------------------------------------
function tbAloneScript:Reloadfiles()
	local tbSay = {"Danh s¸ch Script<enter>Link: <color=green>/script/global/nobitaxd/config/cfg_server.lua<color><enter>Link: <color=green>/script/global/nobitaxd/gm/gm_script.lua<color>"};
		tinsert(tbSay, "Reload Script CFG_server/Reload_CFG_server")
		tinsert(tbSay, "NhËp ®­êng dÉn Script/Reloadfile")
		tinsert(tbSay, "§ãng./no");
	CreateTaskSay(tbSay);
end
--========================================================--
------------------------------------------------------------
-- GM Qu¶n Lý M¸y Chñ
-- GM Qu¶n Lý M¸y Chñ - Gäi Boss Hoµng Kim
------------------------------------------------------------
function tbAloneScript:Auto_TestBoss()
	BossHK(f_bossx,f_bossy)
end
	TBBOSS  = 
	{ --tªn boss,id boss, tû lÖ r¬i ®å,series boss,nLevel
		[1]={	szName = "HuyÒn Gi¸c §¹i S­",		nBossId = 740,	nRate = 322,	nSeries = 0,	nLevel = 95},
		[2]={	szName = "§­êng BÊt NhiÔm",			nBossId = 741,	nRate = 336,	nSeries = 1,	nLevel = 95},
		[3]={	szName = "B¹ch Doanh Doanh",		nBossId = 742,	nRate = 336,	nSeries = 1,	nLevel = 95},
		[4]={	szName = "Thanh TuyÖt S­ Th¸i",		nBossId = 743,	nRate = 341,	nSeries = 2,	nLevel = 95},
		[5]={	szName = "Yªn HiÓu Tr¸i",			nBossId = 744,	nRate = 336,	nSeries = 2,	nLevel = 95},
		[6]={	szName = "Hµ Nh©n Ng·",				nBossId = 745,	nRate = 321,	nSeries = 3,	nLevel = 95},
		[7]={	szName = "Tõ §¹i Nh¹c",				nBossId = 746,	nRate = 341,	nSeries = 4,	nLevel = 95},
		[8]={	szName = "TuyÒn C¬ Tö",				nBossId = 747,	nRate = 341,	nSeries = 4,	nLevel = 95},
		[9]={	szName = "Hµn Ngu Dèt",				nBossId = 748,	nRate = 342,	nSeries = 3,	nLevel = 95},
		[10]={	szName = "§o¹n Méc DuÖ",			nBossId = 565,	nRate = 227,	nSeries = 3,	nLevel = 95},
		[11]={	szName = "Cæ B¸ch",					nBossId = 566,	nRate = 200,	nSeries = 0,	nLevel = 95},
		[12]={	szName = "§­êng Phi YÕn",			nBossId = 1366,	nRate = 200,	nSeries = 1,	nLevel = 95},	
		[13]={	szName = "Hµ Linh Phiªu",			nBossId = 568,	nRate = 200,	nSeries = 2,	nLevel = 95},
		[14]={	szName = "Lam Y Y",					nBossId = 582,	nRate = 200,	nSeries = 1,	nLevel = 95},
		[15]={	szName = "M¹nh Th­¬ng L­¬ng",		nBossId = 583,	nRate = 200,	nSeries = 3,	nLevel = 95},
		[16]={	szName = "Gia LuËt TÞ Ly",			nBossId = 563,	nRate = 200,	nSeries = 3,	nLevel = 95},
		[17]={	szName = "§¹o Thanh Ch©n Nh©n",		nBossId = 562,	nRate = 200,	nSeries = 4,	nLevel = 95},
		[18]={	szName = "V­¬ng T¸",				nBossId = 739,	nRate = 200,	nSeries = 0,	nLevel = 95},
		[19]={	szName = "HuyÒn Nan §¹i S­",		nBossId = 1365,	nRate = 200,	nSeries = 0,	nLevel = 95},
		[20]={	szName = "Chung Linh Tó",			nBossId = 567,	nRate = 200,	nSeries = 2,	nLevel = 95},
		[21]={	szName = "Thanh Liªn Tö",			nBossId = 1368,	nRate = 200,	nSeries = 4,	nLevel = 95},	
	}
function BossHK(f_bossx,f_bossy)
	if (not f_bossx) then
		f_bossx1 = 1;
		f_bossy1 = 12;
	else
		f_bossx1 = f_bossx;
		f_bossy1 = f_bossy;
	end
	if (f_bossy1 - f_bossx1 > 11) then
		f_bossy1 = f_bossx1 + 11;
	end
	local n_count = getn(TBBOSS);
	local tb = {}
	tb = {GetName().." b¹n muèn th¶ boss nµo?"}
	for i = f_bossx1, f_bossy1 do
		tinsert(tb,format("%s/#PickBoss(%d)",TBBOSS[i].szName,i));
	end
	if (f_bossx1 ~= 1) then
		tinsert(tb, "Trang tr­íc/#BossHK( 1,"..(f_bossx1-1)..")");
	end
	if (f_bossy1 < n_count) then
		tinsert(tb, "Trang sau/#BossHK( "..(f_bossy1+1)..","..n_count..")");
	end
	tinsert(tb,"§Ó ta suy nghÜ ®·/cancel");
	CreateTaskSay(tb)
end
function PickBoss(nIndex)
	if GetFightState() == 0 then 
		Talk(1,"","Kh«ng thÓ th¶ boss ë nh÷ng n¬i phi chiÕn ®Êu ®­îc.")
		return 
	end
	local item = TBBOSS[nIndex];
	local nw,nx,ny = GetWorldPos();
	local index = AddNpcEx(item.nBossId,item.nLevel,item.nSeries,SubWorldID2Idx(nw),nx*32,ny*32,1,item.szName,1);
	SetNpcDeathScript(index,"\\script\\missions\\boss\\bossdeath.lua")		
	SetNpcParam(index,1,item.nBossId); --l­u id boss.
	SetNpcTimer(index,120*60*18)
	local W,X,Y = GetWorldPos();
	Msg2SubWorld(format("<color=yellow>%s<color> ®· xuÊt hiÖn t¹i <color=yellow>%s(%d,%d)<color>",item.szName,SubWorldName(SubWorld),floor(X/8),floor((Y+5)/16)));
end
function cancel()
end
------------------------------------------------------------
-- GM Qu¶n Lý M¸y Chñ - Chøc n¨ng th«ng b¸o
------------------------------------------------------------
function tbAloneScript:NotificationManage()
	local szTitle = "HiÖn t¹i cã 2 chøc n¨ng th«ng b¸o chÝnh, ®ã lµ:\n+ <color=red>TÇng sè thÕ giíi<color>: kªnh nµy th«ng b¸o trªn khung ch¸t t¸n gÉu trong giao diÖn ng­êi ch¬i.\n+ <color=red>TÇng sè m¸y chñ<color>: kªnh nµy th«ng b¸o ®Õn ng­êi ch¬i trong toµn m¸y chñ, néi dông ch¹y ch÷ ë phÝa trªn ®Çu nh©n vËt."
	local tbOption = {}
		tinsert(tbOption, {"Th«ng b¸o trªn tÇng sè thÕ giíi", g_AskClientStringEx, {"", 0,256,"Néi dung th«ng b¸o:", {self.EnterNotification, {self, 1}}}})
		tinsert(tbOption, {"Th«ng b¸o trªn tÇng sè m¸y chñ", g_AskClientStringEx, {"", 0,256,"Néi dung th«ng b¸o:", {self.EnterNotification, {self, 2}}}})
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end
function tbAloneScript:EnterNotification(nType, szNotices)
	if szNotices == nil or szNotices == "" then
	return 0 end
	if (nType == 1) then
		Msg2SubWorld("<color=yellow><bclr=red>GM "..GetName().."<bclr> nãi:<color> <color=cyan>"..szNotices)
	elseif (nType == 2) then
		AddGlobalCountNews("<color=yellow><bclr=red>GM "..GetName().."<bclr> th«ng b¸o: <color>"..szNotices, 3)
	end
end
------------------------------------------------------------
-- GM Qu¶n Lý M¸y Chñ - DÞch chuyÓn tøc thêi
------------------------------------------------------------
function tbAloneScript:MoveToPosition()
	g_AskClientStringEx(GetStringTask(TASK_S_POSITION), 0, 256, "ID=53,X=200,Y=200", {self.EnterPosition, {self}})
end

function tbAloneScript:EnterPosition(szPos)
	local tbPos = split(szPos, ",")
	local nMap = tonumber(tbPos[1])
	local nPosX = tonumber(tbPos[2])
	local nPosY = tonumber(tbPos[3])
	local nMove;
	if nPosX < 1000 and nPosY < 1000 then
		nPosX = nPosX*8
		nPosY = nPosY*16
	end
	
	nMove = NewWorld(nMap,nPosX, nPosY)
	AddSkillState(963, 1, 0, 18*3)
	
	if nMove ~= 1 then
		GMMsg2Player("DÞch chuyÓn ®Õn vÞ trÝ","ThÊt b¹i! VÞ trÝ kh«ng hîp lÖ, vui lßng kiÓm tra l¹i.")
		return
	end
	
	SetStringTask(TASK_S_POSITION, szPos)
	GMMsg2Player("DÞch chuyÓn ®Õn vÞ trÝ","<color=yellow>Thµnh c«ng!")
end
-----------------------------------------------------------
-- GM Qu¶n Lý M¸y Chñ - LÊy vËt phÈm
-----------------------------------------------------------
function tbAloneScript:TakeSpecifiedItem()	-- TakeSpecifiedItem
	g_AskClientStringEx(GetStringTask(TASKS_GETITEM), 0, 256, "Th«ng sè item:", {self.TakeSpecifiedItemParam, {self}})
end
function tbAloneScript:TakeSpecifiedItemParam(szParam)
	if not szParam then
		Talk(1, "", "GM ch­a nhËp th«ng sè cña mét item bÊt kú, vui lßng thö l¹i.")
		return 0
	end	
	local nType, tbParam = self:GetTypeParam(szParam)
	if (nType == 0) then
		GMMsg2Player("LÊy vËt phÈm chØ ®Þnh", "ThÊt b¹i! Tèi ®a cho phÐp lµ 16 th«ng sè.")
		return 0
	end
	local nIsParam = self:IsParamNumber(tbParam[2])
	if nIsParam ~= 1 then
		GMMsg2Player("LÊy vËt phÈm chØ ®Þnh", "ThÊt b¹i! ChØ sö dông c¸c ký tù sè tõ 0-9 vµ dÊu phÈy “,”.")
		return 0
	end	
	self:SetCountSpecifiedItem(nType, tbParam)
end
function tbAloneScript:SetCountSpecifiedItem(nType, tbParam)
	local tbOptionSelected = {}
	g_AskClientNumberEx(1, 500, "NhËp sè l­îng:", {self.CountSpecifiedItem, {self, {nType, tbParam, tbOptionSelected}}})
end
function tbAloneScript:CountSpecifiedItem(tbSpecifiedItem, nCount, nOptionSelected)
	local szTitle = "H·y thiÕt lËp thªm option nÕu muèn.\n\n* Option GM ®· chän:"
	local nIsTable = self:IsOption(tbSpecifiedItem[3], "table")
	if nIsTable then
		for x, y in tbSpecifiedItem[3] do
			szTitle = szTitle..format("\n"..strfill_right("+", 5, " ").." <color=green>%s<color>",y[1])
		end
	end
	local tbOpt = {}
		local nBind = self:GetTypeOption(tbSpecifiedItem[3], 1)
		if nBind ~= 1 then
			tinsert(tbOpt, {"+ Thªm option khãa b¶o hiÓm vÜnh viÔn", self.AddOptionInItem, {self, tbSpecifiedItem, nCount, 1}})
			tinsert(tbOpt, {"+ Thªm option khãa b¶o hiÓm", self.AddOptionInItem, {self, tbSpecifiedItem, nCount, 2}})
		end
		local nExpired = self:GetTypeOption(tbSpecifiedItem[3], 2)
		if nExpired ~= 2 then
			tinsert(tbOpt, {"+ Thªm option thêi h¹n sö dông", self.AddOptionInItem, {self, tbSpecifiedItem, nCount, 3}})
		end
		tinsert(tbOpt, {"§· xong, ta muèn lÊy ngay b©y giê", self.CreateItemSpecified, {self, tbSpecifiedItem, nCount}})
		tinsert(tbOpt, {"Chän l¹i option", self.ReselectOption, {self, tbSpecifiedItem, nCount}})
		tinsert(tbOpt, {"§ãng."})
	CreateNewSayEx(szTitle, tbOpt)
end
function tbAloneScript:CreateItemSpecified(tbSpecifiedItem, nCount)
	local GMPlayer = PlayerIndex;
	local szPlayerName = "";
	local szGMName = "";
	if nPlayerIndex then
		PlayerIndex = nPlayerIndex;
		szPlayerName = GetName();
	end
	local nItemIndex = 0;
	local szItemName = "";
	local tbItem = self:GetParamItem(tbSpecifiedItem)
		for i = 1, nCount do
			nItemIndex = self:NewItemEx(tbItem)
			if (nItemIndex <= 0) then
				break
			end
			szItemName = GetItemName(nItemIndex)
			if (IsItemStackable(nItemIndex) == 1) then
				SetItemStackCount(nItemIndex, 1)
			end
			for x, y in tbSpecifiedItem[3] do
				if y[3] == 1 then
					SetItemBindState(nItemIndex, y[2])
				end
				if y[3] == 2 then
					ITEM_SetExpiredTime(nItemIndex,y[2]*24*60)
				end
			end
			AddItemByIndex(nItemIndex)
		end
	SetStringTask(TASKS_GETITEM, tbSpecifiedItem[2][1])
	if nPlayerIndex then
		PlayerIndex = GMPlayer;
			szGMName = GetName()
			Msg2Player(format("B¹n ®· tÆng cho ng­êi ch¬i <color=yellow>%s<color> nµy %d %s", szPlayerName, nCount, szItemName))
		PlayerIndex = nPlayerIndex;
			Msg2Player(format("B¹n ®· ®­îc GM <color=yellow>%s<color> tÆng %d %s", szGMName, nCount, szItemName))
		nPlayerIndex = nil;
	else
		Msg2Player(format("B¹n nhËn ®­îc %d %s", nCount, szItemName))
	end
end
function tbAloneScript:GetParamItem(tbSpecifiedItem)
	local nType = tbSpecifiedItem[1]
	local tbParam = tbSpecifiedItem[2][2]
	local nVersion, nQuality;
	local nGenre, nDetailType, nParcular, nLevel, nSeries, nMagic;
	local MagicIndex1, MagicIndex2, MagicIndex3, MagicIndex4, MagicIndex5, MagicIndex6;
	if (nType == 1) then
		if (getn(tbParam) == 1) then
			nQuality, nDetailType = 1, (tbParam[1] -1)
		elseif (getn(tbParam) == 2) then
			nQuality, nDetailType = tbParam[1], (tbParam[2] -1);
		end
	elseif (nType == 2) then
		nGenre, nDetailType, nParcular, nLevel, nSeries, nMagic = tbParam[1],tbParam[2],tbParam[3],tbParam[4],tbParam[5],tbParam[6];
	elseif (nType == 3) then
		nGenre, nDetailType, nParcular, nLevel, nSeries, nMagic = tbParam[1],tbParam[2],tbParam[3],tbParam[4],tbParam[5],tbParam[6];
		MagicIndex1, MagicIndex2, MagicIndex3, MagicIndex4, MagicIndex5, MagicIndex6 = tbParam[7],tbParam[8],tbParam[9],tbParam[10],tbParam[11],tbParam[12];
	end
	return {
		nVersion or 4,
		nQuality or 2,
		nGenre or 0,
		nDetailType or 0,
		nParcular or 0,
		nLevel or 0,
		nSeries or 0,
		nMagic or 0,
		MagicIndex1 or 0,
		MagicIndex2 or 0,
		MagicIndex3 or 0,
		MagicIndex4 or 0,
		MagicIndex5 or 0,
		MagicIndex6 or 0
	}
end
function tbAloneScript:NewItemEx(tbItem)
	return NewItemEx(
		tbItem[1],
		0,
		tbItem[2],
		tbItem[3],
		tbItem[4],
		tbItem[5],
		tbItem[6],
		tbItem[7],
		tbItem[8],
		tbItem[9],
		tbItem[10],
		tbItem[11],
		tbItem[12],
		tbItem[13],
		tbItem[14],
		0)
end
function tbAloneScript:ReselectOption(tbSpecifiedItem, nCount)
	tbSpecifiedItem[3] = {}
	self:CountSpecifiedItem(tbSpecifiedItem, nCount)
end
function tbAloneScript:GetTypeOption(tbOption, nType)
	for x, y in tbOption do
		if tbOption[x][3] == nType then
			return nType
		end
	end
	return 0
end
function tbAloneScript:AddOptionInItem(tbSpecifiedItem, nCount, nOptionSelected)
	local tbListOption =
	{
		[1] = {"Khãa b¶o hiÓm vÜnh viÔn", 1},
		[2] = {"Khãa b¶o hiÓm", 1},
		[3] = {"Thêi h¹n sö dông", 2},
	};
	if (nOptionSelected == 1) then
		tbSpecifiedItem[3][nOptionSelected] = {tbListOption[nOptionSelected][1], -2, tbListOption[nOptionSelected][2]};
		self:CountSpecifiedItem(tbSpecifiedItem, nCount)
	elseif (nOptionSelected == 2) then
		tbSpecifiedItem[3][nOptionSelected] = {tbListOption[nOptionSelected][1], -1, tbListOption[nOptionSelected][2]};
		self:CountSpecifiedItem(tbSpecifiedItem, nCount)
	elseif (nOptionSelected == 3) then
		self:SetTimeInItem(tbSpecifiedItem, nCount, nOptionSelected, tbListOption[nOptionSelected]);
	end
end
function tbAloneScript:SetTimeInItem(tbSpecifiedItem, nCount, nOptionSelected, tbListOption)
	g_AskClientNumberEx(1,999999, "Thêi h¹n sö dông:", {self.SetTimeOptionInItem, {self, tbSpecifiedItem, nCount, nOptionSelected, tbListOption}})
end
function tbAloneScript:SetTimeOptionInItem(tbSpecifiedItem, nCount, nOptionSelected, tbListOption, nTimer)
	tbSpecifiedItem[3][nOptionSelected] = {tbListOption[1], nTimer, tbListOption[2]};
	self:CountSpecifiedItem(tbSpecifiedItem, nCount)
end
function tbAloneScript:IsOption(tbOpt, nType)
	if (type(tbOpt) == nType) then
		return 1
	else
		return
	end
end
function tbAloneScript:GetTypeParam(szParam)
	local nTypeParam = 0;
	local nMaxParam = 16;
	local tbParam = split(szParam)
	if (getn(tbParam) < 3) then
		nTypeParam = 1;
	elseif (getn(tbParam) == 6) then
		nTypeParam = 2;
	elseif (getn(tbParam) > 6) and (getn(tbParam) < 13) then
		nTypeParam = 3;
	-- elseif (getn(tbParam) >= 13) and (getn(tbParam) =< nMaxParam) then
		-- nTypeParam = 4;
	end
	return nTypeParam, {szParam, tbParam};
end
function tbAloneScript:IsParamNumber(tbParam)
	for i = 1, getn(tbParam) do
		local IsNumber = tonumber(tbParam[i])
		if not IsNumber then
			return 0;
		end
	end
	return 1;
end
-----------------------------------------------------------
-- GM Qu¶n Lý M¸y Chñ - LÊy th«ng tin NPC
-----------------------------------------------------------
function LastNpcTalk()
	local nNpcIndex = GetLastDiagNpc()
	local Name = GetNpcName(nNpcIndex)
	local IdNpc = GetNpcSettingIdx(nNpcIndex)
	local nScript = GetNpcScript(nNpcIndex)
	local DropFile = GetNpcDropRateFile(nNpcIndex)
	local NguHanh = GetNpcSeries(nNpcIndex)
	local Life = GetNpcLife(nNpcIndex)
	local NpcKind = GetNpcKind(nNpcIndex)
	local file  = openfile("npcinfo.lua", "a+")
	write(file,strchar(34).."Name: "..Name.." ID: "..IdNpc.." Script: "..nScript.." DropFile: "..DropFile.." Life: "..Life.." NguHanh: "..NguHanh.." Kind: "..NpcKind..strchar(34),'\n')
	closefile(file)
	Say("<color=green>Th«ng tin ®­îc l­u l¹i ë file server1-npcinfo.lua<color>")
	Msg2Player("<color=yellow>Th«ng tin ®­îc l­u l¹i ë file server1-npcinfo.lua<color>")
end
------------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i
-- GM Qu¶n Lý Ng­êi Ch¬i - Qu¶n lý nh©n vËt
------------------------------------------------------------
function tbAloneScript:ManageSystemGlobal()
	local szTitle = "HÖ thèng qu¶n lý toµn m¸y chñ ®­îc sö dông ®Ó khãa, cÊm ch¸t, kick out,… ng­êi ch¬i trong m¸y chñ."
	local tbOption = {}
		tinsert(tbOption, {"Khãa nh©n vËt ®ang trùc tuyÕn", self.LockPlayerOnline, {self, 1}})
		tinsert(tbOption, {"Më khãa nh©n vËt", self.UnlockPlayer, {self, 1}})
		tinsert(tbOption, {"Khãa tµi kho¶n ®ang trùc tuyÕn", self. LockPlayerOnline, {self, 2}})
		tinsert(tbOption, {"Më khãa tµi kho¶n", self. UnlockPlayer, {self, 2}})
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end
------------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - Qu¶n lý nh©n vËt - Khãa nh©n vËt ®ang trùc tuyÕn/Khãa tµi kho¶n ®ang trùc tuyÕn
------------------------------------------------------------
function tbAloneScript:LockPlayerOnline(nType)
	g_AskClientStringEx("", 1, 50, "Tªn muèn khãa:", {self.EnterLockPlayerOnline, {self, nType}})
end
function tbAloneScript:EnterLockPlayerOnline(nType, szPlayer)
	local nGMPlayer = PlayerIndex
	local nPlayerIndex = 0;
	local szAccount = "";
	if (nType == 1) then
		nPlayerIndex = SearchPlayer(szPlayer)
	elseif (nType == 2) then
		nPlayerIndex= self:SearchAccount(szPlayer)
	end
	
	if (nPlayerIndex <= 0) then
		Msg2Player("Ng­êi nµy hiÖn kh«ng onlone hoÆc kh«ng tån t¹i");
	return 0 end
	
	PlayerIndex = nGMPlayer;
	if (nType == 1) then
		self:LockSystemByNamePlayer(nPlayerIndex);
	elseif (nType == 2) then
		self:LockSystemByAccountPlayer(nPlayerIndex);
	end
end
function tbAloneScript:LockSystemByNamePlayer(nPlayerIndex)
	g_AskClientStringEx("", 1, 500, "Lý do bÞ khãa:", {self.EnterLockSystemByNamePlayer, {self, nPlayerIndex}})
end
function tbAloneScript:EnterLockSystemByNamePlayer(nPlayerIndex, szMsg)
	local nType = 1;
	self:FileSystem_LoadFile(TAB_LINKFILEDATA[nType][1])
	local szPlayerName = "";
	local szMsg = szMsg or "";
	local nGMPlayer = PlayerIndex;
		PlayerIndex = nPlayerIndex;
			szPlayerName = GetName();
			Msg2Player(format("<color=yellow>Nh©n vËt nµy ®· bÞ khãa, v× lÝ do: %s", szMsg));
			self:FileSystem_SetData(TAB_LINKFILEDATA[nType][1], TAB_LINKFILEDATA[nType][2], szPlayerName, 1)
			self:FileSystem_SaveData(TAB_LINKFILEDATA[nType][1])
			SetTaskTemp(TASKTEMP_KICKOUT, GetCurServerTime());
			SetTimer(1*FRAME2TIME, TIMETASK_ID);
			OnTimer()
		PlayerIndex = nGMPlayer;
			Msg2Player("B¹n ®· khãa ng­êi ch¬i nµy thµnh c«ng!")
			SetStringTask(TASKS_LOCKSYSTEM, szPlayerName);
end
function tbAloneScript:LockSystemByAccountPlayer(nPlayerIndex)
	g_AskClientStringEx("", 1, 500, "Lý do bÞ khãa:", {self.EnterLockSystemByAccountPlayer, {self, nPlayerIndex}})
end
function tbAloneScript:EnterLockSystemByAccountPlayer(nPlayerIndex, szMsg)
	local nType = 2;
	self:FileSystem_LoadFile(TAB_LINKFILEDATA[nType][1])
	local szPlayerName = "";
	local szMsg = szMsg or "";
	local nGMPlayer = PlayerIndex;
		PlayerIndex = nPlayerIndex;
			szPlayerName = GetAccount();
			Msg2Player(format("<color=yellow>Nh©n vËt nµy ®· bÞ khãa, v× lÝ do: %s", szMsg));
			self:FileSystem_SetData(TAB_LINKFILEDATA[nType][1], TAB_LINKFILEDATA[nType][2], szPlayerName, 1)
			self:FileSystem_SaveData(TAB_LINKFILEDATA[nType][1])
			SetTaskTemp(TASKTEMP_KICKOUT, GetCurServerTime());
			SetTimer(1*FRAME2TIME, TIMETASK_ID);
			OnTimer()
		PlayerIndex = nGMPlayer;
			Msg2Player("B¹n ®· khãa ng­êi ch¬i nµy thµnh c«ng!")
			SetStringTask(TASKS_LOCKSYSTEM, szPlayerName);
end
function tbAloneScript:SearchAccount(szAccount)
	for i = 1, GetPlayerCount() do
		PlayerIndex = i;
			if (GetAccount() == szAccount) then
			return i end;
	end
return 0 end
function tbAloneScript:GameServerKickOut(nPlayerIndex)
	self:FileSystem_LoadFile(TAB_LINKFILEDATA[1][1])
	self:FileSystem_LoadFile(TAB_LINKFILEDATA[2][1])
	local GMPlayer = PlayerIndex;
		PlayerIndex = nPlayerIndex;
	
	local nIsPlayer = tonumber(self:FileSystem_GetData(TAB_LINKFILEDATA[1][1], TAB_LINKFILEDATA[1][2], GetName())) or 0;
		
		if (nIsPlayer == 1) then
			Msg2Player("Nh©n vËt nµy cña b¹n hiÖn ®ang bÞ khãa, kh«ng thÓ tham gia vµo game.")
			SetTaskTemp(TASKTEMP_KICKOUT, GetCurServerTime());
			SetTimer(1*FRAME2TIME, TIMETASK_ID);
		end
		
		local nIsAccount = tonumber(self:FileSystem_GetData(TAB_LINKFILEDATA[2][1], TAB_LINKFILEDATA[2][2], GetAccount())) or 0;
		
		if (nIsAccount == 1) then
			Msg2Player("Tµi kho¶n nµy cña b¹n hiÖn ®ang bÞ khãa, kh«ng thÓ tham gia vµo game.")
			SetTaskTemp(TASKTEMP_KICKOUT, GetCurServerTime());
			SetTimer(1*FRAME2TIME, TIMETASK_ID);
		end
end
------------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - Qu¶n lý nh©n vËt - Më khãa nh©n vËt/Më khãa tµi kho¶n
------------------------------------------------------------
function tbAloneScript:UnlockPlayer(nType)
	g_AskClientStringEx("", 1, 50, "Tªn më khãa:", {self.EnterUnlockPlayer, {self, nType}})
end

function tbAloneScript:EnterUnlockPlayer(nType, szPlayer)
	self:FileSystem_LoadFile(TAB_LINKFILEDATA[nType][1])
	local nCount = self:FileSystem_GetData(TAB_LINKFILEDATA[nType][1], TAB_LINKFILEDATA[nType][2], szPlayer)
	if (tonumber(nCount) ~= 1) then
		Msg2Player(szPlayer.." kh«ng bÞ khãa")
	return end
	self:FileSystem_SetData(TAB_LINKFILEDATA[nType][1], TAB_LINKFILEDATA[nType][2], szPlayer, "");
	self:FileSystem_SaveData(TAB_LINKFILEDATA[nType][1])
	Msg2Player(format("B¹n ®· më khãa cho <color=yellow>%s<color> nµy thµnh c«ng!", szPlayer));
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt
-----------------------------------------------------------
function tbAloneScript:ManipulationOnPlayer()
	if (GetLevel() < 10) then
		Talk(1, "", "Nh©n vËt ®¹t cÊp 10 trë lªn míi cã thÓ sö dông tÝnh n¨ng nµy")
	return end
	
	g_AskClientStringEx("", 0, 200, "Tªn nh©n vËt:", {self.SearchPlayerOnline, {self}})
end

function tbAloneScript:SearchPlayerOnline(szPlayer)
	local GMPlayer = PlayerIndex;
	local szName, szAccount, szIP;
	local nLevel, nCash;
	nPlayerIndex = SearchPlayer(szPlayer)
	if nPlayerIndex <= 0 then
		Talk(1, "", "Nh©n vËt nµy ®· rêi m¹ng hoÆc kh«ng tån t¹i!")
		return
	end
	
	local szFactionName = {
		["shaolin"] 		= "ThiÕu L©m ph¸i",
		["tianwang"] 	= "Thiªn V­¬ng bang",
		["tangmen"] 	= "§­êng M«n ph¸i",
		["wudu"] 			= "Ngò §éc gi¸o",
		["emei"] 			= "Nga My ph¸i",
		["cuiyan"] 		= "Thóy Yªn m«n",
		["gaibang"] 		= "C¸i Bang ph¸i",
		["tianren"] 		= "Thiªn NhÉn gi¸o",
		["wudang"] 		= "Vâ §ang ph¸i",
		["kunlun"] 		= "C«n L«n ph¸i",
		["huashan"] 	= "Hoa S¬n ph¸i",
	}
	
	PlayerIndex = nPlayerIndex;
		szName = GetName();
		szAccount = GetAccount();
		szFaction = GetFaction();
		nLevel = GetLevel();
		nCash = GetCash();
		szIP = self:GetIP();
		nRepute = GetRepute();
		nWorld, nPosX, nPosY = GetWorldPos();
		nLead = GetLeadLevel();
		nFight = GetFightState();
		nCamp = GetCamp();
		nFaction = GetLastFactionNumber();
		nPK = GetPK();
		nSex = GetSex();
		nFuYuan = GetTask(151);
		nBattle = GetTask(747);
		nLeague = GetTask(2501);
		nRespect = GetRespect();
		nCoin = GetExtPoint(1);
		
		nLife = GetLife(0);
		nMana = GetMana(0);
		nStamina = GetStamina(0);
		nDefend = GetDefend(0);
		nColdR = GetColdR(0);
		nLightR = GetLightR(0);
		nFireR = GetFireR(0);
		nPoisonR = GetPoisonR(0);
		nPhyR = GetPhyR(0);
		nLucky = GetLucky();
		
		nEng =  GetEng(0);
		nDex = GetDex(0);
		nStr = GetStrg(0);
		nVit = GetVit(0);
		nAP = GetRestAP();
		nSP = GetRestSP();
	PlayerIndex = GMPlayer;
		Describe(format(strfill_center(" Th«ng tin ng­êi ch¬i ", 50, "-").."\n"
		.."\n+ Ingame: %s"
		.."\n+ ID Account: %s"
		.."\n+ IP: %s"
		.."\n+ VÞ trÝ: B¶n ®å: %d - Täa ®é: %d,%d"
		.."\n+ M«n ph¸i: %s"
		.."\n+ Level: %d"
		.."\n+ TiÒn v¹n: %d"
		.."\n+ TiÒn ®ång: %d"

		.."\n+ §iÓm danh väng: %d"
		.."\n+ §iÓm phóc duyªn: %d"
		.."\n+ §iÓm uy danh: %d"
		.."\n+ §iÓm tÝch lòy Tèng Kim: %d"
		.."\n+ §iÓm tÝch lòy Liªn §Êu: %d"
		
		.."\n------------------------------------------------"		
		.."\n+ Sinh lùc: %d"
		.."\n+ Néi lùc: %d"
		.."\n+ ThÓ lùc: %d"
		.."\n+ NÐ tr¸nh: %d"
		
		.."\n+ Kh¸ng b¨ng: %d"
		.."\n+ Kh¸ng l«i: %d"
		.."\n+ Kh¸ng háa: %d"
		.."\n+ Kh¸ng ®éc: %d"
		.."\n+ Phßng thñ vËt lý: %d"
		
		.."\n+ Søc m¹nh: %d"
		.."\n+ Sinh khÝ: %d"
		.."\n+ Th©n ph¸p: %d"
		.."\n+ Néi c«ng: %d"
		.."\n+ TiÒm n¨ng cßn l¹i: %d"
		.."\n+ Kü n¨ng cßn l¹i: %d"
		.."\n------------------------------------------------"
		
		, szName or ""
		, szAccount or ""
		, szIP or ""
		, nWorld or 0, nPosX or 0, nPosY or 0
		, szFactionName[szFaction] or "Ch­a gia nhËp"
		, nLevel or 0
		, nCash or 0
		, nCoin or 0
		
		, nRepute or 0
		, nFuYuan or 0
		, nRespect or 0
		, nBattle or 0
		, nLeague or 0
		-------------------------------------------------
		, nLife or 0
		, nMana or 0
		, nStamina or 0
		, nDefend or 0
		
		, nColdR or 0
		, nLightR or 0
		, nFireR or 0
		, nPoisonR or 0
		, nPhyR or 0
		, nStr or 0
		, nVit or 0
		, nDex or 0
		, nEng or 0
		, nAP or 0
		, nSP or 0
		-------------------------------------------------
		)
		,9,
		"GM di chuyÓn ®Õn ng­êi ch¬i nµy/#tbAloneScript:GMMoveToPlayer("..nPlayerIndex..")",
		"Ng­êi ch¬i nµy di chuyÓn ®Õn GM/#tbAloneScript:PlayerMoveToGM("..nPlayerIndex..")",
		"TÆng ®iÓm cho ng­êi ch¬i nµy/#tbAloneScript:GivePoints("..nPlayerIndex..")",
		"TÆng vËt phÈm, ®¹o cô, trang bÞ cho ng­êi ch¬i nµy/#tbAloneScript:GiveItemForPlayer("..nPlayerIndex..")",
		"TÆng tiÒn v¹n (v¹n l­îng) cho ng­êi ch¬i ngµy/#tbAloneScript:GiveCash("..nPlayerIndex..")",
		"TÆng tiÒn ®ång cho ng­êi ch¬i ngµy/#tbAloneScript:GiveCoin("..nPlayerIndex..")",
		"TÆng KNB cho ng­êi ch¬i ngµy/#tbAloneScript:GiveKNB("..nPlayerIndex..")",
		"Më chøc n¨ng cho ng­êi ch¬i kh¸c/#tbAloneScript:MoChucNang("..nPlayerIndex..")",
		"§ãng./OnCancel")
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - GM di chuyÓn ®Õn ng­êi ch¬i nµy
-----------------------------------------------------------
function tbAloneScript:GMMoveToPlayer(nPlayerIndex)
	local nWorld, nX, nY;
	local szName = "";
	local GMPlayer = PlayerIndex;
		PlayerIndex = nPlayerIndex;
			nWorld, nX, nY = GetWorldPos();
			szName = GetName();
		PlayerIndex = GMPlayer;
			local nWorldIdx = NewWorld(nWorld, nX, nY);
			if nWorldIdx ~= 1 then
				GMMsg2Player(szName, "DÞch chuyÓn ®Õn ng­êi ch¬i nµy thÊt b¹i!")
				return 0
			end
			GMMsg2Player(szName, "<color=yellow>DÞch chuyÓn ®Õn ng­êi ch¬i nµy thµnh c«ng!")
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - Ng­êi ch¬i nµy di chuyÓn ®Õn GM
-----------------------------------------------------------
function tbAloneScript:PlayerMoveToGM(nPlayerIndex)
	local nWorld, nX, nY;
	local szPlayerName = "";
	local szGMName = "";
	local GMPlayer = PlayerIndex;
		PlayerIndex = GMPlayer;
			szGMName = GetName();
			nWorld, nX, nY = GetWorldPos();
		PlayerIndex = nPlayerIndex;
			szPlayerName = GetName();
			local nWorldIdx = NewWorld(nWorld, nX, nY)
			if nWorldIdx ~= 1 then
				PlayerIndex = GMPlayer;
					GMMsg2Player(szPlayerName, "DÞch chuyÓn ®Õn ng­êi ch¬i nµy thÊt b¹i!")
				return 0
			end
			GMMsg2Player("Th«ng b¸o triÖu tËp", "B¹n ®­îc GM ra lÖnh triÖu tËp!")
		PlayerIndex = GMPlayer;
			GMMsg2Player(szPlayerName, "<color=yellow>B¹n ®· triÖu tËp ng­êi ch¬i nµy thµnh c«ng!")
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng ®iÓm cho ng­êi ch¬i nµy
-----------------------------------------------------------
function tbAloneScript:GivePoints(nPlayerIndex)
	local szTitle = "GM muèn tÆng ®iÓm g× cho ng­êi ch¬i nµy?";
	local tbOpt = {}
		tinsert(tbOpt, {"CÊp ®é", g_AskClientNumberEx, {0,200, "NhËp cÊp ®é:", {self.SetLevelPlayer, {self, nPlayerIndex}}}})
		tinsert(tbOpt, {"Kinh nghiÖm", g_AskClientNumberEx, {0,9999999999, "NhËp sè ®iÓm:", {self.SetExpPlayer, {self, nPlayerIndex}}}})
		tinsert(tbOpt, {"Danh väng", g_AskClientNumberEx, {0,9999999999, "NhËp sè ®iÓm:", {self.SetReputePlayer, {self, nPlayerIndex}}}})
		tinsert(tbOpt, {"Phóc duyªn", g_AskClientNumberEx, {0,9999999999, "NhËp sè ®iÓm:", {self.SetFuYuanPlayer, {self, nPlayerIndex}}}})
		tinsert(tbOpt, {"Tèng kim", g_AskClientNumberEx, {0,9999999999, "NhËp sè ®iÓm:", {self.SetBattlePointPlayer, {self, nPlayerIndex}}}})
		tinsert(tbOpt, {"Liªn ®Êu", g_AskClientNumberEx, {0,9999999999, "NhËp sè ®iÓm:", {self.SetLeaguePointPlayer, {self, nPlayerIndex}}}})
		tinsert(tbOpt, {"§ãng."})
	CreateNewSayEx(szTitle, tbOpt)
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng ®iÓm cho ng­êi ch¬i nµy - CÊp ®é
-----------------------------------------------------------
function tbAloneScript:SetLevelPlayer(nPlayerIndex, nLevel)
	local szPlayerName, szGMName = "", "";
	local nGMPlayer = PlayerIndex;
		szGMName = GetName();
	PlayerIndex = nPlayerIndex;
		szPlayerName = GetName();
		ST_LevelUp(nLevel-GetLevel());
		Msg2Player(format("B¹n ®· nhËn ®­îc <color=yellow>%d<color> cÊp ®é bëi GM %s", nLevel, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("B¹n ®· tÆng cho ng­êi ch¬i %s <color=yellow>%d<color> cÊp ®é", szPlayerName, nLevel))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng ®iÓm cho ng­êi ch¬i nµy - Kinh nghiÖm
-----------------------------------------------------------
function tbAloneScript:SetExpPlayer(nPlayerIndex, nExp)
	local szPlayerName, szGMName = "", "";
	local nGMPlayer = PlayerIndex;
		szGMName = GetName();
	PlayerIndex = nPlayerIndex;
		szPlayerName = GetName();
		tl_addPlayerExp(nExp);
		Msg2Player(format("B¹n ®· nhËn ®­îc <color=yellow>%d<color> ®iÓm kinh nghiÖm bëi GM %s", nExp, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("B¹n ®· tÆng cho ng­êi ch¬i %s <color=yellow>%d<color> ®iÓm kinh nghiÖm", szPlayerName, nExp))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng ®iÓm cho ng­êi ch¬i nµy - Danh väng
-----------------------------------------------------------
function tbAloneScript:SetReputePlayer(nPlayerIndex, nPoint)
	local szPlayerName, szGMName = "", "";
	local nGMPlayer = PlayerIndex;
		szGMName = GetName();
	PlayerIndex = nPlayerIndex;
		szPlayerName = GetName();
		AddRepute(nPoint);
		Msg2Player(format("B¹n ®· nhËn ®­îc <color=yellow>%d<color> danh väng bëi GM %s", nPoint, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("B¹n ®· tÆng cho ng­êi ch¬i %s <color=yellow>%d<color> danh väng", szPlayerName, nPoint))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng ®iÓm cho ng­êi ch¬i nµy - Phóc duyªn
-----------------------------------------------------------
function tbAloneScript:SetFuYuanPlayer(nPlayerIndex, nPoint)
	local szPlayerName, szGMName = "", "";
	local nGMPlayer = PlayerIndex;
		szGMName = GetName();
	PlayerIndex = nPlayerIndex;
		szPlayerName = GetName();
		SetTask(151, GetTask(151)+nPoint)
		Msg2Player(format("B¹n ®· nhËn ®­îc <color=yellow>%d<color> phóc duyªn bëi GM %s", nPoint, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("B¹n ®· tÆng cho ng­êi ch¬i %s <color=yellow>%d<color> phóc duyªn", szPlayerName, nPoint))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng ®iÓm cho ng­êi ch¬i nµy - Tèng kim
-----------------------------------------------------------
function tbAloneScript:SetBattlePointPlayer(nPlayerIndex, nPoint)
	local szPlayerName, szGMName = "", "";
	local nGMPlayer = PlayerIndex;
		szGMName = GetName();
	PlayerIndex = nPlayerIndex;
		szPlayerName = GetName();
		SetTask(747, GetTask(747)+nPoint);
		Msg2Player(format("B¹n ®· nhËn ®­îc <color=yellow>%d<color> ®iÓm Tèng Kim bëi GM %s", nPoint, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("B¹n ®· tÆng cho ng­êi ch¬i %s <color=yellow>%d<color> ®iÓm Tèng Kim", szPlayerName, nPoint))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng ®iÓm cho ng­êi ch¬i nµy - Liªn §Êu
-----------------------------------------------------------
function tbAloneScript:SetLeaguePointPlayer(nPlayerIndex, nPoint)
	local szPlayerName, szGMName = "", "";
	local nGMPlayer = PlayerIndex;
		szGMName = GetName();
	PlayerIndex = nPlayerIndex;
		szPlayerName = GetName();
		SetTask(2501, GetTask(2501)+nPoint);
		Msg2Player(format("B¹n ®· nhËn ®­îc <color=yellow>%d<color> ®iÓm Liªn §Êu bëi GM %s", nPoint, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("B¹n ®· tÆng cho ng­êi ch¬i %s <color=yellow>%d<color> ®iÓm Liªn §Êu", szPlayerName, nPoint))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng vËt phÈm, ®¹o cô, trang bÞ cho ng­êi ch¬i nµy
-----------------------------------------------------------
function tbAloneScript:GiveItemForPlayer(nPlayerIndex)
	local GMPlayer = PlayerIndex;
		PlayerIndex = GMPlayer;
			self:TakeSpecifiedItem()
		PlayerIndex = nPlayerIndex;
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng tiÒn v¹n (v¹n l­îng) cho ng­êi ch¬i nµy
-----------------------------------------------------------
function tbAloneScript:GiveCash(nPlayerIndex)
	g_AskClientNumberEx(1, 20000, "NhËp sè l­îng:", {self.GiveCashNow, {self, nPlayerIndex}})
end
function tbAloneScript:GiveCashNow(nPlayerIndex, nCount)
	local szPlayer, szGMName = "", "";
	local szGMName = GetName();
	local nGMPlayer = PlayerIndex;
	PlayerIndex = nPlayerIndex;
		szPlayer = GetName();
		Earn(nCount*10000)
		Msg2Player(format("<color=green>B¹n nhËn ®­îc <color=yellow>%d<color> v¹n l­îng tõ GM %s<color>", nCount, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("<color=green>B¹n ®· tÆng ng­êi ch¬i %s <color=yellow>%d<color> v¹n l­îng<color>", szPlayer, nCount))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng tiÒn ®ång cho ng­êi ch¬i nµy
-----------------------------------------------------------
function tbAloneScript:GiveCoin(nPlayerIndex)
	g_AskClientNumberEx(1, 1000000, "NhËp sè l­îng:", {self.GiveCoinNow, {self, nPlayerIndex}})
end
function tbAloneScript:GiveCoinNow(nPlayerIndex, nCount)
	local szPlayer, szGMName = "", "";
	local szGMName = GetName();
	local nGMPlayer = PlayerIndex;
	PlayerIndex = nPlayerIndex;
		for i = 1, nCount do
			AddItem(4,417,1,0,0,0)
		end
		Msg2Player(format("<color=green>B¹n nhËn ®­îc <color=yellow>%d<color> TiÒn §ång tõ GM %s", nCount, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("<color=green>B¹n ®· tÆng ng­êi ch¬i %s <color=yellow>%d<color> TiÒn §ång.", szPlayer, nCount))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - TÆng KNB cho ng­êi ch¬i nµy
-----------------------------------------------------------
function tbAloneScript:GiveKNB(nPlayerIndex)
	g_AskClientNumberEx(1, 1000000, "NhËp sè l­îng:", {self.GiveKNBNow, {self, nPlayerIndex}})
end
function tbAloneScript:GiveKNBNow(nPlayerIndex, nCount)
	local szPlayer, szGMName = "", "";
	local szGMName = GetName();
	local nGMPlayer = PlayerIndex;
	PlayerIndex = nPlayerIndex;
		for i = 1, nCount do
			AddItem(4,343,1,0,0,0)
		end
		Msg2Player(format("<color=green>B¹n nhËn ®­îc <color=yellow>%d<color> KNB tõ GM %s", nCount, szGMName))
	PlayerIndex = nGMPlayer;
		Msg2Player(format("<color=green>B¹n ®· tÆng ng­êi ch¬i %s <color=yellow>%d<color> KNB.", szPlayer, nCount))
end
-----------------------------------------------------------
-- GM Qu¶n Lý Ng­êi Ch¬i - NhËp tªn nh©n vËt - Më chøc n¨ng cho ng­êi ch¬i kh¸c
-----------------------------------------------------------
function tbAloneScript:MoChucNang(nPlayerIndex)
	local szPlayerName, szGMName = "", "";
	local nGMPlayer = PlayerIndex;
szGMName = GetName();
	PlayerIndex = nPlayerIndex;
szPlayerName = GetName();
%tbAloneScript:SupportGMTestGame()
end

































function tbAloneScript:Write()
	local data = "goldequip.txt";
	local str = "";
	for i = 5670, 5919 do
		local nItemIndex = NewItemEx(4,0,1,0,i-1,0,0,0,0,0,0,0,0,0,0,0)
		str = str..format("\t\t{\"%s\",%d},\n",GetItemName(nItemIndex),i)
	end
	-- for i = 4813, 4832 do
		-- local nItemIndex = NewItemEx(4,0,1,0,i-1,0,0,0,0,0,0,0,0,0,0,0)
		-- str = str..format("\t\t{\"%s\",%d},\n",GetItemName(nItemIndex),i)
	-- end
	local Data2 = openfile(""..data.."", "a+");
	write(Data2,tostring(str));
	closefile(Data2);
end











-----------------------------------------------------------
-- GM LÊy Item
-----------------------------------------------------------
function tbAloneScript:GM_layitem()
	local szTitle = format("<color=yellow>NobitaXD:<color><enter>Mêi GM <color=red>%s<color> lùa chän chøc n¨ng GM:", GetName());
	local tbOption = {};
		tinsert(tbOption, {"GM LÊy §å Theo ID", LayDoTheoID})
		--tinsert(tbOption, {"GM LÊy vËt phÈm M·ng", self.TakeSpecifiedItem, {self}})
		tinsert(tbOption, {"GM Help", TakeSpecifiedItem_help})
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID
-----------------------------------------------------------
function LayDoTheoID()			
	local szTitle = "xin h·y chän vËt phÈm cÇn lÊy ! ";
	local tbOpt = {
		{"LÊy §å Hoµng Kim",LayMenuHKMP},
		{"LÊy §å Queskey",LayMenuQueskey},
		{"LÊy §å Magic",LayMenuMagic},
		{"LÊy Ngùa",LayMenuNgua},
		{"LÊy MÆt N¹",LayMenuMatNa},
		{"Tho¸t",OnCancel},
	}
	CreateNewSayEx(szTitle, tbOpt)
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID - LÊy §å Magic
-----------------------------------------------------------
function LayMenuMagic()
	AskClientForNumber("LayMenuMagic_1",0,10000,"LÊy ID Nµo")
end
function LayMenuMagic_1(nID)
	if nID == nil or nID == 0 or nID < 1 or nID > 10000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3355,nID)
	AskClientForNumber("LayMenuMagic_2",0,5000,"Sè L­îng Nhiu")
end
function LayMenuMagic_2(nSoLuong)
	if nSoLuong == nil or nSoLuong == 0 or nSoLuong < 1 or nSoLuong > 5000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
		end
	SetTask(3356,nSoLuong)
	AskClientForNumber("LayMenuMagic_3",0,365,"Bao Nhiu Ngµy")
end
function LayMenuMagic_3(nHSD)
	local nID = GetTask(3355)
	local nSL = GetTask(3356)
	if nHSD == nil or nHSD > 365 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	if nHSD == 0 then
		local nItemIdx = AddItem(6,1,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={6,1,nID,1,0},nCount=nSL,},}, "AD", 1);
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(6,1,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={6,1,nID,1,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.."  [ "..Ten.." ] -  M· M¸y [ %s] - HSD [ "..nHSD.." ]  ngµy".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		-- logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.."  [ "..Ten.." ] -  M· M¸y [ %s] - HSD [ "..nHSD.." ]  ngµy".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),getHWID()))
		return
	end
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID - LÊy §å Queskey
-----------------------------------------------------------
function LayMenuQueskey()
	AskClientForNumber("LayMenuQueskey_1",0,10000,"LÊy ID Nµo")
end
function LayMenuQueskey_1(nID)
	if nID == nil or nID == 0 or nID < 1 or nID > 10000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3355,nID)
	AskClientForNumber("LayMenuQueskey_2",0,9000,"Sè L­îng Nhiu")
end
function LayMenuQueskey_2(nSoLuong)
	if nSoLuong == nil or nSoLuong == 0 or nSoLuong < 1 or nSoLuong > 9000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3356,nSoLuong)
	AskClientForNumber("LayMenuQueskey_3",0,365,"Bao Nhiu Ngµy")
end
function LayMenuQueskey_3(nHSD)
	local nID = GetTask(3355)
	local nSL = GetTask(3356)
	if nHSD == nil or nHSD > 365 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	if nHSD == 0 then
		local nItemIdx = AddItem(4,nID,1,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={4,nID,1,1,0},nCount=nSL,},}, "AD", 1);
		-- logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),getHWID()))
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(4,nID,1,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={4,nID,1,1,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);
		-- logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  HSD [ "..nHSD.." ]  ngµy - M· M¸y [ %s] -".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),getHWID()))
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  HSD [ "..nHSD.." ]  ngµy - M· M¸y [ %s] -".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID - LÊy §å Hoµng Kim
-----------------------------------------------------------
function LayMenuHKMP()
	AskClientForNumber("LayMenuHKMP_1",0,10000,"LÊy ID Nµo")
end
function LayMenuHKMP_1(nID)
	if nID == nil or nID == 0 or nID < 1 or nID > 10000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3355,nID)
	AskClientForNumber("LayMenuHKMP_2",0,1000,"Sè L­îng Nhiu")
end
function LayMenuHKMP_2(nSoLuong)
	if nSoLuong == nil or nSoLuong == 0 or nSoLuong < 1 or nSoLuong > 1000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3356,nSoLuong)
	AskClientForNumber("LayMenuHKMP_3",0,365,"Bao Nhiu Ngµy")
end
function LayMenuHKMP_3(nHSD)
	local nID = GetTask(3355)
	local nSL = GetTask(3356)
	if nHSD == nil or nHSD > 365 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	if nHSD == 0 then
		local nItemIdx = AddGoldItem(0,nID)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,nID},nCount=nSL,nQuality=1},}, "AD", 1);
		-- logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),getHWID()))
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddGoldItem(0,nID)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,nID},nCount=nSL,nQuality=1,nExpiredTime=nHSD * 1440},}, "AD", 1);
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  HSD [ "..nHSD.." ]  ngµy - M· M¸y [ %s] -".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		-- logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  HSD [ "..nHSD.." ]  ngµy - M· M¸y [ %s] -".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),getHWID()))
		return
	end
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID - LÊy MÆt N¹
-----------------------------------------------------------
function LayMenuMatNa()
	AskClientForNumber("LayMenuMatNa_1",0,10000,"LÊy ID Nµo")
end
function LayMenuMatNa_1(nID)
	if nID == nil or nID == 0 or nID < 1 or nID > 10000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3355,nID)
	AskClientForNumber("LayMenuMatNa_2",0,1000,"Sè L­îng Nhiu")
end
function LayMenuMatNa_2(nSoLuong)
	if nSoLuong == nil or nSoLuong == 0 or nSoLuong < 1 or nSoLuong > 1000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3356,nSoLuong)
	AskClientForNumber("LayMenuMatNa_3",0,365,"Bao Nhiu Ngµy")
end
function LayMenuMatNa_3(nHSD)
	local nID = GetTask(3355)
	local nSL = GetTask(3356)
	if nHSD == nil or nHSD > 365 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	if nHSD == 0 then
		local nItemIdx = AddItem(0,11,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,11,nID,1,0},nCount=nSL,},}, "AD", 1);
		-- logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),getHWID()))
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(0,11,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,11,nID,1,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  HSD [ "..nHSD.." ]  ngµy - M· M¸y [ %s] -".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID - LÊy Ngùa
-----------------------------------------------------------
function LayMenuNgua()
	AskClientForNumber("LayMenuNgua_1",0,10000,"LÊy ID Nµo")
end
function LayMenuNgua_1(nID)
	if nID == nil or nID == 0 or nID < 1 or nID > 10000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3355,nID)
	AskClientForNumber("LayMenuNgua_2",0,1000,"Sè L­îng Nhiu")
end
function LayMenuNgua_2(nSoLuong)
	if nSoLuong == nil or nSoLuong == 0 or nSoLuong < 1 or nSoLuong > 1000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3356,nSoLuong)
	AskClientForNumber("LayMenuNgua_3",0,365,"Bao Nhiu Ngµy")
end
function LayMenuNgua_3(nHSD)
	local nID = GetTask(3355)
	local nSL = GetTask(3356)
	if nHSD == nil or nHSD > 365 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	if nHSD == 0 then
		local nItemIdx = AddItem(0,10,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,10,nID,10,0},nCount=nSL,},}, "AD", 1);
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  M· M¸y [ %s] ".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(0,10,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,10,nID,10,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);
		logplayer("data/log_lay_item_admin.txt",format("TG : %s  - ID [ %s] - NV [ %s] - lÊy "..nSL.." [ "..Ten.." ] -  HSD [ "..nHSD.." ]  ngµy - M· M¸y [ %s] -".."",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),GetIP()))
		return
	end
end

----------------------------------------------------------
-- GM Chøc N¨ng - BËt Èn th©n/T¾t Èn th©n
----------------------------------------------------------
function tbAloneScript:GMHide()
	AddSkillState(1206,1,0,777600);
	Msg2Player("BËt chøc n¨ng Èn th©n cho GM");
end
function tbAloneScript:GMShow()
	AddSkillState(1206,1,0,18*1);
	Msg2Player("T¾t chøc n¨ng Èn th©n cho GM");
end
----------------------------------------------------------
-- GM Chøc N¨ng - BËt ngo¹i h×nh GM/T¾t ngo¹i h×nh GM
----------------------------------------------------------
function tbAloneScript:ChangeMask()
	ChangeOwnFeature(0,0,567);
	Msg2Player("BiÕn thµnh h×nh d¹ng GM");
end
function tbAloneScript:RestoreMask()
	RestoreOwnFeature();
	Msg2Player("Trë l¹i h×nh d¹ng ban ®Çu");
end
----------------------------------------------------------
-- GM Chøc N¨ng - BËt vßng s¸ng GM/T¾t vßng s¸ng GM
----------------------------------------------------------
function tbAloneScript:HaloGM()
		if (Title_GetActiveTitle() ~= 5000) then
			SetTask(1122, 5000)
			Title_AddTitle(5000, 1, 30*24*60*60*18);
			Title_ActiveTitle(5000);
		else
			Title_RemoveTitle(5000)
		end
end
----------------------------------------------------------
-- GM Chøc N¨ng - TÝnh n¨ng hç trî kh¸c
----------------------------------------------------------
function tbAloneScript:SupportFeatureOther()
	local szTitle = format("Chµo mõng <color=red>%s<color> tham gia m¸y chñ <color=red>OffLine S¬n Hµ X· T¾c<color>, <enter>§©y lµ lÖnh bµi hç trî dµnh cho GM ®Ó qu¶n lý, ®iÒu hµnh m¸y chñ cña m×nh.");
	local tbOption = {};
		tinsert(tbOption, {"Thay ®æi tr¹ng th¸i (mµu pk)", self.GMChangeCamp, {self}})
		tinsert(tbOption, {"Hñy bá vËt phÈm", DisposeItem})
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle..INFORMATION_DEVELOPER, tbOption)
end

function tbAloneScript:GMChangeCamp()
	local szTitle = "GM muèn ®æi sang mµu tr¹ng th¸i nµo d­íi ®©y?";
	local tbOption = {};
		tinsert(tbOption, {"LuyÖn c«ng (ch÷ tr¾ng)", self.GMChangeCampOK, {self, 0}})
		tinsert(tbOption, {"ChÝnh ph¸i (ch÷ vµng)", self.GMChangeCampOK, {self, 1}})
		tinsert(tbOption, {"Tµ ph¸i (ch÷ tÝm)", self.GMChangeCampOK, {self, 2}})
		tinsert(tbOption, {"Trung lËp (ch÷ xanh)", self.GMChangeCampOK, {self, 3}})
		tinsert(tbOption, {"S¸t thñ (ch÷ ®á)", self.GMChangeCampOK, {self, 4}})
		tinsert(tbOption, {"GM (ch÷ hång)", self.GMChangeCampOK, {self, 5}})
		tinsert(tbOption, {"§ãng."})
	CreateNewSayEx(szTitle, tbOption)
end

function tbAloneScript:GMChangeCampOK(nCamp)
	if not (TAB_LISTCAMP[nCamp]) then
		print("Thieu du lieu nCamp trong table TAB_LISTCAMP!")
	return 0 end
	SetCamp(nCamp)
	SetCurCamp(nCamp)
	Msg2Player(TAB_LISTCAMP[nCamp])
end
----------------------------------------------------------
-- GM Chøc N¨ng - T×m Boss Hoµng Kim
----------------------------------------------------------
function tbAloneScript:GMHelp()
	findgoldboss(1,12) 
end
-----------------------------------------------------------
-- GM Chøc N¨ng - Kü n¨ng
-----------------------------------------------------------
function tbAloneScript:SkillsSystem()
	local szTitle = "HÖ thèng kü n¨ng bao gåm thªm kü n¨ng vµ xãa kü n¨ng, b¹n muèn sö dông hÖ thèng kü n¨ng nµo?"
	local tbOpt = {}
		tinsert(tbOpt, {"Thªm kü n¨ng", g_AskClientStringEx, {"", 0,256,"Néi dung th«ng b¸o:", {self.AddSkills, {self}}}})
		tinsert(tbOpt, {"Xãa kü n¨ng", g_AskClientStringEx, {"", 0,256,"Néi dung th«ng b¸o:", {self.DeleteSkills, {self}}}})
		tinsert(tbOpt, {"§ãng."})
	CreateNewSayEx(szTitle, tbOpt)
end
function tbAloneScript:AddSkills(szSkills)
	local _,_, nStart, nEnd, _, nPoint = self:GetSplitSkills(szSkills)
	for i = nStart, nEnd do
		AddMagic(i, nPoint)
		GMMsg2Player("Thªm kü n¨ng", "Thªm kü n¨ng “"..GetSkillName(i).."” ®¼ng cÊp "..nPoint.."!")
	end
end
function tbAloneScript:DeleteSkills(szSkills)
	local tbSkills, nCount, nStart, _, nEnd, _ = self:GetSplitSkills(szSkills)
	if nCount > 2 then
		GMMsg2Player("Xãa kü n¨ng", "NhËp th«ng sè bÞ lçi, chØ cã thÓ nhËp tèi ®a 2 th«ng sè trë xuèng.")
		return 0
	end
	for i = nStart, nEnd do
		DelMagic(i)
		GMMsg2Player("Xãa kü n¨ng", "Kü n¨ng “"..GetSkillName(i).."” ®· ®­îc xãa bá!")
	end
end
function tbAloneScript:GetSplitSkills(szString)
	local nStartSkill, nEndSkill, nEndSkill2, nPointSkill;
	local tbString = split(szString, ",")
	local nType = self:IsParamNumber(tbString)
	if nType ~= 1 then
		GMMsg2Player("Thªm kü n¨ng", "NhËp th«ng sè bÞ lçi, chØ sö dông c¸c ký tù sè tõ 0-9 vµ dÊu phÈy “,”.")
		return 0
	end
	if (getn(tbString) == 1) then
		nStartSkill = tbString[1];
		nEndSkill = tbString[1];
		nEndSkill2 = tbString[1];
		nPointSkill = 0;
	elseif (getn(tbString) == 2) then
		nStartSkill = tbString[1];
		nEndSkill = tbString[1];
		nEndSkill2 = tbString[2];
		nPointSkill = tbString[2];
	elseif (getn(tbString) == 3) then
		nStartSkill = tbString[1];
		nEndSkill = tbString[2];
		nPointSkill = tbString[3];
	end
	return tbString, getn(tbString), nStartSkill, nEndSkill, nEndSkill2, nPointSkill;
end
-----------------------------------------------------------
-- GM Di ChuyÓn - §Õn b¶n ®å c«ng thµnh chiÕn
-----------------------------------------------------------
function gopos_sevenctc()
	Say("Ng­¬i muèn ®i chiÕn tr­êng nµo cña ThÊt Thµnh §¹i ChiÕn?", 8,
		"ChiÕn tr­êng Thµnh §«/#goto_ctc(1)",
		"ChiÕn tr­êng BiÖn Kinh/#goto_ctc(2)",
		"ChiÕn tr­êng §¹i Lý/#goto_ctc(3)",
		"ChiÕn tr­êng Ph­îng T­êng/#goto_ctc(4)",
		"ChiÕn tr­êng L©m An/#goto_ctc(5)",
		"ChiÕn tr­êng T­¬ng D­¬ng/#goto_ctc(6)",
		"ChiÕn tr­êng D­¬ng Ch©u/#goto_ctc(7)",
		"§Ó ta suy nghÜ l¹i/Cancel")
end
function goto_ctc(nIndex)
	if nIndex == 1 then 	NewWorld(926, 1713,3296)
	elseif nIndex == 2 then	NewWorld(927, 1750,3386)
	elseif nIndex == 3 then	NewWorld(928, 1716,3292)
	elseif nIndex == 4 then	NewWorld(929, 1763,3507)
	elseif nIndex == 5 then	NewWorld(930, 1752,3392)
	elseif nIndex == 6 then	NewWorld(931, 1712,3294)
	elseif nIndex == 7 then	NewWorld(932, 1714,3293)
	end
end
-----------------------------------------------------------
-- Reload File - Reload Script CFG_server
-----------------------------------------------------------
function Reload_CFG_server()
	LoadScript("\\script\\global\\nobitaxd\\config\\cfg_server.lua");
	LoadScript("\\script\\global\\nobitaxd\\npc\\npcthunghiem.lua");
	LoadScript("\\script\\global\\Â·ÈË_Àñ¹Ù.lua");
end
-----------------------------------------------------------
-- Reload File - NhËp ®­êng dÉn Script
-----------------------------------------------------------
function NhapDuongDanFileCanReLoadOK(Link)
        local ReloadScript = LoadScript(Link);
        --if (FALSE(ReloadScript )) then
        --    Msg2Player("XuÊt hiÖn lçi hoÆc sai ®­êng dÉn, kh«ng thÓ Reload file!<enter><color=green>"..Link.."");
        --else
        --    Msg2Player("<color=green>Reload thµnh c«ng Script<color><enter><color=green>"..Link.."");
        --end
end

function Reloadfile()
    return AskClientForString("NhapDuongDanFileCanReLoadOK", "", 1, 500, "<#>NhËp ®­êng dÉn")
end 

----------------------------------------------------
-- LÊy vËt phÈm chØ ®Þnh GM login
----------------------------------------------------
function tbAloneScript:GMLoginInGame()
	if (self:CheckGameMaster() == 2) then
		if (CalcEquiproomItemCount(6,1,4257,-1) == 0) then
			local nItemIndex = AddItem(6,1,4257,1,0,0);
			SetItemBindState(nItemIndex, -1);
		end;
		if (CalcEquiproomItemCount(6,1,1266,-1) == 0) then
			local nItemIndex = AddItem(6,1,1266,1,0,0);
			SetItemBindState(nItemIndex, -1);
		end;
		if (GetLevel() < 10) then
			ST_LevelUp(10-GetLevel())
		end;
		if (Title_GetActiveTitle() ~= 5000) then
			SetTask(1122, 5000)
			Title_AddTitle(5000, 1, 30*24*60*60*18);
			Title_ActiveTitle(5000);
		end;
		AddSkillState(1206,1,0,777600);
		Msg2Player("BËt chøc n¨ng Èn th©n cho GM");
	end;
end

-- KiÓm tra GM (kiÓm tra xem tµi kho¶n, nh©n vËt nµy cã ph¶i lµ GM hay kh«ng?)
-- Gi¸ trÞ tr¶ vÒ: [-2]: Lçi table - [0]: kh«ng ph¶i GM - [1]: tµi kho¶n lµ GM - [2]: tªn tµi kho¶n vµ nh©n vËt lµ GM
--	Gi¸ trÞ thø 2: sè thø tù cña TK
function tbAloneScript:CheckGameMaster()
	if not (TAB_LIST_GAMEMASTER) then
		print("Khong tim thay table!")
	return -2 end
	
	for i = 1, getn(TAB_LIST_GAMEMASTER) do
		if not (TAB_LIST_GAMEMASTER[i]["Account"]) then
			print("Khong tim thay string [Account] trong danh sach table!!!")
		return -2 end
		
		if not (TAB_LIST_GAMEMASTER[i]["Player"]) then
			print("Khong tim thay table [Player] trong danh sach table!!!")
		return -2 end
		
		if not (TAB_LIST_GAMEMASTER[i]["Password"]) then
			print("Khong tim thay string [Password] trong danh sach table!!!")
		return -2 end
		
		if not (TAB_LIST_GAMEMASTER[i]["Rank"]) then
			print("Khong tim thay string [Rank] trong danh sach table!!!")
		return -2 end
		
		if (TAB_LIST_GAMEMASTER[i]["Account"] == GetAccount()) then
			for k = 1, getn(TAB_LIST_GAMEMASTER[i]["Player"]) do
				if (TAB_LIST_GAMEMASTER[i]["Player"][k] == GetName()) then
				return 2, i end
			end
		return 1, i end
	end
return 0 end

function tbAloneScript:StartGameServer()
	for i = 1, getn(TAB_LINKFILEDATA) do
		self:FileSystem_LoadFile(TAB_LINKFILEDATA[i][1])
	end
end

-- ThiÕt lËp d÷ liÖu
--		+ szLinkFile: ®­êng dÉn file d¹ng "\\data\\log.txt"
--		+ szSection: "SECTION"
--		+ szKey: Tõ khãa cÇn load
--		+ szValue: Gi¸ trÞ cña tõ khãa ®ã
function tbAloneScript:FileSystem_SetData(szLinkFile, szSection, szKey, szValue)
	IniFile_SetData(szLinkFile, szSection, szKey, szValue)
end

function tbAloneScript:FileSystem_SaveData(szLinkFile)
	IniFile_Save(szLinkFile, szLinkFile)
end

-- LÊy d÷ liÖu
--		+ szLinkFile: ®­êng dÉn file d¹ng "\\data\\log.txt"
--		+ szSection: "SECTION"
--		+ szKey: Tõ khãa cÇn load
function tbAloneScript:FileSystem_GetData(szLinkFile, szSection, szKey)
	return IniFile_GetData(szLinkFile, szSection, szKey)
end

-- Load d÷ liÖu
--		+ szLinkFile: ®­êng dÉn file d¹ng "\\data\\log.txt"
function tbAloneScript:FileSystem_LoadFile(szLinkFile)
	File_Create(szLinkFile)
	return IniFile_Load(szLinkFile, szLinkFile)
end

-- LÊy danh s¸ch trong file:
--		+ szLinkFile: ®­êng dÉn file d¹ng "\\data\\log.txt"
--		+ szSection = "TABLE"
--> Gi¸ trÞ tr¶ vÒ: Sè l­îng dßng, danh s¸ch table
function tbAloneScript:FileSystem_GetCount(szLinkFile, szSection)
	local tbKey = {}
	local nFile = TabFile_Load(szLinkFile, szSection)
	if nFile ~= 1 then
		print("TÖp tin kh«ng tån t¹i hoÆc ch­a cã d÷ liÖu!")
		return 0
	end
	
	for i = 2, TabFile_GetRowCount(szSection) do
		local szKey = TabFile_GetCell(szSection, i, "["..szSection.."]")
		local strKey = split(szKey, "=")
		if strKey[2] then
			tbKey[getn(tbKey)+1] = strKey;
		end
	end
	
	return getn(tbKey), tbKey
end

function tbAloneScript:GetIP()
	local tbIP = split(GetIP(), " : ")
	return tbIP[1], tbIP[2]
end

function OnTimer()
	--SetFightState(0); --ThiÕt lËp tr¹ng th¸i chiÕn ®Êu
	--ForbidChangePK(1); --CÊm chuyÓn PK
	--SetPKFlag(2); --ThiÕt lËp PK
	--SetChatFlag(1); --CÊm ch¸t
	--DisabledStall(1); --CÊm bµy b¸n
	--ForbitTrade(1); --CÊm giao dÞch
	--DisabledUseTownP(1); --CÊm sö dông THP
	--ForbidEnmity(1); --CÊm cõu s¸t
	--SetCreateTeam(0); --ThiÕt lËp t¹o tæ ®éi
	local nPlayerIndex = PlayerIndex or 0;
	local szName = GetName() or "";
	local szAccount = GetAccount() or "";
	local nTimerOut = GetTaskTemp(TASKTEMP_KICKOUT);
	local nTime = GetCurServerTime();
	local nTimeNow = (nTimerOut - nTime) + TIMER_KICKOUT ;
	Msg2Player("<color=cyan>B¹n cßn "..nTimeNow.." gi©y nöa sÏ bÞ hÖ thèng kick ra khái game.")
	if (nTimeNow == 0) then
		SetTaskTemp(TASKTEMP_KICKOUT, 0)
		OfflineLive(nPlayerIndex);
		KickOutSelf(nPlayerIndex);
		print(format("[LOCKED] - Nguoi choi %s(%s) da bi kick ra khoi server!", szName, szAccount));
		StopTimer(TIMETASK_ID);
	end
end

tbAloneScript:StartGameServer();

function logplayer(zFile,szMsg)
	local handle = openfile(zFile,"a")
	write(handle,format("%s\n",szMsg));
	closefile(handle);
end

function tbAloneScript:capnhatbangxephang()
	local tbSay = {"<dec>Mêi GM tr·i nghiÖm chøc n¨ng trong game"};
		tinsert(tbSay, "CËp nhËt b¶ng xÕp h¹ng/capnhatbangxephang2")		
		tinsert(tbSay, "§ãng./no");
	CreateTaskSay(tbSay);
end

function capnhatbangxephang2()
	RemoteExc("\\script\\xephang\\worldrank_hook.lua", "RankHook:UpdateRank",{})
	Talk(1, "", "CËp NhËt xÕp h¹ng thµnh c«ng !!");
	return
end
