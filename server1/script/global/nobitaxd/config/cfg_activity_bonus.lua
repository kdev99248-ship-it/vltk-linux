Include("\\script\\lib\\objbuffer_head.lua");
Include("\\script\\global\\skills_table.lua");
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua");

nHour_star	= 2000
nHour_end	= 2100
nLevel	=	90
w_ChuNhat	=	0
w_ThuHai	=	1
w_ThuBa	=	2
w_ThuTu	=	3
w_ThuNam	=	4
w_ThuSau	=	5
w_ThuBay	=	6

local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("Chóc mõng cao thñ <color=green>%s<color> ®¸nh rít <color=orange>%s<color> tõ <color=yellow> Boss TiÓu Hoµng Kim<color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
--== Th­ëng ho¹t ®éng m¸y chñ ==--
--== Skill hç trî ho¹t ®éng ==--
function HoTro_BossST()
	local	n	=	random(1,3)
	AddRepute(n)
	Msg2Player("Ngµi thu ®­îc "..n.." ®iÓm danh väng");
	Msg2SubWorld("§¹i HiÖp <color=yellow>"..GetName().."<color> ®· nhËn <color=green>NhiÖm Vô Boss S¸t Thñ<color>. §­îc t¨ng ®iÓm danh väng.");
	AddItem(6,1,72,1,0,0,0)
end
--== Hç trî T©n Thñ ==--
function HoTroTanThu()
	-- KiÓm tra Level
	if GetTask(2070) == 1 then return end
	local nCurLevel = GetLevel()
	if nCurLevel > 1 then
		SetTask(2070, 1)
		return
	end
	-- Hç trî Level
	if nCurLevel < Level_KhoiTao then
		ST_LevelUp(Level_KhoiTao - nCurLevel)
	end
	-- Hç trî trang bŞ vËt phÈm
	tbitemht  =
	{
		[1]	={szName = "ThÇn Hµnh Phï", tbProp = {6,1,1266,1,0,0},	nCount = 1,	nBindState = -2}, --nExpiredTime = 1440*7
 		[2]	={szName = "Håi thµnh phï", tbProp = {6,1,438,0,0},	nCount = 1,	nBindState = -2}, --nExpiredTime = 1440*7
		[3]	={szName = "Mat na tan thu", tbProp = {0,11,561,1,0,0,0}, nCount = 1,  nBindState = -2}, --nExpiredTime = 1440*30
		--[4]	={szName = "Trang BŞ Kim Phong", tbProp = {0,184}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[5]	={szName = "Trang BŞ Kim Phong", tbProp = {0,179}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[6]	={szName = "Trang BŞ Kim Phong", tbProp = {0,177}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[7]	={szName = "Trang BŞ Kim Phong", tbProp = {0,178}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[8]	={szName = "Trang BŞ Kim Phong", tbProp = {0,183}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[9]	={szName = "Trang BŞ Kim Phong", tbProp = {0,181}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[10]	={szName = "Trang BŞ Kim Phong", tbProp = {0,182}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[11]	={szName = "Trang BŞ Kim Phong", tbProp = {0,185}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[12]	={szName = "Trang BŞ Kim Phong", tbProp = {0,180}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*14},
		--[13]	={szName = "Nhan tan thu", tbProp = {0,514}, nCount = 1,  nBindState = -2, nQuality = 1,nExpiredTime = 1440*30},
		--[14]	={szName = "Tóc S­¬ng", tbProp = {0,10,2,9,0,0}, nCount = 1,  nBindState = -2,nExpiredTime = 1440*30},
	}
	tbAwardTemplet:GiveAwardByList(tbitemht, "PhÇn th­ëng t©n thñ");
	SetTask(2070, 1)
	Msg2SubWorld("Chµo mõng T©n Thñ <color=yellow>"..GetName().."<color> ®Õn víi thÕ giíi ¶o <color=green>kiÕm hiÖp t×nh duyÒn Vâ L©m TruyÒn Kú<color>. Chóc b¹n cã nh÷ng kû niÖm ®Ñp vÒ tuæi th¬!.");
end

--== Boss S¸t Thñ ==--
function BossSatThu()
	local tb_BossSatThu_Donate =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,5),	nRate=100,	nExpiredTime = 1440*7},},
	}
	local tb_BossSatThu_Free =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,2),	nRate=100,	nBindState = -2,	nExpiredTime = 1440*7},},
	}
	local	ID_Skill	=	ID_Skill_Donate
	local nWeekDay = tonumber(GetLocalDate("%w"));
	local nHour = tonumber(GetLocalDate("%H%M"))
		if(nHour	>=	nHour_star	and	nHour	<	nHour_end)	and	nWeekDay	==	w_ThuHai	then
			if (GetSkillState(ID_Skill) == -1) then
				tbAwardTemplet:GiveAwardByList(tb_BossSatThu_Free, "PhÇn th­ëng hoµn thµnh NhiÖm vô s¸t thñ cÊp 90");
			else
				tbAwardTemplet:GiveAwardByList(tb_BossSatThu_Donate, "PhÇn th­ëng hoµn thµnh NhiÖm vô s¸t thñ cÊp 90");
			end;
			Msg2SubWorld("Boss <color=yellow>s¸t thñ cÊp 90<color> lµm r¬i nhiÒu <color=green>TiÒn §ång<color> , mau chãng nhÆt lÊy.");
		else
			Msg2Player("NhiÖm vô hoµn thµnh ngoµi khung giê ho¹t ®éng nªn kh«ng nhËn ®­îc th­ëng <color=green>TiÒn §ång<color>.")
		end;
end

--== Boss Thñy T¾c ==--
function BossThuyTac()
	local tb_BossThuyTac_Donate =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,10),	nRate=100,	nExpiredTime = 1440*7},},
	}
	local tb_BossThuyTac_Free =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,3),	nRate=100,	nBindState = -2,	nExpiredTime = 1440*7},},
	}
	local	ID_Skill	=	ID_Skill_Donate
	local nWeekDay = tonumber(GetLocalDate("%w"));
	local nHour = tonumber(GetLocalDate("%H%M"))
		if(nHour	>=	nHour_star	and	nHour	<	nHour_end)	and	(nWeekDay	==	w_ThuBa	or	nWeekDay	==	w_ThuTu)	then
			if (GetSkillState(ID_Skill) == -1) then
				tbAwardTemplet:GiveAwardByList(tb_BossThuyTac_Free, "PhÇn th­ëng Boss Thñy TÆc §Çu LÜnh PLD");
			else
				tbAwardTemplet:GiveAwardByList(tb_BossThuyTac_Donate, "PhÇn th­ëng Boss Thñy TÆc §Çu LÜnh PLD");
			end;
			Msg2SubWorld("Boss <color=yellow>Thñy TÆc §Çu LÜnh<color> lµm r¬i nhiÒu <color=green>TiÒn §ång<color> trªn thuyÒn, mau chãng nhÆt lÊy. ");
		else
			Msg2Player("NhiÖm vô hoµn thµnh ngoµi khung giê ho¹t ®éng nªn kh«ng nhËn ®­îc th­ëng <color=green>TiÒn §ång<color>.")
		end;
end

--== Boss §¹i Thñy T¾c ==--
function BossDaiThuyTac()
	local tb_BossDaiThuyTac_Donate =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,20),	nRate=100,	nExpiredTime = 1440*7},},
	}
	local tb_BossDaiThuyTac_Free =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,5),	nRate=100,	nBindState = -2,	nExpiredTime = 1440*7},},
	}
	local	ID_Skill	=	ID_Skill_Donate
	local nWeekDay = tonumber(GetLocalDate("%w"));
	local nHour = tonumber(GetLocalDate("%H%M"))
		if(nHour	>=	nHour_star	and	nHour	<	nHour_end)	and	(nWeekDay	==	w_ThuBa	or	nWeekDay	==	w_ThuTu)	then
			if (GetSkillState(ID_Skill) == -1) then
				tbAwardTemplet:GiveAwardByList(tb_BossDaiThuyTac_Free, "PhÇn th­ëng Boss Thñy TÆc §¹i §Çu LÜnh PLD");
			else
				tbAwardTemplet:GiveAwardByList(tb_BossDaiThuyTac_Donate, "PhÇn th­ëng Boss Thñy TÆc §¹i §Çu LÜnh PLD");
			end;
			Msg2SubWorld("Boss <color=yellow>Thñy TÆc §¹i §Çu LÜnh<color> lµm r¬i nhiÒu <color=green>TiÒn §ång<color> trªn thuyÒn, mau chãng nhÆt lÊy. ");
		else
			Msg2Player("NhiÖm vô hoµn thµnh ngoµi khung giê ho¹t ®éng nªn kh«ng nhËn ®­îc th­ëng <color=green>TiÒn §ång<color>.")
		end;
end

--== Boss TiÓu Hoµng Kim ==--
function BossTieuHK()
	local tb_BossTieuHK_Donate =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,10),	nRate=100,	nExpiredTime = 1440*7},},
	}
	local tb_BossTieuHK_Free =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,3),	nRate=100,	nBindState = -2,	nExpiredTime = 1440*7},},
	}
	local	ID_Skill	=	ID_Skill_Donate
	local nWeekDay = tonumber(GetLocalDate("%w"));
	local nHour = tonumber(GetLocalDate("%H%M"))
		if(nHour	>=	nHour_star	and	nHour	<	nHour_end)	and	nWeekDay	==	w_ThuNam	then
			if (GetSkillState(ID_Skill) == -1) then
				tbAwardTemplet:GiveAwardByList(tb_BossTieuHK_Free, "PhÇn th­ëng Boss TiÓu Hoµng Kim");
			else
				tbAwardTemplet:GiveAwardByList(tb_BossTieuHK_Donate, "PhÇn th­ëng Boss TiÓu Hoµng Kim");
			end;
			Msg2SubWorld("Boss <color=yellow>TiÓu Hoµng Kim<color> lµm r¬i nhiÒu <color=green>TiÒn §ång<color> , mau chãng nhÆt lÊy. ");
		else
			Msg2Player("NhiÖm vô hoµn thµnh ngoµi khung giê ho¹t ®éng nªn kh«ng nhËn ®­îc th­ëng <color=green>TiÒn §ång<color>.")
		end;
end

--== Boss §¹i Hoµng Kim ==--
function BossDaiHK()
	local tb_BossDaiHK_Donate =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,50),	nRate=100,	nExpiredTime = 1440*7},},
	}
	local tb_BossDaiHK_Free =	{
		{{szName="TiÒn §ång",	tbProp={4,417,1,1,0,0},	nCount=random(1,20),	nRate=100,	nBindState = -2,	nExpiredTime = 1440*7},},
	}
	local	ID_Skill	=	ID_Skill_Donate
	local nWeekDay = tonumber(GetLocalDate("%w"));
	local nHour = tonumber(GetLocalDate("%H%M"))
		if(nHour	>=	nHour_star	and	nHour	<	nHour_end)	and	nWeekDay	==	w_ThuBay	then
			if (GetSkillState(ID_Skill) == -1) then
				tbAwardTemplet:GiveAwardByList(tb_BossDaiHK_Free, "PhÇn th­ëng hoµn thµnh NhiÖm vô s¸t thñ cÊp 90");
			else
				tbAwardTemplet:GiveAwardByList(tb_BossDaiHK_Donate, "PhÇn th­ëng hoµn thµnh NhiÖm vô s¸t thñ cÊp 90");
			end;
			Msg2SubWorld("Boss <color=yellow>§¹i Hoµng Kim<color> lµm r¬i nhiÒu <color=green>TiÒn §ång<color> , mau chãng nhÆt lÊy. ");
		else
			Msg2Player("NhiÖm vô hoµn thµnh ngoµi khung giê ho¹t ®éng nªn kh«ng nhËn ®­îc th­ëng <color=green>TiÒn §ång<color>.")
		end;
end

--== Tèng Kim ==--
function AddAward_toptk(nRank)
	if not nRank then
		return
	end
	local tbThuongTop21 = 
	{
		[1]={
			{szName="Xu", tbProp={4,417,1,1,0,0,0},nCount=50,},
		},
		[2]={
			{szName="Xu", tbProp={4,417,1,1,0,0,0},nCount=40,},
		},
		[3]={
			{szName="Xu", tbProp={4,417,1,1,0,0,0},nCount=30,},
		},
		[4]={
			{szName="Xu", tbProp={4,417,1,1,0,0,0},nCount=20,},
		},
		[5]={
			{szName="Xu", tbProp={4,417,1,1,0,0,0},nCount=10,},
		},
	}
	local slog = format("ThuongTop%dTongKim", nRank)
	local tbAward1 = tbThuongTop21[nRank]
	local nWeekDay = tonumber(GetLocalDate("%w"));
	local nHour = tonumber(GetLocalDate("%H%M"))		
	local nCurLevel = GetLevel()
	if( nHour >= 2100 and nHour < 2300)	and	nWeekDay	==	w_ChuNhat		and	nCurLevel		>=	nLevel	then
		tbAwardTemplet:Give(tbAward1, 1, {slog,slog})
		return
	end
end
