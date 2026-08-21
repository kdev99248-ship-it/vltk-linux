IncludeLib("ITEM");
IncludeLib("FILESYS")
IncludeLib("LEAGUE");
IncludeLib("TONG")
IncludeLib("RELAYLADDER");
IncludeLib("SETTING")
IncludeLib("TIMER");
IncludeLib("NPCINFO")
IL("TITLE");
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\activitysys\\functionlib.lua")
Include("\\script\\activitysys\\npcdailog.lua");
Include("\\script\\gm_tool\\dispose_item.lua");
Include("\\script\\lib\\common.lua");
Include("\\script\\lib\\progressbar.lua");
Include("\\script\\lib\\remoteexc.lua");
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\log.lua")
Include("\\script\\lib\\alonelib.lua");
Include("\\script\\lib\\itemblue.lua");
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\global\\fuyuan.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua");
Include("\\script\\global\\nobitaxd\\npc\\doiraclayvk.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_activity_bonus.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\global\\skills_table.lua");
Include("\\script\\task\\newtask\\tasklink\\tasklink_head.lua"); 
Include("\\script\\task\\newtask\\tasklink\\tasklink_award.lua"); 
Include("\\script\\event\\storm\\function.lua")	--Storm
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\task\\system\\task_string.lua");
Include("\\script\\global\\seasonnpc.lua");
Include("\\script\\global\\nobitaxd\\item\\nhiemvuhoangkim.lua")
Include("\\script\\global\\nobitaxd\\item\\diadovolam.lua")
Include("\\script\\gm_tool\\laoanmay.lua")	--/home/jxser/server1/script/gm_tool
Include("\\script\\global\\nobitaxd\\item\\startgame.lua")
Include("\\script\\global\\nobitaxd\\item\\rendotim.lua")
Include("\\script\\global\\nobitaxd\\item\\dieukientaobanghoi.lua")
Include("\\script\\global\\nobitaxd\\item\\nhanskill.lua")
Include("\\script\\global\\nobitaxd\\vdk\\simcity\\controllers\\thanhthi.lua")
Include("\\script\\global\\nobitaxd\\vdk\\simcity\\head.lua")
Include("\\script\\global\\nobitaxd\\vdk\\simcity\\controllers\\main.lua")
Include("\\script\\global\\nobitaxd\\vdk\\simcity\\controllers\\keoxe.lua")
Include("\\script\\global\\nobitaxd\\vdk\\simcity\\controllers\\vatnuoi.lua")
Include("\\script\\global\\titlefuncs.lua")
Include("\\script\\global\\nobitaxd\\item\\faction_def.lua")
Include("\\script\\task\\newtask\\tasklink\\tasklink_head.lua")
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\hoanbinhvukhi\\main.lua");
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\hoanbinhvukhi\\hoanbinh.lua")
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\taotrangbi.lua")
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\trungluyentrangbi\\trangbihkmp\\refine_equip.lua");
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\trungluyentrangbi\\trangbihkmp\\refine_equip_hanche.lua");
Include("\\script\\missions\\sevencity\\simsevencity.lua")
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\res\\test_res_item.lua")
----------------------
function main()
	dofile("script/global/nobitaxd/npc/npcthunghiem.lua");
	local nDate = tonumber(date("%Y%m%d%H%M"))
	if nDate <= ThoiGianHetHanDiemTP then
		Say("§óng vµo lóc <color=yellow>"..ThoiGianOpenStr.."<color> míi b¾t ®Çu chÝnh thøc khai më m¸y chñ");
		return 1
	end

	local nW, nX, nY = GetWorldPos()
	local year  = tonumber(date("%y"))
	local mm    = tonumber(date("%m"))
	local day   = tonumber(date("%d"))
	local hour  = tonumber(GetLocalDate("%H"))
	local mmin  = tonumber(GetLocalDate("%M"))

	--local nTTK    = GetTask(81)
	local nDochi  = GetTask(1027)
	local nDaTau  = tl_gettaskcourse() ~= 0 and tl_counttasklinknum(1) or 0	
	local nVinhDu = GetTask(2501)
	local nMayMan = GetLucky(0)

	local szTitle =
		"Nh©n vËt: <color=green>"..GetName().."<color>  Tµi kho¶n: <color=green>"..GetAccount().."<color>\n"..
		"Thêi gian: Ngµy <color=yellow>"..day.."<color> Th¸ng <color=yellow>"..mm.."<color> N¨m <color=yellow>20"..year.."<color>, <color=yellow>"..hour.."<color> giê <color=yellow>"..mmin.."<color> phót\n"..
		"Täa ®é: <color=green>"..nW..", "..nX.."/"..nY.."<color>\n"..
		"ThÇn BÝ §å ChÝ: <color=green>"..nDochi.."<color>\n"..
		"NhiÖm vô D· TÈu ®· hoµn thµnh : <color=green>"..nDaTau.."<color>\n"..
		"ChØ sè May m¾n: <color=green>"..nMayMan.."<color> / §iÓm Vinh Dù: <color=green>"..nVinhDu.."<color>"
		
	if (CFG_ChayThuNghiem == 0) then
		local tbOpt =
		{				
		{"Hç trî lµm nhiÖm vô nhanh", diadovolam},
		{"Shop hç trî", Shop_Support},
		{"Tho¸t"},
		}
		CreateNewSayEx(szTitle, tbOpt)
	else
		local tbOpt =
		{			
		{"Gäi ho¹t ®éng Game nhanh", goihoatdongmaychu},
		{"Hç trî lµm NhiÖm vô nhanh", diadovolam},		
		{"NhËn hç trî Test nh©n vËt", HoTroTest},
		{"Gäi SimCity", goisimcity},
		{"Thî rÌn ®a n¨ng", thorendanang},	
		{"Hñy bá mäi thø mËt khÈu 1", DisposeItem_main},
		{"LÊy th«ng tin NPC", LastNpcTalk},		
		{"Di chuyÓn vÒ Ba L¨ng HuyÖn", GotoBLH},
		--{"Test", LayDoRes},
		--{"KT Res", kiemtrares},		
		--{"TriÖu tËp ®ång ®éi", GoiPTToiNoi},	
		{"Tho¸t"},
		--{"§æi r¸c lÊy vò khÝ ngÉu nhiªn", weapon_ring},
		}
		CreateNewSayEx(szTitle, tbOpt)
	end
	return 1
end
function LayDoRes()
	for i = 1, 10 do
		AddItemEx(4, random(), 0, 0, 2, 28, i, 0, 255, 10, 10, 10, 10, 10, 10, 0)
	end
end

function GoiPTToiNoi()
    local nW, nX, nY = GetWorldPos();
    local nFightMode = GetFightState();
    local nPreservedPlayerIndex = PlayerIndex;

    local nMemCount = GetTeamSize();

    if (nMemCount == 0) then
        return 0;
    end

    for i = 1, nMemCount do
        PlayerIndex = GetTeamMember(i);
        SetFightState(nFightMode);
        NewWorld(nW, nX, nY);
    end

    PlayerIndex = nPreservedPlayerIndex;
    return 0;
end

function thorendanang()
		local tbOpt = {
			{"ChÕ T¹o ®å tÝm",Chetaodotim},
			{"Ho¸n §æi, TÈy LuyÖn ",mainreroll},
			{"N©ng CÊp §å B¹ch Kim",bachkim_main},
			--{"Läc L¹i Option Trang BÞ HKMP",LocOptionHKOK},
			{"Trïng LuyÖn Trang BÞ Hoµng Kim M«n Ph¸i",refine_HKMP},
			{"Trïng LuyÖn Trang BÞ TrÊn Bang Chi B¶o",refine_HanChe},
			{"ChÕ T¹o §å Phæ Hoµng Kim M«n Ph¸i",ghepmanhhkmp},
			--{"ChÕ T¹o HKMP 2",GhepManhHKMP},
			{"§æi M¶nh Hoµng Kim M«n Ph¸i",XoayManhHKMP},
			--{"N©ng CÊp ThÇn M·",pgHorseUpgradeMain},	
			{"T¨ng Gi¶m CÊp Trang BÞ ",TangGiamTrangBi},			
			{"N©ng CÊp §å Kh«ng ThÓ Ph¸ Hñy",NangCapKhongThePhaHuy},			
			{"Trë L¹i",main},
			{"KÕt thóc dèi tho¹i",No},
		}
	CreateNewSayEx("<npc><color=green>Ta ®©y cã nhiÒu sù lùa chän cho "..myplayersex().." , ng­¬i muèn lµm g× ?<color>", tbOpt)
end

function NangCapKhongThePhaHuy()

	local szTitle = 
		"N©ng cÊp ®é bÒn trang bÞ thµnh kh«ng thÓ ph¸ hñy.<enter><enter>"..
		"Gi¸ n©ng cÊp : <color=yellow>100 v¹n l­îng x cÊp ®é trang bÞ<color>"

	local tbOpt = {}
	tinsert(tbOpt, {"TiÕn hµnh n©ng cÊp", GiveItemUI_NangCapKhongThePhaHuy})
	tinsert(tbOpt, {"§ãng", no})

	CreateNewSayEx(szTitle, tbOpt)
end

------------------------------------------------

function GiveItemUI_NangCapKhongThePhaHuy()

	GiveItemUI(
		"N©ng cÊp ®é bÒn trang bÞ",
		"§Æt 1 trang bÞ vµo ®Ó n©ng cÊp.<enter><enter>"..
		"+ ChØ 1 trang bÞ mçi lÇn.<enter>"..
		"+ Gi¸ : 100 v¹n l­îng x cÊp ®é trang bÞ.",
		"GiveItemUI_NangCapKhongThePhaHuy_OK",
		nil,
		1
	)
end

------------------------------------------------

function GiveItemUI_NangCapKhongThePhaHuy_OK(nCount)
	if (nCount ~= 1) then
		Talk(1, "", "ChØ ®­îc n©ng cÊp 1 trang bÞ mçi lÇn.")
		return
	end

	local nIdx = GetGiveItemUnit(1)
	if (not nIdx or nIdx <= 0) then
		Talk(1, "", "Kh«ng nhËn ®­îc trang bÞ.")
		return
	end

	local itemLevel = GetItemLevel(nIdx)
	local itemName  = GetItemName(nIdx)
	local durability = GetCurDurability(nIdx)
	local G, D, P = GetItemProp(nIdx)

	if (G == 6 or G == 4 or G == 1 or G == 7) then
		Talk(1, "", "ChØ n©ng cÊp ®­îc trang bÞ (tr¾ng, xanh, tÝm, b¹ch kim).")
		return
	end

	if (durability == -1) then
		Talk(1, "", "Trang bÞ nµy ®· lµ kh«ng thÓ ph¸ hñy.")
		return
	end

	local nMoney = 1000000 * itemLevel

	if (GetCash() < nMoney) then
		Talk(1, "", "Kh«ng ®ñ ng©n l­îng ®Ó n©ng cÊp.")
		return
	end

	Pay(nMoney)

	EH_SetCurDurability(nIdx, -1)

	Talk(1, "", 
		"§· n©ng cÊp thµnh c«ng!<enter><enter>"..
		"Trang bÞ <color=yellow>"..itemName.."<color> ®· trë thµnh kh«ng thÓ ph¸ hñy!"
	)

	Msg2Player("Trang bÞ ®· trë thµnh kh«ng thÓ ph¸ hñy.")
end

function GotoBLH()
	local nW, nX, nY = GetWorldPos();
	if (nW == 246) then
	Msg2Player("Map nµy kh«ng thÓ sö dông tÝnh n¨ng nµy!")
	return 1
	end
	if (nW == 53) then
		SetPos(1626,3179);
	else
		NewWorld(53, 1626, 3179);
	end
	SetFightState(0);
	Msg2Player("Di chuyÓn vÒ <color=green>Ba L¨ng HuyÖn<color> thµnh c«ng!")
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID
-----------------------------------------------------------
function LayDoTheoID()			
	local szTitle = "xin h·y chän vËt phÈm cÇn lÊy ! ";
	local tbOpt = {
		{"LÊy §å Magic",LayMenuMagic},
		{"LÊy §å Hoµng Kim",LayMenuHKMP},
		{"LÊy §å Queskey",LayMenuQueskey},		
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
	AskClientForNumber("LayMenuMagic_1",0,50000,"LÊy ID Nµo?")
end
function LayMenuMagic_1(nID)
	if nID == nil or nID == 0 or nID < 1 or nID > 50000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3355,nID)
	AskClientForNumber("LayMenuMagic_2",0,5000,"Sè L­îng?")
end
function LayMenuMagic_2(nSoLuong)
	if nSoLuong == nil or nSoLuong == 0 or nSoLuong < 1 or nSoLuong > 5000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
		end
	SetTask(3356,nSoLuong)
	AskClientForNumber("LayMenuMagic_3",0,365,"Bao Nhiªu Ngµy?")
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
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(6,1,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={6,1,nID,1,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);
		return
	end
end

-----------------------------------------------------------
-- GM LÊy Item - LÊy §å Theo ID - LÊy §å Queskey
-----------------------------------------------------------
function LayMenuQueskey()
	AskClientForNumber("LayMenuQueskey_1",0,10000,"LÊy ID Nµo?")
end
function LayMenuQueskey_1(nID)
	if nID == nil or nID == 0 or nID < 1 or nID > 10000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3355,nID)
	AskClientForNumber("LayMenuQueskey_2",0,9000,"Sè L­îng?")
end
function LayMenuQueskey_2(nSoLuong)
	if nSoLuong == nil or nSoLuong == 0 or nSoLuong < 1 or nSoLuong > 9000 then
		Msg2Player("Sè kh«ng hîp lÖ")
		return
	end
	SetTask(3356,nSoLuong)
	AskClientForNumber("LayMenuQueskey_3",0,365,"Bao Nhiªu Ngµy?")
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
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(4,nID,1,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={4,nID,1,1,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);
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
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddGoldItem(0,nID)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,nID},nCount=nSL,nQuality=1,nExpiredTime=nHSD * 1440},}, "AD", 1);
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
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(0,11,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,11,nID,1,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);		
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
		return
	end
	if nHSD ~= 0 then
		local nItemIdx = AddItem(0,10,nID,1,0,0)
		local Ten = GetItemName(nItemIdx)
		RemoveItemByIndex(nItemIdx)
		tbAwardTemplet:GiveAwardByList({{szName=""..Ten.."",tbProp={0,10,nID,10,0},nCount=nSL,nExpiredTime=nHSD * 1440},}, "AD", 1);
		return
	end
end


function moruong()
OpenStoreBox(1)
OpenStoreBox(2)
OpenStoreBox(3)
AddItem(6,1,1427,90,1,0,0)
end

function HoTroTest()
	local tbOpt =
	{
	{"NhËn c¸c lo¹i ®iÓm", pointall},
	{"NhËn tiÒn", moneyall},
	{"NhËn trang bÞ", trangbiall},
	{"NhËn thó c­ìi", ThuCuoi},
	{"Häc kü n¨ng m«n ph¸i", HocKyNangMonPhai},	
	{"NhËn vËt phÈm hç trî", VatPhamHoTro},	
	{"Më réng r­¬ng", moruong},
	{"NhËn skills", NhanSkill},	
	{"TÈy tñy nhanh", TayTuyNhanh},	
	{"T¹o bang héi", DieuKienTaoBangHoi},
	{"NhËn danh hiÖu", nhandanhhieu},
	{"Thay ®æi danh hiÖu", change_title},
	{"LÊy ®å theo ID", LayDoTheoID},
	{"ChuyÓn m«n ph¸i nhanh", change_phai},	
	{"Quay l¹i", main},
	{"Tho¸t"},
	}
	CreateNewSayEx("Chän hç trî:", tbOpt)
end


--------------------- Gia NhËp M«n Ph¸i (New)-------------------------

function change_phai()
	local szTitle = "Xin chµo ! §¹i hiÖp muèn gia nhËp ph¸i nµo ?"
	local tbOpt= {}
	local tbFacName = tbFacDef.tbFacShortName
	for i = 0, getn(tbFacName) do
		tinsert(tbOpt, {tbFacName[i],joinMonphai,{i}})
	end
	tinsert(tbOpt, {"L¸t n÷a quay l¹i"});
	CreateNewSayEx(szTitle, tbOpt)
end
function joinMonphai(nIndex)
	local CurFaction = GetLastFactionNumber() 
	local nLevelSkill = 120 -- add tíi skill 150
	if nIndex == CurFaction then
		Msg2Player("HiÖn t¹i b¹n ®ang ë m«n ph¸i nµy")
		return 1;
	end
		---------------th«ng tin m«n ph¸i hiÖn t¹i-------------------
	local curFacNames = tbFacDef.tbFacNames[CurFaction]
	local fname = tbFacDef.tbFacChNames[CurFaction]
	if curFacNames ~= nil then
		--DoClearSkillCore()
		local curFacNumber = tbFacDef.tbFacName2FacId[curFacNames]
		local curTaskId_Fact mi= tbFacDef.tbFacTaskIds[CurFaction]
		nt_setTask(curTaskId_Fact,0) -- xãa nhiÖm vô m«n ph¸i cña ph¸i cò
		for i = 10, nLevelSkill, 10 do
			DelFacSkill(curFacNumber,i)
		end
		local szMsg = format("§· xãa tÊt c¶ kü n¨ng cña <color=green>%s<color>",fname)
		Msg2Player(""..szMsg)
	end
	RollbackSkill()
	local nTotalSkillPoint = GetLevel() - 1
	local nCurSkillPoint = GetMagicPoint()
	local nDelta = nTotalSkillPoint - nCurSkillPoint
	if (nDelta ~= 0) then
		AddMagicPoint(nDelta)
	end
	
	-------------Th«ng tin add m«n ph¸i míi---------------------
	local FacNames = tbFacDef.tbFacNames[nIndex]
	local FacNumber = tbFacDef.tbFacName2FacId[FacNames]
	local FacSeries = tbFacDef.tbSeriess[nIndex]
	local Camps = tbFacDef.tbCamps[nIndex]
	local RankIds = tbFacDef.tbRankIds[nIndex]
	local TaskId_Fact = tbFacDef.tbFacTaskIds[nIndex]
	local TaskId_137s = tbFacDef.tbTaskId_137s[nIndex]
	local Value_137s = tbFacDef.tbValue_137s[nIndex]
	local name = format("<color=yellow>"..GetName().."<color>")
	local JoinMsgs = format(tbFacDef.tbJoinMsgs[nIndex],name)
	----------------------------------
	SetSeries(FacSeries)
	nt_setTask(TaskId_Fact, 60*256) -- Set lµm nhiÖm vô xuÊt s­
	SetFaction(FacNames) 
	SetCamp(Camps)
	SetCurCamp(Camps)
	SetRank(RankIds)
	nt_setTask(TaskId_137s,Value_137s)
	SetLastFactionNumber(FacNumber)
	for i = 10, nLevelSkill, 10 do
		AddFacSkill(FacNumber,i)
	end
	DoClearPropCore()
	Msg2SubWorld(JoinMsgs)
	KickOutSelf()
end


------------------------------------------------VËt PhÈm Hç Trî------------------------------------------------
TAB_VATPHAMHOTRO = {
	{szName="ThÇn Hµnh Phï", tbProp={6,1,1266,1,0,0}, nBindState=-2, nWidth=1, nHeight=1},
	{szName="Thæ ®Þa phï (sö dông v« h¹n) ", tbProp={6,1,438,1,0,0}, nBindState=-2, nWidth=1, nHeight=1},
	--{szName="S¸t thñ gi¶n (cÊp 90)", tbProp={6,1,400,90,0,0}, nWidth=1, nHeight=2 },
	{szName="Khiªu chiÕn lÖnh", tbProp={6,1,1499,1,0,0}, nCount=2, nWidth=3, nHeight=5},	
	{szName="LÖnh bµi Phong L¨ng §é", tbProp={4,489,1,0,0,0} , nWidth=1, nHeight=1},
	--{szName="Viªm §Õ LÖnh", tbProp={6,1,1617,1,0,0}, nWidth=1, nHeight=1 },
	{szName="Ngäc Long LÖnh Bµi", tbProp={6,1,2623,1,0,0}, nWidth=1, nHeight=1 },
	{szName="NhÊt Kû Cµn Kh«n Phï", tbProp={6,1,2126,1,0,0} , nWidth=1, nHeight=1},
	{szName="Cµn Kh«n Song TuyÖt Béi", tbProp={6,1,2219,1,0,0} , nWidth=1, nHeight=1},	
	{szName="TÈy Tñy Kinh", tbProp={6,1,22,1,0,0}, nCount=15 , nWidth=3, nHeight=5},
	{szName="Vâ L©m MËt TÞch", tbProp={6,1,26,1,0,0}, nCount=15, nWidth=3, nHeight=5},
	{szName="Phi Tèc hoµn", tbProp={6,0,6,1,0,0}, nCount=2 , nWidth=3, nHeight=5},
	{szName="§¹i Lùc hoµn", tbProp={6,0,3,1,0,0}, nCount=2, nWidth=3, nHeight=5},	
}

function VatPhamHoTro()
    local tbTaskSay = {
        "<dec>Mêi b¹n chän:",
        "S¸t thñ gi¶n (chän ngò hµnh)/#HoTro_ChonNguHanh()",
        "VËt phÈm hç trî kh¸c/#HoTro_VatPhamKhac()",
    }
    CreateTaskSay(tbTaskSay)
end

function HoTro_VatPhamKhac()
    AddItemByTable("Mêi b¹n chän vËt phÈm hç trî:", TAB_VATPHAMHOTRO)
end

function HoTro_ChonNguHanh()
    local tbTaskSay = {"<dec>Vui lßng chän thuéc tÝnh:",
                        "Kim/#HoTro_CapSatThuGian(0)",
                        "Méc/#HoTro_CapSatThuGian(1)",
                        "Thñy/#HoTro_CapSatThuGian(2)",
                        "Háa/#HoTro_CapSatThuGian(3)",
                        "Thæ/#HoTro_CapSatThuGian(4)",
                      }
    CreateTaskSay(tbTaskSay)
end

function HoTro_CapSatThuGian(nSeries)
    local tbAwardItem = {tbProp={6,1,400,90,nSeries,0}, nCount = 1}
    tbAwardTemplet:GiveAwardByList(tbAwardItem, "NhËn ®­îc S¸t Thñ Gi¶n!")
end


----Vßng S¸ng - Danh HiÖu------
function vongsang(nindex)
Title_AddTitle(nindex, 1, 4302359);
Title_ActiveTitle(nindex);
SetTask(1122, nindex);
end

function nhandanhhieu()
local szTitle = "<npc>Xin chµo <color=yellow>"..GetName().."<color> , xin mêi chän Danh HiÖu...!!!"
local tbOpt =
{
{"Th¸i thó Ph­îng T­êng.", vongsang,{153}},
{"Th¸i thó Thµnh §«.", vongsang,{154}},
{"Th¸i thó §¹i Lý.", vongsang,{155}},
{"Th¸i thó BiÖn Kinh.", vongsang,{156}},
{"Th¸i thó T­¬ng D­¬ng.", vongsang,{157}},
{"Th¸i thó D­¬ng Ch©u.", vongsang,{158}},
{"Th¸i thó L©m An.", vongsang,{159}},
{"Vâ L©m Liªn §Êu Qu¸n Qu©n.", vongsang,{81}},
{"Vâ L©m Liªn §Êu H¹ng 2.", vongsang,{82}},
{"Vâ L©m Liªn §Êu H¹ng 3.", vongsang,{83}},
{"Vâ L©m Liªn §Êu H¹ng 4.", vongsang,{84}},
--{"BQT Vâ L©m TruyÒn Kú.", vongsang,{5000}},
{"Test", vongsang,{3014}},
--{"Trang KÕ",danhhieu2},
{"Trë L¹i",main},
{"Tho¸t"},
}
	CreateNewSayEx(szTitle, tbOpt)
end

------------------------------------Lay thong tin NPC----------------------------------
function LastNpcTalk()
	local nNpcIndex = GetLastDiagNpc()
	local IdNpc    = GetNpcSettingIdx(nNpcIndex)
	if IdNpc == nil or IdNpc < 0 then
		Say("<color=yellow>Kh«ng t×m thÊy th«ng tin NPC nµo c¸c h¹ ®· nãi chuyÖn gÇn ®©y.<color>")
		return 1
	end
	local Name     = GetNpcName(nNpcIndex)        or "nil"
	local nScript  = GetNpcScript(nNpcIndex)      or "nil"
	local DropFile = GetNpcDropRateFile(nNpcIndex) or "nil"
	local NguHanh  = GetNpcSeries(nNpcIndex)      or "nil"
	local Life     = GetNpcLife(nNpcIndex)        or "nil"
	local NpcKind  = GetNpcKind(nNpcIndex)        or "nil"
	local file = openfile("npcinfo.lua", "a+")
	write(file, strchar(34).."Name: "..Name.." ID: "..IdNpc.." Script: "..nScript.." DropFile: "..DropFile.." Life: "..Life.." NguHanh: "..NguHanh.." Kind: "..NpcKind..strchar(34), '\n')
	closefile(file)
	Say("<color=green>Th«ng tin NPC ®· t×m thÊy ®­îc l­u l¹i ë file server1/npcinfo.lua<color>")
	Msg2Player("<color=yellow>Th«ng tin ®­îc l­u l¹i ë file server1/npcinfo.lua<color>")
end
------------------------------------Sim City----------------------------------
function goisimcity()
		local tbOpt = {
			{"Gäi SimCity Thµnh ThÞ",main_trieuman},
			{"Gäi SimCity KÐo Xe",main_voky},
			--{"Gäi SimCity VËt Nu«i",main_vatnuoi},
			{"KÕt thóc dèi tho¹i",No},
		}
	CreateNewSayEx("<npc><color=green>Ta ®©y cã nhiÒu sù lùa chän, ng­¬i muèn lµm g×?<color>", tbOpt)
end

--=====
function Skill_Support_AnThan()
	AddSkillState(1206,1,0,18*60*5);
	Msg2Player("Hç trî Èn th©n");
end

--===== Shop hç trî =====---
function Shop_Support()
	local tbOpt =
	{
		{"Ta muèn mua ThÇn hµnh phï Thæ ®Þa phï", Shop_Support_1},
		{"Ta muèn mua 40 D· tÈu chi b¶o", Shop_Support_2},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Shop ta më b¸n cho ®¹o h÷ ®ång gi¸ 1 l­îng. Haha !", tbOpt)
end
function Shop_Support_1()
	if (GetCash() <= 2) then
		Talk(1, "", "Ph¶i ca ®ñ 2 l­îng míi ca thÓ mua.")
		return
	end
	if CalcFreeItemCellCount() < 2 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 2 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	Pay(2)
	tbAwardTemplet:GiveAwardByList({{szName="ThÇn Hµnh Phï",tbProp={6,1,1266,1,0,0,0},nCount=1,nExpiredTime = 10080},}, "NobitaXD-Thunghiem", 1);
	tbAwardTemplet:GiveAwardByList({{szName="Thæ ®~a phï (sö dông v« h¹n) ",tbProp={6,1,438,1,0,0,0},nCount=1,nExpiredTime = 10080},}, "NobitaXD-Thunghiem", 1);
end

function Shop_Support_2()
	if (GetCash() <= 400000) then
		Talk(1, "", "Ph¶i ca ®ñ 400000 l­îng míi ca thÓ mua.")
		return
	end
	if CalcFreeItemCellCount() < 2 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 2 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	Pay(400000)
	for i = 1, 40 do
		AddItem(6,1,4378,1,0,0,0)
	end;
end

--========================= Tinh nang Thu Nghiem ========================--

---=====| {"List Item Noel 2007", List_Item_tet2008} - Star |=====---
-- [1]	={szName = "B¸nh ch­ng th­îng h¹ng",	tbProp = {6,1,1662,1,0,0},	nCount = 1},
-- [6]	={szName = "Phóc",	tbProp = {6,1,1657,1,0,0},	nCount = 1},
-- [7]	={szName = "Léc",	tbProp = {6,1,1658,1,0,0},	nCount = 1},
-- [8]	={szName = "Thä",	tbProp = {6,1,1659,1,0,0},	nCount = 1},

function List_Item_tet2008()
	for i = 1, 50 do
		AddItem(6,1,1657,1,0,0,0)
		AddItem(6,1,1658,1,0,0,0)
		AddItem(6,1,1659,1,0,0,0)
	end
	for i = 1, 200 do
		AddItem(6,1,1662,1,0,0,0)
	end
end

---=====| {"List Item Noel 2007", List_Item_noel2007} - Star |=====---
function List_Item_noel2007()
	for i = 1, 100 do
		AddItem(6,1,1634,1,0,0,0)
		AddItem(6,1,1635,1,0,0,0)
		AddItem(6,1,1636,1,0,0,0)
	end
end

---=====| {"List Item Noel 2006", List_Item_noel2006} - Star |=====---
function List_Item_noel2006()
	for i = 1, 10 do
		AddItem(6,1,1008,1,0,0,0)
	end
end

---=====| {"Test Th­ëng Ho¹t §éng", activity_bonus} - Star |=====---
function activity_bonus()
	local tbOpt =
	{
		{"Item Donate", Item},
		{"Boss ST 9x", BossSatThu},
		{"Boss Thñy TÆc §Çu LÜnh", BossThuyTac},
		{"Boss Thñy TÆc §¹i §Çu LÜnh", BossDaiThuyTac},
		{"Boss TiÓu Hoµng Kim", BossTieuHK},
		{"Boss §¹i Hoµng Kim", BossDaiHK},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function Item()
	AddItem(6,1,2126,1,0,0,0)	-- NhÊt Kû Cµn Kh«n Phï
end
---=====| {"Test Th­ëng Ho¹t §éng", activity_bonus} - End |=====---

---=====| {"NhËn c¸c lo¹i ®iÓm", pointall} - Star |=====---
function pointall()
	local tbOpt =
	{
		{"NhËn cÊp ®é", dangcap200},
		{"NhËn ®iÓm kinh nghiÖm", nhankinhnghiem},
		{"NhËn ®iÓm tiÒm n¨ng", pointtiemnang},
		{"NhËn ®iÓm kü n¨ng", pointkynang},
		{"NhËn 1000 ®iÓm Danh väng Phóc duyªn", pointdvpd},
		{"NhËn tµi l·nh ®¹o", pointtld},
		{"NhËn ®iÓm liªn ®Êu", nhandiemvinhdu},
		{"NhËn ®iÓm tèng kim", nhandiemtongkim},
		{"NhËn ®iÓm cèng hiÕn", conghien},
		{"§æi mµu", trangthai},
		{"Quay l¹i", HoTroTest},		
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end

function conghien()
	AddContribution(1000000);
	Msg2Player("B¹n nhËn ®­îc 1.000.000 ®iÓm cèng hiÕn")
end

--§iÓm Kinh NghiÖm
function nhankinhnghiem()
	AskClientForNumber("nhankinhnghiem1",0,9999999999999999,"NhËp EXP")
end

function nhankinhnghiem1(nNum)
	AddOwnExp(nNum)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>"..nNum.."<color> kinh nghiÖm.") 
end

--§iÓm Vinh Dù
function nhandiemvinhdu()
	AskClientForNumber("nhandiemvinhdu1",0,1000000,"NhËp Sè L­îng:") 
end

function nhandiemvinhdu1(nNum)
	SetTask(2501, GetTask(2501) + nNum)
	Msg2Player("B¹n nhËn ®­îc "..nNum.." §iÓm Vinh Dù.")
end

----------------------------------------------------------------------------------------------------
--§iÓm Tèng Kim
function nhandiemtongkim()
	AskClientForNumber("nhandiemtongkim1",0,1000000,"NhËp Sè L­îng:") 
end

function nhandiemtongkim1(nNum)
	SetTask(747, GetTask(747) + nNum)
	Msg2Player("B¹n nhËn ®­îc "..nNum.." §iÓm Tèng Kim.")
end

---------Trang Thai--------------
function trangthai()
local szTitle = "Xin chµo <color=red>"..GetName().."<color>"
local tbOpt =
	{
		{"LuyÖn C«ng",luyencong},
		{"ChÝnh Ph¸i",chinhphai},
		{"Trung LËp",trunglap},
		{"Tµ Ph¸i",taphai},
		{"S¸t Thñ",satthu},
		--{"Trë L¹i",main},
		{"Tho¸t"},
	}
	CreateNewSayEx(szTitle, tbOpt)
end
function luyencong()
SetCurCamp(0)
SetCamp(0)
end
function chinhphai()
SetCurCamp(1)
SetCamp(1)
end
function trunglap()
SetCurCamp(3)
SetCamp(3) 
end
function taphai()
SetCurCamp(2)
SetCamp(2) 
end
function satthu()
SetCurCamp(4)
SetCamp(4) 
end

function nhanlv()
	local nCurLevel = GetLevel()
	if nCurLevel >= nlevel_test then
	--if nCurLevel >= 120 then
			Talk(1, "", "Ng­¬i ®· ®¹t cÊp "..nlevel_test.." råi.")
		return
	end
	local nAddLevel = nlevel_test - nCurLevel
	--local nAddLevel = 120 - nCurLevel
	ST_LevelUp(nAddLevel)
end;

function dangcap200()
	AskClientForNumber("level",0,200,"NhËp CÊp §é:") 
end

function level(num)
	local nCurLevel = GetLevel()
	local nAddLevel = num - nCurLevel
	ST_LevelUp(nAddLevel)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>"..num.."<color> cÊp ®é.") 
end

function pointtld()
	for i = 1, 250 do
		AddLeadExp(1000000000)
	end
	Msg2Player("B¹n nhËn ®­îc 100 cÊp tµi l·nh ®¹o");
end

function pointdvpd()
	AddRepute(1000)
	Msg2Player("Ngµi thu ®­îc 1000 ®iÓm danh väng");
	FuYuan_Start();
	FuYuan_Add(1000);
end

function pointkynang()
	AskClientForNumber("pointkynang1",0,100,"NhËp Sè L­îng 0-100:") 
end;
function pointkynang1(nNum)
	AddMagicPoint(nNum)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>"..nNum.."<color> ®iÓm Kü N¨ng.")
end

function pointtiemnang()
	AskClientForNumber("pointtiemnang1",0,1000,"NhËp Sè L­îng 0-1000:") 
end;
function pointtiemnang1(nNum)
	AddProp(nNum)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>"..nNum.."<color> ®iÓm TiÒm N¨ng.")
end
---=====| {"NhËn c¸c lo¹i ®iÓm", pointall} - End |=====---
---=====| {"NhËn tiÒn", moneyall} - Star |=====---
function moneyall()
	local tbOpt =
	{
		{"NhËn Ng©n l­îng", tienvan},
		{"NhËn TiÒn §ång", addtiendong},
		{"NhËn Kim Nguyªn B¶o", addKNB},		
		{"Quay l¹i", HoTroTest},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end

function tienvan()
	AskClientForNumber("tienvan1", 0, 100000, "NhËp sè v¹n l­îng muèn nhËn:")
end

function tienvan1(nNum)
	local nLuong = nNum * 10000
	Earn(nLuong)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>"..nNum.."<color> v¹n l­îng")
end

function addvanluong()
	Earn(nNganLuong);
	Msg2Player("B¹n nhËn ®­îc "..nNganLuong.." l­îng");
end

function addtiendong()
	local	n_otrong	= nTienDong/100
	if (CalcFreeItemCellCount() < n_otrong) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ "..n_otrong.." « trèng ®Ó nhËn.")
	return end
	for i = 1,nTienDong	do
		AddStackItem(1,4,417,1,1,0,0,0)
	end
end;

function addKNB()
	local	n_otrong	= nKimNguyenBao/1
	if (CalcFreeItemCellCount() < n_otrong) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ "..n_otrong.." « trèng ®Ó nhËn.")
	return end
	for i = 1,nKimNguyenBao	do
		AddStackItem(1,4,343,1,1,0,0,0)
	end
end;
---=====| {"NhËn tiÒn", moneyall} - End |=====---
---=====| {"NhËn trang bÞ", trangbiall} - Star |=====---
function trangbiall()
	local tbOpt =
	{
		{"Trang BÞ Xanh", trangbixanh},
		{"Nguyªn liÖu Ðp ®å TÝm", TrangBiTim},
		--{"ChÕ T¹o §å TÝm", Chetaodotim},
		{"Hoµng Kim", trangbiHK},		
		{"Hoµng Kim M«n Ph¸i", hkmp},
		{"Hoµng Kim Liªn §Êu", trangbiLD},
		{"Hoµng Kim Hoµn Mü", trangbiHM},		
		{"Hoµng Kim Cùc PhÈm", trangbiCP},
		{"Hoµng Kim Hoµn Mü Cùc PhÈm", trangbiHMCP},		
		--{"Hoµng Kim (Sù KiÖn)", trangbiHK_event},
		--{"Hoµng Kim (Super)", trangbiHK_Super},
		{"Quay l¹i", HoTroTest},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end

------------------------------------------------Trang BÞ TÝm------------------------------------------------
TAB_OPTION = {
	["Vò khÝ"] = {
		["KiÕm"] 			= {0,0,0},
		["§ao"] 				= {0,0,1},
		["Bæng"] 			= {0,0,2},
		["Th­¬ng"] 		= {0,0,3},
		["Chïy"] 			= {0,0,4},
		["Song §ao"] 	= {0,0,5},
		["Phi Tiªu"] 		= {0,1,0},
		["Phi §ao"] 		= {0,1,1},
		["Tô TiÔn"] 		= {0,1,2},
	},
	
	["Trang Phôc"] = {
		["ThÊt B¶o Cµ Sa"] 						= {0,2,0},
		["Ch©n Vò Th¸nh Y"] 					= {0,2,1},
		["Thiªn NhÉn MËt Trang"] 		= {0,2,2},
		["Gi¸ng Sa Bµo"] 							= {0,2,3},
		["§­êng Nghª Gi¸p"] 					= {0,2,4},
		["V¹n L­u Quy T«ng Y"] 			= {0,2,5},
		["TuyÒn Long Bµo"] 					= {0,2,6},
		["Long Tiªu §¹o Y"] 					= {0,2,8},
		["Cöu VÜ B¹ch Hå Trang"] 		= {0,2,9},
		["TrÇm H­¬ng Sam"] 					= {0,2,10},
		["TÝch LÞch Kim Phông Gi¸p"] 	= {0,2,11},
		["V¹n Chóng TÒ T©m Y"] 			= {0,2,12},
		["L­u Tiªn QuÇn"] 						= {0,2,13},
	},
	
	["Nãn"] = {
		["Tú L« M·o"] 								=	{0,7,0},
		["Ngò L·o Qu¸n"] 						=	{0,7,1},
		["Tu La Ph¸t KÕt"] 						=	{0,7,2},
		["Th«ng Thiªn Ph¸t Qu¸n"] 		=	{0,7,3},
		["YÓm NhËt Kh«i"] 						=	{0,7,4},
		["TrÝch Tinh Hoµn"] 					=	{0,7,5},
		["¤ Tµm M·o"]								=	{0,7,6},
		["Quan ¢m Ph¸t Qu¸n"]				=	{0,7,7},
		["¢m D­¬ng V« Cùc Qu¸n"]		=	{0,7,8},
		["HuyÒn Tª DiÖn Tr¸o"]				=	{0,7,9},
		["Long HuyÕt §Çu Hoµn"]			=	{0,7,10},
		["Long L©n Kh«i"]						=	{0,7,11},
		["Thanh Tinh Thoa"] 					=	{0,7,12},
		["Kim Phông TriÓn SÝ"] 				=	{0,7,13},
	},
	
	["Hé UyÓn"] = {
		["Long Phông HuyÕt Ngäc Tr¹c"]		=	{0,8,0},
		["Thiªn Tµm Hé UyÓn"]						=	{0,8,1},
	},
	
	["Th¾t l­ng"] = {
		["Thiªn Tµm Yªu §¸i"]				=	{0,6,0},
		["B¹ch Kim Yªu §¸i"]					=	{0,6,1},
	},
	
	["Giµy"] = {
		["Cöu TiÕt X­¬ng VÜ Ngoa"]		=	{0,5,0},
		["Thiªn Tµm Ngoa"]					=	{0,5,1},
		["Kim Lò Hµi"]								=	{0,5,2},
		["Phi Phông Ngoa"]						=	{0,5,3},
	},
};

function TrangBiTim()
	local tbSay = {"<dec>B¹n muèn nhËn hç trî nµo?"};
		tinsert(tbSay, "Ph«i ®å tÝm 6 dßng/AddEquipPurpleNoParam")
		tinsert(tbSay, "HuyÒn Tinh Kho¸ng Th¹ch/HuyenTinh")
		tinsert(tbSay, "Kho¸ng th¹ch ®· cã thuéc tÝnh/KhoangThach2")
		tinsert(tbSay, "Kho¸ng th¹ch ch­a cã thuéc tÝnh/KhoangThach")
		tinsert(tbSay, "Thñy tinh/ThuyTinh")
		tinsert(tbSay, "Phóc Duyªn/PhucDuyen")
		tinsert(tbSay, "KÕt thóc ®èi tho¹i./no")
	CreateTaskSay(tbSay)
end

function KhoangThach2()
	local tbSay = {"<dec>B¹n muèn nhËn hç trî nµo?"};
		tinsert(tbSay, "HiÖn 1/Hien1")
		tinsert(tbSay, "Èn 1/An1")
		tinsert(tbSay, "HiÖn 2/Hien2")
		tinsert(tbSay, "Èn 2/An2")
		tinsert(tbSay, "HiÖn 3/Hien3")
		tinsert(tbSay, "Èn 3/An3")
		tinsert(tbSay, "KÕt thóc ®èi tho¹i./no")
	CreateTaskSay(tbSay)
end

function PhucDuyen()
	if (CalcFreeItemCellCount() < 3) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 3 « trèng.")
	return end
	
	for nID = 122, 124 do
		AddItem(6,1, nID, 0,0,0)
	end
end

function ThuyTinh()
	if (CalcFreeItemCellCount() < 3) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 3 « trèng.")
	return end
	
	for nID = 238, 240 do
		AddItem(4, nID, 1, 0,0,0)
	end
end

function KhoangThach()
	if (CalcFreeItemCellCount() < 20) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 20 « trèng.")
	return end
	
	for i = 1, 10 do
		AddItem(6,1,149,1,0,0,0)
		AddItem(6,1,150,1,0,0,0)
		AddItem(6,1,150,1,1,0,0)
		AddItem(6,1,150,1,2,0,0)
		AddItem(6,1,150,1,3,0,0)
		AddItem(6,1,150,1,4,0,0)

		AddItem(6,1,151,1,0,0,0)
		AddItem(6,1,152,1,0,0,0)
		AddItem(6,1,152,1,1,0,0)
		AddItem(6,1,152,1,2,0,0)
		AddItem(6,1,152,1,3,0,0)
		AddItem(6,1,152,1,4,0,0)

		AddItem(6,1,153,1,0,0,0)
		AddItem(6,1,154,1,0,0,0)
		AddItem(6,1,154,1,1,0,0)
		AddItem(6,1,154,1,2,0,0)
		AddItem(6,1,154,1,3,0,0)
		AddItem(6,1,154,1,4,0,0)
	end
end

function HuyenTinh()
	if (CalcFreeItemCellCount() < 20) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 20 « trèng.")
	return end
	for i = 1, 10 do
		for k = 1, 10 do
			AddItem(6,1,147,k,0,0,0);
		end
	end
end

function AddEquipPurpleNoParam()
	if (CalcFreeItemCellCount() < 20) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 20 « trèng.")
	return end
	local tbEquip = TAB_OPTION;
	local szTitle = "Ng­¬i muèn nhËn lo¹i nµo?"
	local tbOption = {};
	for x, y in tbEquip do
		tinsert(tbOption, {format("%s", x), EquipPurpleConfirm,{tbEquip[x]}})
	end
		tinsert(tbOption, {"KÕt thóc ®èi tho¹i."})
	CreateNewSayEx(szTitle, tbOption)
end

function EquipPurpleConfirm(tbEquip)
	local szTitle = "Ng­¬i muèn nhËn lo¹i nµo?"
	local tbOption = {};
	for x, y in tbEquip do
		tinsert(tbOption, {format("%s", x), EquipPurpleOK,{tbEquip[x]}})
	end
		tinsert(tbOption, {"KÕt thóc ®èi tho¹i."})
	CreateNewSayEx(szTitle, tbOption)
end

function EquipPurpleOK(tbEquip)
	for i = 0, 4 do
		AddQualityItem(2,tbEquip[1], tbEquip[2], tbEquip[3], 10, i, 0, -1,-1,-1,-1,-1,-1)
	end
end

-- Nhan trang bi hoang kim ---------------------------------------------------------------------------------
function trangbiHK_Super()
	local tbOpt =
	{
		{"Ngò Hµnh Ên", nguhanhan},
		{"Vò LiÖt", vuliet},
		{"TBvip 2013", tbvip},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function tbvip()
	if CalcFreeItemCellCount() < 30 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 30 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=5214,5218 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function vuliet()
	if CalcFreeItemCellCount() < 30 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 30 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=5208,5212 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nguhanhan()
	if CalcFreeItemCellCount() < 30 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 30 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=5188,5192 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function trangbiHK_event()
	local tbOpt =
	{
		{"TuÖ Thanh", nhantuethanh},
		{"ChÊp Tö", nhanchaptu},
		{"Minh NguyÖt", nhanminhnguyet},
		{"To¹i Nh©n", nhantoainhan},
		{"Phôc Hi", nhanphuchi},
		{"N÷ Oa", nhannuoa},
		{"Chóc Dung", nhanchucdung},
		{"ThÇn N«ng", nhanthannong},
		{"Nh­ ý", nhannhuy},
		{"D­¬ng ThÇn", nhanduongthan},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function trangbiHK()
	local tbOpt =
	{
		{"V« Danh", nhanvodanh},
		{"Kim Quang", nhankimquang},
		{"Vinh DiÖu", nhanvinhdieu},
		{"An Bang", nhananbang},
		{"§Þnh Quèc", nhandinhquoc},
		{"§éng S¸t", nhandongsat},
		{"Thiªn Hoµng", nhanthienhoang},
		{"Kim Phong", nhankimphong},
		{"HiÖp Cèt", nhanhiepcot},
		{"Nhu T×nh", nhannhutinh},
		{"Hång ¶nh", nhanhonganh},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function nhanduongthan()
	if CalcFreeItemCellCount() < 30 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 30 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=515,520 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhannhuy()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=492,493 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanthannong()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=482,483 do	-- 482, 483, 485, 487, 488
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
	for i=485,485 do	-- 482, 483, 485, 487, 488
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
	for i=487,488 do	-- 482, 483, 485, 487, 488
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanchucdung()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=472,472 do	-- 472, 476, 477, 478
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
	for i=476,478 do	-- 472, 476, 477, 478
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhannuoa()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=463,464 do	-- 463, 464, 467, 468
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
	for i=467,468 do	-- 463, 464, 467, 468
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanphuchi()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=455,458 do	-- 455, 456, 457, 458
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhantoainhan()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=442,443 do	-- 442, 443, 445, 446, 448
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
	for i=445,446 do	-- 442, 443, 445, 446, 448
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
	for i=448,448 do	-- 442, 443, 445, 446, 448
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanminhnguyet()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=440,441 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanchaptu()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=438,439 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhantuethanh()
	if CalcFreeItemCellCount() < 2 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 2 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=208,209 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanhonganh()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=204,207 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhannhutinh()
	if CalcFreeItemCellCount() < 20 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 20 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=190,193 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanhiepcot()
	if CalcFreeItemCellCount() < 20 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 20 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=186,189 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhankimphong()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=177,185 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanthienhoang()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=168,176 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhandongsat()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=143,146 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhankimquang()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=194,203 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanvodanh()
	if CalcFreeItemCellCount() < 2 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 2 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=141,142 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhananbang()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=164,167 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhandinhquoc()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=159,163 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function nhanvinhdieu()
	if CalcFreeItemCellCount() < 30 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 30 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
 	for i=214,215 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end
-- Nhan trang bi hoang kim hoang my ---------------------------------------------------------------------------------
function trangbiHM()
	local tbOpt =
	{
		{"Hoµn Mü An Bang", HManbang},
		{"Hoµn Mü Hång ¶nh", HMhonganh},
		{"Hoµn Mü Vinh DiÖu", HMvinhdieu},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function HMvinhdieu()
	if CalcFreeItemCellCount() < 30 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 30 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=512,513 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function HMhonganh()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=434,437 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function HManbang()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=210,213 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
-- Nhan trang bi hoang kim lien dau ---------------------------------------------------------------------------------
function trangbiLD()
	local tbOpt =
	{
		{"Liªn §Êu An Bang", LDanbang},
		{"Liªn §Êu §Þnh Quèc", LDdinhquoc},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function LDdinhquoc()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=389,393 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function LDanbang()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=394,397 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
-- Nhan trang bi hoang kim cuc pham ---------------------------------------------------------------------------------
function trangbiCP()
	local tbOpt =
	{
		{"Cùc PhÈm An Bang", CPanbang},
		{"Cùc PhÈm §Þnh Quèc", CPdinhquoc},
		{"Cùc PhÈm Nhu T×nh", CPnhutinh},
		{"Cùc PhÈm HiÖp Cèt", CPhiepcot},
		{"Cùc PhÈm §éng S¸t", CPdongsat},
		{"Cùc PhÈm Hång ¶nh", CPhonganh},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function CPhonganh()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=532,535 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function CPdongsat()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=494,497 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function CPhiepcot()
	if CalcFreeItemCellCount() < 20 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 20 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=412,415 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function CPnhutinh()
	if CalcFreeItemCellCount() < 20 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 20 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=416,419 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function CPanbang()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=408,411 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
function CPdinhquoc()
	if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=403,407 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
-- Nhan trang bi hoang kim hoan my cuc pham ---------------------------------------------------------------------------------
function trangbiHMCP()
	local tbOpt =
	{
		{"Hoµn Mü Cùc PhÈm An Bang", HMCPanbang},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function HMCPanbang()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 10 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	for i=424,427 do
		local ItemIdx=AddGoldItem(0, i);
		--SetItemBindState(ItemIdx, -2);
	end	
end;
-- Nhan trang bi hoang kim mon phai ---------------------------------------------------------------------------------
function trangbiHKMP()
	local tbOpt =
	{
		--{"Vò khÝ HKMP", vukhihkmp},
		{"Trang bÞ HKMP", hkmp},
		{"TrÊn Bang Chi B¶o", tranbang},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end

function hkmp()
	local tbOpt =
	{
		{"Ph¸i ThiÕu L©m",thieulam},
		{"Ph¸i Thiªn V­¬ng",thienvuong},
		{"Ph¸i §­êng M«n",duongmon},
		{"Ph¸i Ngò §éc",ngudoc},
		{"Ph¸i Nga My",ngamy},
		{"Ph¸i Thóy Yªn",thuyyen},
		{"Ph¸i Thiªn NhÉn",thiennhan},
		{"Ph¸i C¸i Bang",caibang},
		{"Ph¸i Vâ §ang",vodang},
		{"Ph¸i C«n L«n",conlon},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function thieulam()
	local tbOpt =
	{
		{"ThiÕu L©m §ao",thieulamdao},
		{"ThiÕu L©m Bæng",thieulambong},
		{"ThiÕu L©m QuyÒn",thieulamquyen},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function thieulamdao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Tø Kh«ng Gi¸ng Ma Giíi ®ao",tbProp={0,11},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Tø Kh«ng Tö Kim Cµ Sa",tbProp={0,12},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="TTø Kh«ng Hé ph¸p Yªu ®¸i",tbProp={0,13},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Tø Kh«ng NhuyÔn B× Hé UyÓn",tbProp={0,14},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Tø Kh«ng Giíi LuËt Ph¸p giíi",tbProp={0,15},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Tø Kh«ng §¹t Ma T¨ng Hµi",tbProp={0,776},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function thieulambong()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Phôc Ma Tö Kim C«n",tbProp={0,6},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Phôc Ma HuyÒn Hoµng Cµ Sa",tbProp={0,7},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Phôc Ma ¤ Kim NhuyÔn §iÒu",tbProp={0,8},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Phôc Ma PhËt T©m NhuyÔn KhÊu",tbProp={0,9},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Phôc Ma Phæ §é T¨ng hµi",tbProp={0,10},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Phôc Ma V« L­îng Kim Cang UyÓn",tbProp={0,771},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function thieulamquyen()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Méng Long ChÝnh Hång T¨ng M·o",tbProp={0,1},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Méng Long Kim Ti ChÝnh Hång Cµ Sa",tbProp={0,2},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Méng Long HuyÒn Ti Ph¸t ®¸i",tbProp={0,3},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Méng Long PhËt Ph¸p HuyÒn Béi",tbProp={0,4},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Méng Long §¹t Ma T¨ng hµi",tbProp={0,5},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Méng Long Tö Kim B¸t Nh· Giíi",tbProp={0,769},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function thienvuong()
	local tbOpt =
	{
		{"Thiªn V­¬ng Chïy",thienvuongchuy},
		{"Thiªn V­¬ng Th­¬ng",thienvuongthuong},
		{"Thiªn V­¬ng §ao",thienvuongdao},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function thienvuongchuy()
if CalcFreeItemCellCount() < 1 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="H¸m Thiªn Kim Hoµn §¹i Nh·n ThÇn Chïy",tbProp={0,16},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="H¸m Thiªn Vò ThÇn T­¬ng Kim Gi¸p",tbProp={0,17},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="H¸m Thiªn Uy Vò Thóc yªu ®¸i",tbProp={0,18},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="H¸m Thiªn Hæ ®Çu KhÈn Thóc UyÓn",tbProp={0,19},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="H¸m Thiªn Thõa Long ChiÕn Ngoa",tbProp={0,20},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function thienvuongthuong()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="KÕ NghiÖp B«n L«i Toµn Long th­¬ng",tbProp={0,21},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
tbAwardTemplet:GiveAwardByList({{szName="KÕ NghiÖp HuyÒn Vò Hoµng Kim Kh¶i",tbProp={0,22},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
tbAwardTemplet:GiveAwardByList({{szName="KÕ NghiÖp B¹ch Hæ V« Song khÊu",tbProp={0,23},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
tbAwardTemplet:GiveAwardByList({{szName="KÕ NghiÖp HáaV©n Kú L©n Thñ ",tbProp={0,24},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
tbAwardTemplet:GiveAwardByList({{szName="KÕ NghiÖp Chu T­íc L¨ng V©n Ngoa",tbProp={0,25},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function thienvuongdao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Ngù Long L­îng Ng©n B¶o ®ao",tbProp={0,26},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ngù Long ChiÕn ThÇn Phi Qu¶i gi¸p",tbProp={0,27},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ngù Long Thiªn M«n Thóc Yªu hoµn",tbProp={0,28},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ngù Long TÊn Phong Hé yÓn",tbProp={0,29},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ngù Long TuyÖt MÖnh ChØ hoµn",tbProp={0,30},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Ngù Long TÊn Phong Ph¸t C¬",tbProp={0,793},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function duongmon()
	local tbOpt =
	{
		{"§­êng M«n Ná",duongmonno},
		{"§­êng M«n Phi §ao",duongmonphidao},
		{"§­êng M«n Phi Tiªu",duongmonphitieu},
		{"§­êng M«n BÉy",duongmonbay},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function duongmonno()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Thiªn Quang Hoa Vò M¹n Thiªn",tbProp={0,76},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Thiªn Quang §Þnh T©m Ng­ng ThÇn Phï ",tbProp={0,77},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Thiªn Quang S©m La Thóc §¸i",tbProp={0,78},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Thiªn Quang Song B¹o Hµn ThiÕt Tr¹c",tbProp={0,79},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Thiªn Quang Thóc Thiªn Ph­îc §Þa Hoµn",tbProp={0,80},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Thiªn Quang §Þa Hµnh Thiªn Lý  Ngoa",tbProp={0,843},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function duongmonphidao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="B¨ng Hµn §¬n ChØ Phi §ao",tbProp={0,71},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="B¨ng Hµn HuyÒn Y Thóc Gi¸p",tbProp={0,72},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="B¨ng Hµn T©m TiÔn Yªu KhÊu",tbProp={0,73},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="B¨ng Hµn HuyÒn Thiªn B¨ng Háa Béi",tbProp={0,74},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="B¨ng Hµn NguyÖt ¶nh Ngoa",tbProp={0,75},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function duongmonphitieu()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="S©m Hoµng Phi Tinh §o¹t Hån",tbProp={0,81},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S©m Hoang KimTiÒn Liªn Hoµn Gi¸p",tbProp={0,82},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S©m Hoang Hån Gi¶o Yªu Thóc",tbProp={0,83},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S©m Hoang HuyÒn ThiÕt T­¬ng Ngäc Béi",tbProp={0,84},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S©m Hoang Tinh VÉn Phi Lý ",tbProp={0,85},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function duongmonbay()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="§Þa Ph¸ch Ngò hµnh Liªn Hoµn Qu¸n",tbProp={0,86},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þa Ph¸ch H¾c DiÖm Xung Thiªn Liªn",tbProp={0,87},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þa Ph¸ch TÝch LÞch L«i Háa Giíi",tbProp={0,88},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þa Ph¸ch KhÊu T©m tr¹c",tbProp={0,89},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þa Ph¸ch §Þa Hµnh Thiªn Lý Ngoa",tbProp={0,90},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] §Þa Ph¸ch Phong Hµn Thóc Yªu",tbProp={0,854},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function ngudoc()
	local tbOpt =
	{
		{"Ngò §éc §ao",ngudocdao},
		{"Ngò §éc Ch­ëng",ngudocchuong},
		{"Ngò §éc Bïa",ngudocbua},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function ngudocdao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Minh ¶o Tµ S¸t §éc NhËn",tbProp={0,61},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Minh ¶o U §éc ¸m Y",tbProp={0,62},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Minh ¶o §éc YÕt ChØ Hoµn",tbProp={0,63},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Minh ¶o Hñ Cèt Hé uyÓn",tbProp={0,64},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Minh ¶o Song Hoµn Xµ Hµi",tbProp={0,65},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Minh Hoan Song Hoµn Xµ KhÊu",tbProp={0,829},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function ngudocchuong()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="U Lung Kim Xµ Ph¸t ®¸i ",tbProp={0,56},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="U Lung XÝch YÕt MËt trang ",tbProp={0,57},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="U Lung Thanh Ng« TriÒn yªu",tbProp={0,58},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="U Lung Ng©n ThÒm Hé UyÓn",tbProp={0,59},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="U Lung MÆc Thï NhuyÔn Lý ",tbProp={0,60},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function ngudocbua()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Chó Ph­îc Ph¸ gi¸p ®Çu hoµn",tbProp={0,66},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Chó Ph­îc DiÖt L«i C¶nh Phï ",tbProp={0,67},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Chó Ph­îc U ¶o ChØ Hoµn",tbProp={0,68},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Chó Ph­îc Xuyªn T©m §éc UyÓn",tbProp={0,69},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Chó Ph­îc B¨ng Háa Thùc Cèt Ngoa",tbProp={0,70},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Chó Phäc Trïng Cèt Ngäc Béi",tbProp={0,834},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function ngamy()
	local tbOpt =
	{
		{"Nga My KiÕm",ngamykiem},
		{"Nga My Ch­ëng",ngamychuong},
		{"Nga My Buff",ngamybuff},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function ngamykiem()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="V« Gian û Thiªn KiÕm",tbProp={0,31},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Gian Thanh Phong Truy Y",tbProp={0,32},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Gian PhÊt V©n Ti ®¸i",tbProp={0,33},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Gian CÇm VËn Hé UyÓn",tbProp={0,34},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Gian B¹ch Ngäc Bµn ChØ ",tbProp={0,35},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] V« Gian Thanh Phong NhuyÔn KÞch",tbProp={0,796},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);

end
function ngamychuong()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="V« Ma Ma Ni qu¸n",tbProp={0,36},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Ma Tö Kh©m Cµ Sa",tbProp={0,37},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Ma B¨ng Tinh ChØ Hoµn",tbProp={0,38},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Ma TÈy T­îng Ngäc KhÊu ",tbProp={0,39},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« Ma Hång Truy NhuyÔn Th¸p hµi",tbProp={0,40},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] V« YÓm Thu Thñy L­u Quang §¸i",tbProp={0,801},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function ngamybuff()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="V« TrÇn Ngäc N÷ Tè T©m qu¸n",tbProp={0,41},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« TrÇn Thanh T©m H­íng ThiÖn Ch©u",tbProp={0,42},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« TrÇn Tõ Bi Ngäc Ban ChØ ",tbProp={0,43},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« TrÇn PhËt T©m Tõ H÷u Yªu Phèi",tbProp={0,44},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="V« TrÇn PhËt Quang ChØ Hoµn",tbProp={0,45},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function thuyyen()
	local tbOpt =
	{
		{"Thóy Yªn §ao",thuyyendao},
		{"Thóy Yªn Song §ao",thuyyensongdao},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function thuyyendao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Tª Hoµng Phông Nghi ®ao",tbProp={0,46},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Tª Hoµng TuÖ T©m Khinh Sa Y",tbProp={0,47},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Tª Hoµng Phong TuyÕt B¹ch V©n Thóc §¸i",tbProp={0,48},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Tª Hoµng B¨ng Tung CÈm uyÓn",tbProp={0,49},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Tª Hoµng Thóy Ngäc ChØ Hoµn",tbProp={0,50},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Tª Hoµng HuÖ T©m Tr­êng Sinh KhÊu",tbProp={0,811},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function thuyyensongdao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="BÝch H¶i Uyªn ¦¬ng Liªn Hoµn ®ao ",tbProp={0,51},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="BÝch H¶i Hoµn Ch©u Vò Liªn",tbProp={0,52},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="BÝch H¶i Hång Linh Kim Ti ®¸i",tbProp={0,53},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="BÝch H¶i Hång L¨ng Ba",tbProp={0,54},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="BÝch H¶i Khiªn TÕ ChØ hoµn",tbProp={0,55},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] BÝch H¶i Hoµn Ch©u Tuyªn Thanh C©n",tbProp={0,816},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function vodang()
	local tbOpt =
	{
		{"Vâ §ang KiÕm",vodangkiem},
		{"Vâ §ang KhÝ",vodangkhi},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function vodangkiem()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="CËp Phong Ch©n Vò KiÕm",tbProp={0,121},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="CËp Phong Tam Thanh Phï",tbProp={0,122},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="CËp Phong HuyÒn Ti Tam §o¹n cÈm",tbProp={0,123},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="CËp Phong Thóy Ngäc HuyÒn Hoµng Béi",tbProp={0,124},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="CËp Phong Thanh Tïng Ph¸p giíi",tbProp={0,125},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] CËp Phong Thóy Ngäc HuyÒn Hoµng UyÓn",tbProp={0,888},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function vodangkhi()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="L¨ng Nh¹c Th¸i Cùc KiÕm",tbProp={0,116},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L¨ng Nh¹c V« Ng· ®¹o bµo",tbProp={0,117},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L¨ng Nh¹c Né L«i Giíi",tbProp={0,118},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L¨ng Nh¹c V« Cùc HuyÒn Ngäc Béi",tbProp={0,119},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L¨ng Nh¹c Thiªn §Þa HuyÒn Hoµng giíi",tbProp={0,120},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] L¨ng Nh¹c V« Ng· Thóc §¸i",tbProp={0,881},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function conlon()
	local tbOpt =
	{
		{"C«n L«n §ao",conlondao},
		{"C«n L«n KiÕm",conlonkiem},
		{"C«n L«n Bïa",conlonbua},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function conlondao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="S­¬ng Tinh Thiªn Niªn Hµn ThiÕt",tbProp={0,126},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S­¬ng Tinh Ng¹o S­¬ng ®¹o bµo",tbProp={0,127},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S­¬ng Tinh Thanh Phong Lò ®¸i",tbProp={0,128},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S­¬ng Tinh Thiªn Tinh B¨ng Tinh thñ ",tbProp={0,129},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="S­¬ng Tinh Phong B¹o chØ hoµn",tbProp={0,130},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] S­¬ng Tinh L­u Tinh C¶n NguyÖt KhÊu",tbProp={0,891},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function conlonkiem()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="L«i Khung Hµn Tung B¨ng B¹ch quan",tbProp={0,131},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L«i Khung Thiªn §Þa Hé phï",tbProp={0,132},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L«i Khung Phong L«i Thanh CÈm ®¸i",tbProp={0,133},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L«i Khung Linh Ngäc UÈn L«i",tbProp={0,134},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="L«i Khung Cöu Thiªn DÉn L«i giíi",tbProp={0,135},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] L«i Khung Linh Ngäc Èn L«i UyÓn",tbProp={0,898},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function conlonbua()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Vô ¶o B¾c Minh §¹o qu¸n",tbProp={0,136},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Vô ¶o Ki B¸n phï chó ",tbProp={0,137},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Vô ¶o Thóc T©m chØ hoµn",tbProp={0,138},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Vô ¶o Thanh ¶nh HuyÒn Ngäc Béi",tbProp={0,139},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);

 tbAwardTemplet:GiveAwardByList({{szName="Vô ¶o Tung Phong TuyÕt ¶nh ngoa",tbProp={0,140},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function caibang()
	local tbOpt =
	{
		{"C¸i Bang Rång",caibangrong},
		{"C¸i Bang Bæng",caibangbong},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function caibangrong()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="§ång Cõu Phi Long §Çu hoµn",tbProp={0,91},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§ång Cõu Gi¸ng Long C¸i Y",tbProp={0,92},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§ång Cõu TiÒm Long Yªu §¸i",tbProp={0,93},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§ång Cõu Kh¸ng Long Hé UyÓn",tbProp={0,94},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§ång Cõu KiÕn Long Ban ChØ",tbProp={0,95},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] §ång Cõu Ngù Long Ngäc Béi",tbProp={0,855},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function caibangbong()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="§Þch Kh¸i Lôc Ngäc Tr­îng",tbProp={0,96},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þch Kh¸i Cöu §¹i C¸i Y",tbProp={0,97},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þch Kh¸i TriÒn M·ng yªu ®¸i",tbProp={0,98},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þch Kh¸i CÈu TÝch B× Hé uyÓn",tbProp={0,99},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§Þch Kh¸i Th¶o Gian Th¹ch giíi",tbProp={0,100},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function thiennhan()
	local tbOpt =
	{
		{"Thiªn NhÉn §ao",thiennhandao},
		{"Thiªn NhÉn KÝch",thiennhankich},
		{"Thiªn NhÉn Bïa",thiennhanbua},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function thiennhandao()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Ma ThÞ LiÖt DiÖm Qu¸n MiÖn",tbProp={0,111},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma ThÞ LÖ Ma PhÖ T©m Liªn",tbProp={0,112},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma ThÞ NghiÖp Háa U Minh Giíi",tbProp={0,113},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma ThÞ HuyÕt Ngäc ThÊt S¸t Béi",tbProp={0,114},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma ThÞ s¬n  H¶i Phi Hång Lý",tbProp={0,115},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Ma ThÞ LÖ Ma PhÖ T©m §¸i",tbProp={0,876},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function thiennhankich()
if CalcFreeItemCellCount() < 50 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Ma S¸t Quû Cèc U Minh Th­¬ng",tbProp={0,101},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma S¸t Tµn D­¬ng ¶nh HuyÕt Gi¸p",tbProp={0,102},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma S¸t XÝch Ký Táa Yªu KhÊu",tbProp={0,103},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma S¸t Cö Háa Liªu Thiªn uyÓn",tbProp={0,104},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma S¸t V©n Long Thæ Ch©u giíi",tbProp={0,105},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Ma S¸t Cö Háa Liªu Thiªn Hoµn",tbProp={0,868},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end
function thiennhanbua()
if CalcFreeItemCellCount() < 5 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 5 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="Ma Hoµng Kim Gi¸p Kh«i",tbProp={0,106},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma Hoµng ¸n XuÊt Hæ H¹ng Khuyªn",tbProp={0,107},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma Hoµng Khª Cèc Thóc yªu ®¸i",tbProp={0,108},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma Hoµng HuyÕt Y Thó Tr¹c",tbProp={0,109},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Ma Hoµng §¨ng §¹p Ngoa",tbProp={0,110},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
 tbAwardTemplet:GiveAwardByList({{szName="[TrÊn Bang Chi B¶o] Ma Hoµng Dung Kim §o¹n NhËt Giíi",tbProp={0,874},nCount=1,nQuality = 1,},}, "NobitaXD-ThunghiemHKMP", 1);
end

function vukhihkmp()
	local tbOpt =
	{
		{"ThiÕu l©m", vktl},
		{"Thiªn v­¬ng", vktv},
		{"§êng m«n", vkdm},
		{"Ngò ®éc", vk5d},
		{"Nga mi", vknm},
		{"Thuý yªn", vkty},
		{"C¸i bang", vkcb},
		{"Thiªn nhÉn", vktn},
		{"Vâ ®ang", vkvd},
		{"C«n l«n", vkcl},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end

function vktl()
	--AddGoldItem(0, 1)
	AddGoldItem(0, 6)
	AddGoldItem(0, 11)
end

function vktv()
	AddGoldItem(0, 16)
	AddGoldItem(0, 21)
	AddGoldItem(0, 26)
end

function vknm()
	AddGoldItem(0, 31)
	--AddGoldItem(0, 39)
end

function vkty()
	AddGoldItem(0, 46)
	AddGoldItem(0, 51)
end

function vk5d()
	--AddGoldItem(0, 56)
	AddGoldItem(0, 61)
end

function vkdm()
	AddGoldItem(0, 71)
	AddGoldItem(0, 76)
	AddGoldItem(0, 81)
end

function vkcb()
	AddGoldItem(0, 94)
	AddGoldItem(0, 96)
end

function vktn()
	AddGoldItem(0, 101)
	--AddGoldItem(0, 111)
end

function vkvd()
	AddGoldItem(0, 116)
	AddGoldItem(0, 121)
end

function vkcl()
	AddGoldItem(0, 126)
	--AddGoldItem(0, 131)
end

function tranbang()
	local tbOpt =
	{
		{"ThiÕu l©m", tbtl},
		{"Thiªn v­¬ng", tbtv},
		{"§­êng m«n", tbdm},
		{"Ngò ®éc", tb5d},
		{"Nga mi", tbnm},
		{"Thuý yªn", tbty},
		{"C¸i bang", tbcb},
		{"Thiªn nhÉn", tbtn},
		{"Vâ ®ang", tbvd},
		{"C«n l«n", tbcl},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end

function tbtl()
	AddGoldItem(0, 769)
	AddGoldItem(0, 771)
	AddGoldItem(0, 776)
end

function tbtv()
	AddGoldItem(0, 793)
end

function tbnm()
	AddGoldItem(0, 796)
	AddGoldItem(0, 801)
	--AddGoldItem(0, 808)
end

function tbty()
	AddGoldItem(0, 811)
	AddGoldItem(0, 816)
end

function tb5d()
	AddGoldItem(0, 829)
	AddGoldItem(0, 834)
end

function tbdm()
	AddGoldItem(0, 843)
	AddGoldItem(0, 854)
end

function tbcb()
	AddGoldItem(0, 855)
end

function tbtn()
	AddGoldItem(0, 868)
	AddGoldItem(0, 874)
	AddGoldItem(0, 876)
end

function tbvd()
	AddGoldItem(0, 881)
	AddGoldItem(0, 888)
end

function tbcl()
	AddGoldItem(0, 891)
	AddGoldItem(0, 898)
	--AddGoldItem(0, 901)
end
---=====| {"NhËn trang bÞ", trangbiall} - End |=====---
---=====| {"NhËn vËt phÈm hç trî", Itemhotro} - Star |=====---
function Itemhotro()
	local tbOpt =
	{
		{"Hç trî luyÖn cÊp", itemLuyenCap},
		{"D· TÈu Chi B¶o", DaTauChiBao},
		{"Kü N¨ng 9x", KyNang9x},
		{"Kü N¨ng 12x", KyNang12x},
		{"ThÇn hµnh phï, Thæ ®Þa phï", itemTHPTDP},
		{"Vâ L©m MËt TÞch, TÈy Tñy Kinh", itemVLMTTTK},
		{"LÖnh bµi nhiÖm vô", itemLenhBaiNhiemVu},
		{"Hç trî tÝnh n¨ng", itemTinhNang},
		{"Hç trî Event", VatPhamEvent},
		--{"10 LÖnh bµi gäi Boss", LBBoss},
		--{"Hç trî Event", itemEvent},
		{"CÈm nang T©n Thñ", TanThuCamNang},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end

function TanThuCamNang()
	if (CalcFreeItemCellCount() < 1) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 1 « trèng.")
	return end;
	if (CalcEquiproomItemCount(6,1,4258,-1) == 0) then
		local nItemIndex = AddItem(6,1,4258,1,0,0);
		SetItemBindState(nItemIndex, -1);
	else
		Say("<color=yellow>CÈm nang T©n Thñ<color> kh«ng ph¶i ë trong hµnh trang cña ng­¬i råi sao!",0)
	end;
end

function LBBoss()
	if (CalcFreeItemCellCount() < 10) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 10 « trèng.")
	return end
	for i = 1, 10 do
		AddItem(6,1,1022,1,0,0,0)
		end
end
function itemLuyenCap()
	if (CalcFreeItemCellCount() < 15) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 15 « trèng.")
	return end
	for i = 1, 5 do
		AddItem(6,1,125,1,0,0,0)
		AddItem(6,1,1181,1,0,0,0)
	end
	AddItem(0,11,561,1,0,0,0)
	AddGoldItem(0, 514)
	AddItem(6,1,2126,1,0,0,0)
end
function DaTauChiBao()
	for i = 1, 50 do
		AddItem(6,1,4378,1,0,0,0)
	end;
end

function KyNang12x()
if CalcFreeItemCellCount() < 2 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 2 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="BU quyOt kü n¨ng cÊp 120",tbProp={6,1,1125,1,0,0,0},nCount=1,},}, "NobitaXD-ThunghiemSkill12x", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§¹i Thµnh BÝ KÝp 120",tbProp={6,1,2425,1,0,0,0},nCount=1,},}, "NobitaXD-ThunghiemSkill12x", 1);
end
function KyNang9x()
if CalcFreeItemCellCount() < 2 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 2 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="S¸ch kü n¨ng cÊp 90",tbProp={6,1,2426,1,0,0,0},nCount=1,},}, "NobitaXD-ThunghiemSkill9x", 1);
 tbAwardTemplet:GiveAwardByList({{szName="§¹i Thµnh BÝ KÝp 90",tbProp={6,1,2424,1,0,0,0},nCount=1,},}, "NobitaXD-ThunghiemSkill9x", 1);
end
function itemTHPTDP()
if CalcFreeItemCellCount() < 2 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 2 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
end
 tbAwardTemplet:GiveAwardByList({{szName="ThÇn Hµnh Phï",tbProp={6,1,1266,1,0,0,0},nCount=1,},}, "NobitaXD-Thunghiem", 1);
 tbAwardTemplet:GiveAwardByList({{szName="Thæ ®~a phï (sö dông v« h¹n) ",tbProp={6,1,438,1,0,0,0},nCount=1,},}, "NobitaXD-Thunghiem", 1);
end
function itemVLMTTTK()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end
	
	for i = 1, 15 do
		AddItem(6,1,22,1,0,0,0)
		AddItem(6,1,26,1,0,0,0)
	end
end
function itemLenhBaiNhiemVu()
	if (CalcFreeItemCellCount() < 1) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 1 « trèng.")
	return end
	AddItem(6,1,4266,1,0,0,0)
end

function itemTinhNang()
	local tbOpt =
	{
		{"Trang bÞ B¹ch Kim", main_itemBachKim},
		{"TÝnh n¨ng trang bÞ huyÒn tinh", TrangBiTim},
		{"TÝnh n¨ng Phong Lang §é", itemPLD},
		{"TÝnh n¨ng Tèng Kim", itemTK},
		{"TÝnh n¨ng V­ît ¶i", itemVA},
		{"Nh¹c V­¬ng KiÕm", itemNVK},
		{"LÔ bao Khiªu ChiÕn LÖnh", itemlebaoKCL},
		{"Trïng sinh", main_TrungSinh},
		--{"NhËn 200 MËt ®å thÇn bÝ", itemMDTB},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbOpt)
end
function main_TrungSinh()
	local tbOpt =
	{
		{"Trïng sinh 1", itemTrungSinh_1},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Hç trî t×nh n¨ng <color=yellow>Trïng sinh<color> chän nguyªn liÖu.", tbOpt)
end
function itemTrungSinh_1()
	AddItem(6,1,1390,0,0,0,0);	-- <B¾c §Èu Tr­êng Sinh ThuËt - C¬ Së Thiªn>
	Earn(100000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow><B¾c §Èu Tr­êng Sinh ThuËt - C¬ Së Thiªn><color> mét c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>10.000<color> v¹n l­îng")
end

function main_itemBachKim()
	local tbOpt =
	{
		{"ChÕ t¹o trang bÞ hoµng kim thµnh b¹ch kim (ThÇn bÝ thiÕt t­îng)", itemBachKim_1up},
		{"ChÕ t¹o trang bÞ hoµng kim thµnh b¹ch kim (ThÇn BÝ Th­¬ng Nh©n)", itemBachKim_2up},
		{"Th¨ng cÊp trang bÞ b¹ch kim +1", itemBachKim_1},
		{"Th¨ng cÊp trang bÞ b¹ch kim +2", itemBachKim_2},
		{"Th¨ng cÊp trang bÞ b¹ch kim +3", itemBachKim_3},
		{"Th¨ng cÊp trang bÞ b¹ch kim +4", itemBachKim_4},
		{"Th¨ng cÊp trang bÞ b¹ch kim +5", itemBachKim_5},
		{"Th¨ng cÊp trang bÞ b¹ch kim +6", itemBachKim_6},
		{"Th¨ng cÊp trang bÞ b¹ch kim +7", itemBachKim_7},
		{"Th¨ng cÊp trang bÞ b¹ch kim +8", itemBachKim_8},
		{"Th¨ng cÊp trang bÞ b¹ch kim +9", itemBachKim_9},
		{"Th¨ng cÊp trang bÞ b¹ch kim +10", itemBachKim_10},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Hç trî t×nh n¨ng <color=yellow>Trang bÞ b¹ch kim<color> chän nguyªn liÖu.", tbOpt)
end
function itemBachKim_1up()
	AddItem(6,1,1309,0,0,0,0);	-- M¶nh Bæ Thiªn Th¹ch (trung)
	AddItem(6,1,147,8,0,0,0);	-- HuyÒn tinh kho¸ng th¹ch cÊp 8
	AddItem(6,1,398,0,0,0,0);	-- ThÇn bU kho¸ng th¹ch
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> mét c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>HuyÒn tinh kho¸ng th¹ch cÊp 8<color> mét c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>ThÇn bU kho¸ng th¹ch<color> mét c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_2up()
	AddItem(6,1,1473,0,0,0,0);	-- L«i Tr¹ch Chïy
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>L«i Tr¹ch Chïy<color> mét c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_1()
	AddItem(6,1,1309,0,0,0,0);	-- M¶nh Bæ Thiªn Th¹ch (trung)
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> mét c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_2()
	for	i = 1,2	do
		AddItem(6,1,1309,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> 2 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_3()
	for	i = 1,3	do
		AddItem(6,1,1309,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> 3 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_4()
	for	i = 1,4	do
		AddItem(6,1,1309,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> 4 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_5()
	for	i = 1,5	do
		AddItem(6,1,1309,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> 5 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_6()
	for	i = 1,6	do
		AddItem(6,1,1309,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> 6 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_7()
	AddItem(6,1,1310,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (®¹i)
	for	i = 1,5	do
		AddItem(6,1,1309,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	AddItem(6,1,2127,0,0,0,0)	-- B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 1)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (®¹i)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> 5 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 1)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_8()
	AddItem(6,1,1310,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (®¹i)
	for	i = 1,5	do
		AddItem(6,1,1309,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	AddItem(6,1,2160,0,0,0,0)	-- B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 1)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (®¹i)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (trung)<color> 5 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 2)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_9()
	AddItem(6,1,1310,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (®¹i)
	for	i = 1,5	do
		AddItem(6,1,1310,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	AddItem(6,1,2161,0,0,0,0)	-- B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 1)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (®¹i)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (®¹i)<color> 5 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 3)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemBachKim_10()
	AddItem(6,1,1310,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (®¹i)
	for	i = 1,5	do
		AddItem(6,1,1310,0,0,0,0)	-- M¶nh Bæ Thiªn Th¹ch (trung)
	end;
	Earn(10000000);
	AddItem(6,1,2162,0,0,0,0)	-- B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 1)
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (®¹i)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>M¶nh Bæ Thiªn Th¹ch (®¹i)<color> 5 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>B¾c §Èu LuyÖn Kim ThuËt (QuyÓn 4)<color> 1 c¸i")
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1.000<color> v¹n l­îng")
end
function itemVA()
	AddItem(6,1,400,90,0,0,0)
end
function itemPLD()
	AddItem(4,489,1,1,0,0)
	AddItem(6,1,2745,0,0,0,0)
end
function itemNVK()
	AddItem(6,1,2340,0,0,0,0)
end
function itemMDTB()
	for i=1,200	do
	AddItem(6,1,196,0,0,0,0)
	end
end
function itemlebaoKCL()
	AddItem(6,1,2006,0,0,0,0)
end
function itemTK()
	if CheckGioiHan(3997)==1 then
		Say("<color=green>Hæ trî t©n thñ<color>: Ngµy h«m nay b¹n ®· nhËn th­ëng råi. Ngµy mai h·y quay l¹i gÆp ta",0);
		return
	end
	if CalcFreeItemCellCount() < 5 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 5 « trèng råi h·y tiÕp tôc nhÐ !",0);
		return 1;
	end
	local tbAwardItemmn = {
		{szName="phi tèc",tbProp={6,1,190,1,0,0},nCount=50,nBindState = -2,nExpiredTime = 1440},
		{szName="lÖnh bµi",tbProp={6,1,157,1,0,0},nCount=50,nBindState = -2,nExpiredTime = 1440},
		{szName="chiÕn cæ",tbProp={6,1,156,1,0,0},nCount=50,nBindState = -2,nExpiredTime = 1440},
	}
	tbAwardTemplet:Give(tbAwardItemmn, 1)
end
function CheckGioiHan(TaskDate)
	old_date = GetByte(GetTask(TaskDate), 1)
	old_month = GetByte(GetTask(TaskDate), 2)
	old_year = GetByte(GetTask(TaskDate), 3)

	now_date = tonumber(date("%d"))
	now_month = tonumber(date("%m"))
	now_year = tonumber(date("%y"))

	if old_date == now_date and old_month == now_month and old_year == now_year then
		return 1;
	else
		SetTask(TaskDate, SetByte(GetTask(TaskDate), 1, now_date))
		SetTask(TaskDate, SetByte(GetTask(TaskDate), 2, now_month))
		SetTask(TaskDate, SetByte(GetTask(TaskDate), 3, now_year))	
		return 0;
	end
end

function TrangBiTim()
	local tbSay = {"<dec><color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm."};
		tinsert(tbSay, "Ph«i ®å tÝm 6 dßng/AddEquipPurpleNoParam")
		tinsert(tbSay, "HuyÒn Tinh Kho¸ng Th¹ch/HuyenTinh")
		tinsert(tbSay, "Kho¸ng th¹ch/KhoangThach")
		tinsert(tbSay, "Thñy tinh/ThuyTinh")
		tinsert(tbSay, "Phóc Duyªn/PhucDuyen")
		tinsert(tbSay, "KÕt thóc ®èi tho¹i./no")
	CreateTaskSay(tbSay)
end

function HuyenTinh()
	if (CalcFreeItemCellCount() < 20) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 20 « trèng.")
	return end
	for i = 1, 10 do
		for k = 1, 10 do
			AddItem(6,1,147,k,0,0,0);
		end
	end
end

function KhoangThach()
	if (CalcFreeItemCellCount() < 20) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 20 « trèng.")
	return end
		AddItem(6,1,149,1,0,0,0)
		AddItem(6,1,150,1,0,0,0)
		AddItem(6,1,150,1,1,0,0)
		AddItem(6,1,150,1,2,0,0)
		AddItem(6,1,150,1,3,0,0)
		AddItem(6,1,150,1,4,0,0)

		AddItem(6,1,151,1,0,0,0)
		AddItem(6,1,152,1,0,0,0)
		AddItem(6,1,152,1,1,0,0)
		AddItem(6,1,152,1,2,0,0)
		AddItem(6,1,152,1,3,0,0)
		AddItem(6,1,152,1,4,0,0)

		AddItem(6,1,153,1,0,0,0)
		AddItem(6,1,154,1,0,0,0)
		AddItem(6,1,154,1,1,0,0)
		AddItem(6,1,154,1,2,0,0)
		AddItem(6,1,154,1,3,0,0)
		AddItem(6,1,154,1,4,0,0)
end

function ThuyTinh()
	if (CalcFreeItemCellCount() < 3) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 3 « trèng.")
	return end
	
	for nID = 238, 240 do
		AddItem(4, nID, 1, 0,0,0)
	end
end

function PhucDuyen()
	if (CalcFreeItemCellCount() < 3) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 3 « trèng.")
	return end
	
	for nID = 122, 124 do
		AddItem(6,1, nID, 0,0,0)
	end
end

TAB_OPTION = {
	["Vò khÝ"] = {
		["KiÕm"] 			= {0,0,0},
		["§ao"] 				= {0,0,1},
		["Bæng"] 			= {0,0,2},
		["Th­¬ng"] 		= {0,0,3},
		["Chïy"] 			= {0,0,4},
		["Song §ao"] 	= {0,0,5},
		["Phi Tiªu"] 		= {0,1,0},
		["Phi §ao"] 		= {0,1,1},
		["Tô TiÔn"] 		= {0,1,2},
	},
	
	["Y Phôc"] = {
		["ThÊt B¶o Cµ Sa"] 						= {0,2,0},
		["Ch©n Vò Th¸nh Y"] 					= {0,2,1},
		["Thiªn NhÉn MËt Trang"] 		= {0,2,2},
		["Gi¸ng Sa Bµo"] 							= {0,2,3},
		["§­êng Nghª Gi¸p"] 					= {0,2,4},
		["V¹n L­u Quy T«ng Y"] 			= {0,2,5},
		["TuyÒn Long Bµo"] 					= {0,2,6},
		["Long Tiªu §¹o Y"] 					= {0,2,8},
		["Cöu VÜ B¹ch Hå Trang"] 		= {0,2,9},
		["TrÇm H­¬ng Sam"] 					= {0,2,10},
		["TÝch LÞch Kim Phông Gi¸p"] 	= {0,2,11},
		["V¹n Chóng TÒ T©m Y"] 			= {0,2,12},
		["L­u Tiªn QuÇn"] 						= {0,2,13},
	},
	
	["Nãn"] = {
		["Tú L« M·o"] 								=	{0,7,0},
		["Ngò L·o Qu¸n"] 						=	{0,7,1},
		["Tu La Ph¸t KÕt"] 						=	{0,7,2},
		["Th«ng Thiªn Ph¸t Qu¸n"] 		=	{0,7,3},
		["YÓm NhËt Kh«i"] 						=	{0,7,4},
		["TrÝch Tinh Hoµn"] 					=	{0,7,5},
		["¤ Tµm M·o"]								=	{0,7,6},
		["Quan ¢m Ph¸t Qu¸n"]				=	{0,7,7},
		["¢m D­¬ng V« Cùc Qu¸n"]		=	{0,7,8},
		["HuyÒn Tª DiÖn Tr¸o"]				=	{0,7,9},
		["Long HuyÕt §Çu Hoµn"]			=	{0,7,10},
		["Long L©n Kh«i"]						=	{0,7,11},
		["Thanh Tinh Thoa"] 					=	{0,7,12},
		["Kim Phông TriÓn SÝ"] 				=	{0,7,13},
	},
	
	["Hé UyÓn"] = {
		["Long Phông HuyÕt Ngäc Tr¹c"]		=	{0,8,0},
		["Thiªn Tµm Hé UyÓn"]						=	{0,8,1},
	},
	
	["Th¾t l­ng"] = {
		["Thiªn Tµm Yªu §¸i"]				=	{0,6,0},
		["B¹ch Kim Yªu §¸i"]					=	{0,6,1},
	},
	
	["Giµy"] = {
		["Cöu TiÕt X­¬ng VÜ Ngoa"]		=	{0,5,0},
		["Thiªn Tµm Ngoa"]					=	{0,5,1},
		["Kim Lò Hµi"]								=	{0,5,2},
		["Phi Phông Ngoa"]						=	{0,5,3},
	},
};

function AddEquipPurpleNoParam()
	if (CalcFreeItemCellCount() < 20) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 20 « trèng.")
	return end
	local tbEquip = TAB_OPTION;
	local szTitle = "Ng­¬i muèn nhËn lo¹i nµo?"
	local tbOption = {};
	for x, y in tbEquip do
		tinsert(tbOption, {format("%s", x), EquipPurpleConfirm,{tbEquip[x]}})
	end
		tinsert(tbOption, {"KÕt thóc ®èi tho¹i."})
	CreateNewSayEx(szTitle, tbOption)
end

function EquipPurpleConfirm(tbEquip)
	local szTitle = "Ng­¬i muèn nhËn lo¹i nµo?"
	local tbOption = {};
	for x, y in tbEquip do
		tinsert(tbOption, {format("%s", x), EquipPurpleOK,{tbEquip[x]}})
	end
		tinsert(tbOption, {"KÕt thóc ®èi tho¹i."})
	CreateNewSayEx(szTitle, tbOption)
end

function EquipPurpleOK(tbEquip)
	for i = 0, 4 do
		AddQualityItem(2,tbEquip[1], tbEquip[2], tbEquip[3], 10, i, 0, -1,-1,-1,-1,-1,-1)
	end
end
---=====| {"NhËn vËt phÈm hç trî", Itemhotro} - End |=====---
---=====| {"NhËn thó c­ìi", ThuCuoi} - Star |=====---
TAB_THUCUOI = {
	{szName="¤ V©n §¹p TuyÕt", tbProp={0,10,5,6,0,0}, nWidth=2, nHeight=3},
	{szName="XÝch Thè", tbProp={0,10,5,7,0,0}, nWidth=2, nHeight=3},
	{szName="TuyÖt ¶nh", tbProp={0,10,5,8,0,0}, nWidth=2, nHeight=3},
	{szName="§Ých L«", tbProp={0,10,5,9,0,0}, nWidth=2, nHeight=3},
	{szName="ChiÕu D¹ Ngäc S­ Tö", tbProp={0,10,5,10,0,0}, nWidth=2, nHeight=3},
	{szName="Phi V©n", tbProp={0,10,8,10,0,0}, nWidth=2, nHeight=3},
	{szName="B«n Tiªu", tbProp={0,10,6,10,0,0}, nWidth=2, nHeight=3},
	{szName="Phiªn Vò", tbProp={0,10,7,10,0,0}, nWidth=2, nHeight=3},
};

function ThuCuoi()
	local tbThuCuoi = TAB_THUCUOI;
	AddItemByTable("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>: Mêi b¹n chän tÝnh n¨ng thö nghiÖm.", tbThuCuoi)
end
---=====| {"NhËn thó c­ìi", ThuCuoi} - End |=====---
---=====| {"Häc kü n¨ng m«n ph¸i", HocKyNangMonPhai} - Star |=====---
-- skill mon phai 1x - 12x
TAB_SKILLALL =
{
	[1] = {
		tbSkillBase={14,10,8,4,6,15,16,20,271,11,19,273,21},
		tbSkill9x={318,319,321},
		tbSkill12x={709},
		--tbSkill15x= {1055,1056,1057},
	},
	
	[2] = {
		tbSkillBase={34,30,29,26,23,24,33,37,35,31,40,42,32,36,41,324},
		tbSkill9x={322,323,325},
		tbSkill12x={708},
		--tbSkill15x= {1058, 1059, 1060},
	},
	
	[3] = {
		tbSkillBase={45,43,347,303,50,54,47,343,345,349,249,48,58,341},
		tbSkill9x={339,302,342,351},
		tbSkill12x={710},
		--tbSkill15x= {1069, 1070, 1071},
	},
	
	[4] = {
		tbSkillBase={63,65,62,60,67,70,66,68,384,64,69,356,73,72,71,75,74},
		tbSkill9x={353,355,390},
		tbSkill12x={711},
		--tbSkill15x= {1066, 1067},
	},
	
	[5] = {
		tbSkillBase={85,80,77,79,93,385,82,89,86,92,88,252,91,282},
		tbSkill9x={328,380,332},
		tbSkill12x={712},
		--tbSkill15x= {1061, 1062, 1114},
	},
	
	[6] = {
		tbSkillBase={99,102,95,97,269,105,113,100,109,108,114,111},
		tbSkill9x={336,337},
		tbSkill12x={713},
		--tbSkill15x= {1063, 1065},
	},
	
	[7] = {
		tbSkillBase={122,119,116,115,129,274,124,277,128,125,130,360},
		tbSkill9x={357,359},
		tbSkill12x={714},
		--tbSkill15x= {1073, 1074},
	},
	
	[8] = {
		tbSkillBase={135,145,132,131,136,137,141,138,140,364,143,142,150,148},
		tbSkill9x={361,362,391},
		tbSkill12x={715},
		--tbSkill15x= {1075, 1076},
	},
	
	[9] = {
		tbSkillBase={153,155,152,151,159,164,158,160,157,165,166,267},
		tbSkill9x={365,368},
		tbSkill12x={716},
		--tbSkill15x= {1078, 1079},
	},
	
	[10] = {
		tbSkillBase={169,179,167,168,392,171,174,178,172,393,173,175,181,176,90,275,182,630},
		tbSkill9x={372,375,394},
		tbSkill12x={717},
		--tbSkill15x= {1080, 1081},
	},
}

function HocKyNangMonPhai()
	local nFaction = GetLastFactionNumber()+1
	if not (TAB_SKILLALL[nFaction]) then
		Talk(1,"","B¹n ch­a gia nhËp m«n ph¸i!")
	return end
	if (getn(TAB_SKILLALL[nFaction].tbSkillBase) > 0) then
		for i = 1, getn(TAB_SKILLALL[nFaction].tbSkillBase) do
			if (HaveMagic(TAB_SKILLALL[nFaction].tbSkillBase[i]) == -1) then
				AddMagic(TAB_SKILLALL[nFaction].tbSkillBase[i])
			end
		end
	end
	if (getn(TAB_SKILLALL[nFaction].tbSkill9x) > 0) then
		for i = 1, getn(TAB_SKILLALL[nFaction].tbSkill9x) do
			if (skillsupport(TAB_SKILLALL[nFaction].tbSkill9x[i]) == 1) then
				if (HaveMagic(TAB_SKILLALL[nFaction].tbSkill9x[i]) == -1) then
					AddMagic(TAB_SKILLALL[nFaction].tbSkill9x[i])
				end
			else
				if (HaveMagic(TAB_SKILLALL[nFaction].tbSkill9x[i]) == -1) then
					AddMagic(TAB_SKILLALL[nFaction].tbSkill9x[i], 20)
				end
			end
		end
	end
	if (getn(TAB_SKILLALL[nFaction].tbSkill12x) > 0) then
		for i = 1, getn(TAB_SKILLALL[nFaction].tbSkill12x) do
			if (HaveMagic(TAB_SKILLALL[nFaction].tbSkill12x[i]) == -1) then
				AddMagic(TAB_SKILLALL[nFaction].tbSkill12x[i],20)
			end
		end
	end

end

function skillsupport(nSkillID)
	local tbSkills = {351,390,332,391,394}
	for i = 1, getn(tbSkills) do
		if nSkillID == tbSkills[i] then
		return 1 end
	end
return 0 end

---=====| {"Häc kü n¨ng m«n ph¸i", HocKyNangMonPhai} - End |=====---
---=====| {"TÈy tñy nhanh", TayTuyNhanh} - Star |=====---
function TayTuyNhanh()
	local tbSay = {"Ng­¬i muèn tÈy tñy lo¹i g× ®©y?"}
		tinsert(tbSay, "T¨ng ®iÓm nhanh/tangdiemnhanh")
		tinsert(tbSay, "TÈy ®iÓm kü n¨ng/taydiemkynang")
		tinsert(tbSay, "TÈy ®iÓm tiÒm n¨ng/taydiemtiemnang")
		tinsert(tbSay, "KÕt thóc ®èi tho¹i./OnCancel")
	CreateTaskSay(tbSay)
end

function taydiemkynang()
	Say("Ng­¬i ®ång ý TÈy ®iÓm kü n¨ng kh«ng?", 2, "TÈy ®iÓm kü n¨ng /taydiemkynangok","Kh«ng tÈy /OnCancel")
end

function taydiemkynangok()
	i = HaveMagic(210)
	j = HaveMagic(400)
	n = RollbackSkill()
	x = 0
	if (i ~= -1) then x = x + i end
	if (j ~= -1) then x = x + j end
	rollback_point = n - x
	if (rollback_point + GetMagicPoint() < 0) then
		rollback_point = -1 * GetMagicPoint()
	end
	AddMagicPoint(rollback_point)
	if (i ~= -1) then AddMagic(210,i) end
	if (j ~= -1) then AddMagic(400,j) end
	Msg2Player("TÈy Tñy thµnh c«ng! ng­¬i ®· cã thÓ ph©n phèi "..rollback_point.." ®iÓm. ")
	Talk(1,"KickOutSelf","TÈy Tñy thµnh c«ng! ng­¬i ®· cã thÓ ph©n phèi "..rollback_point.." ®iÓm.")
end

function taydiemtiemnang()
	Say("Ng­¬i ®ång ý tÈy ®iÓm tiÒm n¨ng kh«ng?", 2, "TÈy ®iÓm tiÒm n¨ng/taydiemtiemnangok", "Kh«ng tÈy /OnCancel")
end

function taydiemtiemnangok()
	base_str = {35,20,25,30,20}
	base_dex = {25,35,25,20,15}
	base_vit = {25,20,25,30,25}
	base_eng = {15,25,25,20,40}
	player_series = GetSeries() + 1
	Utask88 = GetTask(88)
	AddStrg(base_str[player_series] - GetStrg(1) + GetByte(Utask88,1))
	AddDex(base_dex[player_series] - GetDex(1) + GetByte(Utask88,2))
	AddVit(base_vit[player_series] - GetVit(1) + GetByte(Utask88,3))
	AddEng(base_eng[player_series] - GetEng(1) + GetByte(Utask88,4))
end

function tangdiemnhanh()
	Say("ThÝch Minh: Ng­¬i muèn t¨ng ®iÓm kü n¨ng nµo?", 4,
		"T¨ng Søc M¹nh/add_prop_str",
		"T¨ng Th©n Ph¸p/add_prop_dex",
		"T¨ng Ngo¹i C«ng/add_prop_vit",
		"T¨ng Néi C«ng/add_prop_eng")
end

function add_prop_str()
	AskClientForNumber("enter_str_num", 0, GetProp(), "Xin h·y nhËp ®iÓm sè søc m¹nh: ");
end

function add_prop_dex()
	AskClientForNumber("enter_dex_num", 0, GetProp(), "Xin h·y nhËp ®iÓm sè th©n ph¸p: ");
end

function add_prop_vit()
	AskClientForNumber("enter_vit_num", 0, GetProp(), "Xin h·y nhËp ®iÓm sè ngo¹i c«ng:");
end

function add_prop_eng()
	AskClientForNumber("enter_eng_num", 0, GetProp(), "Xin h·y nhËp ®iÓm sè néi c«ng: ");
end

function enter_str_num(n_key)
	if (n_key < 0 or n_key > GetProp()) then
		return
	end
	AddStrg(n_key);
end

function enter_dex_num(n_key)
	if (n_key < 0 or n_key > GetProp()) then
		return
	end
	AddDex(n_key);
end

function enter_vit_num(n_key)
	if (n_key < 0 or n_key > GetProp()) then
		return
	end
	AddVit(n_key);
end

function enter_eng_num(n_key)
	if (n_key < 0 or n_key > GetProp()) then
		return
	end
	AddEng(n_key);
end
function OnCancel()
end;
---=====| {"TÈy tñy nhanh", TayTuyNhanh} - Star |=====---
---=====| {"Hñy bá mäi thø", TayTuyNhanh} - Star |=====---
function deltem()
	if (GetBoxLockState() ~= 0) then
		Say("Xin më khãa r­¬ng tr­íc !", 0)
		return
	end
	GiveItemUI("Hñy vËt phÈm", "§¹i hiÖp h·y cÈn träng trong viÖc hñy vËt phÈm!", "DisposeConfirm", "onCancel", 1);
end

function DisposeConfirm(nCount)	

	for i=1, nCount do
		local nItemIndex = GetGiveItemUnit(i)
		local strItem = GetItemName(nItemIndex)
		local nQuality = GetItemQuality(nItemIndex);
		local nBindState = GetItemBindState(nItemIndex)
	--if (nBindState >=0)  then
	--	Talk(1, "", "VËt phÈm cÇn hñy ph¶i lµ vËt phÈm khãa!");
	--	return
	--end
		--SaveLog(nItemIndex)
		RemoveItemByIndex(nItemIndex)
		WriteLog(date("%Y%m%d %H%M%S").."\t".." GM Hñy Item "..GetAccount().."\t"..GetName().."\t".." Huû item "..strItem)
	end--for
	Talk(1, "", "§¹i hiÖp cã thÓ s¾p xÕp l¹i r­¬ng chøa ®å råi!");
	Msg2Player("§¹i hiÖp võa hñy vËt phÈm thµnh c«ng")
end
---=====| {"Hñy bá mäi thø", TayTuyNhanh} - End |=====---


--===== Hç trî Item Event =====---
function itemEvent()
	local tbOpt =
	{
		{"Event Sinh NhËt Vâ L©m TruyÒn Kú", EventSNVLTK},
		{"Event TÕt Nguyªn §¸n", EventTetNguyenDan},
		{"Event Gi¸ng Sinh", EventNoel},
		{"Event Trung Thu", EventTrungThu},
		{"Event Quèc Kh¸nh", EventQuocKhanh},
		{"Event §æi MËt §å ThÇn BÝ 2007", EventMDTB2007},
		{"Event NÊu B¸nh Ch­ng mïng 3 th¸ng 3 n¨m 2007", EventNauBanh2007},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>§©y lµ danh s¸ch c¸c Event ngµy x­a ®­îc më l¹i!", tbOpt)
end

--===== Bat dau Event Nau Banh Chung mung 3 thang 3 nam 2007 =====--
function EventNauBanh2007()
	local tbOpt =
	{
		{"10 bé nguyªn liÖu", NLEventNauBanh2007},
		{"05 Nguyªn LiÖu lµm b¸nh", TPEventNauBanh2007},
		{"05 B¸nh Chay c¸c lo¹i", TPEventNauBanh2007BanhChay},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event nÊu b¸nh ch­ng mïng 3 th¸ng 3 n¨m 2007 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function NLEventNauBanh2007()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 200 do
		AddItem(6,1,1393,1,0,0,0)
	end
	Earn(1000000);
end
function TPEventNauBanh2007()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,1394,1,0,0,0)
	end
end
function TPEventNauBanh2007BanhChay()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,1395,1,0,0,0)
		AddItem(6,1,1396,1,0,0,0)
		AddItem(6,1,1397,1,0,0,0)
	end
end

--===== Bat dau Event Doi Mat Do Than Bi 2007 =====--
function EventMDTB2007()
	local tbOpt =
	{
		{"10 bé nguyªn liÖu", NLEventMDTB2007},
		{"05 R­¬ng B¹c, R­¬ng Vµng", TPEventMDTB2007},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event §æi MËt §å ThÇn BÝ 2007 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function NLEventMDTB2007()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 200 do
		AddItem(6,1,196,1,0,0,0)
	end

	for i = 1, 10 do
		AddItem(6,1,1376,1,0,0,0)
	end
end

function TPEventMDTB2007()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,1377,1,0,0,0)
		AddItem(6,1,1378,1,0,0,0)
	end
end

--===== Bat dau Event Quoc Khanh =====--
function EventQuocKhanh()
	local tbOpt =
	{
		{"Chµo Mõng Quèc Kh¸nh 2007", EventQuocKhanh2007},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>§©y lµ tæng hîp c¸c <color=yellow>Event Quèc Kh¸nh<enter>chuÈn VNG<color> ®­îc më l¹i, mêi b¹n tr·i nghiÖm!", tbOpt)
end

-- Quoc Khanh 2007
function EventQuocKhanh2007()
	local tbOpt =
	{
		{"10 bé nguyªn liÖu", NLEventQuocKhanh2007},
		{"10 Hép Quµ Quèc Kh¸nh", TPEventQuocKhanh2007},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Mõng Quèc Kh¸nh 2007 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end
function NLEventQuocKhanh2007()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 100 do
		AddItem(6,1,1494,1,0,0,0)
	end
	Earn(1500000);
end
function TPEventQuocKhanh2007()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 10 do
		AddItem(6,1,1495,1,0,0,0)
	end
end

--===== Bat dau Event Sinh Nhat Vo Lam =====--
function EventSNVLTK()
	local tbOpt =
	{
		{"Mõng Sinh NhËt Vâ L©m 1 Tuæi", EventSinhNhat1Tuoi},
		{"Mõng Sinh NhËt Vâ L©m 2 Tuæi", EventSinhNhat2Tuoi},
		{"Mõng Sinh NhËt Vâ L©m 3 Tuæi", EventSinhNhat3Tuoi},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>§©y lµ tæng hîp c¸c <color=yellow>Event Sinh NhËt Vâ L©m TruyÒn Kú<enter>chuÈn VNG<color> ®­îc më l¹i, mêi b¹n tr·i nghiÖm!", tbOpt)
end

-- SNVLTK 3 Tuoi
function EventSinhNhat3Tuoi()
	local tbOpt =
	{
		{"10 bé phÇn th­êng 1", NLEventSinhNhat3TuoiItem1},
		{"10 bé phÇn th­êng 2", NLEventSinhNhat3TuoiItem2},
		{"10 bé phÇn th­êng 3", NLEventSinhNhat3TuoiItem3},
		{"10 B¸nh Kem Nh­ ý, C¸t T­êng", NLEventSinhNhat3TuoiItemBanhKem},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Mõng Sinh NhËt Vâ L©m TruyÒn Kú 3 Tuæi nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function NLEventSinhNhat3TuoiItem1()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 10 do
		AddItem(6,1,1756,1,0,0,0)
		AddItem(6,1,1757,1,0,0,0)
		AddItem(6,1,1758,1,0,0,0)
		AddItem(6,1,1759,1,0,0,0)
	end
	Earn(300000);
end

function NLEventSinhNhat3TuoiItem2()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 30 do
		AddItem(6,1,1752,1,0,0,0)
		AddItem(6,1,1753,1,0,0,0)
		AddItem(6,1,1754,1,0,0,0)
		AddItem(6,1,1755,1,0,0,0)
	end
	Earn(1000000);
end

function NLEventSinhNhat3TuoiItem3()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end
	
	for i = 1, 30 do
		AddItem(6,1,1752,1,0,0,0)
		AddItem(6,1,1753,1,0,0,0)
		AddItem(6,1,1754,1,0,0,0)
		AddItem(6,1,1755,1,0,0,0)
	end

	for i = 1, 10 do
		AddItem(6,1,1760,1,0,0,0)
	end
end

function NLEventSinhNhat3TuoiItemBanhKem()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end
	
	for i = 1, 10 do
		AddItem(6,1,1761,1,0,0,0)
		AddItem(6,1,1762,1,0,0,0)
	end
end

-- SNVLTK 2 Tuoi
function EventSinhNhat2Tuoi()
	local tbOpt =
	{
		{"10 bé Nguyªn LiÖu", NLEventSinhNhat2TuoiItem10},
		{"10 Thµnh PhÈm", TPEventSinhNhat2TuoiItem10},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Mõng Sinh NhËt Vâ L©m TruyÒn Kú 2 Tuæi nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventSinhNhat2TuoiItem10()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 10 do
		AddItem(6,1,1439,1,0,0,0)
		AddItem(6,1,1440,1,0,0,0)
		AddItem(6,1,1441,1,0,0,0)
	end
end

function NLEventSinhNhat2TuoiItem10()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng.")
	return end

	for i = 1, 10 do
		AddItem(6,1,1436,1,0,0,0)
		AddItem(6,1,1437,1,0,0,0)
	end

	for i = 1, 300 do
		AddItem(6,1,1438,1,0,0,0)
	end
end

-- SNVLTK 1 Tuoi
function EventSinhNhat1Tuoi()
	local tbOpt =
	{
		{"10 bé Nguyªn LiÖu", NLEventSinhNhat1TuoiItem10},
		{"10 Thµnh PhÈm", TPEventSinhNhat1TuoiItem10},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Mõng Sinh NhËt Vâ L©m TruyÒn Kú 1 Tuæi nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function NLEventSinhNhat1TuoiItem10()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,2 do
		AddStackItem(10,4,975,1,1,0,0,0)
		AddStackItem(50,4,976,1,1,0,0,0)
		AddStackItem(50,4,977,1,1,0,0,0)
		AddStackItem(10,4,978,1,1,0,0,0)
	end
end;

function TPEventSinhNhat1TuoiItem10()
	if (CalcFreeItemCellCount() < 20) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 20 « trèng.")
	return end

	for i = 1, 10 do
		AddItem(6,1,1100,1,0,0,0)
		AddItem(6,1,1101,1,0,0,0)
	end
end

--===== Bat dau Event Trung Thu =====--
function EventTrungThu()
	local tbOpt =
	{
		{"Trung Thu 2005", EventTrungThu2005},
		{"Trung Thu 2006", EventTrungThu2006},
		{"Trung Thu 2007", EventTrungThu2007},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>§©y lµ tæng hîp c¸c <color=yellow>Event Trung Thu Vâ L©m TruyÒn Kú<enter>chuÈn VNG<color> ®­îc më l¹i, mêi b¹n tr·i nghiÖm!", tbOpt)
end

-- Event Trung Thu 2007
function EventTrungThu2007()
	local tbOpt =
	{
		{"Nguyªn liÖu lµm b¸nh Trung Thu", NLEventTrungThu2007},
		{"B¸nh trung thu", TPEventTrungThu2007},
		{"Hai bé tranh H»ng Nga Tiªn Tö", NLEventTrungThu2006Pic},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Trung Thu 2006 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventTrungThu2007()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,1510,1,0,0,0)
		AddItem(6,1,1511,1,0,0,0)
		AddItem(6,1,1512,1,0,0,0)
		AddItem(6,1,1513,1,0,0,0)
		AddItem(6,1,1514,1,0,0,0)
	end
end

function NLEventTrungThu2007()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng.")
	return end

	for i = 1, 11 do
		AddItem(6,1,1503,1,0,0,0)	--Tói bét
		AddItem(6,1,1504,1,0,0,0)	--Tói ®­êng
		AddItem(6,1,1505,1,0,0,0)	--Tói trøng
	end

	for i = 1, 1 do
		AddItem(6,1,1506,1,0,0,0)	--Tói ®Ëu xanh
		AddItem(6,1,1507,1,0,0,0)	--Tói h¹t sen
		AddItem(6,1,1508,1,0,0,0)	--Tói thÞt gµ
		AddItem(6,1,1509,1,0,0,0)	--Tói thÞt heo
	end

	Earn(800000);
end

-- Event Trung Thu 2006
function EventTrungThu2006()
	local tbOpt =
	{
		{"5 bé Nguyªn liÖu ghÐp lång ®Ìn", NLEventTrungThu2006},
		{"5 Lång §Ìn c¸c lo¹i", TPEventTrungThu2006LD},
		{"5 b¸nh Trung Thu c¸c lo¹i", TPEventTrungThu2006Banh},
		{"100 Lång §Ìn KÐo Qu©n (®Æc biÖt)", TPEventTrungThu2006LDKQ},
		{"Hai bé tranh H»ng Nga Tiªn Tö", NLEventTrungThu2006Pic},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Trung Thu 2006 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventTrungThu2006LDKQ()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng.")
	return end

	for i = 1, 100 do
		AddItem(6,1,1234,1,0,0,0)
	end
end
function NLEventTrungThu2006Pic()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng.")
	return end

	for i = 1, 1 do
		AddItem(6,1,1207,1,0,0,0)
		AddItem(6,1,1208,1,0,0,0)
		AddItem(6,1,1209,1,0,0,0)
		AddItem(6,1,1210,1,0,0,0)
		AddItem(6,1,1211,1,0,0,0)
		AddItem(6,1,1212,1,0,0,0)
		AddItem(6,1,1213,1,0,0,0)
		AddItem(6,1,1214,1,0,0,0)
		AddItem(6,1,1215,1,0,0,0)
		AddItem(6,1,1216,1,0,0,0)
		AddItem(6,1,1217,1,0,0,0)
		AddItem(6,1,1218,1,0,0,0)
	end
end
function TPEventTrungThu2006Banh()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,1235,1,0,0,0)
		AddItem(6,1,1236,1,0,0,0)
		AddItem(6,1,1237,1,0,0,0)
		AddItem(6,1,1238,1,0,0,0)
		AddItem(6,1,1239,1,0,0,0)
		AddItem(6,1,1240,1,0,0,0)
	end
end
function TPEventTrungThu2006LD()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,1229,1,0,0,0)
		AddItem(6,1,1230,1,0,0,0)
		AddItem(6,1,1231,1,0,0,0)
		AddItem(6,1,1232,1,0,0,0)
		AddItem(6,1,1233,1,0,0,0)
		AddItem(6,1,1234,1,0,0,0)

		AddItem(6,1,1241,1,0,0,0)
		AddItem(6,1,1242,1,0,0,0)
		AddItem(6,1,1243,1,0,0,0)
		AddItem(6,1,1244,1,0,0,0)
		AddItem(6,1,1245,1,0,0,0)
		AddItem(6,1,1246,1,0,0,0)
	end
end
function NLEventTrungThu2006()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,1226,1,0,0,0)
		AddItem(6,1,1227,1,0,0,0)
		AddItem(6,1,1228,1,0,0,0)
		AddItem(6,1,1225,1,0,0,0)
	end

	for i = 1, 10 do
		AddItem(6,1,1221,1,0,0,0)
		AddItem(6,1,1224,1,0,0,0)
		AddItem(6,1,1223,1,0,0,0)
		AddItem(6,1,1222,1,0,0,0)
	end

	for i = 1, 5 do
		AddItem(6,1,1221,1,0,0,0)
		AddItem(6,1,1222,1,0,0,0)
		AddItem(6,1,1223,1,0,0,0)
		AddItem(6,1,1224,1,0,0,0)
		AddItem(6,1,1225,1,0,0,0)
		AddItem(6,1,1226,1,0,0,0)
		AddItem(6,1,1227,1,0,0,0)
		AddItem(6,1,1228,1,0,0,0)
	end

	Earn(100000);
end

-- Event Trung Thu 2005
function EventTrungThu2005()
	local tbOpt =
	{
		{"Nguyªn liÖu 05 B¸nh Trung Thu §Ëu Xanh", NLEventTrungThu2005DauXanh},
		{"Nguyªn liÖu 05 B¸nh Trung Thu Bét Sen", NLEventTrungThu2005BotSen},
		{"Nguyªn liÖu 05 B¸nh Trung Thu §Ëu Trøng", NLEventTrungThu2005DauTrung},
		{"Nguyªn liÖu 05 B¸nh Trung Thu Sen Trøng", NLEventTrungThu2005SenTrung},
		{"Nguyªn liÖu 05 B¸nh Trung Thu H¹nh nh©n", NLEventTrungThu2005HanhNhan},
		{"Nguyªn liÖu 05 B¸nh Trung Thu ThËp CÈm", NLEventTrungThu2005ThapCam},
		{"05 B¸nh Trung Thu C¸c Lo¹i", TPEventTrungThu2005},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Trung Thu 2005 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventTrungThu2005()
	if (CalcFreeItemCellCount() < 40) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 40 « trèng.")
	return end

	for i = 1, 5 do
		AddItem(6,1,890,1,0,0,0)
		AddItem(6,1,891,1,0,0,0)
		AddItem(6,1,892,1,0,0,0)
		AddItem(6,1,893,1,0,0,0)
		AddItem(6,1,894,1,0,0,0)
		AddItem(6,1,895,1,0,0,0)
		AddItem(6,1,896,1,0,0,0)
	end
end
function NLEventTrungThu2005ThapCam()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddStackItem(4,4,520,1,1,0,0,0)	--Bét m×
		AddStackItem(4,4,521,1,1,0,0,0)	--§­êng c¸t
		AddStackItem(1,4,524,1,1,0,0,0)	--§Ëu xanh
		AddStackItem(1,4,523,1,1,0,0,0)	--Bét sen
		AddStackItem(1,4,525,1,1,0,0,0)	--H¹nh nh©n
		AddStackItem(1,4,526,1,1,0,0,0)	--§Ëu phéng
		AddStackItem(3,4,527,1,1,0,0,0)	--§Ëu phéng
	end
end;
function NLEventTrungThu2005HanhNhan()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddStackItem(6,4,520,1,1,0,0,0)	--Bét m×
		AddStackItem(6,4,521,1,1,0,0,0)	--§­êng c¸t
		AddStackItem(1,4,525,1,1,0,0,0)	--H¹nh nh©n
		AddStackItem(2,4,526,1,1,0,0,0)	--§Ëu phéng
	end
end;
function NLEventTrungThu2005SenTrung()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddStackItem(5,4,520,1,1,0,0,0)	--Bét m×
		AddStackItem(6,4,521,1,1,0,0,0)	--§­êng c¸t
		AddStackItem(2,4,523,1,1,0,0,0)	--Bét sen
		AddStackItem(2,4,522,1,1,0,0,0)	--Trøng
	end
end;
function NLEventTrungThu2005DauXanh()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddStackItem(8,4,520,1,1,0,0,0)	--Bét m×
		AddStackItem(5,4,521,1,1,0,0,0)	--§­êng c¸t
		AddStackItem(2,4,524,1,1,0,0,0)	--§Ëu xanh
	end
end;
function NLEventTrungThu2005BotSen()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddStackItem(5,4,520,1,1,0,0,0)	--Bét m×
		AddStackItem(8,4,521,1,1,0,0,0)	--§­êng c¸t
		AddStackItem(2,4,523,1,1,0,0,0)	--Bét sen
	end
end;
function NLEventTrungThu2005DauTrung()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddStackItem(6,4,520,1,1,0,0,0)	--Bét m×
		AddStackItem(5,4,521,1,1,0,0,0)	--§­êng c¸t
		AddStackItem(2,4,524,1,1,0,0,0)	--§Ëu xanh
		AddStackItem(2,4,522,1,1,0,0,0)	--Trøng
	end
end;

--===== Bat dau Event Giang Sinh =====--
function EventNoel()
	local tbOpt =
	{
		{"Gi¸ng Sinh 2006", EventNoel2006},
		{"Gi¸ng Sinh 2007", EventNoel2007},
		{"Gi¸ng Sinh 2008", EventNoel2008},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>§©y lµ tæng hîp c¸c <color=yellow>Event Gi¸ng Sinh Vâ L©m TruyÒn Kú<enter>chuÈn VNG<color> ®­îc më l¹i, mêi b¹n tr·i nghiÖm!", tbOpt)
end

-- Event Giang Sinh 2008
function EventNoel2008()
	local tbOpt =
	{
		{"Nguyªn liÖu ®æi B¸nh Kem", NLEventNoel2008},
		{"B¸nh Kem", TPEventNoel2008},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Gi¸ng Sinh 2008 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventNoel2008()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddItem(6,1,1848,1,0,0,0)	--B¸nh Kem D©u
		AddItem(6,1,1849,1,0,0,0)	--B¸nh Kem Socola
	end
end;
function NLEventNoel2008()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,4 do
		AddItem(6,1,1843,1,0,0,0)	--NÕn Gi¸ng Sinh
		AddItem(6,1,1844,1,0,0,0)	--Chu«ng Gi¸ng Sinh
		AddItem(6,1,1845,1,0,0,0)	--Ví Gi¸ng Sinh
		AddItem(6,1,1846,1,0,0,0)	--ThiÖp Gi¸ng Sinh
	end
	for i = 1,6 do
		AddItem(6,1,1835,1,0,0,0)	--Phóc Duyªn Tinh Th¹ch
	end
	for i = 1,3 do
		AddItem(6,1,1847,1,0,0,0)	--Ng«i Sao Gi¸ng Sinh
	end
	Earn(40000);
end;

-- Event Giang Sinh 2006
function EventNoel2006()
	local tbOpt =
	{
		{"Nguyªn liÖu lµm ng­êi tuyÕt", NLEventNoel2006},
		{"Ng­êi tuyÕt", TPEventNoel2006NguoiTuyet},
		{"H¹t Gi¸ng Sinh", TPEventNoelHatGiangSinh},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Gi¸ng Sinh 2006 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventNoelHatGiangSinh()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,1 do
		AddItem(6,1,1005,1,0,0,0)
		AddItem(6,1,1006,1,0,0,0)
		AddItem(6,1,1007,1,0,0,0)
		AddItem(6,1,1008,1,0,0,0)
	end
end;
function TPEventNoel2006NguoiTuyet()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddItem(6,1,1319,1,0,0,0)
		AddItem(6,1,1320,1,0,0,0)
		AddItem(6,1,1321,1,0,0,0)
		AddItem(6,1,1322,1,0,0,0)
		AddItem(6,1,1323,1,0,0,0)
		AddItem(6,1,1324,1,0,0,0)
	end
end;
function NLEventNoel2006()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,30 do
		AddItem(6,1,1312,1,0,0,0)	--Hoa TuyÕt
	end
	for i = 1,3 do
		AddItem(6,1,1313,1,0,0,0)	--Cµ rèt
		AddItem(6,1,1315,1,0,0,0)	--Nãn gi¸ng sinh
	end
	for i = 1,6 do
		AddItem(6,1,1314,1,0,0,0)	--Cµnh th«ng
	end
	for i = 1,1 do
		AddItem(6,1,1316,1,0,0,0)	--Kh¨n choµng xanh
		AddItem(6,1,1317,1,0,0,0)	--Kh¨n choµng ®á
		AddItem(6,1,1318,1,0,0,0)	--C©y th«ng
	end
	Earn(9000);
end;

-- Event Giang Sinh 2007
function EventNoel2007()
	local tbOpt =
	{
		{"Nguyªn liÖu t¹o ng­êi tuyÕt", NLEventNoel2007},
		{"TuyÕt Nh©n", TPEventNoel2007TuyetNhan},
		{"KÑo Gi¸ng Sinh", TPEventNoel2007KeoGiangSinh},
		{"H¹t Gi¸ng Sinh", TPEventNoelHatGiangSinh},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Gi¸ng Sinh 2007 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventNoel2007KeoGiangSinh()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddItem(6,1,1622,1,0,0,0)
		AddItem(6,1,1623,1,0,0,0)
		AddItem(6,1,1624,1,0,0,0)
		AddItem(6,1,1625,1,0,0,0)
		AddItem(6,1,1626,1,0,0,0)
	end
end;
function TPEventNoel2007TuyetNhan()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddItem(6,1,1634,1,0,0,0)
		AddItem(6,1,1635,1,0,0,0)
		AddItem(6,1,1636,1,0,0,0)
	end
end;
function NLEventNoel2007()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,6 do
		AddItem(6,1,1628,1,0,0,0)	--kim
	end
	for i = 1,9 do
		AddItem(6,1,1629,1,0,0,0)	--méc
	end
	for i = 1,12 do
		AddItem(6,1,1630,1,0,0,0)	--thñy
	end
	for i = 1,15 do
		AddItem(6,1,1631,1,0,0,0)	--háa
	end
	for i = 1,18 do
		AddItem(6,1,1632,1,0,0,0)	--thæ
	end
	for i = 1,1 do
		AddItem(6,1,1633,1,0,0,0)	--ngò s¾c
	end
	Earn(100000);
end;

--===== Bat dau Event Tet Nguyen Dan =====--
function EventTetNguyenDan()
	local tbOpt =
	{
		{"TÕt Nguyªn §¸n 2007", EventTetNguyenDan2007},
		{"TÕt Nguyªn §¸n 2008", EventTetNguyenDan2008},
		{"TÕt Nguyªn §¸n 2009", EventTetNguyenDan2009},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event TÕt Nguyªn §¸n nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

-- Event Tet Nguyen Dan 2009
function EventTetNguyenDan2009()
	local tbOpt =
	{
		{"Nguyªn liÖu ®æi Hång Bao", NLEventTetNguyenDan2009},
		{"M©m ngò qu¶", NLEventTetNguyenDan2009MNQ},
		{"Hång Bao", TPEventTetNguyenDan2009},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Gi¸ng Sinh 2009 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventTetNguyenDan2009()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,1 do
		AddItem(6,1,1892,1,0,0,0)
		AddItem(6,1,1893,1,0,0,0)
	end
end;
function NLEventTetNguyenDan2009MNQ()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,1 do
		AddItem(6,1,1887,1,0,0,0)
		AddItem(6,1,1888,1,0,0,0)
		AddItem(6,1,1889,1,0,0,0)
	end

	for i = 1,2 do
		AddItem(6,1,1886,1,0,0,0)
	end

	for i = 1,3 do
		AddItem(6,1,1890,1,0,0,0)
	end
end;
function NLEventTetNguyenDan2009()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,5 do
		AddItem(6,1,1912,1,0,0,0)
		AddItem(6,1,1913,1,0,0,0)
		AddItem(6,1,1914,1,0,0,0)
	end

	for i = 1,1 do
		AddItem(6,1,1891,1,0,0,0)
	end

	Earn(80000);
end;

-- Event Tet Nguyen Dan 2008
function EventTetNguyenDan2008()
	local tbOpt =
	{
		{"Nguyªn liÖu lµm B¸nh ch­ng", NLEventTetNguyenDan2008},
		{"B¸nh Ch­ng", TPEventTetNguyenDan2008},
		{"Treo LiÔn", TPEventTetNguyenDan2008PLT},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Gi¸ng Sinh 2008 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventTetNguyenDan2008PLT()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,1 do
		AddItem(6,1,1657,1,0,0,0)
		AddItem(6,1,1658,1,0,0,0)
		AddItem(6,1,1659,1,0,0,0)
	end
end;
function TPEventTetNguyenDan2008()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,1 do
		AddItem(6,1,1662,1,0,0,0)
		AddItem(6,1,1663,1,0,0,0)
		AddItem(6,1,1664,1,0,0,0)
	end
end;
function NLEventTetNguyenDan2008()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,1 do
		AddItem(6,1,1660,1,0,0,0)	--BÝ quyÕt lµm b¸nh ch­ng th­îng h¹ng
		AddItem(6,1,1661,1,0,0,0)	--BÝ quyÕt lµm b¸nh ch­ng h¶o h¹ng
	end

	for i = 1,12 do
		AddItem(6,1,1653,1,0,0,0)	--L¸ b¸nh
	end

	for i = 1,9 do
		AddItem(6,1,1654,1,0,0,0)	--G¹o nÕp
	end

	for i = 1,6 do
		AddItem(6,1,1655,1,0,0,0)	--§Ëu xanh
	end

	for i = 1,3 do
		AddItem(6,1,1656,1,0,0,0)	--ThÞt heo
	end

	Earn(20000);
end;

-- Event Tet Nguyen Dan 2007
function EventTetNguyenDan2007()
	local tbOpt =
	{
		{"Nguyªn liÖu lµm phong ph¸o", NLEventTetNguyenDan2007},
		{"Phong Ph¸o", TPEventTetNguyenDan2007},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Mêi b¹n tham gia tr¶i nghiÖm Event Gi¸ng Sinh 2007 nguyªn gèc VinaGame ngµy x­a ®­îc m×nh më l¹i!", tbOpt)
end

function TPEventTetNguyenDan2007()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,1 do
		AddItem(6,1,1354,1,0,0,0)
		AddItem(6,1,1357,1,0,0,0)
		AddItem(6,1,1355,1,0,0,0)
		AddItem(6,1,1358,1,0,0,0)
		AddItem(6,1,1356,1,0,0,0)
		AddItem(6,1,1359,1,0,0,0)
	end
end;
function NLEventTetNguyenDan2007()
	if (CalcFreeItemCellCount() < 50) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 50 « trèng ®Ó nhËn.")
	return end

	for i = 1,10 do
		AddItem(6,1,1351,1,0,0,0)	--Ph¸o tiÓu
	end
	for i = 1,12 do
		AddItem(6,1,1352,1,0,0,0)	--Ph¸o trung
	end
	for i = 1,102 do
		AddItem(6,1,1353,1,0,0,0)	--Ph¸o ®¹i
	end
	Earn(9000);
end;

--===== Shop Event =====---
function ShopEventDL()
	local tbOpt =
	{
		{"Event N¨m 2005", EventVNG2005},
		{"Event N¨m 2006", EventVNG2006},
		{"Event N¨m 2007", EventVNG2007},
		{"Event N¨m 2008", EventVNG2008},
		{"Event N¨m 2009", EventVNG2009},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>T¹i ®©y cã b¸n nguyªn liÖu Event ®ång gi¸ 1 v¹n l­îng.<enter>§Ó gióp c¸c b¹n tr·i nghiÖm nhÑ nhµng h¬n nªn m×nh sÏ b¸n 1 lÇn 100 hép, 200 hép, 500 hép!!!", tbOpt)
end

--===== Bat dau ban nguyen lieu Event nam 2009 =====--
function EventVNG2009()
	local tbOpt =
	{
		{"TÕt Nguyªn §¸n 2009", EventVNG2009TND},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event n¨m 2009 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2009TND()
	local tbOpt =
	{
		{"Mua 100 Lam B¶o R­¬ng (100v)", EventVNG2009TND100L},
		{"Mua 200 Lam B¶o R­¬ng (200v)", EventVNG2009TND200L},
		{"Mua 100 Hång B¶o R­¬ng (100v)", EventVNG2009TND100H},
		{"Mua 200 Hång B¶o R­¬ng (200v)", EventVNG2009TND200H},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event TÕt Nguyªn §¸n n¨m 2009 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2009TND100H()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hång B¶o R­¬ng", tbProp={6,1,1885,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hång B¶o R­¬ng", 1)

end
function EventVNG2009TND200H()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hång B¶o R­¬ng", tbProp={6,1,1885,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hång B¶o R­¬ng", 1)

end
function EventVNG2009TND100L()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Lam B¶o R­¬ng", tbProp={6,1,1884,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Lam B¶o R­¬ng", 1)

end
function EventVNG2009TND200L()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Lam B¶o R­¬ng", tbProp={6,1,1884,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Lam B¶o R­¬ng", 1)

end
--===== Bat dau ban nguyen lieu Event nam 2008 =====--
function EventVNG2008()
	local tbOpt =
	{
		{"Sinh NhËt VLTK 3 Tuæi", EventVNG2008SNVLTK},
		{"TÕt Nguyªn §¸n 2008", EventVNG2008TND},
		{"Gi¸ng Sinh 2008", EventVNG2008Noel},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event n¨m 2008 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2008Noel()
	local tbOpt =
	{
		{"Mua 100 Hép Quµ Xanh (100v)", EventVNG2008Noel100Xanh},
		{"Mua 200 Hép Quµ Xanh (200v)", EventVNG2008Noel200Xanh},
		{"Mua 100 Hép Quµ §á (100v)", EventVNG2008Noel100Do},
		{"Mua 200 Hép Quµ §á (200v)", EventVNG2008Noel200Do},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Gi¸ng Sinh n¨m 2008 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2008Noel200Do()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hép Quµ §á", tbProp={6,1,1842,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép Quµ §á", 1)

end
function EventVNG2008Noel100Do()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hép Quµ §á", tbProp={6,1,1842,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép Quµ §á", 1)

end
function EventVNG2008Noel200Xanh()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hép Quµ Xanh", tbProp={6,1,1841,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép Quµ Xanh", 1)

end
function EventVNG2008Noel100Xanh()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hép Quµ Xanh", tbProp={6,1,1841,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép Quµ Xanh", 1)

end
function EventVNG2008TND()
	local tbOpt =
	{
		{"Mua 100 Tói mong xu©n (100v)", EventVNG2008TND100},
		{"Mua 200 Tói mong xu©n (200v)", EventVNG2008TND200},
		{"Mua 500 Tói mong xu©n (500v)", EventVNG2008TND500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event TÕt Nguyªn §¸n n¨m 2008 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2008TND500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Tói mong xu©n", tbProp={6,1,1652,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói mong xu©n", 1)

end
function EventVNG2008TND200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Tói mong xu©n", tbProp={6,1,1652,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói mong xu©n", 1)

end
function EventVNG2008TND100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Tói mong xu©n", tbProp={6,1,1652,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói mong xu©n", 1)

end
function EventVNG2008SNVLTK()
	local tbOpt =
	{
		{"Mua 100 Tói §¹i Hû Xu©n (100v)", EventVNG2008SNVLTKXuan},
		{"Mua 100 Tói §¹i Hû H¹ (100v)", EventVNG2008SNVLTKHa},
		{"Mua 100 Tói §¹i Hû Thu (100v)", EventVNG2008SNVLTKThu},
		{"Mua 100 Tói §¹i Hû §«ng (100v)", EventVNG2008SNVLTKDong},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Sinh NhËt Vâ L©m TruyÒn Kú 3 Tuæi ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2008SNVLTKDong()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Tói §¹i Hû §«ng", tbProp={6,1,1751,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói §¹i Hû §«ng", 1)

end
function EventVNG2008SNVLTKThu()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Tói §¹i Hû Thu", tbProp={6,1,1750,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói §¹i Hû Thu", 1)

end
function EventVNG2008SNVLTKHa()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Tói §¹i Hû H¹", tbProp={6,1,1749,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói §¹i Hû H¹", 1)

end
function EventVNG2008SNVLTKXuan()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Tói §¹i Hû Xu©n", tbProp={6,1,1748,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói §¹i Hû Xu©n", 1)

end
--===== Bat dau ban nguyen lieu Event nam 2007 =====--
function EventVNG2007()
	local tbOpt =
	{
		{"Sinh NhËt VLTK 2 Tuæi", EventVNG2007SNVLTK},
		{"TÕt Nguyªn §¸n 2007", EventVNG2007TND},
		{"Gi¸ng Sinh 2007", EventVNG2007Noel},
		{"Trung Thu 2007", EventVNG2007TrungThu},
		{"Quèc Kh¸nh 2007", EventVNG2007QuocKhanh},
		{"§æi MËt §å ThÇn BÝ", EventVNG2007MDTB},
		{"Giç Tæ Hïng V­¬ng Mïng 10 Th¸ng 03", EventVNG2007NauBanh},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event n¨m 2007 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007SNVLTK()
	local tbOpt =
	{
		{"Mua 100 Hoa hång ®á (100v)", EventVNG2007SNVLTK100},
		{"Mua 200 Hoa hång ®á (200v)", EventVNG2007SNVLTK200},
		{"Mua 500 Hoa hång ®á (500v)", EventVNG2007SNVLTK500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Sinh NhËt Vâ L©m TruyÒn Kú 2 Tuæi ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007SNVLTK500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Hoa hång ®á", tbProp={6,1,1438,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hoa hång ®á", 1)

end
function EventVNG2007SNVLTK200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hoa hång ®á", tbProp={6,1,1438,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hoa hång ®á", 1)

end
function EventVNG2007SNVLTK100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hoa hång ®á", tbProp={6,1,1438,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hoa hång ®á", 1)

end
function EventVNG2007TND()
	local tbOpt =
	{
		{"Mua 100 Bao l× x× (100v)", EventVNG2007TND100},
		{"Mua 200 Bao l× x× (200v)", EventVNG2007TND200},
		{"Mua 500 Bao l× x× (500v)", EventVNG2007TND500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event TÕt Nguyªn §¸n n¨m 2007 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007TND500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Bao l× x×", tbProp={6,1,1350,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Bao l× x×", 1)

end
function EventVNG2007TND200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Bao l× x×", tbProp={6,1,1350,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Bao l× x×", 1)

end
function EventVNG2007TND100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Bao l× x×", tbProp={6,1,1350,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Bao l× x×", 1)

end
function EventVNG2007Noel()
	local tbOpt =
	{
		{"Mua 100 Hép quµ gi¸ng sinh (100v)", EventVNG2007Noel100},
		{"Mua 200 Hép quµ gi¸ng sinh (200v)", EventVNG2007Noel200},
		{"Mua 500 Hép quµ gi¸ng sinh (500v)", EventVNG2007Noel500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Gi¸ng Sinh n¨m 2007 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007Noel500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Hép quµ gi¸ng sinh", tbProp={6,1,1627,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ gi¸ng sinh", 1)

end
function EventVNG2007Noel200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hép quµ gi¸ng sinh", tbProp={6,1,1627,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ gi¸ng sinh", 1)

end
function EventVNG2007Noel100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hép quµ gi¸ng sinh", tbProp={6,1,1627,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ gi¸ng sinh", 1)

end
function EventVNG2007TrungThu()
	local tbOpt =
	{
		{"Mua 100 Tói nguyªn liÖu (100v)", EventVNG2007TrungThu100},
		{"Mua 200 Tói nguyªn liÖu (200v)", EventVNG2007TrungThu200},
		{"Mua 500 Tói nguyªn liÖu (500v)", EventVNG2007TrungThu500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Trung Thu n¨m 2007 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007TrungThu500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Tói nguyªn liÖu", tbProp={6,1,1502,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói nguyªn liÖu", 1)

end
function EventVNG2007TrungThu200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Tói nguyªn liÖu", tbProp={6,1,1502,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói nguyªn liÖu", 1)

end
function EventVNG2007TrungThu100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Tói nguyªn liÖu", tbProp={6,1,1502,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói nguyªn liÖu", 1)

end
function EventVNG2007QuocKhanh()
	local tbOpt =
	{
		{"Mua 100 Ng«i sao chiOn th¾ng (100v)", EventVNG2007QuocKhanh100},
		{"Mua 200 Ng«i sao chiOn th¾ng (200v)", EventVNG2007QuocKhanh200},
		{"Mua 500 Ng«i sao chiOn th¾ng (500v)", EventVNG2007QuocKhanh500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Quèc Kh¸nh n¨m 2007 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007QuocKhanh500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Ng«i sao chiOn th¾ng", tbProp={6,1,1494,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Ng«i sao chiOn th¾ng", 1)

end
function EventVNG2007QuocKhanh200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Ng«i sao chiOn th¾ng", tbProp={6,1,1494,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Ng«i sao chiOn th¾ng", 1)

end
function EventVNG2007QuocKhanh100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Ng«i sao chiOn th¾ng", tbProp={6,1,1494,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Ng«i sao chiOn th¾ng", 1)

end
function EventVNG2007MDTB()
	local tbOpt =
	{
		{"Mua 100 MËt ®å thÇn bU (100v)", EventVNG2007MDTB100},
		{"Mua 200 MËt ®å thÇn bU (200v)", EventVNG2007MDTB200},
		{"Mua 500 MËt ®å thÇn bU (500v)", EventVNG2007MDTB500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event ®æi MËt §å ThÇn BÝ n¨m 2007 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007MDTB500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="MËt ®å thÇn bU ", tbProp={6,1,196,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "MËt ®å thÇn bU ", 1)

end
function EventVNG2007MDTB200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="MËt ®å thÇn bU ", tbProp={6,1,196,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "MËt ®å thÇn bU ", 1)

end
function EventVNG2007MDTB100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="MËt ®å thÇn bU ", tbProp={6,1,196,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "MËt ®å thÇn bU ", 1)

end
function EventVNG2007NauBanh()
	local tbOpt =
	{
		{"Mua 100 Tói hµng haa (100v)", EventVNG2007NauBanh100},
		{"Mua 200 Tói hµng haa (200v)", EventVNG2007NauBanh200},
		{"Mua 500 Tói hµng haa (500v)", EventVNG2007NauBanh500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event NÊu b¸nh ch­ng n¨m 2007 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2007NauBanh500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Tói hµng haa", tbProp={6,1,1393,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói hµng haa", 1)

end
function EventVNG2007NauBanh200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Tói hµng haa", tbProp={6,1,1393,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói hµng haa", 1)

end
function EventVNG2007NauBanh100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Tói hµng haa", tbProp={6,1,1393,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tói hµng haa", 1)

end
--===== Bat dau ban nguyen lieu Event nam 2006 =====--
function EventVNG2006()
	local tbOpt =
	{
		{"Sinh NhËt VLTK 1 Tuæi", EventVNG2006SNVLTK},
		{"Gi¸ng Sinh 2006", EventVNG2006Noel},
		{"Trung Thu 2006", EventVNG2006TrungThu},
		{"Vu Lan 2006", EventVNG2006VuLan},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event n¨m 2006 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2006VuLan()
	local tbOpt =
	{
		{"Mua 90 Kim Liªn hoa  (90v)", EventVNG2006VuLanKim},
		{"Mua 90 Méc Liªn Hoa (90v)", EventVNG2006VuLanMoc},
		{"Mua 90 Thñy Liªn Hoa (90v)", EventVNG2006VuLanThuy},
		{"Mua 90 Háa Liªn Hoa (90v)", EventVNG2006VuLanHoa},
		{"Mua 90 Thæ Liªn Hoa (90v)", EventVNG2006VuLanTho},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Vu Lan n¨m 2006 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2006VuLanTho()
	if (GetCash() <= 900000) then
		Talk(1, "", "Ph¶i ca ®ñ 90 v¹n míi ca thÓ mua.")
		return
	end
	Pay(900000)
	local tbItem = {szName="Thæ Liªn Hoa", tbProp={6,1,1130,1,0,0}, nCount=90, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Thæ Liªn Hoa", 1)

end
function EventVNG2006VuLanHoa()
	if (GetCash() <= 900000) then
		Talk(1, "", "Ph¶i ca ®ñ 90 v¹n míi ca thÓ mua.")
		return
	end
	Pay(900000)
	local tbItem = {szName="Háa Liªn Hoa", tbProp={6,1,1129,1,0,0}, nCount=90, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Háa Liªn Hoa", 1)

end
function EventVNG2006VuLanThuy()
	if (GetCash() <= 900000) then
		Talk(1, "", "Ph¶i ca ®ñ 90 v¹n míi ca thÓ mua.")
		return
	end
	Pay(900000)
	local tbItem = {szName="Thñy Liªn Hoa", tbProp={6,1,1128,1,0,0}, nCount=90, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Thñy Liªn Hoa", 1)

end
function EventVNG2006VuLanKim()
	if (GetCash() <= 900000) then
		Talk(1, "", "Ph¶i ca ®ñ 90 v¹n míi ca thÓ mua.")
		return
	end
	Pay(900000)
	local tbItem = {szName="Kim Liªn hoa ", tbProp={6,1,1126,1,0,0}, nCount=90, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Kim Liªn hoa ", 1)

end
function EventVNG2006VuLanMoc()
	if (GetCash() <= 900000) then
		Talk(1, "", "Ph¶i ca ®ñ 90 v¹n míi ca thÓ mua.")
		return
	end
	Pay(900000)
	local tbItem = {szName="Méc Liªn Hoa", tbProp={6,1,1127,1,0,0}, nCount=90, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Méc Liªn Hoa", 1)

end
function EventVNG2006TrungThu()
	local tbOpt =
	{
		{"Mua 100 Hép vËt liÖu lång ®Ìn (100v)", EventVNG2006TrungThu100},
		{"Mua 200 Hép vËt liÖu lång ®Ìn (200v)", EventVNG2006TrungThu200},
		{"Mua 500 Hép vËt liÖu lång ®Ìn (500v)", EventVNG2006TrungThu500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Trung Thu n¨m 2006 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2006TrungThu500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Hép vËt liÖu lång ®`n", tbProp={6,1,1220,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép vËt liÖu lång ®`n", 1)

end
function EventVNG2006TrungThu200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hép vËt liÖu lång ®`n", tbProp={6,1,1220,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép vËt liÖu lång ®`n", 1)

end
function EventVNG2006TrungThu100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hép vËt liÖu lång ®`n", tbProp={6,1,1220,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép vËt liÖu lång ®`n", 1)

end
function EventVNG2006Noel()
	local tbOpt =
	{
		{"Mua 100 Hép quµ gi¸ng sinh (100v)", EventVNG2006Noel100},
		{"Mua 200 Hép quµ gi¸ng sinh (200v)", EventVNG2006Noel200},
		{"Mua 500 Hép quµ gi¸ng sinh (500v)", EventVNG2006Noel500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Gi¸ng Sinh n¨m 2006 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2006Noel500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Hép quµ gi¸ng sinh", tbProp={6,1,1311,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ gi¸ng sinh", 1)

end
function EventVNG2006Noel200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hép quµ gi¸ng sinh", tbProp={6,1,1311,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ gi¸ng sinh", 1)

end
function EventVNG2006Noel100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hép quµ gi¸ng sinh", tbProp={6,1,1311,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ gi¸ng sinh", 1)

end
function EventVNG2006SNVLTK()
	local tbOpt =
	{
		{"Mua 100 Hép quµ Sinh nhËt (100v)", EventVNG2006SNVLTK100},
		{"Mua 200 Hép quµ Sinh nhËt (200v)", EventVNG2006SNVLTK200},
		{"Mua 500 Hép quµ Sinh nhËt (500v)", EventVNG2006SNVLTK500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Sinh NhËt VLTK 1 Tuæi n¨m 2006 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2006SNVLTK500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="Hép quµ Sinh nhËt", tbProp={6,1,1099,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ Sinh nhËt", 1)

end
function EventVNG2006SNVLTK200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="Hép quµ Sinh nhËt", tbProp={6,1,1099,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ Sinh nhËt", 1)

end
function EventVNG2006SNVLTK100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="Hép quµ Sinh nhËt", tbProp={6,1,1099,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "Hép quµ Sinh nhËt", 1)

end

--===== Bat dau ban nguyen lieu Event nam 2005 =====--
function EventVNG2005()
	local tbOpt =
	{
		{"Trung Thu 2005", EventVNG2005TrungThu},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event n¨m 2005 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2005TrungThu()
	local tbOpt =
	{
		{"Mua 100 LÔ vËt trung thu (100v)", EventVNG2005TrungThu100},
		{"Mua 200 LÔ vËt trung thu (200v)", EventVNG2005TrungThu200},
		{"Mua 500 LÔ vËt trung thu (500v)", EventVNG2005TrungThu500},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>:<enter>Cña hµng nguyªn liÖu Event Trung Thu n¨m 2005 ®©y!<enter>M¹i d« ... m¹i d« mäi ng­êi ¬i !!!", tbOpt)
end
function EventVNG2005TrungThu500()
	if (GetCash() <= 5000000) then
		Talk(1, "", "Ph¶i ca ®ñ 500 v¹n míi ca thÓ mua.")
		return
	end
	Pay(5000000)
	local tbItem = {szName="LÔ vËt Trung Thu", tbProp={6,1,897,1,0,0}, nCount=500, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "LÔ vËt Trung Thu", 1)

end
function EventVNG2005TrungThu200()
	if (GetCash() <= 2000000) then
		Talk(1, "", "Ph¶i ca ®ñ 200 v¹n míi ca thÓ mua.")
		return
	end
	Pay(2000000)
	local tbItem = {szName="LÔ vËt Trung Thu", tbProp={6,1,897,1,0,0}, nCount=200, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "LÔ vËt Trung Thu", 1)

end
function EventVNG2005TrungThu100()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="LÔ vËt Trung Thu", tbProp={6,1,897,1,0,0}, nCount=100, nExpiredTime = 10080}
	tbAwardTemplet:GiveAwardByList(tbItem, "LÔ vËt Trung Thu", 1)

end
-------------END----------------

---=====| {"Hç trî Event", VatPhamEvent} - Star |=====---
function VatPhamEvent()
	local szTitlez =  "<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color>\n-----------------------------------------------------\n* <color=green>Mäi chi tiÕt xin liªn hÖ:<color>\n\t\t+ Zalo: 0393644475"
		local tbOpt =
		{
		{"NhËn nguyªn liÖu", VatPhamEvent_NL},
		{"NhËn thµnh phÇm", VatPhamEvent_TP},
		{"Hñy bá mäi thø", deltem},
		{"Tho¸t"},
		}
		CreateNewSayEx(szTitlez, tbOpt)	
	return 1				
end

function VatPhamEvent_NL()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
		return
	end
	if (CFG_vm_birthplan	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Hép quµ Sinh nhËt",	tbProp = {6,1,1099,1,0,0},	nCount = 1},
			[2]	={szName = "S÷a t­¬i",	tbProp = {4,975},	nCount = 2},
			[3]	={szName = "Bét tinh",	tbProp = {4,976},	nCount = 10},
			[4]	={szName = "§­êng tinh",	tbProp = {4,977},	nCount = 10},
			[5]	={szName = "Trøng gµ",	tbProp = {4,978},	nCount = 2},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_mid_autumn05	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "LÔ vËt Trung Thu",	tbProp = {6,1,897,1,0,0},	nCount = 1},
			[2]	={szName = "Bét m×",	tbProp = {4,520 },	nCount = 34},
			[3]	={szName = "§­êng c¸t",	tbProp = {4,521 },	nCount = 34},
			[4]	={szName = "Bét sen",	tbProp = {4,523 },	nCount = 5},
			[5]	={szName = "§Ëu xanh",	tbProp = {4,524 },	nCount = 5},
			[6]	={szName = "Trøng",	tbProp = {4,522 },	nCount = 4},
			[7]	={szName = "H¹nh Nh©n",	tbProp = {4,525 },	nCount = 4},
			[8]	={szName = "§Ëu Phéng",	tbProp = {4,526 },	nCount = 3},
			[9]	={szName = "C¬m Dõa",	tbProp = {4,527 },	nCount = 3},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_2006vm_NationalDay	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Quµ Quèc Kh¸nh",	tbProp = {6,1,1155,1,0,0},	nCount = 10},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_menglan_2006	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Kim Liªn hoa ",	tbProp = {6,1,1126,1,0,0},	nCount = 9},
			[2]	={szName = "Méc Liªn Hoa",	tbProp = {6,1,1127,1,0,0},	nCount = 9},
			[3]	={szName = "Thñy Liªn Hoa",	tbProp = {6,1,1128,1,0,0},	nCount = 9},
			[4]	={szName = "Háa Liªn Hoa",	tbProp = {6,1,1129,1,0,0},	nCount = 9},
			[5]	={szName = "Thæ Liªn Hoa",	tbProp = {6,1,1130,1,0,0},	nCount = 9},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_Act2Years2007	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Hoa hång ®á",	tbProp = {6,1,1438,1,0,0},	nCount = 30},
			[2]	={szName = "N¬ ®á",	tbProp = {6,1,1437,1,0,0},	nCount = 1},
			[3]	={szName = "GiÊy gai hoa",	tbProp = {6,1,1436,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_GUOQING2007	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Ng«i sao chiOn th¾ng",	tbProp = {6,1,1494,1,0,0},	nCount = 10},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_mid_autumn06	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Hép vËt liÖu lång ®`n",	tbProp = {6,1,1220,1,0,0},	nCount = 1},
			[2]	={szName = "GiÊy kiOng vµng (VËt liÖu lµm lång ®`n)",	tbProp = {6,1,1221,1,0,0},	nCount = 2},
			[3]	={szName = "GiÊy kiOng lam (VËt liÖu lµm lång ®`n)",	tbProp = {6,1,1222,1,0,0},	nCount = 2},
			[4]	={szName = "GiÊy kiOng lôc (VËt liÖu lµm lång ®`n)",	tbProp = {6,1,1223,1,0,0},	nCount = 2},
			[5]	={szName = "GiÊy kiOng ®á (VËt liÖu lµm lång ®`n)",	tbProp = {6,1,1224,1,0,0},	nCount = 2},
			[6]	={szName = "GiÊy kiOng cam (VËt liÖu lµm lång ®`n)",	tbProp = {6,1,1225,1,0,0},	nCount = 1},
			[7]	={szName = "Thanh tre (VËt liÖu lµm lång ®Ìn)",	tbProp = {6,1,1226,1,0,0},	nCount = 6},
			[8]	={szName = "D©y cãi (VËt liÖu lµm lång ®Ìn)",	tbProp = {6,1,1227,1,0,0},	nCount = 6},
			[9]	={szName = "NÕn",	tbProp = {6,1,1228,1,0,0},	nCount = 6},
			[10]	={szName = "Lång ®`n b­¬m b­ím",	tbProp = {6,1,1241,1,0,0},	nCount = 1},
			[11]	={szName = "Lång ®`n ng«i sao",	tbProp = {6,1,1242,1,0,0},	nCount = 1},
			[12]	={szName = "Lång ®`n èng",	tbProp = {6,1,1243,1,0,0},	nCount = 1},
			[13]	={szName = "Lång ®`n trßn",	tbProp = {6,1,1244,1,0,0},	nCount = 1},
			[14]	={szName = "Lång ®`n c¸ chÐp",	tbProp = {6,1,1245,1,0,0},	nCount = 1},
			[15]	={szName = "Lång ®`n kÐo qu©n",	tbProp = {6,1,1246,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_xmas2007	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Hép quµ gi¸ng sinh",	tbProp = {6,1,1627,1,0,0},	nCount = 1},
			[2]	={szName = "Kim B¨ng Tinh",	tbProp = {6,1,1628,1,0,0},	nCount = 6},
			[3]	={szName = "Méc B¨ng Tinh",	tbProp = {6,1,1629,1,0,0},	nCount = 9},
			[4]	={szName = "Thñy B¨ng Tinh",	tbProp = {6,1,1630,1,0,0},	nCount = 12},
			[5]	={szName = "Háa B¨ng Tinh",	tbProp = {6,1,1631,1,0,0},	nCount = 15},
			[6]	={szName = "Thæ B¨ng Tinh",	tbProp = {6,1,1632,1,0,0},	nCount = 18},
			[7]	={szName = "Ng? S¾c B¨ng Tinh",	tbProp = {6,1,1633,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_xmas2006	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Hép quµ gi¸ng sinh",	tbProp = {6,1,1311,1,0,0},	nCount = 1},
			[2]	={szName = "Hoa tuyOt",	tbProp = {6,1,1312,1,0,0},	nCount = 30},
			[3]	={szName = "Cµ rèt",	tbProp = {6,1,1313,1,0,0},	nCount = 3},
			[4]	={szName = "Cµnh th«ng",	tbProp = {6,1,1314,1,0,0},	nCount = 6},
			[5]	={szName = "Nan gi¸ng sinh",	tbProp = {6,1,1315,1,0,0},	nCount = 3},
			[6]	={szName = "Kh¨n choµng (xanh)",	tbProp = {6,1,1316,1,0,0},	nCount = 1},
			[7]	={szName = "Kh¨n choµng (®á)",	tbProp = {6,1,1317,1,0,0},	nCount = 1},
			[8]	={szName = "C©y th«ng ",	tbProp = {6,1,1318,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_zhongqiu2007	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Tói nguyªn liÖu",	tbProp = {6,1,1502,1,0,0},	nCount = 1},
			[2]	={szName = "Tói Bét",	tbProp = {6,1,1503,1,0,0},	nCount = 11},
			[3]	={szName = "Tói ®­êng",	tbProp = {6,1,1504,1,0,0},	nCount = 11},
			[4]	={szName = "Tói Trøng",	tbProp = {6,1,1505,1,0,0},	nCount = 11},
			[5]	={szName = "Tói §Ëu xanh",	tbProp = {6,1,1506,1,0,0},	nCount = 1},
			[6]	={szName = "Tói h¹t sen",	tbProp = {6,1,1507,1,0,0},	nCount = 1},
			[7]	={szName = "Tói th~t gµ",	tbProp = {6,1,1508,1,0,0},	nCount = 1},
			[8]	={szName = "Tói Th~t",	tbProp = {6,1,1509,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_newyear_2008	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Tói mong xu©n",	tbProp = {6,1,1652,1,0,0},	nCount = 1},
			[2]	={szName = "L¸ b¸nh",	tbProp = {6,1,1653,1,0,0},	nCount = 12},
			[3]	={szName = "G¹o nOp",	tbProp = {6,1,1654,1,0,0},	nCount = 9},
			[4]	={szName = "§Ëu xanh",	tbProp = {6,1,1655,1,0,0},	nCount = 6},
			[5]	={szName = "Th~t heo ",	tbProp = {6,1,1656,1,0,0},	nCount = 3},
			[6]	={szName = "Phóc",	tbProp = {6,1,1657,1,0,0},	nCount = 1},
			[7]	={szName = "Léc",	tbProp = {6,1,1658,1,0,0},	nCount = 1},
			[8]	={szName = "Thä",	tbProp = {6,1,1659,1,0,0},	nCount = 1},
			[9]	={szName = "BU quyOt lµm b¸nh ch­ng th­îng h¹ng",	tbProp = {6,1,1660,1,0,0},	nCount = 1},
			[10]	={szName = "BU quyOt lµm b¸nh ch­ng h¶o h¹ng",	tbProp = {6,1,1661,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_newyear_2009	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Lam B¶o R­¬ng",	tbProp = {6,1,1884,1,0,0},	nCount = 1},
			[2]	={szName = "Hång B¶o R­¬ng",	tbProp = {6,1,1885,1,0,0},	nCount = 1},
			[3]	={szName = "M·ng CÇu",	tbProp = {6,1,1886,1,0,0},	nCount = 2},
			[4]	={szName = "Dõa",	tbProp = {6,1,1887,1,0,0},	nCount = 1},
			[5]	={szName = "§u §ñ",	tbProp = {6,1,1888,1,0,0},	nCount = 1},
			[6]	={szName = "Xoµi",	tbProp = {6,1,1889,1,0,0},	nCount = 1},
			[7]	={szName = "Sung",	tbProp = {6,1,1890,1,0,0},	nCount = 3},
			[8]	={szName = "Lôc B¶o Ch©u",	tbProp = {6,1,1891,1,0,0},	nCount = 1},
			[9]	={szName = "Phóc",	tbProp = {6,1,1912,1,0,0},	nCount = 5},
			[10]	={szName = "Léc",	tbProp = {6,1,1913,1,0,0},	nCount = 5},
			[11]	={szName = "Thä",	tbProp = {6,1,1914,1,0,0},	nCount = 5},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_qingren_jieri_2009	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "H¹t c©y t×nh nh©n",	tbProp = {6,1,1927,1,0,0},	nCount = 1},
			[2]	={szName = "Thiªn Tiªn Thñy",	tbProp = {6,1,1928,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_jiefang_jieri2008	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Hép quµ may m¾n",	tbProp = {6,1,1734,1,0,0},	nCount = 1},
			[2]	={szName = "M¶nh cê 1",	tbProp = {6,1,1735,1,0,0},	nCount = 10},
			[3]	={szName = "M¶nh cê 2",	tbProp = {6,1,1736,1,0,0},	nCount = 6},
			[4]	={szName = "M¶nh cê 3",	tbProp = {6,1,1737,1,0,0},	nCount = 3},
			[5]	={szName = "M¶nh cê 4",	tbProp = {6,1,1738,1,0,0},	nCount = 1},
			[6]	={szName = "ThiOt Ng­u Lang Nha Béi",	tbProp = {6,1,1733,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_jiefang_jieri2009	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Tói mong chiOn th¾ng",	tbProp = {6,1,2009,1,0,0},	nCount = 1},
			[2]	={szName = "Bao g¹o",	tbProp = {6,1,2010,1,0,0},	nCount = 4},
			[3]	={szName = "N­íc tinh khiÕt",	tbProp = {6,1,2011,1,0,0},	nCount = 6},
			[4]	={szName = "Men r­îu",	tbProp = {6,1,2012,1,0,0},	nCount = 2},
			[5]	={szName = "Nho t­¬i",	tbProp = {6,1,2007,1,0,0},	nCount = 1},
			[6]	={szName = "Tói thøc ¨n",	tbProp = {6,1,2018,1,0,0},	nCount = 1},
			[7]	={szName = "B×nh n­íc",	tbProp = {6,1,2019,1,0,0},	nCount = 1},
			[8]	={szName = "Tói vËt dông c¸ nh©n",	tbProp = {6,1,2016,1,0,0},	nCount = 1},
			[9]	={szName = "Tói Y TÕ",	tbProp = {6,1,2017,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_pingzi	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Tói §¹i Hû Xu©n",	tbProp = {6,1,1748,1,0,0},	nCount = 1},
			[2]	={szName = "Tói §¹i Hû H¹",	tbProp = {6,1,1749,1,0,0},	nCount = 1},
			[3]	={szName = "Tói §¹i Hû Thu",	tbProp = {6,1,1750,1,0,0},	nCount = 1},
			[4]	={szName = "Tói §¹i Hû §«ng",	tbProp = {6,1,1751,1,0,0},	nCount = 1},
			[5]	={szName = "Mong",	tbProp = {6,1,1752,1,0,0},	nCount = 3},
			[6]	={szName = "VLTK",	tbProp = {6,1,1753,1,0,0},	nCount = 3},
			[7]	={szName = "3",	tbProp = {6,1,1754,1,0,0},	nCount = 3},
			[8]	={szName = "Tuæi",	tbProp = {6,1,1755,1,0,0},	nCount = 3},
			[9]	={szName = "Phong",	tbProp = {6,1,1756,1,0,0},	nCount = 1},
			[10]	={szName = "Háa",	tbProp = {6,1,1757,1,0,0},	nCount = 1},
			[11]	={szName = "Liªn",	tbProp = {6,1,1758,1,0,0},	nCount = 1},
			[12]	={szName = "thµnh ",	tbProp = {6,1,1759,1,0,0},	nCount = 1},
			[13]	={szName = "§¹i Hû LÔ Bao",	tbProp = {6,1,1760,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_zhongqiu_jieri_2008	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Lång ®Ìn b­¬m b­ím",	tbProp = {6,1,1796,1,0,0},	nCount = 6},
			[2]	={szName = "Lång ®Ìn ng«i sao",	tbProp = {6,1,1797,1,0,0},	nCount = 6},
			[3]	={szName = "Lång ®Ìn èng",	tbProp = {6,1,1798,1,0,0},	nCount = 6},
			[4]	={szName = "Lång ®Ìn trßn",	tbProp = {6,1,1799,1,0,0},	nCount = 6},
			[5]	={szName = "HuyÒn tinh kho¸ng th¹ch (cÊp 2)",	tbProp = {6,1,147,2,0,0},	nCount = 1},
			[6]	={szName = "Phóc Duyªn Lé (TiÓu) ",	tbProp = {6,1,122,1,0,0},	nCount = 1},
			[7]	={szName = "NÕn th­ëng nguyÖt",	tbProp = {6,1,1800,1,0,0},	nCount = 1},
			[8]	={szName = "Ngò s¾c long ch©u (Kim)",	tbProp = {6,1,1807,1,0,0},	nCount = 1},
			[9]	={szName = "Ngò s¾c long ch©u (Méc)",	tbProp = {6,1,1808,1,0,0},	nCount = 1},
			[10]	={szName = "Ngò s¾c long ch©u (Thñy)",	tbProp = {6,1,1809,1,0,0},	nCount = 1},
			[11]	={szName = "Ngò s¾c long ch©u (Háa)",	tbProp = {6,1,1810,1,0,0},	nCount = 1},
			[12]	={szName = "Ngò s¾c long ch©u (Thæ)",	tbProp = {6,1,1811,1,0,0},	nCount = 1},
			[13]	={szName = "Ngò s¾c phông vò (Kim)",	tbProp = {6,1,1812,1,0,0},	nCount = 1},
			[14]	={szName = "Ngò s¾c phông vò (Méc)",	tbProp = {6,1,1813,1,0,0},	nCount = 1},
			[15]	={szName = "Ngò s¾c phông vò (Thñy)",	tbProp = {6,1,1814,1,0,0},	nCount = 1},
			[16]	={szName = "Ngò s¾c phông vò (Háa)",	tbProp = {6,1,1815,1,0,0},	nCount = 1},
			[17]	={szName = "Ngò s¾c phông vò (Thæ)",	tbProp = {6,1,1816,1,0,0},	nCount = 1},
			[18]	={szName = "Hép V©n Du",	tbProp = {6,1,1794,1,0,0},	nCount = 1},
			[19]	={szName = "Hép Tiªn V?",	tbProp = {6,1,1795,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_yn_chunjie	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "M·ng cÇu",	tbProp = {4,951 },	nCount = 10},
			[2]	={szName = "Dõa",	tbProp = {4,952 },	nCount = 10},
			[3]	={szName = "§u ®ñ",	tbProp = {4,953 },	nCount = 10},
			[4]	={szName = "Xoµi",	tbProp = {4,954 },	nCount = 10},
			[5]	={szName = "Sung",	tbProp = {4,955 },	nCount = 10},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_ma_chunjie	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Bét ®¸",	tbProp = {4,956 },	nCount = 1},
			[2]	={szName = "L­u huúnh",	tbProp = {4,957 },	nCount = 1},
			[3]	={szName = "Than cñi",	tbProp = {4,958 },	nCount = 1},
			[4]	={szName = "GiÊy hång",	tbProp = {4,959 },	nCount = 1},
			[5]	={szName = "Tim ph¸o",	tbProp = {4,960 },	nCount = 1},
			[6]	={szName = "Háa d­îc mËt t~ch",	tbProp = {4,961 },	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_birthday_jieri_2009	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Thiªn Tø B¶o R­¬ng",	tbProp = {6,1,2061,1,0,0},	nCount = 1},
			[2]	={szName = "Hïng",	tbProp = {6,1,2062,1,0,0},	nCount = 2},
			[3]	={szName = "B¸",	tbProp = {6,1,2063,1,0,0},	nCount = 2},
			[4]	={szName = "Thiªn",	tbProp = {6,1,2064,1,0,0},	nCount = 2},
			[5]	={szName = "H¹",	tbProp = {6,1,2065,1,0,0},	nCount = 2},
			[6]	={szName = "Hoµng Kú",	tbProp = {6,1,2066,1,0,0},	nCount = 1},
			[7]	={szName = "§ång Cæ",	tbProp = {6,1,2067,1,0,0},	nCount = 1},
			[8]	={szName = "Hïng T©m KiOm",	tbProp = {6,1,2070,1,0,0},	nCount = 1},
			[9]	={szName = "B¸ V­¬ng Th­¬ng",	tbProp = {6,1,2071,1,0,0},	nCount = 1},
			[10]	={szName = "Thiªn Tµn §ao",	tbProp = {6,1,2072,1,0,0},	nCount = 1},
			[11]	={szName = "H¹ NhËt Cung",	tbProp = {6,1,2073,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	elseif (CFG_mengjiang2007	==	1) then
		local tbVatPhamEvent_NL =
			{
			[1]	={szName = "Vâ L©m MËt Th­",	tbProp = {6,1,1477,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_NL, "NhËn nguyªn liÖu Event-NobitaXD", 1)
	else
		Talk(1, "", "HiÖn t¹i kh«ng cã Event nµo ®­îc më.")
	end
end

function VatPhamEvent_TP()
	if (CalcFreeItemCellCount() < 30) then
		Talk(1, "", "Hµnh trang cña b¹n kh«ng ®ñ 30 « trèng ®Ó nhËn.")
		return
	end
	if (CFG_vm_birthplan	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "B¸nh sinh nhËt",	tbProp = {6,1,1100,1,0,0},	nCount = 1},
 			[2]	={szName = "B¸nh Sinh nhËt th­îng h¹n",	tbProp = {6,1,1101,1,0,0},	nCount = 1},
 			[3]	={szName = "NOn Vui vÎ",	tbProp = {6,1,1095,1,0,0},	nCount = 1},
 			[4]	={szName = "NOn B×nh an",	tbProp = {6,1,1096,1,0,0},	nCount = 1},
 			[5]	={szName = "NOn May m¾n",	tbProp = {6,1,1097,1,0,0},	nCount = 1},
 			[6]	={szName = "NOn H¹nh phóc",	tbProp = {6,1,1098,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_mid_autumn05	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "B¸nh Trung Thu ch¸y",	tbProp = {6,1,890,1,0,0},	nCount = 1},
 			[2]	={szName = "B¸nh Trung Thu §Ëu Xanh",	tbProp = {6,1,891,1,0,0},	nCount = 1},
 			[3]	={szName = "B¸nh Trung thu h¹t sen ",	tbProp = {6,1,892,1,0,0},	nCount = 1},
 			[4]	={szName = "B¸nh Trung Thu §Ëu Trøng",	tbProp = {6,1,893,1,0,0},	nCount = 1},
 			[5]	={szName = "B¸nh Trung thu sen trøng",	tbProp = {6,1,894,1,0,0},	nCount = 1},
 			[6]	={szName = "B¸nh Trung Thu Qu¶ Nh©n",	tbProp = {6,1,895,1,0,0},	nCount = 1},
 			[7]	={szName = "B¸nh Trung Thu thËp cÈm",	tbProp = {6,1,896,1,0,0},	nCount = 1},
			[8]	={szName = "Phông NguyÖt Qu¶ Dung",	tbProp = {6,1,127,1,0,0},	nCount = 1},
			[9]	={szName = "Cèng NguyÖt Phï Dung",	tbProp = {6,1,128,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_menglan_2006	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Vßng Kim Liªn Hoa",	tbProp = {6,1,1131,1,0,0},	nCount = 1},
			[2]	={szName = "Vßng Méc Liªn Hoa",	tbProp = {6,1,1132,1,0,0},	nCount = 1},
			[3]	={szName = "Vßng Thñy Liªn Hoa",	tbProp = {6,1,1133,1,0,0},	nCount = 1},
			[4]	={szName = "Vßng Háa Liªn Hoa",	tbProp = {6,1,1134,1,0,0},	nCount = 1},
			[5]	={szName = "Vßng Thæ Liªn Hoa",	tbProp = {6,1,1135,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_Act2Years2007	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Hép quµ tr¾ng",	tbProp = {6,1,1439,1,0,0},	nCount = 1},
			[2]	={szName = "Hép quµ vµng",	tbProp = {6,1,1440,1,0,0},	nCount = 1},
			[3]	={szName = "Hép quµ xanh",	tbProp = {6,1,1441,1,0,0},	nCount = 1},
			[4]	={szName = "B¸nh b«ng lan",	tbProp = {6,1,1442,1,0,0},	nCount = 1},
			[5]	={szName = "B¸nh kem",	tbProp = {6,1,1443,1,0,0},	nCount = 1},
			[6]	={szName = "B¸nh kem ®Æc biÖt",	tbProp = {6,1,1444,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_GUOQING2007	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Quµ Quèc Kh¸nh",	tbProp = {6,1,1495,1,0,0},	nCount = 1},
			[2]	={szName = "Huy ch­¬ng Quèc Kh¸nh",	tbProp = {6,1,1496,1,0,0},	nCount = 20},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_mid_autumn06	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Lång ®`n b­¬m b­ím ®Æc biÖt",	tbProp = {6,1,1229,1,0,0},	nCount = 1},
 			[2]	={szName = "Lång ®`n ng«i sao ®Æc biÖt",	tbProp = {6,1,1230,1,0,0},	nCount = 1},
 			[3]	={szName = "Lång ®`n èng ®Æc biÖt",	tbProp = {6,1,1231,1,0,0},	nCount = 1},
 			[4]	={szName = "Lång ®`n trßn ®Æc biÖt",	tbProp = {6,1,1232,1,0,0},	nCount = 1},
 			[5]	={szName = "Lång ®`n c¸ chÐp ®Æc biÖt",	tbProp = {6,1,1233,1,0,0},	nCount = 1},
 			[6]	={szName = "Lång ®`n kÐo qu©n ®Æc biÖt",	tbProp = {6,1,1234,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_xmas2007	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "KÑo gi¸ng sinh (bÐ xUu)",	tbProp = {6,1,1622,1,0,0},	nCount = 1},
 			[2]	={szName = "KÑo gi¸ng sinh (nhá)",	tbProp = {6,1,1623,1,0,0},	nCount = 1},
 			[3]	={szName = "KÑo gi¸ng sinh (voa)",	tbProp = {6,1,1624,1,0,0},	nCount = 1},
 			[4]	={szName = "KÑo gi¸ng sinh (lín)",	tbProp = {6,1,1625,1,0,0},	nCount = 1},
 			[5]	={szName = "KÑo gi¸ng sinh (®Æc biÖt)",	tbProp = {6,1,1626,1,0,0},	nCount = 1},
 			[6]	={szName = "KÑo b¹c hµ gi¸ng sinh",	tbProp = {6,1,1637,1,0,0},	nCount = 1},
 			[7]	={szName = "KÑo d©u gi¸ng sinh",	tbProp = {6,1,1638,1,0,0},	nCount = 1},
 			[8]	={szName = "KÑo s÷a gi¸ng sinh",	tbProp = {6,1,1639,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_xmas2006	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Ng­êi tuyOt choµng kh¨n xanh (®Æc biÖt)",	tbProp = {6,1,1319,1,0,0},	nCount = 1},
 			[2]	={szName = "Ng­êi tuyOt choµng kh¨n ®á (®Æc biÖt)",	tbProp = {6,1,1320,1,0,0},	nCount = 1},
 			[3]	={szName = "Ng­êi tuyOt ®Æc biÖt",	tbProp = {6,1,1321,1,0,0},	nCount = 1},
 			[4]	={szName = "Ng­êi tuyOt choµng kh¨n xanh (th­êng)",	tbProp = {6,1,1322,1,0,0},	nCount = 1},
 			[5]	={szName = "Ng­êi tuyOt choµng kh¨n ®á (th­êng)",	tbProp = {6,1,1323,1,0,0},	nCount = 1},
 			[6]	={szName = "Ng­êi tuyOt th­êng",	tbProp = {6,1,1324,1,0,0},	nCount = 1},
 			[7]	={szName = "B¸nh bU ®á",	tbProp = {6,1,1325,1,0,0},	nCount = 1},
 			[8]	={szName = "B¸nh kem",	tbProp = {6,1,1326,1,0,0},	nCount = 1},
 			[9]	={szName = "Gµ l«i",	tbProp = {6,1,1327,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_zhongqiu2007	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "B¸nh ®Ëu xanh",	tbProp = {6,1,1510,1,0,0},	nCount = 1},
 			[2]	={szName = "B¸nh h¹t sen",	tbProp = {6,1,1511,1,0,0},	nCount = 1},
 			[3]	={szName = "B¸nh Trung Thu gµ n­íng",	tbProp = {6,1,1512,1,0,0},	nCount = 1},
 			[4]	={szName = "B¸nh Trung Thu heo quay",	tbProp = {6,1,1513,1,0,0},	nCount = 1},
 			[5]	={szName = "Hép b¸nh Trung Thu",	tbProp = {6,1,1514,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_newyear_2008	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "B¸nh ch­ng th­îng h¹ng",	tbProp = {6,1,1662,1,0,0},	nCount = 1},
 			[2]	={szName = "B¸nh ch­ng h¶o h¹ng",	tbProp = {6,1,1663,1,0,0},	nCount = 1},
 			[3]	={szName = "B¸nh ch­ng th­êng",	tbProp = {6,1,1664,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_newyear_2009	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "NÕn C¸t T­êng",	tbProp = {6,1,1915,1,0,0},	nCount = 1},
 			[2]	={szName = "NÕn Nh­ ý",	tbProp = {6,1,1916,1,0,0},	nCount = 1},
 			[3]	={szName = "B¸nh ch­ng th­îng h¹ng",	tbProp = {6,1,1894,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_jiefang_jieri2008	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "L¸ Cê ChiOn Th¾ng",	tbProp = {6,1,1739,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_jiefang_jieri2009	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "BÇu r­îu",	tbProp = {6,1,2013,1,0,0},	nCount = 1},
			[2]	={szName = "R­îu nho",	tbProp = {6,1,2014,1,0,0},	nCount = 1},
			[3]	={szName = "ThiÕt T©m B«i",	tbProp = {6,1,2008,1,0,0},	nCount = 1},
			[4]	={szName = "NÕn B¸t tr©n phóc nguyÖt",	tbProp = {6,1,1817,1,0,0},	nCount = 1},
			[5]	={szName = "Thiªn S¬n TuyÕt Liªn",	tbProp = {6,1,1431,1,0,0},	nCount = 1},
			[6]	={szName = "HuyÒn Ch©n §¬n",	tbProp = {6,1,1678,1,0,0},	nCount = 1},
			[7]	={szName = "HuyÕt Ch©n §¬n",	tbProp = {6,1,1677,1,0,0},	nCount = 1},
			[8]	={szName = "B¹ch Ch©n §¬n",	tbProp = {6,1,1676,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_pingzi	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "B¸nh Kem Nh­ u",	tbProp = {6,1,1761,1,0,0},	nCount = 1},
			[2]	={szName = "B¸nh Kem C¸t T­êng",	tbProp = {6,1,1762,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_zhongqiu_jieri_2008	==	1) then
		local tbVatPhamEvent_TP =
			{
			--[1]	={szName = "B¸nh trung thu Väng NguyÖt",	tbProp = {6,1,1801,1,0,0},	nCount = 100},
			[1]	={szName = "B¸nh trung thu KiÕn NguyÖt",	tbProp = {6,1,1802,1,0,0},	nCount = 100},
			--[3]	={szName = "B¸nh trung thu Th­ëng NguyÖt",	tbProp = {6,1,1803,1,0,0},	nCount = 100},
			--[4]	={szName = "Phông NguyÖt Qu¶ Dung",	tbProp = {6,1,127,1,0,0},	nCount = 1},
			--[5]	={szName = "Cèng NguyÖt Phï Dung",	tbProp = {6,1,128,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_yn_chunjie	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "B¸nh ch­ng ThËp cÈm",	tbProp = {6,1,1023,1,0,0},	nCount = 1},
			[2]	={szName = "B¸nh tÐt nh©n ®Ëu",	tbProp = {6,1,1024,1,0,0},	nCount = 1},
			[3]	={szName = "B¸nh tÐt thËp cÈm",	tbProp = {6,1,1025,1,0,0},	nCount = 1},
			[4]	={szName = "B¸nh Ch­ng th­îng h¹ng",	tbProp = {6,1,1026,1,0,0},	nCount = 1},
			[5]	={szName = "TiÓu Hång bao",	tbProp = {6,1,1027,1,0,0},	nCount = 1},
			[6]	={szName = "§¹i Hång bao",	tbProp = {6,1,1028,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_ma_chunjie	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Bao l× x× n¨m míi (tiÓu) ",	tbProp = {6,1,1029,1,0,0},	nCount = 1},
			[2]	={szName = "Bao l× x× n¨m míi (®¹i) ",	tbProp = {6,1,1030,1,0,0},	nCount = 1},
			[3]	={szName = "Ph¸o",	tbProp = {6,1,1031,1,0,0},	nCount = 1},
			[4]	={szName = "Ph¸o Phóc Léc ",	tbProp = {6,1,1032,1,0,0},	nCount = 1},
			[5]	={szName = "Ph¸o Phóc Thä ",	tbProp = {6,1,1033,1,0,0},	nCount = 1},
			[6]	={szName = "Ph¸o May m¾n",	tbProp = {6,1,1034,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_birthday_jieri_2009	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "T©n B¶n Cæ",	tbProp = {6,1,2068,1,0,0},	nCount = 1},
			[2]	={szName = "T©n B¶n Kú",	tbProp = {6,1,2069,1,0,0},	nCount = 100},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	elseif (CFG_mengjiang2007	==	1) then
		local tbVatPhamEvent_TP =
			{
			[1]	={szName = "Méc Bµi",	tbProp = {6,1,1478,1,0,0},	nCount = 1},
			[2]	={szName = "§ång Bµi",	tbProp = {6,1,1479,1,0,0},	nCount = 1},
			[3]	={szName = "Ng©n Bµi",	tbProp = {6,1,1480,1,0,0},	nCount = 1},
			[4]	={szName = "Kim Bµi",	tbProp = {6,1,1481,1,0,0},	nCount = 1},
			[5]	={szName = "Ngäc Bµi",	tbProp = {6,1,1482,1,0,0},	nCount = 1},
			}
		tbAwardTemplet:GiveAwardByList(tbVatPhamEvent_TP, "NhËn thµnh phÇm Event-NobitaXD", 1)
	else
		Talk(1, "", "HiÖn t¹i kh«ng cã Event nµo ®­îc më.")
	end
end
-----------------------
-- 2023/07/06
-- Shop Item Thu Phi
-----------------------
function OpenShop()
	local	nKNB	=	nKNB_NhatKy
	if	(CFG_ShopItemThuPhi	== 0)	then
		Talk(1, "", "HiÖn t¹i kh«ng më.")
		return 0				
	else
	local szTitlez =  "<color=yellow>Vâ L©m TruyÒn Kú 1 - 2009<color> - <color=blue>Phong Háa Liªn Thµnh!.<color>\nGöi quý nh©n sÜ th©n mÕn! Tuy lµ Server miÔn phÝ, tuy nhiªn ®Ó cã chÊt l­îng æn ®Þnh nhÊt cho mäi ng­êi ch¬i. Team ®· ®Çu t­ Server vµ c¸c phô phÝ ®Ó vËn hµnh cho toµn m¸y chñ dïng chung. ë ®©y kh«ng Ðp buéc bÊt kú ai ph¶i Donate vµ còng ®Ó ®¸p lÔ Anh Em ñng hé th× m¸y chñ cã b¸n mét sè vËt phÈm ®Ó Anh Em quý mÕn ñng hé cho Server cã kinh phÝ duy tr× hµng th¸ng!\n<color=wood>   1. NhÊt kû cµn kh«n phï (30 ngµy) gi¸ "..nKNB.." Kim Nguyªn B¶o víi c¸c thuéc tÝnh sau:<color>\n<color=cyan>     - T¨ng +1 cÊp kü n¨ng vèn cã<color>\n<color=cyan>     - Phôc håi sinh lùc néi lùc 50 ®iÓm<color>\n<color=cyan>     - T¨ng kh¸ng tÊc c¶ + 10%<color>\n<color=cyan>     - x2 §iÓm kinh nghiÖm luyÖn c«ng<color>"
		local tbOpt =
		{
		{"Mua NhÊt Kû (30 ngµy)", pay_NhatKy},
		{"Mua ThÇn Hµnh Phï (30 ngµy)", pay_THP},
		{"Mua Thæ §Þa Phï (30 ngµy)", pay_TDP},
		{"Mua D· TÈu LÖnh bµi", pay_DTLB},
		{"Mua LÖnh Bµi Thñy TÆc", pay_LBTT},
		--{"Mua T©m T©m T­¬ng ¸nh Phï (30 ngµy)", pay_TTTAP},
		{"Tho¸t"},
		}
		CreateNewSayEx(szTitlez, tbOpt)	
	return 1				
	end
end

function pay_LBTT()
	local nTD = nTD_LBTT
	Buy_LBTT(nTD)
end
function Buy_LBTT(nNedCount)
	local nTD = nTD_LBTT
	if (nNedCount < nTD or nNedCount == nil) then
		print("Fail!!!!");
		return
	end;
	if CalcFreeItemCellCount() < 2 then 
		Say("B¸n hµng rong: Xin h·y s¾p xÕp l¹i hµnh trang!",0);
		return 0;
	end
	local nCount = CalcEquiproomItemCount(4, 417, 1, 1)

	if (nCount < nNedCount) then
		Talk(1,"","Kh¸ch quan ch­a ®ñ <color=yellow>"..nTD.." TiÒn §ång<color>! Khi nµo cã ®ñ <color=yellow>"..nTD.." TiÒn §ång<color> h·y quay l¹i. ")
		return 1;
	end
	ConsumeEquiproomItem(nNedCount, 4, 417, 1, 1)
	local tbItem ={szName="LÖnh Bµi Thñy TÆc",tbProp={6,1,2745,1,0,0},nCount=1,nExpiredTime=1440*30,nBindState = -2}
		tbAwardTemplet:GiveAwardByList(tbItem, "LÖnh Bµi Thñy TÆc", 1)
	return 0;

end

function pay_DTLB()
	local nTD = nTD_DTLB
	Buy_DTLB(nTD)
end
function Buy_DTLB(nNedCount)
	local nTD = nTD_DTLB
	if (nNedCount < nTD or nNedCount == nil) then
		print("Fail!!!!");
		return
	end;
	if CalcFreeItemCellCount() < 2 then 
		Say("B¸n hµng rong: Xin h·y s¾p xÕp l¹i hµnh trang!",0);
		return 0;
	end
	local nCount = CalcEquiproomItemCount(4, 417, 1, 1)

	if (nCount < nNedCount) then
		Talk(1,"","Kh¸ch quan ch­a ®ñ <color=yellow>"..nTD.." TiÒn §ång<color>! Khi nµo cã ®ñ <color=yellow>"..nTD.." TiÒn §ång<color> h·y quay l¹i. ")
		return 1;
	end
	ConsumeEquiproomItem(nNedCount, 4, 417, 1, 1)
	local tbItem ={szName="Hoµn thµnh D· TÈu LÖnh bµi",tbProp={6,1,4379,1,0,0},nCount=1,nExpiredTime=1440*30,nBindState = -2}
		tbAwardTemplet:GiveAwardByList(tbItem, "Hoµn thµnh D· TÈu LÖnh bµi", 1)
	return 0;

end

function pay_TDP()
	local nTD = nTD_TDP
	Buy_TDP(nTD)
end
function Buy_TDP(nNedCount)
	local nTD = nTD_TDP
	if (nNedCount < nTD or nNedCount == nil) then
		print("Fail!!!!");
		return
	end;
	if CalcFreeItemCellCount() < 2 then 
		Say("B¸n hµng rong: Xin h·y s¾p xÕp l¹i hµnh trang!",0);
		return 0;
	end
	local nCount = CalcEquiproomItemCount(4, 417, 1, 1)

	if (nCount < nNedCount) then
		Talk(1,"","Kh¸ch quan ch­a ®ñ <color=yellow>"..nTD.." TiÒn §ång<color>! Khi nµo cã ®ñ <color=yellow>"..nTD.." TiÒn §ång<color> h·y quay l¹i. ")
		return 1;
	end
	ConsumeEquiproomItem(nNedCount, 4, 417, 1, 1)
	local tbItem ={szName="Thæ ®~a phï (sö dông v« h¹n)",tbProp={6,1,438,1,0,0},nCount=1,nExpiredTime=1440*30,nBindState = -2}
		tbAwardTemplet:GiveAwardByList(tbItem, "Thæ ®~a phï (sö dông v« h¹n)", 1)
	return 0;

end

function pay_THP()
	local nTD = nTD_THP
	Buy_THP(nTD)
end
function Buy_THP(nNedCount)
	local nTD = nTD_THP
	if (nNedCount < nTD or nNedCount == nil) then
		print("Fail!!!!");
		return
	end;
	if CalcFreeItemCellCount() < 2 then 
		Say("B¸n hµng rong: Xin h·y s¾p xÕp l¹i hµnh trang!",0);
		return 0;
	end
	local nCount = CalcEquiproomItemCount(4, 417, 1, 1)

	if (nCount < nNedCount) then
		Talk(1,"","Kh¸ch quan ch­a ®ñ <color=yellow>"..nTD.." TiÒn §ång<color>! Khi nµo cã ®ñ <color=yellow>"..nTD.." TiÒn §ång<color> h·y quay l¹i. ")
		return 1;
	end
	ConsumeEquiproomItem(nNedCount, 4, 417, 1, 1)
	local tbItem ={szName="ThÇn Hµnh Phï",tbProp={6,1,1266,1,0,0},nCount=1,nExpiredTime=1440*30,nBindState = -2}
		tbAwardTemplet:GiveAwardByList(tbItem, "ThÇn Hµnh Phï", 1)
	return 0;

end

function pay_NhatKy()
	local nKNB = nKNB_NhatKy
	Buy_NhatKy(nKNB)
end
function Buy_NhatKy(nNedCount)
	local nKNB = nKNB_NhatKy
	if (nNedCount < nKNB or nNedCount == nil) then
		print("Fail!!!!");
		return
	end;
	if CalcFreeItemCellCount() < 2 then 
		Say("B¸n hµng rong: Xin h·y s¾p xÕp l¹i hµnh trang!",0);
		return 0;
	end
	local nCount = CalcEquiproomItemCount(4, 343, 1, 1)

	if (nCount < nNedCount) then
		Talk(1,"","Kh¸ch quan ch­a ®ñ <color=yellow>"..nKNB.." Kim Nguyªn B¶o<color>! Khi nµo cã ®ñ <color=yellow>"..nKNB.." Kim Nguyªn B¶o<color> h·y quay l¹i. ")
		return 1;
	end
	ConsumeEquiproomItem(nNedCount, 4, 343, 1, 1)

	AddItem(6,1,4378,1,0,0,0)	-- NhÊt Kû Cµn Kh«n Phï
	Talk(1, "", "C¶m ¬n b¹n ®· mua ñng hé m¸y chñ. Khi sö dông sÏ nhËn ®­îc hiÓu qu¶ trong 30 ngµy!")
	return 0;

end

function TienDongToKNB()
	Buy_TienDongToKNB(20)
end
function Buy_TienDongToKNB(nNedCount)
	if (nNedCount < 20 or nNedCount == nil) then
		print("Fail!!!!");
		return
	end;
	if CalcFreeItemCellCount() < 2 then 
		Say("B¸n hµng rong: Xin h·y s¾p xÕp l¹i hµnh trang!",0);
		return 0;
	end
	local nCount = CalcEquiproomItemCount(4, 417, 1, 1)

	if (nCount < nNedCount) then
		Talk(1,"","Kh¸ch quan ch­a ®ñ <color=yellow> 20 TiÒn §ång<color>! Khi nµo cã ®ñ <color=yellow>20 TiÒn §ång <color> h·y quay l¹i. ")
		return 1;
	end
	ConsumeEquiproomItem(nNedCount, 4, 417, 1, 1)

	AddStackItem(1,4,343,1,1,0,0,0)

	return 0;

end

function TanThu_Support()

	local nCurLevel = GetLevel()
	if nCurLevel > 1 then
		Talk(1,"","Kh«ng ph¶i c¸c h¹ ®· nhËn <color=yellow>Hç Trî T©n Thñ<color> ë ta mét lÇn råi sao?")
		return
	end
	if (CFG_HoTroTanThu	==	1) then
		HoTroTanThu()
		AddLeadExp(10000000)
	end
end

function NhatKy_Fix()
			if (GetSkillState(966) == -1) then
				Talk(1,"","B¹n kh«ng thuéc danh s¸ch ®Òn bï?")
				return
			else
	PlayerFunLib:AddSkillState(966,1,3,46656000,1)
	PlayerFunLib:AddSkillState(979,1,3,46656000,1)
	-- PlayerFunLib:AddSkillState(967,1,3,46656000,1)
	PlayerFunLib:AddSkillState(1208,1,3,46656000,1)
	PlayerFunLib:AddSkillState(314,1,3,46656000,1)
	PlayerFunLib:AddSkillState(892,1,3,46656000,1)  --- x2 exp moi
	-- PlayerFunLib:AddSkillState(1697,1,3,1080*60*24,1) ---- 24h
	AddLeadExp(20000000)
	Talk(1,"","§· nhËn thµnh c«ng")
	WriteLog(date("%Y%m%d %H%M%S").."\t".."Sö dông NhÊt Kû Cµn Kh«n Phï".."\t".. GetAccount().."\t"..GetName())
			end;

	
	
end

function EventBaoDanh_QuaTang()
	local task_fanpage = GetTask(5800);
	if task_fanpage > 0 then
			Say("<color=fire>§¹i hiÖp §¹i HiÖp §· NhËn Råi!", 0)
		return 1
	end

	local Name=GetName()
	if (Name == "LohasFlask") or (Name == "TLÙDatÙMa") or (Name == "§¹iÙS­ÙHuynh")	or (Name == "GameMaster")	or (Name == "PhôcÙHæÙLaÙH¸n")	or (Name == "O»nÙTµÙLµÙV»n")	or (Name == "AlanKhoa")		then 
		local tbItem = {
					{szName="LÔ bao Vâ L©m TruyÒn Kú 1",	tbProp={6,1,4380,1,0,0},			nCount=1,nBindState=-2,	nExpiredTime=1440*60},
					{szName="NhÊt Kû Cµn Kh«n Phï (30 Ngµy)",		tbProp={6,1,4378,1,0,0},			nCount=1,nBindState=-2,	nExpiredTime=1440*60},
				}
		tbAwardTemplet:GiveAwardByList(tbItem, "b¸o danh facebook", 1)
		SetTask(5800,1)
		Msg2SubWorld("§¹i HiÖp <color=yellow>"..GetName().."<color> ®· nhËn <color=green>Th­ëng Sù KiÖn Group Trµ Chanh<color>. Thµnh c«ng.");
	else 
		Talk(1, "", "§¹i hiÖp ch­a b¸o danh, nªn khu«ng cã trong danh s¸ch quµ tÆng lÇn nµy <color=yellow>T¹i Group Trµ Chanh - ChÐm Giã<color>.")
	end
end


function Suport8x()
	local a = GetTask(1533);	
	if (a == 1) then	
		Talk(1,"","B¹n ®· nhËn råi!")
	return end;

	if(CalcFreeItemCellCount() < 35)then
		Talk(1,"no","§Ó ®¶m b¶o kh«ng r¬i vËt phÈm ra ngoµi, cÇn 35 « trèng trong hµnh trang.")
	return end;

	if (GetLevel() < 80) then
		Say("ThËt ®¸ng tiÕc, chØ cã nh÷ng hiÖp kh¸ch tõ Level 80 trá lªn míi cã thÓ nhËn hç trî", 0)
		return
	end

		if (GetFaction() == "emei") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2963,1,0,0}, nCount = 4,nBindState = -2});
			local s = random(1,3)
			if s==1 then
				if (HaveMagic(328) == -1) then AddMagic(328,1) end
			end;
			if s==2 then
					if (HaveMagic(380) == -1) then AddMagic(380,1) end
			end;
			if s==3 then
				if (HaveMagic(332) == -1) then AddMagic(332) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - Nga My")
		elseif (GetFaction() == "cuiyan") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2964,1,0,0}, nCount = 2,nBindState = -2});
			local s = random(1,2)
			if s==1 then
				if (HaveMagic(336) == -1) then AddMagic(336,1) end
			end;
			if s==2 then
					if (HaveMagic(337) == -1) then AddMagic(337,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - Thóy Yªn")
		elseif (GetFaction() == "tangmen") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2961,1,0,0}, nCount = 4,nBindState = -2});
			local s = random(1,3)
			if s==1 then
				if (HaveMagic(339) == -1) then AddMagic(339,1) end
			end;
			if s==2 then
				if (HaveMagic(302) == -1) then AddMagic(302,1) end
			end;
			if s==3 then
				if (HaveMagic(342) == -1) then AddMagic(342,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - §­êng M«n")
		elseif (GetFaction() == "wudu") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2962,1,0,0}, nCount = 3,nBindState = -2});
			local s = random(1,2)
			if s==1 then
				if (HaveMagic(353) == -1) then AddMagic(353,1) end
			end;
			if s==2 then
				if (HaveMagic(355) == -1) then AddMagic(355,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - Ngò §éc")
		elseif (GetFaction() == "tianwang") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2960,1,0,0}, nCount = 3,nBindState = -2});
			local s = random(1,3)
			if s==1 then
				if (HaveMagic(322) == -1) then AddMagic(322,1) end
			end;
			if s==2 then
				if (HaveMagic(323) == -1) then AddMagic(323,1) end
			end;
			if s==3 then
				if (HaveMagic(325) == -1) then AddMagic(325,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - Thiªn V­¬ng")
		elseif (GetFaction() == "shaolin") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2959,1,0,0}, nCount = 2,nBindState = -2});
			local s = random(1,3)
			if s==1 then
				if (HaveMagic(318) == -1) then AddMagic(318,1) end
			end;
			if s==2 then
				if (HaveMagic(319) == -1) then AddMagic(319,1) end
			end;
			if s==3 then
				if (HaveMagic(321) == -1) then AddMagic(321,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - ThiÕu L©m")
		elseif (GetFaction() == "wudang") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2967,1,0,0}, nCount = 2,nBindState = -2});
				local s = random(1,2)
			if s==1 then
				if (HaveMagic(365) == -1) then AddMagic(365,1) end
			end;
			if s==2 then
				if (HaveMagic(368) == -1) then AddMagic(368,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - Vâ §ang")
		elseif (GetFaction() == "kunlun") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2968,1,0,0}, nCount = 3,nBindState = -2});
			local s = random(1,2)
			if s==1 then
				if (HaveMagic(372) == -1) then AddMagic(372,1) end
			end;
			if s==2 then
				if (HaveMagic(375) == -1) then AddMagic(375,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - C«n L«n")
		elseif (GetFaction() == "tianren") then
			local s = random(1,3)
			if s==1 then
					if (HaveMagic(361) == -1) then AddMagic(361,1) end
			end;
			if s==2 then
				if (HaveMagic(362) == -1) then AddMagic(362,1) end
			end;
			if s==3 then
				if (HaveMagic(391) == -1) then AddMagic(391) end
			end;
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2966,1,0,0}, nCount = 3,nBindState = -2});
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - Thiªn NhÉn")
		elseif (GetFaction() == "gaibang") then
			-- tbAwardTemplet:GiveAwardByList({szName="BÝ kiÕp 80", tbProp={6,1,2965,1,0,0}, nCount = 2,nBindState = -2});
			local s = random(1,2)
			if s==1 then
				if (HaveMagic(357) == -1) then AddMagic(357,1) end
			end;
			if s==2 then
				if (HaveMagic(359) == -1) then AddMagic(359,1) end
			end;
			SetTask(1533,1);
			Msg2Player("NhËn ®­îc bÝ quyÕt M«n Ph¸i - C¸i Bang")
		else
			Talk(1,"","B¹n cÇn gia nhËp m«n ph¸i míi cã thÓ sö dông chøc n¨ng nµy!")
		end
end

Include("\\script\\global\\repute_head.lua")
Include("\\script\\global\\skills_table.lua")

function main_nvmp()
	player_Faction = GetFaction()
	if	(player_Faction == "wudang") then	Done_VoDang()
	elseif	(player_Faction == "wudu") then	Done_NguDoc()
	elseif	(player_Faction == "gaibang") then	Done_CaiBang()
	elseif	(player_Faction == "cuiyan") then	Done_ThuyYen()
	elseif	(player_Faction == "tangmen") then	Done_DuongMon()
	elseif	(player_Faction == "emei") then	Done_NgaMy()
	elseif	(player_Faction == "shaolin") then	Done_ThieuLam()
	elseif	(player_Faction == "tianren") then	Done_ThienNhan()
	elseif	(player_Faction == "tianwang") then	Done_ThienVuong()
	elseif	(player_Faction == "kunlun") then	Done_ConLon()
	else
		Talk(1, "", "T­ chÊt ng­¬i kh«ng tÖ, h·y luyÖn tËp thªm sÏ cã ngµy thµnh danh !.")
		return	1
	end
end

function Done_ThieuLam()
--function L10_prise()
	Talk(1,"","RÊt tèt! Ng­¬i ®­îc th¨ng lµm Hé ViÖn Vâ T¨ng.")
	SetTask(7,20*256)
	SetRank(2)
	add_sl(20)
	AddNote("LÊy ®­îc Kim Liªn Hoa, trë l¹i gÆp HuyÒn Nh©n ph­¬ng Tr­îng, hoµn thµnh thö th¸ch ThiÕu L©m ph¸i. Th¨ng cÊp Hé ViÖn Vâ T¨ng. ")
	Msg2Player("Chóc mõng b¹n! B¹n ®· th¨ng cÊp Hé ViÖn Vâ T¨ng cña ThiÕu L©m ph¸i! Häc ®­îc ThiÕu L©m QuyÒn Ph¸p, ThiÕu L©m C«n Ph¸p, ThiÕu L©m §ao ph¸p. ")
--end;

--function L20_prise()
	Talk(2,"","S­ thóc! Ta ®· thu phôc 5 tªn man rî kia, tõ nay vÒ sau hä kh«ng d¸m g©y sù n÷a ®©u!","Ng· PhËt tõ bi! ThiÖn tai thiÖn tai!")
	SetTask(7,30*256)
	SetRank(3)
	add_sl(30)
	AddNote("Thu phôc ®­îc n¨m g· ngç ng­îc, th¨ng cÊp Hé Tù Kim Cang. ")
	Msg2Player("Chóc mõng b¹n! B¹n ®· th¨ng cÊp Hé Tù Kim Cang cña ThiÕu L©m tù! Häc ®­îc vâ c«ng BÊt §éng Minh V­¬ng. ")
--end;

--function L30_prise()
	Talk(1,"","§a t¹ s­ thóc!")
	SetTask(7,40*256)
	SetRank(4)
	add_sl(40)
	AddNote("LÊy l¹i ®­îc B¸t Nh· Ba La MËt §a T©m Kinh, th¨ng chøc Hé Ph¸p La H¸n. ")
	Msg2Player("Chóc mõng b¹n! B¹n ®· th¨ng chøc Hé Ph¸p La H¸n cña ThiÕu L©m ph¸i! Häc ®­îc vâ c«ng La H¸n TrËn. ")
--end;

--function L40_sele3_result()
	Talk(1,"","NhiÖm vô nµy ng­¬i hoµn thµnh tèt l¾m, vi s­ sÏ th¨ng ng­¬i lµm ®Ö tö cÊp 40, ®õng lµm ta thÊt väng nhÐ!")
	SetTask(7,50*256)
	SetRank(5)
	add_sl(50)
	AddNote("LÊy ®­îc lêi chØ b¶o tõ chç TÞch DiÖt NhÞ T¨ng, hoµn thµnh nhiÖm vô TÞch DiÖt NhÞ T¨ng. Th¨ng cÊp TruyÒn Kinh La H¸n. ")
	Msg2Player("Chóc mõng b¹n. B¹n ®· th¨ng cÊp TruyÒn Kinh La H¸n cña ThiÕu L©m ph¸i! Häc ®­îc vâ c«ng S­ Tö Hèng. ")
--end;

--function L50_prise()
	Talk(1,"","§©y ®óng lµ 'DÞch Cèt Kinh'! Hay qu¸.....")
	SetTask(7,60*256)
	SetRank(6)
	add_sl(60)
	AddNote("T×m ®­îc DÞch Cèt Kinh, hoµn thµnh nhiÖm vô t×m kinh. Th¨ng cÊp Phôc ma Thiªn V­¬ng. ")
	Msg2Player("Chóc mõng b¹n! B¹n ®· th¨ng chøc Phôc ma Thiªn V­¬ng cña ThiÕu L©m ph¸i! Häc ®­îc vâ c«ng Long Tr¶o Hæ Tr¶o, Hoµnh Quy Lôc Hîp, Ma Ha V« L­îng. ")
--end;

--function L60_prise()
	Talk(2,"","Chóc mõng ng­¬i ®· x«ng qua ®­îc 108 La H¸n TrËn, ng­¬i cã thÓ xuÊt s­, vÒ sau hµnh tÈu giang hå, cøu tÕ gióp ng­êi, hµnh hiÖp tr­îng nghÜa, kh«ng ®­îc cã vâ sanh kiªu, nhí lÊy ®ã!","§Ö tö xin ghi nhí!")
	SetRank(62)
	SetTask(7,70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("Trong La H¸n TrËn t×m ®­îc 4 mãn tÝn vËt giao cho HuyÒn Nan, hoµn thµnh nhiÖm vô xuÊt s­. Th¨ng chøc V« L­îng ThÝch T«n, thuËn lîi xuÊt s­. ")
	Msg2Player("Chóc mõng B¹n xuÊt s­! B¹n ®· ®­îc phong lµm V« L­îng ThÝch T«n ")
--end;
--function return_complete()
		Talk(1,"","RÊt tèt! C¨n cø theo sù ®ãng gãp cña ng­¬i cho bæn tù, ®­îc vinh h¹nh nhËn chøc danh Hé Ph¸p Tr­ëng l·o.")
		SetTask(7,80*256)
		SetFaction("shaolin")
		SetCamp(1)
		SetCurCamp(1)
		SetRank(72)
		add_sl(70)
		Msg2Player("B¹n häc ®­îc tuyÖt häc trÊn ThiÕu L©m ph¸i Nh­ Lai Thiªn DiÖp, vâ c«ng DÞch C©n Kinh. ")
		AddNote("§· quay trë l¹i ThiÕu L©m ph¸i. ")
		Msg2Faction(GetName().." ®· trë l¹i ThiÕu L©m, ®­îc phong lµ: Hé Ph¸p Tr­ëng l·o ")
--end;
--function enroll_prise()
	Talk(1,"","Xem ra ng­¬i ®· héi ®ñ bèn phÈm chÊt ®ã! Chóc mõng ng­¬i, tõ nµy vÒ sau ng­êi ®· trë thµnh ®Ö tö ký danh cña bæn ph¸i råi!")
	i = ReturnRepute(12,29,2)
	AddRepute(i)
	Uworld38 = SetByte(GetTask(38),2,127)
	SetTask(38,Uworld38)
	Msg2Player("Hoµn thµnh nhiÖm vô ký danh ®Ö tö cña ThiÕu L©m ph¸i, trë thµnh ®Ö tö ThiÕu L©m, danh väng t¨ng lªn. "..i.."®iÓm.")
	AddNote("Hoµn thµnh nhiÖm vô ký danh ®Ö tö cña ThiÕu L©m ph¸i, trë thµnh ®Ö tö ThiÕu L©m. ")
--end;
--function U122_prise()
		Talk(2,"HuyÒn Nan: Kim quèc ®ang tiÕp tôc ®éng binh, vâ l©m Trung Nguyªn sÏ l¹i cã mét phen kinh thiªn ®éng ®Þa. ë ®©y l·o t¨ng cã mét quyÓn 'ThiÕu L©m TuyÖt kü', tÆng cho tiÓu h÷u, hy väng ng­¬i ch¨m chØ luyÖn c«ng, kh«ng chØ trë thµnh ®Ö tö cña bæn tù mµ cß cã thÓ lµ ","Sù r¨n d¹y cña ®¹i s­, tiÓu tö sao kh«ng d¸m tu©n theo!")
		if (HaveMagic(318) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(318,1)
		end
		if (HaveMagic(319) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(319,1)
		end
		if (HaveMagic(321) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(321,1)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("Häc ®­îc kü n¨ng ThiÕu L©m: §¹t Ma §é Giang, Hoµnh T¶o Thiªn Qu©n, V« T­íng Tr¶m. ")
		SetTask(122,255)
   add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
   AddRepute(add_repute)
   Msg2Player("")
   Msg2Player("Cøu Th­êng, Lý hai ng­êi, hîp gi¶i cïng thiÒn t¨ng, hoµn thµnh nhiÖm vô ThiÕu L©m. Danh väng cña b¹n t¨ng thªm. "..add_repute.."®iÓm.")
   AddNote("Cøu xuÊt Th­êng, Lý hai ng­êi, hîp gi¶i cïng thiÒn t¨ng, hoµn thµnh nhiÖm vô ThiÕu L©m. ")
--end
end

-- Ph¸i Thiªn V­¬ng
function Done_ThienVuong()
--function L10_prise()
	Talk(1,"","Lµm rÊt tèt! L·o phu sÏ phong cho ng­¬i lµm ThÞ VÖ tr­ëng! Sau nµy cã rÊt nhiÒu thö th¸ch ®ang chê, ng­¬i cÇn ph¶i tiÕp tôc cè g¾ng")
	SetTask(3, 20*256)
	SetRank(44)
	add_tw(20)
	Msg2Player("Chóc mõng B¹n! §· ®­îc phong lµm tr­ëng thÞ. Häc ®­îc: Thiªn V­¬ng Chïy Ph¸p, Thiªn V­¬ng Th­¬ng Ph¸p, Thiªn V­¬ng §ao Ph¸p. ")
	AddNote("Quay l¹i tiÒn ®iÖn, mang 3 viªn Kª HuyÕt Th¹ch giao cho V­¬ng Hùu, hoµn thµnh nhiÖm vô Kª HuyÕt Th¹ch, ®­îc phong lµm Tr­ëng thÞ vÖ. ")
--end;
--function L20_prise()
	Talk(1,"","Ng­¬i®¬n th©n ®éc m· x«ng vµo sµo huyÖt cña bän thæ phØ v× d©n trõ h¹i, lµm thËt tèt! Bæn to¹ xem víi t­ chÊt cña ng­¬i chØ cÇn tËp luyÖn mét thêi gian ch¾c ch¾n sÏ trë thµnh mét nh©n vËt næi tiÕng vang danh thiªn h¹!")
	SetRank(45)
	SetTask(3, 30*256)
	add_tw(30)
	Msg2Player("Chóc mõng b¹n! §· hoµn thµnh nhiÖm vô ®éng B¹ch Thuû ®­îc phong lµm Thñ Tr¹i H¶n T­íng, sÏ ®­îc häc vâ c«ng TÜnh T©m QuyÕt cña Thiªn V­¬ng bang ")
	AddNote("Trë l¹i ®¶o Thiªn V­¬ng mang CÈm K× giao cho D­¬ng Hå hoµn thµnh nhiÖm vô ®éng B¹ch Thuû, ®­îc phong lµm Thñ Tr¹i H·n T­íng ")
--end;
--function L30_prise()
	Talk(1,"","Th× ra Thiªn V­¬ng LÖnh ®· bÞ bän c­íp ë YÕn Tö ®éng trém mÊt, may lµ t×m l¹i ®­îc, nÕu kh«ng sÏ bÞ bang chñ quë tr¸ch. Ng­¬i thËt ®· gióp ta mét viÖc lín. Bæn sø nãi lêi sÏ gi÷ lÊy lêi, nhÊt ®Þnh sÏ phong ng­¬i lµm Ch­ëng §¸ §Çu LÜnh.")
	SetRank(46)
	SetTask(3, 40*256)
	add_tw(40)
	Msg2Player("Mang Thiªn V­¬ng lÖnh giao cho Cæ B¸ch, hoµn thµnh nhiÖm vô Thiªn V­¬ng lÖnh. §­îc phong lµ: Ch­ëng §µ §Çu LÜnh. Häc ®­îc B¸t Phong Tr¶m, D­¬ng Quan Tam §iÖp, Hµng V©n QuyÕt. ")
	AddNote("Trë l¹i ®¶o Thiªn V­¬ng mang Thiªn V­¬ng lÖnh giao cho Cæ B¸ch, hoµn thµnh nhiÖm vô, ®­îc phong lµ: Ch­ëng §µ §Çu LÜnh ")
--end;
--function L40_prise()
	Talk(1,"","Tèt qu¸! Cã nh÷ng d­îc liÖu nµy th× Ng« C­¬ng sÏ ®­îc cøu! ThËt kh«ng biÕt ph¶i c¶m ¬n ng­¬i thÕ nµo ®©y?!")
	SetRank(47)
	SetTask(3, 50*256)
	add_tw(50)
	Msg2Player("Mang hai vÞ thuèc giao cho Lé V©n ViÔn, hoµn thµnh nhiÖm vô, ®­îc phong lµm Thuû §¹o thèng lÜnh. Häc ®­îc: §o¹n Hån ThÝch ")
	AddNote("Quay vÒ ®¹i ®iÖn Thiªn V­¬ng mang hai vÞ thuèc giao cho Lé V©n ViÔn, hoµn thµnh nhiÖm vô. §­îc phong lµ: Thuû §¹o thèng lÜnh ")
--end;
--function L50_prise()
	Talk(1,"","Ngò S¾c th¹ch nµy kh«ng chØ cã thÓ an ®Þnh lßng ng­êi mµ cßn mang h¹nh phóc cho bæn bang. ThËt lµ trêimuèn gióp ta!")
	SetTask(3, 60*256)
	SetRank(48)
	add_tw(60)
	Msg2Player("Hoµn thµnh nhiÖm vô thñy qu¸i, trë thµnh Hé §¶o T­íng qu©n, häc ®­îc vâ c«ng Kim Chung Tr¸o. ")
	AddNote("Trë l¹i Thiªn V­¬ng Bang, giao Ngò s¾c th¹ch cho Phóc Thµnh hoµn thµnh nhiÖm vô, trë thµnh Hé §¶o t­íng qu©n. ")
--end;
--function L60_prise()
	Msg2Player("Chóc mõng b¹n ®· xuÊt s­ thµnh c«ng, b¹n ®­îc phong lµ TrÊn Bang Nguyªn So¸i! Danh väng t¨ng thªm 120 ®iÓm! ")
	Msg2SubWorld("Thiªn V­¬ng"..GetName().."XuÊt s­ thµnh c«ng, c¸o biÖt D­¬ng bang chñ vµ c¸c ®ång m«n huynh ®Ö, tiÕp tôc hµnh tÈu giang hå. ")
	AddRepute(120)
	SetRank(79)
	SetTask(3, 70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("Quay l¹i TÈm cung Thiªn V­¬ng Bang, ®­a Thiªn V­¬ng Di Th­ cho Bang chñ D­¬ng Anh, hoµn thµnh nhiÖm vô xuÊt s­. Th¨ng chøc K×nh Thiªn Nguyªn So¸i.. ")
--end;
--function return_complete()
		Talk(1,"","RÊt tèt! Hoan nghªnh ng­¬i trë l¹i Thiªn V­¬ng Bang, ta phong ng­¬i lµ K×nh Thiªn Nguyªn So¸i. ")
		SetTask(3, 80*256)
		SetFaction("tianwang")
		SetCamp(3)
		SetCurCamp(3)
		SetRank(69)
		add_tw(70)
		Msg2Player("B¹n häc ®­îc tuyÖt kü trÊn ph¸i cña Thiªn V­¬ng bang: Thiªn V­¬ng ChiÕn ý, Vâ C«ng V« T©m Tr¶m, HuyÕt ChiÕn B¸t ph­¬ng, Thõa Long QuyÕt. ")
		AddNote("§· quay trë l¹i Thiªn V­¬ng bang. ")
		Msg2Faction(GetName().." ®· trë l¹i Thiªn V­¬ng bang, ®­îc phong lµ K×nh Thiªn Nguyªn So¸i")
--end;
--function Uworld38_prise()
	Talk(1,"","Bång Lai Xu©n! Qu¶ thËt lµ h¶o töu! Võa më n¾p ra ®· ngöi thÊy mïi th¬m ngµo ng¹t! Xem ra ng­¬icòng lµ mét ng­êi cã khÝ ph¸ch, mäi ng­êi cïng nhau l­u l¹c giang hå nµo!")
	Uworld38 = SetByte(GetTask(38),1,127)
	SetTask(38,Uworld38)
	i = ReturnRepute(15,19,2)
	AddRepute(i)
	AddNote("VÒ ®Õn Thiªn V­¬ng ®¶o, ®em Liªn Lai Xu©n giao cho T«n §¹o LÜnh, hoµn thµnh nhiÖm vô Ký danh ®Ö tö. ")
	Msg2Player("VÒ ®Õn Thiªn V­¬ng ®¶o, ®em Liªn Lai Xu©n giao cho T«n §¹o LÜnh, hoµn thµnh nhiÖm vô Ký danh ®Ö tö, Danh väng cña b¹n t¨ng thªm. "..i.."®iÓm.")
--end;
--function Uworld121_yanghu2()
		Talk(2,"","ThËt vÊt v¶ cho ng­¬i®· nãi cho t¹i h¹ biÕt kÕ ho¹ch x©m chiÕm cña ph¸i C«n L«n! §©y cã mét quyÓn mËt tÞch cña Thiªn V­¬ng bang! Xin h·y nhËn lÊy!","Ta nhÊt ®Þnh sÏ chuyªn cÇn rÌn luyÖn vâ nghÖ! Cïng víi D­¬ng H÷u Sø b¶o vÖ giang s¬n Tèng triÒu!")
		if (HaveMagic(322) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(322,1)
		end
		if (HaveMagic(323) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(323,1)
		end
		if (HaveMagic(325) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(325,1)
   		end
		--CheckIsCanGet150SkillTask()
   	Msg2Player("Häc ®­îc kü thuËt Ph¸ Thiªn Tr¶m, Truy Tinh Trôc NguyÖt, Truy Phong QuyÕt cña Thiªn V­¬ng bang ")
   	SetTask(121,255)
	add_repute = ReturnRepute(30,95,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
	AddRepute(add_repute)
	Msg2Player("NhiÖm vô hoµn thµnh, danh väng cña b¹n ®­îc t¨ng lªn "..add_repute.."®iÓm.")
	AddNote("NhiÖm vô Bi LuyÕn Mé TuyÕt: Nãi cho D­¬ng Hå biÕt kÕ ho¹ch x©m chiÕm cña C«n L«n ph¸i nh­ng vÉn kh«ng cã c¸ch nµo hµn g¾n l¹i quan hÖ gi÷a Hµ Mé TuyÕt vµ D­¬ng Hå, nhiÖm vô hoµn thµnh. ")
--end
end

-- Ph¸i Ngò §éc
function Done_NguDoc()
--function L10_prise()
	Talk(1,"","Tèt l¾m! Ng­¬i lui ra ®i! §õng cã ng¨n trë ta luyÖn c«ng!")
	SetTask(10,20*256)
	SetRank(50)
	add_wu(20)
	Msg2Player("Chóc mõng b¹n! B¹n ®­îc th¨ng lµ §o¹t Hån T¶n Nh©n! Häc ®­îc vâ c«ng Ngò §éc Ch­ëng Ph¸p, Ngò §éc §ao Ph¸p, Cöu Thiªn Cuång L«i.")
	AddNote("Gióp Tang Ch©u t×m con nhÖn vµ TÝn th¹ch. §­îc phong lµ §o¹t Hån T¶n Nh©n.")
--end;
--function L20_prise()
	Talk(1,"","Hahaha! ThËt vui qu¸! Ng­¬i thËt rÊt cã b¶n lÜnh! §­îc! Tiªn tö ta gi÷ lêi th¨ng ng­¬i lµ Th«i MÖnh Sø Gi¶ ")
	SetTask(10,30*256)
	SetRank(51)
	add_wu(30)
	Msg2Player("Chóc mõng B¹n! §· ®­îc th¨ng lµ Ngò §éc Gi¸o Th«i mÖnh sø gi¶ SÏ ®­îc häc vâ c«ng: XÝch DiÖm Thùc Thiªn, T¹p Nan D­îc Kinh ")
	AddNote("V× B¹ch Doanh Doanh, ®i giÕt La Tiªu s¬n thÊt quû, ®­îc th¨ng lµ: Th«i MÖnh Sø Gi¶ ")
--end;
--function L30_prise()
	Talk(2,"","Méc H­¬ng §Ønh! Tèt! Tèt! Ta sÏ th­ëng ph¹t ph©n minh. LÇn nµy ng­¬i lËp ®¹i c«ng. B¾t ®Çu thõ h«m nay, ng­¬i sÏ ®­îc th¨ng lµ: H¾c ¸m Diªm La ","§a t¹ §å tr¹i chñ!")
	SetTask(10,40*256)
	SetRank(52)
	add_wu(40)
	Msg2Player("Chóc mõng B¹n! §· ®­îc th¨ng lµ H¾c ¸m Diªm La. Häc ®­îc vâ c«ng: U Minh Kh« L©u, B¸ch §éc Xuyªn T©m, B¨ng Lam HuyÒn Tinh, V« H×nh §éc ")
	AddNote("§o¹t ®­îc Méc H­¬ng §Ønh vÒ cho §å DÞ, ®­îc th¨ng lµ H¾c ¸m Diªm La ")
--end;
--function L40_prise()
	Talk(1,"","Ng­¬i lµ mét trong sè nh÷ng ng­êi ®· vµo trong Kim Xµ tr¹ch mµ cßn sèng sãt trë vÒ. Xem ra th× b¶n lÜnh cña ng­¬i qu¶ kh«ng tÇm th­êng chót nµo")
	SetTask(10,50*256)
	SetRank(53)
	add_wu(50)
	Msg2Player("Chóc mõng B¹n!: §· ®­îc th¨ng lµm: V« §æng La S¸t! Häc ®­îc vâ c«ng: Xuyªn Y Ph¸ Gi¸p, V¹n §éc Thùc T©m ")
	AddNote("TiÕn vµo Kim Xµ tr¹ch b¾t ®­îc Nh·n KÝnh v­¬ng M·ng Xµ, ®­îc th¨ng lµ V« ¦u La S¸t ")
--end;
--function L50_prise()
	Talk(2,"","Ng­¬icã thÓ ®¬n th­¬ng ®éc m· mµ ®o¹t l¹i ®­îc Ngäc San H«, qu¶ lµ b¶n lÜnh bÊt phµm. Bæn tr¹i chñ xem ng­¬i®óng lµ mét kú tµi,phong cho ng­¬ilµm Co §éc T«n Gi¶. Sau nµy ng­¬icã thÓ thay ta mµ ®iÒu hµnh mäi viÖc trong tr¹i","Tu©n lÖnh!")
	SetTask(10,60*256)
	SetRank(54)
	add_wu(60)
	AddNote("Mang Ngäc San H« vÒ cho Thang BËt, ®­îc th¨ng lµ Co §éc T«n Gi¶ ")
	Msg2Player("Chóc mõng B¹n! §· ®­îc th¨ng lµm Co §éc T«n Gi¶. Häc ®­îc vâ c«ng Xuyªn T©m §éc ThÝch ")
--end;
--function L60_prise()
	Talk(1,"","Thuéc h¹ kh¾c cèt ghi t©m. TuyÖt kh«ng d¸m quªn")
	SetTask(10,70*256)
	SetRank(70)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("§o¹t l¹i Tõ ®éc Chu tõ tay cña Nh¹n §·ng ph¸i, tr¶ l¹i cho Ngò §éc Gi¸o. Hoµn thµnh nhiÖm vô xuÊt s­. §­îc phong lµ U Minh Quû Sø, thuËn lîi xuÊt s­ ")
	Msg2Player("Chóc mõng B¹n! §· thµnh c«ng xuÊt s­. B¹n ®· ®­îc phong lµ U Minh Quû Sø ")
--end;
--function return_complete()
		Talk(1,"","Çy! Ng­¬i b©y giê ®· lµ ®Ö tö cña bæn gi¸o råi! Ta sÏ ®Ò b¹t ng­¬i lµ U Minh Quû V­¬ng ")
		SetTask(10,80*256)
		SetRank(80)
		add_wu(70)
		Msg2Player("B¹n häc ®­îc tuyÖt häc trÊn ph¸i; Ngò §éc kú Kinh, Vâ c«ng Thiªn C­¬ng §Þa S¸t. Chu C¸p Thanh Minh ")
		SetFaction("wudu")
		SetCamp(2)
		SetCurCamp(2)
		AddNote("§· quay trë l¹i Ngò §éc Gi¸o, tiÕp tôc tËp luyÖn vâ nghÖ ")
		Msg2Player(GetName().."§· quay trë l¹i Ngò §éc Gi¸o, ®­îc phong lµm U Minh quû V­¬ng. ")
--end;
--function enroll_prise()
	Talk(1,"","N¨m Khæng t­íc vò ®· gom ®ñ. Hay l¾m! VËy lµ ng­¬i ®· chÝnh thøc trë thµnh ®Ö tö ký danh cña bæn m«n råi")
	i = ReturnRepute(25,29,5)
	AddRepute(i)
	Uworld37 = SetByte(GetTask(37),2,127)
	SetTask(37,Uworld37)
	AddNote("Hoµn thµnh nhiÖm vô luyÖn c«ng ë Ngò §éc ®éng, ChÝnh thøc trë thµnh <color=red>Ký Danh ®Ö tö<color> cña bæn m«n. ")
	Msg2Player("Hoµn thµnh nhiÖm vô luyÖn c«ng ë Ngò §éc ®éng, ChÝnh thøc trë thµnh Ký Danh ®Ö tö cña bæn m«n. ")
--end;
--function Uworld_wufinish()
		Talk(2,"","ë ®©y cã mét quyÓn 'MËt d­îc Kinh 'cña Ngò §éc gi¸o, xin tÆng cho ®¹i hiÖp, xin chí chèi tõ ","VËy th× ta còng kh«ng kh¸ch s¸o! Ta sÏ nghiªn cøu quyÓn mËt kinh nµy, ®Ó cã thÓ gi¶i cøu cho thiªn h¹ ")
		if (HaveMagic(353) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(353,1)
		end
		if (HaveMagic(355) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(355,1)
		end
		if (HaveMagic(390) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(390)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("LuyÖn ®­îc kü n¨ng: ¢m D­¬ng Thùc Cèt, HuyÒn ¢m Tr¶m, §o¹n C©n Hñ Cèt ")
		SetTask(124,255)
   add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
   AddRepute(add_repute)
   Msg2Player("§em ®­îc thuèc gi¶i vÒ cho Uy DuÉn Ch©n, hoµn thµnh nhiÖm vô, danh väng cña b¹n t¨ng thªm "..add_repute.."®iÓm.")
   AddNote("§em ®­îc thuèc gi¶i vÒ cho Uy DuÉn Ch©n, hoµn thµnh nhiÖm vô ")
--end
end

-- Ph¸i §­êng M«n
function Done_DuongMon()
--function L10_prise()
	Talk(1,"","Ng­¬i qu¶ nhiªn cã b¶n lÜnh, cã thÓ gióp Bæn m«n t×m l¹i Ma Vò ch©m. §­îc! Bæn täa sÏ d¹y ng­¬i vµi chiªu, nh×n kü ®©y! ")
	SetRank(26)
	SetTask(2, 20*256)
	add_tm(20)
	AddNote("Trë vÒ Vâ C«ng phßng, giao Ma Vò Ch©m cho §­êng H¹c, hoµn thµnh nhiÖm vô, th¨ng lµm Tr¸ng ®inh. ")
	Msg2Player("Giao Ma Vò Ch©m t×m ®­îc cho §­êng H¹c, hoµn thµnh nhiÖm vô Ma Vò Ch©m, th¨ng lµ §­êng M«n Tr¸ng ®inh. Häc ®­îc §­êng M«n ¸m khÝ, §Þa DiÖm Háa. ")
--end;
--function L20_prise()
	SetRank(27)	
	SetTask(2, 30*256)
	add_tm(30)
	Msg2Player("Chóc mõng b¹n! B¹n ®· ®­îc th¨ng lµm §­êng M«n Hé ViÖn, ®­îc häc vâ c«ng §éc ThÝch Cèt ")
	AddNote("Giao Kim H¹ng quyÓn cho §­êng Cõu ch­ëng m«n, hoµn thµnh nhiÖm vô §­êng U. §­îc th¨ng lµm Hé ViÖn. ")
--end;
--function L30_prise()
	Talk(2, "", "§­êng V©n s­ thóc, t¹i h¹ ®· t×m ®­îc nh÷ng tªn Thæ PhØ b¸o thï cho «ng vµ ®o¹t vÒ 'Háa KhÝ Phæ'. ChØ cÇn «ng giao cho Ch­ëng m«n sÏ kh«ng ph¶i chÞu h×nh ph¹t n÷a!", "Ta lu«n ®îi ®Õn ngµy nµy. Ng­¬i nãi xem ng­¬i cÇn g×? Ta sÏ ®¸p øng!")
	SetRank(28)
	SetTask(2, 40*256)
	add_tm(40)
	Msg2Player("Chóc mõng b¹n! B¹n ®· ®­îc th¨ng lµm §­êng M«n Giíi TiÒn Hé VÖ, häc ®­îc: Truy T©m TiÔn, M¹n Thiªn Hoa Vò, Xuyªn T©m ThÝch. ")
	AddNote("VÒ ®Õn Háa KhÝ phßng, giao Ho¶ KhÝ Phæ cho §­êng V©n, hoµn thµnh nhiÖm vô Ho¶ KhÝ Phæ, th¨ng lµ: Giíi TiÒn Hé VÖ. ")
--end;
--function L40_prise()
	SetRank(29)
	SetTask(2, 50*256)
	add_tm(50)
	Msg2Player("Chóc mõng b¹n! B¹n ®· ®­îc th¨ng lµm ®Ö tö NhËp C¸c! Cã thÓ häc vâ c«ng Hµn B¨ng ThÝch cña §­êng M«n. ")
	AddNote("§Õn phßng thuèc §­êng m«n, phôc mÖnh §­êng D·, hoµn thµnh nhiÖm vô C¶nh Tö Kú, th¨ng lµm ®Ö tö NhËp C¸c. ")
--end;
--function L50_prise()
	SetRank(30)
	SetTask(2, 60*256)
	add_tm(60)
	Msg2Player("Giao ¸m KhÝ Phæ cho §­êng Nhµn, th¨ng lµm §­êng M«n Tø L·o M«n Nh©n! Häc ®­îc L«i KÝch ThuËt. ")
	AddNote("Giao ¸m KhÝ Phæ cho §­êng Nhµn, nhiÖm vô hoµn thµnh, th¨ng lµ: Tø L·o M«n Nh©n. ")
--end;
--function L60_prise()
	Msg2Player("Chóc mõng b¹n häc thµnh tµi cã thÓ xuÊt s­! B¹n ®­îc phong lµ Thiªn Thñ ThÇn VÖ.. Danh väng t¨ng thªm 120 diÓm. ")
	Msg2SubWorld("§­êng M«n"..GetName().."Thµnh tµi xuÊt s­, tõ biÖt c¸c huynh muéi ®ång m«n ®Ó hµnh tÈu giang hå. ")
	AddRepute(120)
	SetRank(66)
	SetTask(2, 70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("Trë vÒ §­êng M«n, giao ThÊt Tinh TuyÖt MÖnh KiÕm cho §­êng Cõu ch­ëng m«n, hoµn thµnh nhiÖm vô xuÊt s­. §­îc th¨ng lµm Thiªn Thñ ThÇn VÖ. ")
--end;
--function return_complete()
		Talk(1,"","Hay l¾m! Ng­¬i ®· thµnh t©m nh­ vËy! Ta sao nì tõ chèi!")
		SetTask(2,80*256)
		SetRank(76)
		add_tm(70)			-- µ÷ÓÃskills_table.luaÖÐµÄº¯Êý£¬²ÎÊýÎªÑ§µ½¶àÉÙ¼¶¼¼ÄÜ¡£
		Msg2Player("B¹n ®· häc ®­îc tuyÖt häc trÊn ph¸i: T©m Nh·n, vâ c«ng TiÓu Lý Phi §ao, Thiªn La §Þa Vâng, T¸n Hoa Tiªu. ")
		SetFaction("tangmen")
		SetCamp(3)
		SetCurCamp(3)
		AddNote("§· quay l¹i §­êng M«n, ®øng trong hµng ngò ")
		Msg2Player(GetName().."Quay l¹i §­êng M«n, ®­îc th¨ng lµ Lôc C¸c tr­ëng l·o. ")
--end;
--function Uworld37_prise()
	Talk(1,"","Ng­¬i ®· thuËn lîi qua ¶i, trë thµnh §Ö tö ký danh cña bæn m«n! ")
	UTask_world37 = SetByte(GetTask(37),1,127)
	i = ReturnRepute(25,19,4)		-- È±Ê¡ÉùÍû£¬×î´óÎÞËðºÄµÈ¼¶£¬Ã¿¼¶µÝ¼õÂÊ
	SetTask(37,UTask_world37)
	AddRepute(i)		-- ¼ÓÉùÍû
	Msg2Player("Mang 3 c©y tróc ®Õn Tróc H¶i Tam Quan xuÊt khÈu giao cho phßng nghÞ sù §­êng m«n, hoµn thµnh nhiÖm vô Ký Danh ®Ö tö. Trë thµnh §­êng m«n Ký Danh ®Ö tö, thanh thÕ t¨ng lªn"..i.."®iÓm.")
	AddNote("T¹i lèi ra cña Tróc H¶i Tam Quan, giao 3 c©y tre cho §­êng M«n tr¸ng ®inh, hoµn thµnh nhiÖm vô ký danh ®Ö tö. ")
--end;
--function Uworld123_step4a()
	if (HaveMagic(339) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
		AddMagic(339,1)
	end
	if (HaveMagic(302) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
		AddMagic(302,1)
	end
	if (HaveMagic(342) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
		AddMagic(342,1)
	end
	if (HaveMagic(351) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
		AddMagic(351)
	end
	--CheckIsCanGet150SkillTask()
	Msg2Player("B¹n häc ®­îc NhiÕp Hån NguyÖt ¶nh, B¹o Vò Lª Hoa, Cöu Cung Phi Tinh, Lo¹n Hoµn KÝch!")
	Msg2Player("§oan Méc DuÖ tiÕp tôc mêi b¹n vÒ b¸o tin cho §­êng BÊt NhiÔm.")
	SetTask(123,75)
	Talk(2,"","Nhê ng­¬i thay ta chuyÓn lêi cho BÊt NhiÔm C«ng Tö, nãi §oan Méc DuÖ ta quyÕt kh«ng lµm ngµi thÊt väng. ","§­îc! T¹i h¹ còng xin ®a t¹ tiÒn bèi võa råi ®· chØ d¹y. ")
--end
--function Uworld123_step4b()
	SetTask(123,70)
	Talk(1,"","RÊt tèt! nhê ng­¬i thay ta chuyÓn lêi cho BÊt NhiÔm C«ng Tö, nãi §oan Méc DuÖ ta quyÕt kh«ng lµm ngµi thÊt väng. ")
	Msg2Player("§oan Méc DuÖ tiÕp tôc mêi b¹n vÒ b¸o tin cho §­êng BÊt NhiÔm.")
--end
end

-- Ph¸i nga my
function Done_NgaMy()
--function L10_prise()
	SetRank(14)
	SetTask(1,20*256)
	add_em(20)
	Msg2Player("Chóc mõng b¹n! B¹n ®­îc th¨ng lµm Vò Y Ni, häc ®­îc Nga Mi kiÕm ph¸p, Nga Mi ch­ëng ph¸p. ")
	AddNote("Quay vÒ Nga Mi ph¸i, phôc mÖnh DiÖu Èn, hoµn thµnh nhiÖm vô g­¬ng ®ång. ")
--end;
--function L20_prise()
	Talk(1,"","Muéi cã ®ñ b¶n lÜnh vµo hang Hæ thu phôc M·nh Hæ, thËt xøng danh lµ ®Ö tö Nga Mi!")
	SetRank(15)
	SetTask(1, 30*256)
	add_em(30)
	Msg2Player("Chóc mõng b¹n! §· ®­îc th¨ng lµm CÈm Y Ni! Häc ®­îc Tõ Hµng Phæ §é. ")
	AddNote("Trë vÒ gi¶ng kinh ®­êng cña Nga Mi ph¸i, phôc mÖnh DiÖu Nh­, hoµn thµnh nhiÖm vô thu phôc m·nh hæ, ®­îc phong lµ: CÈm Y Ni. ")
--end;
--function L30_prise()
	Talk(1,"","Háa hå µ! Muéi thËt lµ ®å tinh ranh, lÇn sau kh«ng ®Ó ng­¬i ch¹y lung tung n÷a! C¶m ¬n muéi ®· gióp ta!")
	SetRank(16)
	SetTask(1, 40*256)
	add_em(40)
	Msg2Player("Chóc mõng b¹n! §­îc phong lµ: B¹ch Liªn Tiªn Tö ")
	AddNote("Mang Ho¶ Hå giao cho Môc V©n Tõ, hoµn thµnh nhiÖm vô Ho¶ Hå, ®­îc phong lµ: B¹ch Liªn Tiªn Tö ")
--end;	
--function L40_prise()
	Talk(1,"","Khóc phæ 'B¸ch §iÓu TriÒu Phông'! Tèt l¾m! TÇn s­ tû thÊy ®­îc nhÊt ®Þnh rÊt vui, c¶m ¬n tiÓu s­ muéi! ")
	SetRank(17)
	SetTask(1, 50*256)
	add_em(50)
	Msg2Player("Chóc mõng b¹n! §· trë thµnh Thanh Liªn Tiªn Tö. Häc ®­îc L­u Thuû. ")
	AddNote("VÒ Nga Mi, giao B¸ch §iÓu TriÒu Phông khóc phæ cho T« Tõ Hinh, hoµn thµnh nhiÖm vô. Th¨ng chøc thµnh Thanh Liªn Tiªn Tö. ")
--end;
--function L50_prise()
	Talk(1,"","ChuyÖn nµy ng­¬i lµm rÊt tèt, ng­¬i t­ chÊt th«ng minh, chØ cÇn tiÕp tôc cè g¾ng, tiÒn ®å nhÊt ®Þnh réng më!")
	AddNote("Quay vÒ Ch¸nh ®iÖn phôc mÖnh Thanh HiÓu S­ Th¸i, hoµn thµnh nhiÖm vô TÝn T­íng tù. §­îc th¨ng chøc T¸n Hoa Thiªn N÷, häc ®­îc PhËt Quang Phæ ChiÕu, PhËt T©m Tõ H÷u, Tõ Hµng Phæ §é. ")
	SetRank(18)
	SetTask(1, 60*256)
	add_em(60)
	Msg2Player("Chóc mõng b¹n! B¹n ®· ®­îc th¨ng chøc T¸n Hoa Thiªn N÷! Häc ®­îc PhËt T©m Tõ H÷u. ")
	AddNote("NhiÖm vô hoµn thµnh, ®­îc phong T¸n Hoa Thiªn N÷ ")
--end;
--function L60_prise()
	Talk(1, "","Chóc mõng b¹n thµnh nghÖ xuÊt s­! B¹n ®­îc phong lµ Th¸nh N÷. Tõ h«m nay cã thÓ tù do hµnh hiÖp giang hå! B¹n cã thÓ chän gia nhËp m«n ph¸i kh¸c tiÕp tôc häc nghÖ, còng cã thÓ x©y dùng bang héi më réng thÕ lùc trªn giang hå. HoÆc lµm mét ®éc hµnh n÷ hiÖp còng rÊt oai phong! Giang hå kiÕm hiÖp, biÓn réng trêi cao, hy väng b¹n ph¸t triÓn quyÒn c­íc, nhÊt triÓn hång ®å!")
	Msg2Player("Chóc mõng ng­¬i ®· häc thµnh tµi! Ng­¬i ®· ®­îc phong lµ Th¸nh n÷ Nga Mi ph¸i! Danh väng t¨ng thªm 120 ®iÓm! ")
	Msg2SubWorld("§Ö tö Nga Mi ph¸i "..GetName().."Thµnh tµi xuÊt s­, tõ biÖt c¸c s­ muéi ®ång m«n ®Ó xuèng nói hµnh tÈu giang hå ")
	AddRepute(120)
	SetRank(74)
	SetTask(1, 70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("VÒ ®Õn Ch¸nh ®iÖn giao Yªn Ngäc ChØ Hoµn cho Thanh HiÓu S­ Th¸i, hoµn thµnh nhiÖm vô xuÊt s­. §­îc th¨ng lµm Th¸nh n÷. ")
--end;
--function return_complete()			-- ÖØ·µ³É¹¦
		Talk(1,"","§­îc! §©y 5 v¹n l­îng ®· nhËn ®­îc. Ng­¬i ®­îc phong lµ Kim §Ønh Th¸nh N÷ cña bæn ph¸i, hy väng ng­¬i cè g¾ng gióp bæn ph¸i ph¸t d­¬ng quang ®¹i.")
		SetTask(1,80*256)
		SetFaction("emei")
		SetCamp(1)
		SetCurCamp(1)
		SetRank(64)
		add_em(70)			-- µ÷ÓÃskills_table.luaÖÐµÄº¯Êý£¬²ÎÊýÎªÑ§µ½¶àÉÙ¼¶¼¼ÄÜ¡£
		Msg2Player("B¹n häc ®­îc tuyÖt häc trÊn ph¸i: PhËt Ph¸p V« Biªn, Vâ C«ng BÊt DiÖt BÊt TuyÖtt, PhËt Quang Phæ ChiÕu, Thanh ¢m Ph¹n X­íng. ")
		AddNote("§· quay vÒ Nga Mi ph¸i, ®øng trong hµng ngò ")
		Msg2Player(GetName().."§­îc phong thµnh Kim §Ønh Th¸nh N÷, l¹i quay vÒ Nga Mi ph¸i. ")
--end;
--function Uworld36_prise()
	Uworld36 = SetByte(GetTask(36),1,127)
	i = ReturnRepute(30,19,3)		-- È±Ê¡ÉùÍû£¬×î´óÎÞËðºÄµÈ¼¶£¬Ã¿¼¶µÝ¼õ
	SetTask(36,Uworld36)
	AddRepute(i)		-- ¼ÓÉùÍû
	AddNote("§­a cho DiÖu TrÇn B¹ch Ngäc nh­ ý, hoµn thµnh nhiÖm vô, trë thµnh Ký Danh ®Ö tö cña Nga Mi ph¸i ")
	Msg2Player("§­a cho DiÖu TrÇn B¹ch Ngäc nh­ ý, hoµn thµnh nhiÖm vô, trë thµnh Ký Danh ®Ö tö cña Nga Mi ph¸i, thanh thÕ giang hå ®­îc t¨ng "..i.."®iÓm.")
	Talk(1,"","Chóc mõng muéi nhËn ®­îc B¹ch Ngäc Nh­ ý, thuËn lîi qua ®­îc 4 ¶i thö th¸ch cña tû muéi ta. Tõ nay muéi ®· lµ ®Ö tö cña bæn ph¸i! VÒ sau hoan nghªnh muéi ®Õn Nga Mi du ngo¹n!")
--end
--function Uworld125_finish()
		Talk(4,"","Xem ra, duyªn phËn gi÷a Nga Mi víi thiªn th­ ®· tËn, sø m¹ng nµy lµ cña c¸c h¹ míi ®óng!","T¹i h¹?","Ph¶i, cã lÏ chØ cã ng­¬i míi thÊu hiÓu ®­îc bÝ mËt bªn trong. BÇn ni sÏ ®em nh÷ng chiªu thøc ghi trªn s¸ch truyÒn thô cho ng­¬i, mong ng­¬i cã thÓ ®¹t thµnh, ®õng uæng phÝ mét lÇn luyÖn c«ng khã nhäc!","§Ö tö nhÊt ®Þnh kh«ng phô lßng. Tõ nay cã g× dÆn dß, ®Ö tö nhÊt nhÊt tu©n theo!")
		if (HaveMagic(328) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(328,1)
		end
		if (HaveMagic(380) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(380,1)
		end
		if (HaveMagic(332) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(332)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("Ng­¬i ®· häc Tam Nga TÒ TuyÕt, Phong Lé Thóy ¶nh, Phæ §é Tïng Sinh ")
		SetTask(125,255)  --Ñ§µÃ¼¼ÄÜµÄÉèÖÃ±äÁ¿255
	add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
	AddRepute(add_repute)
	Msg2Player("Thiªn th­ Nga My quay vÒ nh­ ®· ®Þnh, nhiÖm vô hoµn thµnh. Danh väng t¨ng thªm "..add_repute.."®iÓm.")
	AddNote("Thiªn th­ Nga My quay vÒ nh­ ®· ®Þnh, nhiÖm vô hoµn thµnh. ")
--end
end

-- Ph¸i Thóy Yªn
function Done_ThuyYen()
--function L10_prise()
	Talk(1,"","§­îc råi! Ng­¬i thËt cã tµi! Ta sÏ th¨ng cho ng­¬i lªn ®Ö tö 10 cÊp.")
	SetTask(6,20*256)
	SetRank(32)
	add_cy(20)
	AddNote("Giao Thóy Vò tr©m, quay vÒ Do·n Hµm Yªn phôc mÖnh, hoµn thµnh nhiÖm vô t×m tr©m. Trë thµnh Tam PhÈm Hoa Sø ")
	Msg2Player("Chóc mõng b¹n ®· ®­îc phong thµnh Tam PhÈm Hoa Sö cña Thóy Yªn m«n, häc ®­îc vâ c«ng Thóy Yªn ®ao ph¸p, Thóy Yªn song ®ao. ")
--end;
--function L20_check()
	Talk(1,"","<#> Yªn HiÓu Tr¸i:<#> §¹i Man §µ La Hoa ®· ®ñ råi. S­ muéi qu¶ lµ cã b¶n lÜnh, cã thÓ trë thµnh NhÞ PhÈm Hoa Sø.")
	SetTask(6,30*256)
	SetRank(33)
	add_cy(30)
	Msg2Player("Chóc mõng b¹n! §· ®­îc th¨ng Thóy Yªn m«n NhÞ PhÈm Hoa Sø! Häc ®­îc vâ c«ng B¨ng T©m Tr¸i ¶nh. ")
	AddNote("H¸i ®­îc 10 ®ãa §¹i Man §µ La Hoa, hoµn thµnh nhiÖm vô §¹i Man §µ La Hoa. §­îc th¨ng lµ NhÞ PhÈm Hoa Sø. ")
--end;
--function L30_prise()
	Talk(1,"","Ho¸ ra vÉn cßn bÝ quyÕt nh­ vËy, ®a t¹ tiÓu muéi! Ta phong muéi lµ NhÊt PhÈm Hoa Sø.")
	SetTask(6,40*256)
	SetRank(34)
	add_cy(40)
	Msg2Player("Chóc mõng b¹n! §· ®­îc phong thµnh NhÊt PhÈm Hoa Sø! Häc xong vâ c«ng Vò §¶ Lª Hoa, Phï V©n T¸n TuyÕt. ")
	AddNote("§o¹t ®­îc bÝ quyÕt trång hoa Vò Y Nghª Th­êng, hoµn thµnh nhiÖm vô, ®­îc phong lµ: NhÊt PhÈm Hoa Sø. ")
--end;
--function L40_prise()
	Talk(2,"","Yªn s­ tû! Ta ®· cøu ®­îc tÊt c¶ nh÷ng ng­êi con g¸i bÞ tªn ¸c b¸ b¾t ®i, vµ ®· cho h¾n mét bµi häc, h¾n sÏ kh«ng d¸m lµm chuyÖn xÊu Êy n÷a ®©u!","ChØ cÇn ®Ö tö Thuý Yªn M«n chóng ta ra tay th× kh«ng cã viÖc g× lµ kh«ng thµnh, b¶n lÜnh cña ng­¬i ngµy cµng cao, tiÕp tôc nç lùc thªm nhÐ!")
	SetTask(6,50*256)
	SetRank(77)
	add_cy(50)
	Msg2Player("Chóc mõng b¹n! §· ®­îc th¨ng lµ Thóy Yªn m«n Hoa ThÇn Sø Gi¶! Häc ®­îc vâ c«ng Hé ThÓ Hµn B¨ng. ")
	AddNote("Cøu tho¸t c¸c d©n n÷ bÞ tªn ¸c b¸ b¾t cãc, d¹y h¾n mét bµi häc. Hoµn thµnh nhiÖm vô cÊp 40. §­îc th¨ng lµ Thóy Yªn m«n Hoa ThÇn Sø Gi¶! ")
--end;
--function L50_prise()
	Talk(1,"","RÊt tèt! Ng­¬i qu¶ trÝ dòng song toµn, ®· lµm kh«ng Ýt chuyÖn cho Bæn m«n, thËt kh«ng hæ danh lµ trô cét cña bæn m«n! ")
	SetTask(6,60*256)
	SetRank(36)
	add_cy(60)
	Msg2Player("Chóc mõng b¹n! §· ®­îc phong lµ Hoa Tinh! Häc ®­îc vâ c«ng TuyÕt ¶nh ")
	AddNote("§o¹t l¹i Vò §ång Quan ¢m, hoµn thµnh nhiÖm vô cÊp 50, ®­îc phong lµ Hoa Tinh ")
--end;
--function L60_prise()
	Msg2Player("B¹n giao th­ cho Do·n Hµm Yªn, vµ kÓ l¹i toµn bé sù viÖc cho nµng nghe. ")
	Talk(2,"","LÇn nµy ng­¬i ®· gióp gi¶i quyÕt chuyÖn Bæn m«n, lËp ®­îc ®¹i c«ng. Chóc mõng ng­¬i! Ng­¬i cã thÓ xuÊt s­! ","§a t¹ Ch­ëng m«n! ")
	SetTask(6,70*256)
	SetRank(35)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("B¹n giao th­ cho Do·n Hµm Yªn, vµ kÓ l¹i toµn bé sù viÖc cho nµng nghe, hoµn thµnh nhiÖm vô xÊt s­, ®­îc phong lµ Hoa Tiªn ")
	Msg2Player("Chóc mõng b¹n ®­îc lµm Hoa Tiªn, ng­¬i ®· cã thÓ xuÊt s­ ")
--end;
--function return_complete()
		Talk(1,"","§­îc! 5 v¹n l­îng ®· nhËn ®ñ. Ta phong ng­¬i lµ Hoa ThÇn cña bæn ph¸i, ®ång thêi truyÒn cho ng­¬i häc vâ c«ng tuyÖt kü bæn m«n ' BÝch H¶i TriÒu Sinh', hi väng ng­¬i cã thÓ tiÕp tôc nç lùc.")
		SetTask(6,80*256)
		SetFaction("cuiyan")
		SetCamp(3)
		SetCurCamp(3)
		SetRank(67)
		add_cy(70)			-- µ÷ÓÃskills_table.luaÖÐµÄº¯Êý£¬²ÎÊýÎªÑ§µ½¶àÉÙ¼¶¼¼ÄÜ¡£
		Msg2Player("Ng­¬i häc ®­îc tuyÖt kü trÊn ph¸i cña Thóy Yªn M«n lµ B¨ng Cèt TuyÕt T©m, vâ c«ng Môc D· L­u Tinh, BÝch H¶i TriÒu Sinh ")
		Msg2Player(GetName().."<#>Quay l¹i Thóy Yªn m«n, ®­îc phong lµ Hoa ThÇn ")
		AddNote("§· quay vÒ Thóy Yªn m«n, ®øng trong hµng ngò. ")
--end;
--function enroll_prise()
	Talk(1,"U36_leave","Chóc mõng! B¹n ®· v­ît qua thö th¸ch cña Bæn ph¸i, tõ b©y giê chóng ta lµ tû muéi tèt! ")		-- Çé»¨
	i = ReturnRepute(20,29,5)		-- È±Ê¡ÉùÍû£¬×î´óÎÞËðºÄµÈ¼¶£¬Ã¿¼¶µÝ¼õ
	AddRepute(i)
	Uworld36 = SetByte(GetTask(36),2,127)
	SetTask(36,Uworld36)
	AddNote("Hoµn thµnh nhiÖm vô Hoa Kh«i trËn, trë thµnh <color=Red>Ký Danh ®Ö tö<color> cña Thóy Yªn m«n ")
	Msg2Player("Hoµn thµnh nhiÖm vô Hoa Kh«i trËn, trë thµnh Ký Danh ®Ö tö cña Thóy Yªn m«n ")
--end;
--function Uworld126_finish()
		Talk(3,"","Hµnh tÈu giang hå th­êng gÆp nhiÒu nguy hiÓm, ë ®©y Hµm Yªn cã quyÓn bÝ kÝp cña Thóy Yªn cã thÓ gióp Ých cho ng­¬i. ","ThËt ng¹i qu¸!","Giang hå nhi n÷ kh«ng nªn c©u nÖ, h·y nhËn lÊy ®i!")
		if (HaveMagic(336) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(336,1)
		end
		if (HaveMagic(337) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(337,1)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("Häc xong vâ c«ng B¨ng tung V« ¶nh, B¨ng T©m tiªn tö cña Thóy Yªn. ")
		SetTask(126,255)
	add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
	AddRepute(add_repute)
	Msg2Player("<#>§· xãa bá ©n o¸n gi÷a LÖ Thu Thñy vµ §oµn T­ Thµnh, nhiÖm vô hoµn thµnh. Danh tiÕng cña ng­¬i ®· ®­îc t¨ng lªn "..add_repute.."<#>®iÓm.")
	AddNote("§· xo¸ bá ©n o¸n gi÷a LÖ Thu Thñy vµ §oµn T­ Thµnh. NhiÖm vô hoµn thµnh. ")
--end
end

-- Ph¸i C¸i Bang
function Done_CaiBang()
--function L10_prise()
	Talk(2,"","Bang chñ, r­îu t«i ®· mua vÒ råi!","Tèt! Huynh ®Ö l¹i uèng chung ®i nµo?")
	SetTask(8,20*256)
	SetRank(38)
	add_gb(20)	
	AddNote("Mua ®ñ 5 l¹i r­îu, hoµn thµnh nhiÖm vô cÊp 10, trë thµnh ChÊp §¹i ®Ö tö ")
	Msg2Player("Chóc mõng b¹n! §­îc phong lµ ChÊp §¹i ®Ö tö! Häc ®­îc C¸i bang Ch­ëng ph¸p, C¸i bang Bæng ph¸p.")
--end;
--function L20_prise()
	SetTask(8,30*256)
	SetRank(39)
	add_gb(30)	
	Msg2Player("Chóc mõng B¹n!. §· ®­îc th¨ng lµ: C¸i Bang ChÊp B¸t ®Ö tö. Häc ®­îcHãa hiÓm Vi Di ")
	AddNote("Chóc mõng B¹n!. §· ®­îc th¨ng lµ: C¸i Bang  ChÊp B¸t ®Ö tö. Häc ®­îc Hãa HiÓm Vi Di ")
--end
--function L30_prise()
	Talk(2,"","Tr­ëng l·o! Ta ®· ®em v¨n th­ vÒ råi!","Xem ra Kim binh ®· thËt sù hµnh ®éng! Chóng ta ph¶i cÈn hËn h¬n míi ®­îc. LÇn nµy ng­¬i lËp ®­îcc«ng lín, ta phong ng­¬i lµ ®Ö tö cÊp 30")
	SetTask(8,40*256)
	SetRank(40)
	add_gb(40)
	Msg2Player("Chóc mõng B¹n! §· ®­îc th¨ng lµ C¸i Bang ChÊp Bæng ®Ö tö, sÏ ®­îc häcGi¸ng Long Ch­ëng; §¶ CÈu TrËn. ")
	AddNote("Gi¶i quyÕt ®­îc sù viÖc ë Thôc C­¬ng s¬n, cøu ®­îc ®Ö tö C¸i bang, ®­îc th¨ng lµ ChÊp bæng ®Ö tö ")
--end;
--function L40_prise()
	Talk(3,"","§a t¹ Ngôy tr­ëng l·o! ")
	SetTask(8,50*256)
	SetRank(41)
	add_gb(50)	
	Msg2Player("Chóc mõng B¹n! §· ®­îc th¨ng lµ: C¸i Bang Long §Çu ®Ö tö ®­îc häc Ho¹t BÊt L­u Thñ ")
	AddNote("B¶o vÖ an toµn cho Tr­¬ng TuÊn, hoµn thµnh nhiÖm vô cÊp 40, ®­îc th¨ng Long §Çu ®Ö tö ")
--end;
--function L50_prise()
	Talk(1,"","Bang chñ: Ng­¬i lµm tèt l¾m, mong r»ng viÖc lµm lÇn nµy gióp cho sù nghiÖp kh¸ng Kim, ®Ó khái bá c«ng kh«ng v« Ých!")
	SetTask(8,60*256)
	SetRank(42)
	add_gb(60)	
	Msg2Player("Chóc mõng b¹n! §­îc phong lµ §¹i Long ®Çu! Häc ®­îc vâ c«ng Kh¸ng Long H÷u Hèi, Bæng §¶ ¸c CÈu.")
	AddNote("Giao thµnh c«ng bøc §Þa ®å Trung nguyªn cho Tr­¬ng TuÊn, hoµn thµnh nhiÖm vô cÊp 50. Trë thµnh §¹i Long ®Çu.")
--end;
--function L60_prise()
	SetRank(68)
	SetTask(8, 70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("Mang 5 c¸i tói v¶i trë vÒ C¸i Bang, hoµn thµnh nhiÖm vô xuÊt s­, ®­îc phong Tiªu Diªu thÇn c¸i. ")
	Msg2Player("Chóc mõng B¹n! §· thuËn lîi xuÊt s­. §­îc phong lµ Tiªu diªu thÇn c¸i ")
--end;
--function return_complete()
		Talk(1,"","Haha, kh«ng ngê ng­¬i chuÈn bÞ ®ñ sè ng©n l­îng mµ ta nãi, tèt l¾m! Ta lÊy th©n phËn bang chñ cho ng­¬i trïng ph¶n bæn ph¸i ®ång thêi ®¶m nhiÖm chøc Cöu §¹i Tr­ëng L·o cña bæn gi¸o.")
		SetTask(8,80*256)
		SetFaction("gaibang")
		SetCamp(1)
		SetCurCamp(1)
		SetRank(78)
		add_gb(70)			-- µ÷ÓÃskills_table.luaÖÐµÄº¯Êý£¬²ÎÊýÎªÑ§µ½¶àÉÙ¼¶¼¼ÄÜ¡£
		Msg2Player("B¹n häc ®­îc tuyÖt häc trÊn ph¸i Tóy §iÖp Cuång Vò, vâ c«ng Tiªu Diªu C«ng")
		AddNote("§· ®­îc phÐp trë l¹i C¸i bang")
		Msg2Player(GetName().."Trïng ph¶n C¸i bang, ®­îc phong lµ Cöu §¹i Tr­ëng L·o")
--end;
--function enroll_prise()
	Talk(1,"","Ha ha ha! Ng­¬i ®óng lµ cã khiÕu ¨n xin! Tèt! Ta sÏ nhËn ng­¬i lµm ®Ö tö ký danh! ")
	i = ReturnRepute(15,29,2)		-- È±Ê¡ÉùÍû£¬×î´óÎÞËðºÄµÈ¼¶£¬Ã¿¼¶µÝ¼õ
	AddRepute(i)
	Uworld30 = SetByte(GetTask(30),2,127)
	SetTask(30,Uworld30)
	AddNote("Hoµn thµnh nhiÖm vô, trë thµnh ®Ö tö chÝnh thøc <color=Red>cña C¸i Bang<color>. ")
	Msg2Player("Hoµn thµnh nhiÖm vô, trë thµnh ®Ö tö chÝnh thøc cña C¸i Bang ")
--end;
--function Uworld128_finish()
		Talk(1,"","C¸i Bang ta cã mét bé mËt quyÕt, ng­¬i xøng ®¸ng ®­îc truyÒn d¹y!")
		if (HaveMagic(357) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(357,1)
		end
		if (HaveMagic(359) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(359,1)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("B¹n häc ®­îc tuyÖt kü cña C¸i bangPhi Long T¹i Thiªn, Thiªn H¹ V« CÈu ")
		SetTask(128,255)
   add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
   AddRepute(add_repute)
   Msg2Player("Cøu ®­îc Giíi V« Tµ, hoµn thµnh nhiÖm vô. Danh väng cña b¹n t¨ng thªm "..add_repute.."®iÓm.")
   AddNote("Cøu ®­îc Giíi V« Tµ, hoµn thµnh nhiÖm vô. ")
--end
end

-- Ph¸i Thiªn NhÉn
function Done_ThienNhan()
--function L10_prise()
	SetTask(4, 20*256)
	SetRank(56)
	add_tr(20)
	Msg2Player("B¹n ®­îc phong lµ V« ¶nh S¸t Thñ! Häc ®­îc Thiªn NhÉn M©u Ph¸p, Thiªn NhÉn §ao ph¸p, Háa PhÇn Liªn Hoa. ")
	AddNote("§­a c¸c m¶nh ThÊt S¸t lÖnh bµi cho §­êng chñ Ngét Ng¹o, hoµn thµnh nhiÖm vô ThÊt S¸t ®éng, th¨ng cÊp V« ¶nh S¸t Thñ. ")
--end;
--function L20_prise()
	Talk(1,"","Ng­¬i gióp ta lÊy l¹i NhËt NguyÖt Song Lu©n, thËt ®óng lµ ©n nh©n cøu m¹ng cña ta! Kh«ng, kh«ng, ng­êi lµ phô mÉu t¸i sinh cña ta!")
	SetRank(57)
	SetTask(4, 30*256)
	add_tr(30)
	Msg2Player("B¹n ®­îc th¨ng cÊp Thiªn NhÉn Tö SÜ! Häc ®­îc vâ c«ng ¶o ¶nh Phi Hå. ")
	AddNote("§­a cÆp NhËt NguyÖt Song Lu©n cho NhËt NguyÖt §µn chñ ¤ Hîp T¸t, hoµn thµnh nhiÖm vô §øa trÎ th«ng minh. Th¨ng cÊp Tö SÜ. ")
--end;
--function L30_prise()
	Talk(1,"","Ng­¬i thËt tµi, lo¹i ®¸ quý thÕ nµy mµ còng t×m ®­îc! MÉu hËu h¼n sÏ rÊt thÝch chiÕc ¸o ngäc!")
	SetRank(58)
	SetTask(4, 40*256)
	add_tr(40)
	Msg2Player("§­a bèn lo¹i ®¸ quý cho Phong §­êng §­êng chñ Hoµn Nhan TuyÕt Y, hoµn thµnh nhiÖm vô B¶o Th¹ch. §­îc phong: U Minh Tö SÜ. Häc ®­îc vâ c«ng: LiÖt Háa T×nh Thiªn, Th«i s¬n §iÒn H¶i, Phi Hång V« TÝch. ")
	AddNote("Quay l¹i Thiªn NhÉn gi¸o, ®­a bèn lo¹i ®¸ quý cho Phong §­êng §­êng chñ Hoµn Nhan TuyÕt Y, hoµn thµnh nhiÖm vô B¶o Th¹ch. Trë thµnh U Minh Tö SÜ. ")
--end;
--function L40_prise()
	Talk(1, "", "Lµm thËt tèt! LÇn nµy ng­¬i ®· lËp c«ng lín, ta nhÊt ®Þnh sÏ nãi tèt ng­¬i víi Gi¸o chñ!")
	SetRank(59)
	SetTask(4, 50*256)
	add_tr(50)
	Msg2Player("Chóc mõng b¹n! §­îc phong lµ: Ch­ëng Kú sø! Häc ®­îc vâ c«ng Bi T« Thanh Phong. ")
	AddNote("Quay l¹i Thiªn NhÉn Gi¸o, ®­a bøc mËt th­ cho H÷u Hé Ph¸p Gia LuËt TÞ Li, hoµn thµnh nhiÖm vô hµnh thÝch. Th¨ng cÊp Ch­ëng Kú Sø. ")
--end;
--function L50_prise()
	Talk(1,"","Ng­¬i tuy lµ ®Ö tö míi nh­ng cã thÓ ®¶m ®­¬ng viÖc hÖ träng, bæn gi¸o rÊt cÇn nh÷ng ng­êi ®¾c lùc nh­ ng­¬i, ta sÏ nãi víi Gi¸o chñ ®Ó s¾c phong cho ng­¬i.")
	SetRank(60)
	SetTask(4, 60*256)
	SetTask(21,0)
	add_tr(60)
	Msg2Player("Chóc mõng b¹n ®· ®­îc s¾c phong lµm Hé Gi¸o Sø cña Thiªn NhÉn Gi¸o! Häc ®­îc vâ c«ng LÞch Ma §o¹t Hån.")
	AddNote("VÒ Thiªn NhÉn Gi¸o ®Õn gÆp T¶ Hé ph¸p §oan Méc DuÖ phôc mÖnh, hoµn thµnh nhiÖm vô cøu ng­êi. Th¨ng chøc lµm Hé Gi¸o Sø.")
--end;
--function L60_prise()
	Msg2SubWorld("TÝn ®å Thiªn NhÉn Gi¸o "..GetName().."XuÊt s­ thµnh c«ng, c¸o biÖt ch­ vÞ gi¸o h÷u trë vÒ ph­¬ng Nam. ")
	SetRank(71)
	SetTask(28,0)
	SetTask(4, 70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("Quay l¹i Thiªn NhÉn §¹i ®×nh, ®­a quyÓn s¸ch da dª cho Hoµn Nhan Hïng LiÖt, hoµn thµnh nhiÖm vô xuÊt s­. Th¨ng cÊp T¸t M·n Ph¸p S­. ")
	Msg2Player("Chóc mõng B¹n! XuÊt s­ thµnh c«ng! §­îc phong lµ T¸t M·n Ph¸p S­! Danh väng t¨ng thªm 120 ®iÓm! ")
	AddRepute(120)
--end;
--function return_complete()
		Talk(1,"","RÊt tèt! Ng­¬i ®· trë thµnh Ký danh ®Ö tö cña bæn gi¸o. Ta sÏ ®Ò cö ng­¬i víi Th¸nh Gi¸o Tr­ëng L·o cña bæn gi¸o, ®õng lµm ta thÊt väng.")
		SetFaction("tianren")	
		SetCamp(2)
		SetCurCamp(2)
		SetRank(81)
		SetTask(4, 80*256)
		add_tr(70)			-- µ÷ÓÃskills_table.luaÖÐµÄº¯Êý£¬²ÎÊýÎªÑ§µ½¶àÉÙ¼¶¼¼ÄÜ¡£
		Msg2Player("B¹n ®· häc ®­îc trÊn ph¸i tuyÖt häc: Thiªn Ma Gi¶i ThÓ, Du Thiªn Ho¸n NhËt, Ma DiÖm ThÊt S¸t. ")
		AddNote("Quay trë l¹i Thiªn NhÉn Gi¸o, l¹i ®øng vµo hµng ngò. ")
		Msg2Player(GetName().."Quay trë l¹i Thiªn NhÉn Gi¸o, ®­îc phong lµm Th¸nh Gi¸o tr­ëng l·o. ")
--end;
--function world30_prise()
	i = ReturnRepute(15,19,6)		-- È±Ê¡ÉùÍû15£¬×î´óÎÞËðºÄµÈ¼¶19¼¶£¬Ã¿¼¶µÝ¼õ6%
	Uworld30 = SetByte(GetTask(30),1,127)
	AddRepute(i)
	SetTask(30,Uworld30)
	Earn(500)
	Talk(1,"","V× c«ng lao ng­¬i lËp cho bæn gi¸o, bæn gi¸o nhËn ng­¬i lµm ®Ö tö!")
	AddNote("Quay l¹i Thiªn NhÉn Gi¸o, ®­a Vò V­¬ng KiÕm cho Thiªn NhÉn Tö SÜ, trë thµnh ®Ö tö, ®­îc th­ëng 500 l­îng. ")
	Msg2Player("Quay l¹i Thiªn NhÉn Gi¸o, ®­a Vò V­¬ng KiÕm cho Thiªn NhÉn Tö SÜ, hoµn thµnh nhiÖm vô. Të thµnh ®Ö tö cña Thiªn NhÉn Gi¸o, ®­îc th­ëng 500 l­îng, danh väng ®­¬c n©ng cao. "..i.."®iÓm.")
--end;
--function Uworld127_over()
		Talk(2,"","Hßm s¸ch mËt cña Thiªn NhÉn ta giao cho ng­¬i, nÕu tõ chèi ta sÏ giÕt ng­¬i, quyÕt kh«ng nuèt lêi.","§· nh­ vËy, t¹i h¹ kh«ng thÓ kh«ng nhËn lêi.")
		if (HaveMagic(361) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
     		 	AddMagic(361,1)
		end
		if (HaveMagic(362) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
   	  		 AddMagic(362,1)
		end
		if (HaveMagic(391) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(391)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("§­a §¹i ®iªu cho Hoµn Nhan TuyÕt Y, häc ®­îc kü n¨ng V©n Long KÝch, Thiªn Ngo¹i L­u Tinh, NhiÕp Hån Lo¹n T©m. Quay l¹i b¸o tin cho L­u l·o gia. ")
		SetTask(127,110)
--end
--function U127_finish()
	if(GetTask(127) == 110) then
      SetTask(127,255)
   else
      SetTask(127,245)				  --»ñµÃÉùÍûµÄÉèÖÃ±äÁ¿245
	end
	   add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
	   AddRepute(add_repute)
	   Msg2Player("Hoµn thµnh nhiÖm vô, trë vÒ L­u gia, danh väng t¨ng lªn "..add_repute.."®iÓm.")
	   AddNote("Quay l¹i chç L­u viªn ngo¹i, hoµn thµnh nhiÖm vô. ")
--end
end

-- Ph¸i C«n l«n
function Done_ConLon()
--function L10_prise()
	Talk(1,"","Ng­¬i thËt giái! Ta sÏ nãi tiÓu th­ ®Ò b¹t ng­¬i")
	SetTask(9,20*256)
	SetRank(20)
	add_kl(20)
	Msg2Player("Chóc mõng B¹n! §· trë thµnh C«n L«n ph¸i Phông KiÕm ®Ö tö! Häc ®­îc C«n L«n §ao ph¸p, C«n L«n kiÕm ph¸p, ThÝch Ph­îc Chó, bïa thanh Phong. ")
	AddNote("H¸i thuèc vÒ, gÆp TiÓu Hµn phôc mÖnh, hoµn thµnh nhiÖm vô h¸i thuèc, th¨ng cÊp thµnh Phông kiÕm ®Ö tö. ")
--end;
--function L20_prise()
	Talk(1,"","§©y råi! §©y råi! RÊt c¶m ¬n ng­¬i! Ta nhÊt ®Þnh sÏ tiÕn cö ng­¬i víi Ch­ëng m«n")
	SetTask(9,30*256)
	SetRank(21)
	add_kl(30)
	Msg2Player("Chóc mõng b¹n! §· ®­îc th¨ng cÊp thµnh C«n L«n ph¸i Tö Vi Hé Ph¸p, häc ®­îc Ky B¸n phï. ")
	AddNote("T×m ®­îc x­¬ng ®Çu l¹c ®µ, giao cho Th¸n Tøc L·o Nh©n, hoµn thµnh nhiÖm vô. Th¨ng cÊp thµnh Tö Vi hé ph¸p ")
--end;
--function L30_prise()
	Talk(1,"","Uhmm! §éng t¸c còng kh«ng ®Õn nçi chËm. §­îc! Ta sÏ phong ng­¬i lµ Th¸i Vi Hé Ph¸p, tõ ®©y vÒ sau cø cè g¾ng lµm viÖc cho ta th× tÊt nhiªn sÏ kh«ng Ýt lîi Ých cho ng­¬i!")
	SetTask(9,40*256)
	SetRank(22)
	add_kl(40)
	Msg2Player("Chóng mõng ng­¬i! §· ®­îc th¨ng cÊp thµnh C«n L«n ph¸i Th¸i Vi Hé Ph¸p, häc ®­îc vâ c«ng NhÊt Khi Tam thanh, Thiªn TÕ TÊn L«i, Thiªn Thanh §Þa Träc, B¾c Minh §¸o H¶i ")
	AddNote("T×m ®­îc 3 h¹t D¹ Minh Ch©u, hoµn thµnh nhiÖm vô cÊp 30 cña C«n L«n, ®­îc th¨ng tiÕn trë Th¸i Vi Hé Ph¸p ")
--end;
--function L40_prise()
	Talk(1,"","§a t¹ Hé ph¸p! ")
	SetTask(TASK_9,50*256)
	SetRank(23)
	add_kl(50)
	Msg2Player("Chóc mõng B¹n! §· ®­îc th¨ng cÊp thµnh C«n L«n ph¸i Th¸i Vi Hé Ph¸p! Häc ®­îc vâ c«ng Khi Hµn Ng¹o TuyÕt, KhÝ T©m phï ")
	AddNote("§o¹t ®­îc HuyÕt Hån ThÇn KiÕm, hoµn thµnh nhiÖm vô cÊp 40 cña C«n L«n ph¸i, th¨ng tiÕn thµnh Th¸i Vi Hé Ph¸p. ")
--end;
--function L50_prise()
	Talk(2,"","Hé ph¸p! §Ö tö may m¾n kh«ng bá m¹ng!","§­îc l¾m! Ng­¬i ®­îc th¨ng tiÕn trë thµnh Thô Phï Thiªn t­íng. H·y nhí kü! ChØ cÇn trung thµnh víi ta, cã bÊt cø Ých lîi g× ta ®Òu kh«ng quªn ng­¬i!")
	SetTask(9,60*256)
	SetRank(24)
	add_kl(60)
	Msg2Player("Chóc mõng B¹n! §· trë thµnh Thô Phï Thiªn t­íng! Häc ®­îc Cuång Phong SËu §iÖn, Mª Tung ¶o ¶nh ")
	AddNote("LÊy ®­îc tãc cña B¨ng HuyÖt qu¸i nh©n, hoµn thµnh nhiÖm vô cÊp 50 cña C«n L«n ph¸i. §­îc phong Thô Phï Thiªn T­íng. ")
--end;
--function L60_prise()
	Talk(1,"","§a t¹ Ch­ëng m«n! ")
	SetRank(65)
	SetTask(9, 70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("Hoµn thµnh nhiÖm vô xuÊt s­, ®­îc phong lµ Tiªn Phï Ch©n Qu©n ")
	Msg2Player("Chóc mõng B¹n! Thµnh nghÖ xuÊt s­! B¹n ®· ®­îc phong lµ Tiªn Phï Ch©n Qu©n ")
--end;
--function return_complete()
		Talk(1,"","Tèt l¾m! VËy th× ta sÏ ®i th«ng b¸o tin ng­¬i ®· quay trë l¹i m«n ph¸i. ")
		SetTask(9,80*256)
		SetFaction("kunlun")
		add_kl(70)			-- µ÷ÓÃskills_table.luaÖÐµÄº¯Êý£¬²ÎÊýÎªÑ§µ½¶àÉÙ¼¶¼¼ÄÜ¡£
		Msg2Player("B¹n ®· häc tuyÖt häc TrÊn ph¸i S­¬ng Ng¹o C«n L«n, Ngò L«i ChÝnh Ph¸p")
		SetCamp(3)
		SetCurCamp(3)
		SetRank(75)
		AddNote("§· quay trë l¹i C«n L«n ph¸i, l¹i ghi tªn trong m«n ph¸i ")
		Msg2Player(GetName().."<#>§­îc phong lµm Hé Ph¸p Ch©n Qu©n cña C«n L«n ph¸i, trë vÒ ph¸i C«n L«n tiÕp tôc tu hµnh. ")
--end;
--function enroll_prise()
	Talk(1,"","Muèn nhËp m«n th× chØ b»ng c¸i viÖc nhá nhÆt nh­ vËy th«i kh«ng ®ñ, nh­ng thÊy ng­¬ith«ng minh lanh lÑ, bæn to¹ cho phÐp ng­¬i lµm Ký Danh ®Ö tö vËy! ")
	i = ReturnRepute(30,29,3)		-- È±Ê¡ÉùÍû£¬×î´óÎÞËðºÄµÈ¼¶£¬Ã¿¼¶µÝ¼õ
	AddRepute(i)
	Uworld31 = SetByte(GetTask(31),2,127)
	SetTask(31,Uworld31)
	AddNote("<#>Hoµn thµnh nhiÖm vô Kim T¬ HÇu, trë thµnh <color=Red>Ký Danh ®Ö tö<color>. Danh väng cña b¹n t¨ng thªm "..i.."<#>®iÓm.")
	Msg2Player("Hoµn thµnh nhiÖm vô Kim T¬ HÇu, trë thµnh Ký danh ®Ö tö. ")
--end;
--function Uworld130_finish()
		Talk(4,"","ë ®©y cã 1 quyÓn bÝ kÝp cña C«n L«n, ng­¬i h·y theo ®ã mµ tËp luyÖn","§©y lµ…?","ChØ hy väng ng­¬i nghiªm tóc luyÖn tËp, lóc C«n L«n gÆp nguy khã, cã thÓ ra tay yÓm trî, lµ l·o giµ nµy ®· m·n nguyÖn l¾m råi. ","V·n bèi tu©n lÖnh")
		if (HaveMagic(372) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(372,1)
		end
		if (HaveMagic(375) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(375,1)
		end
		if (HaveMagic(394) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(394)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("Häc ®­îc kü n¨ng C«n L«n Ng¹o TuyÕt TiÕu Phong, L«i §éng Cöu Thiªn, Tóy Tiªn T¸ Cèt ")
 		SetTask(130,255)
   add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
   AddRepute(add_repute)
   Msg2Player("Hãa gi¶i mét cuéc néi chiÕn, hoµn thµnh nhiÖm vô. Danh väng cña b¹n t¨ng thªm "..add_repute.."®iÓm.")  
   AddNote("Hãa gi¶i mét cuéc néi chiÕn, hoµn thµnh nhiÖm vô. ")
--end
end

-- Ph¸i Vâ §ang
function Done_VoDang()
--function L10_prise()
	Talk(1,"","Xem ra ng­¬i ®· bá chót c«ng phu luyÖn tËp! Giái l¾m!")
	SetRank(8)
	SetTask(5, 20*256)
	add_wd(20)
	AddNote("VÒ Tö Tiªu ®¹i ®iÖn, tr¶ lêi chÝnh x¸c 3 c©u hái cña ch­ëng m«n, hoµn thµnh nhiÖm vô §¹o §øc kinh. Trë thµnh Nhµn T¶n ®¹o nh©n. ")
	Msg2Player("Chóc mõng B¹n! §· trë thµnh Nhµn T¶n §¹o Nh©n! Häc ®­îc Vâ §ang QuyÒn Ph¸p, Vâ §ang KiÕm Ph¸p. ")
--end
--function L20_prise()
	Talk(1,"","Qu¶ nhiªn söa ®­îc råi! Hay qu¸! ThËt c¶m ¬n!")
	SetRank(9)
	SetTask(5, 30*256)
	add_wd(30)
	Msg2Player("Chóc mõng b¹n! B¹n ®· ®­îc th¨ng lµm Thanh Tu §¹o Nh©n! Häc ®­îc ThÊt Tinh TrËn!")
	AddNote("Trë vÒ Phô MÉu ®iÖn, ®em Thiªn Tµm §¹o bµo giao cho §µo Th¹ch M«n, hoµn thµnh nhiÖm vô §¹o bµo. §­îc phong lµ Thanh Tu §¹o Nh©n.")
--end;
--function L30_prise()
	Talk(1,"","Xem ra vâ c«ng cña ng­¬i qua nhiªn tiÕn bé rÊt mau! ThËt ®¸ng mõng! ")
	SetRank(10)
	SetTask(5, 40*256)
	add_wd(40)
	Msg2Player("Chóc mõng b¹n! B¹n ®­îc phong lµ TuÇn S¬n §¹o Nh©n! Häc ®­îc vâ c«ng Vâ §ang ph¸i lµ B¸t CËp Nhi Phôc, KiÕm Phi Kinh Thiªn.")
	AddNote("Trong thêi gian quy ®Þnh quay vÒ ThËp Ph­¬ng §iÖn, ®­a 5 c©y Häa mi th¶o cho Tõ §¹i Nh¹c, hoµn thµnh nhiÖm vô Häa mi th¶o, th¨ng lµm TuÇn S¬n §¹o Nh©n.")
--end;
--function L40_prise()
	SetRank(11)
	SetTask(5, 50*256)
	add_wd(50)
	Msg2Player("Chóc mõng B¹n! Trë thµnh NhËp Quan §¹o Nh©n! Häc ®­îc vâ c«ng Thª V©n Tung cña Vâ §ang ph¸i. ")
	AddNote("§Õn Tö Tiªu ®¹i ®iÖn, giao th­ cña NhuËn N­¬ng cho §¹o NhÊt Ch©n Nh©n, hoµn thµnh nhiÖm vô. Trë thµnh NhËp Quan ®¹o nh©n. ")
--end;
--function L50_prise()
	SetRank(12)
	SetTask(5, 60*256)
	add_wd(60)
	Msg2Player("Chóc mõng B¹n! B¹n ®· trë thµnh Ch­ëng Kinh §¹o Nh©n! Häc ®­îc vâ c«ng To¹ Väng V« Ng· cña Vâ §ang ph¸i. ")
	AddNote("VÒ tíi ®iÖn Long Hæ Vâ §ang ph¸i, phôc mÖnh §¬n Tö Nam, hoµn thµnh nhiÖm vô NhËt hµnh nhÊt thiÖn. Trë thµnh Ch­ëng Kinh §¹o Nh©n. ")
--end;
--function L60_prise()
	Msg2SubWorld("§Ö tö Vâ §ang ph¸i "..GetName().."XuÊt s­ thµnh c«ng, c¸o biÖt c¸c s­ ®Ö s­ muéi xuÊt s¬n hµnh hiÖp tr­îng nghÜa! ")
	SetRank(63)
	SetTask(5, 70*256)
	SetFaction("")
	SetCamp(4)
	SetCurCamp(4)
	AddNote("VÒ Tö Tiªu ®¹i ®iÖn, lÊy 3 b¶n ch©n kinh giao cho ch­ëng m«n §¹o NhÊt Ch©n Nh©n, hoµn thµnh nhiÖm vô xÊt s­. Trë thµnh ng­êi gióp viÖc, thuËn lîi xuÊt s­. ")
	Msg2Player("Chóc mõng b¹n xuÊt s­! §­îc phong lµm HuyÒn Vò ThÇn ThÞ! Danh väng cña b¹n t¨ng thªm 120 ®iÓm! ")
	AddRepute(120)
--end;
--function return_complete()
		Talk(1,"","Hay l¾m! Ta sÏ th«ng b¸o tin ng­¬i ®· quay l¹i m«n ph¸i!")
		SetTask(5, 80*256)
		SetFaction("wudang")
		add_wd(70)			-- µ÷ÓÃskills_table.luaÖÐµÄº¯Êý£¬²ÎÊýÎªÑ§µ½¶àÉÙ¼¶¼¼ÄÜ¡£
		Msg2Player("B¹n häc ®­îc trÊn ph¸i tuyÖt häc Th¸i Cùc ThÇn C«ng, V« Ng· V« KiÕm, Tam Hoµn Thao NguyÖt. ")
		SetCamp(1)
		SetCurCamp(1)
		SetRank(73)
		AddNote("§· trë vÒ Vâ §ang ph¸i,®øng trong hµng ngò. ")
		Msg2Player(GetName().."§­îc phong lµm HuyÒn Vâ Ch©n Qu©n cña Vâ §ang ph¸i, tiÕp tôc ë l¹i Vâ §ang tËp luyÖn. ")
--end;
--function uworld31_prise()
	UTask_world31 = SetByte(GetTask(31),1,127)
	i = ReturnRepute(25,24,4)		-- È±Ê¡ÉùÍû12£¬×î´óÎÞËðºÄµÈ¼¶24¼¶£¬Ã¿¼¶µÝ¼õ8%
	SetTask(31,UTask_world31)
	AddRepute(i)		-- ¼ÓÉùÍû
	Talk(1,"","C¶m ¬n ng­¬i ®· gióp ta lÊy l¹i thïng gç! Ta ®· ®øng ë ®©y rÊt l©u, ng­¬i lµ trong sè Ýt ng­êi chÞu gióp ta t×m l¹i thïng gç, ta phong ng­¬i lµ ®Ö tö ký danh Vâ §ang ph¸i,sau nµy ng­¬i cã thÓ mua b¸n trang bÞ vò khÝ cña Vâ §ang ph¸i.")
	AddNote("Gióp ®ì tiÓu ®¹o sÜ Thanh Phong t×m l¹i thïng gç, nhiÖm vô hoµn thµnh. Trë thµnh Ký danh ®Ö tö. Danh väng t¨ng thªm ")
	Msg2Player("Gióp ®ì tiÓu ®¹o sÜ Thanh Phong t×m l¹i thïng gç, nhiÖm vô hoµn thµnh. Trë thµnh Ký danh ®Ö tö. Danh väng t¨ng thªm "..i.."®iÓm.")
--end
--function Uworld129_finish()
		Talk(2,"","Ta ®­a nã cho ng­¬i v× hy väng ng­¬i cã thÓ ph¸t d­¬ng quang ®¹i, nh­ thÕ vâ l©m Trung nguyªn l¹i cã thªm 1 phÇn lùc l­îng chèng Kim.",".....VËy ®­îc! T¹i h¹ xin nhËn!")
		if (HaveMagic(365) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(365,1)
		end
		if (HaveMagic(368) == -1) then		-- ±ØÐëÃ»ÓÐ¼¼ÄÜµÄ²Å¸ø¼¼ÄÜ
			AddMagic(368,1)
		end
		--CheckIsCanGet150SkillTask()
		Msg2Player("Häc ®­îc kü n¨ng Thiªn §Þa V« Cùc, Nh©n KiÕm Hîp NhÊt ")
		SetTask(129,255)
   add_repute = ReturnRepute(30,100,4)			-- ÉùÍû½±Àø£º×î´ó30µã£¬´Ó100¼¶ÆðÃ¿¼¶µÝ¼õ4%
   AddRepute(add_repute)
   Msg2Player("Cøu Chu V©n TuyÒn, nhiÖm vô hoµn thµnh. Danh väng cña b¹n t¨ng thªm "..add_repute.."®iÓm.")
   AddNote("Cøu Chu V©n TuyÒn, nhiÖm vô hoµn thµnh. NhiÖm vô hoµn thµnh ")
--end
end