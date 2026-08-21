Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\activitysys\\npcfunlib.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\lib\\composelistclass.lua")
Include("\\script\\event\\jiefang_jieri\\201004\\triumph_drum\\npc.lua")
Include("\\script\\event\\zhongqiu_jieri\\200808\\zoumadeng\\event.lua")	--zhongqiu_jieri/200808
Include("\\script\\misc\\eventsys\\type\\npc.lua")
Include("\\script\\lib\\composeex.lua")
--»»È¡ÐÐÏÀÁî³ö´í - modified by DinhHQ - 20110921
Include("\\script\\vng_event\\doi_hanh_hiep_lenh\\exchangeitem.lua")
Include("\\script\\missions\\dragonboat\\npc\\dragonboat_main.lua")
Include("\\script\\lib\\awardtemplet.lua")

Include("\\script\\event\\cookies2007\\event.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function OnExit()

end;

function main()
	dofile("script/global/Áã··¹¦ÄÜ.lua");

	--Say( "T¹i ®©y ta cã b¸n Tèng kim Chiªu Binh lÖnh vµ LÖnh Bµi Phong L¨ng §é ng­¬i cã muèn mua kh«ng ?!", 6,
	--	"Mua TÝn Sø Kim Yªu bµi/TinsuLB",
	--	"Mua M¶nh Thiªn Th¹ch/buyMTT",
	--	"Mua LÖnh bµi Phong L¨ng §é/buyLB",
	--	"Mua Tèng Kim Chiªu Binh LÖnh/buytk",
	--	"NÊu b¸nh ch­ng ®ãn giao thõa/cookies2007_main",
	--	"VËy ta ®i ®©y!/OnExit" );
	--return

	local nNpcIndex = GetLastDiagNpc();
	local szNpcName = GetNpcName(nNpcIndex);
	if NpcName2Replace then szNpcName = NpcName2Replace(szNpcName) end
	local tbDailog = DailogClass:new(szNpcName);
	--G_ACTIVITY:OnMessage("ClickNpc", tbDailog, nNpcIndex);
	
	--EventSys:GetType("AddNpcOption"):OnEvent(szNpcName, tbDailog, nNpcIndex)
	
	
	tbDailog.szTitleMsg = "<#><npc>ë ®©y toµn kú tr©n dÞ b¶o, kh¸ch quan cø lùa chän tho¶i m¸i ®i!"
	
	--Change request 04/06/2011, ÖÆÔì°×½ð×°±¸- Modified by DinhHQ - 20110605
	local w,x,y = GetWorldPos()
	if (CFG_cookies2007	== 1) then
		tbDailog:AddOptEntry("ho¹t ®éng mïng 3 th¸ng 3",  cookies2007_main);  	
	end
	if (CFG_zhongqiu_jieri_2008	== 1) then
		tbDailog:AddOptEntry("Mua 1 nÕn ®á",  zhongqiu0808_zoumadeng_buy);  	
	end
	--if w == 176 then
		tbDailog:AddOptEntry("Mua M¶nh Thiªn Th¹ch To¸i PhiÕn.", Sale, {151}); 
	--end
	--»»È¡ÐÐÏÀÁî³ö´í- modified by DinhHQ - 20110921
	--tbVng_Exchange_HHL:AddDialog(tbDailog)
       --tbDailog:AddOptEntry("Tham gia ®ua thuyÒn rång", WantBuyBaoshi)
      	--tbDailog:AddOptEntry("Liªn quan ®Õn thuyÒn rång", dragonboat_main)
	--tbDailog:AddOptEntry("Mua håi thiªn t¸i t¹o cÈm nang", WantBuyHuiTian)
	--tbDailog:AddOptEntry("Mua Tö M·ng Kim Bµi", WantBuyJinpai)
	--tbDailog:AddOptEntry("Mua Kim ¤ Kim Bµi", WantBuyJinWuJinpai)
	--tbDailog:AddOptEntry("§æi lÊy B¶o Th¹ch", WantBuyBaoshi)
	
	--Change request 04/06/2011 - Modified by DinhHQ - 20110605
	--tbDailog:AddOptEntry("§Ó ta xem nµo (cöa tiÖm ®å cò)", OpenSecondStore); 
	if tbTriumphDrum:CheckCondition_BuyDrum() == 1 then
		tbDailog:AddOptEntry("Mua Trèng Kh¶i Hoµn",  tbTriumphDrum.NpcTalk,{tbTriumphDrum});  	
	end

	--Change request 04/06/2011 - Modified by DinhHQ - 20110605
	--tbDailog:AddOptEntry("Tho¸t ra", OnExit, {}); 	
	tbDailog:Show()
end;

function OpenSecondStore()
	--do return end	
	CreateStores();
	AddShop2Stores(178, "Cöa tiÖm ®å cò", 1, 100, "", 1);
	OpenStores();

end
function TinsuLB()
	if (GetCash() <= 1000000) then
		Talk(1, "", "Ph¶i ca ®ñ 100 v¹n míi ca thÓ mua.")
		return
	end
	Pay(1000000)
	local tbItem = {szName="TÝn Sø Kim Yªu bµi", tbProp={6,1,888,1,0,0},}
	tbAwardTemplet:GiveAwardByList(tbItem, "TÝn Sø Kim Yªu bµi", 1)

end
function buytk()
	if (GetCash() <= 200000) then
		Talk(1, "", "Ph¶i ca ®ñ 20 v¹n míi ca thÓ mua.")
		return
	end
	Pay(200000)
	local tbItem = {szName="Tèng kim chiªu binh lÖnh", tbProp={6,1,30083,1,0,0},}
	tbAwardTemplet:GiveAwardByList(tbItem, "Tèng kim chiªu binh lÖnh", 1)

end
function buyLB()
	if (GetCash() <= 200000) then
		Talk(1, "", "Ph¶i ca ®ñ 20 v¹n míi ca thÓ mua.")
		return
	end
	Pay(200000)
	local tbItem = {szName="LÖnh bµi Phong L¨ng §é", tbProp={4,489,1,1,0,0},}
	tbAwardTemplet:GiveAwardByList(tbItem, "LÖnh bµi Phong L¨ng §é", 1)

end
function buyMTT()
Sale(151)
end

function WantBuyHuiTian()
	--Change request 04/06/2011 - Modified by DinhHQ - 20110605
	local nPrice = 1
	local szTitle = format("Mua håi thiªn t¸i t¹o cÈm nang cÇn ph¶i cã %s Hµnh HiÖp LÖnh",tostring(nPrice))
	local tbOpt = {}
	tinsert(tbOpt, {"X¸c nhËn", BuyHuiTian}) 
	tinsert(tbOpt, {"Nh©n tiÖn ghÐ qua th«i"})
	CreateNewSayEx(szTitle, tbOpt);
end

function WantBuyJinpai()
	--Change request 04/06/2011 - Modified by DinhHQ - 20110605
	local nPrice = 100
	local szTitle = format("Mua Tö M·ng Kim Bµi cÇn ph¶i cã %s Hµnh HiÖp LÖnh, quyÕt ®Þnh muèn mua chø?",tostring(nPrice))
	local tbOpt = {}
	tinsert(tbOpt, {"X¸c nhËn", BuyJinpai}) 
	tinsert(tbOpt, {"Nh©n tiÖn ghÐ qua th«i"})
	CreateNewSayEx(szTitle, tbOpt);
end

function WantBuyJinWuJinpai()
	local nPrice = 400
	local szTitle = format("Mua Kim ¤ Kim Bµi cÇn ph¶i cã %s Hµnh HiÖp LÖnh, ng­¬i cã x¸c ®Þnh mua kh«ng?",tostring(nPrice))
	local tbOpt = {}
	tinsert(tbOpt, {"X¸c nhËn", BuyJinWuJinpai}) 
	tinsert(tbOpt, {"Nh©n tiÖn ghÐ qua th«i"})
	CreateNewSayEx(szTitle, tbOpt);
end


function BuyHuiTian()
	local tbFormula = 
	{
		szName = "Håi thiªn t¸i t¹o cÈm nang",
		--Change request 04/06/2011 - Modified by DinhHQ - 20110605
		tbMaterial = {{szName="Hµnh HiÖp LÖnh",tbProp={6,1,2566,1,0,0},nCount = 1,},},
		tbProduct = {szName="Håi thiªn t¸i t¹o cÈm nang",tbProp={6,1,1781,1,0,0}, tbParam={60},},
		
		nWidth = 1,
		nHeight = 1,
		nFreeItemCellLimit = 1,
	}
	
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end

function BuyJinpai()
	local tbFormula = 
	{
		szName = "Tö M·ng Kim Bµi",
		--Change request 04/06/2011 - Modified by DinhHQ - 20110605
		tbMaterial = {{szName="Hµnh HiÖp LÖnh",tbProp={6,1,2566,1,0,0},nCount = 100,},},
		tbProduct = {szName="Tö M·ng Kim Bµi",tbProp={6,1,2765,1,0,0},},
		
		nWidth = 1,
		nHeight = 1,
		nFreeItemCellLimit = 0.02,
	}
	
	local p = tbActivityCompose:new(tbFormula, "xingxialin2zimangjinpai", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end

function BuyJinWuJinpai()
	local tbFormula = 
	{
		szName = "Kim ¤ Kim Bµi",
		tbMaterial = {{szName="Hµnh HiÖp LÖnh",tbProp={6,1,2566,1,0,0},nCount = 400,},},
		tbProduct = {szName="Kim ¤ Kim Bµi",tbProp={6,1,3001,1,0,0},},
		
		nWidth = 1,
		nHeight = 1,
		nFreeItemCellLimit = 1,
	}
	
	local p = tbActivityCompose:new(tbFormula, "xingxialin3jinwujinpai", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end


tbEquip2Item = tbActivityCompose:new()

function tbEquip2Item:CheckItem(tbItem ,nItemIndex)
	if IsMyItem(nItemIndex) ~= 1 then
		return
	end
	
	local tbRecItem = self:MakeItem(nItemIndex)
	local nExpiredTime = ITEM_GetExpiredTime(nItemIndex)
	local nLeftUsageTime = ITEM_GetLeftUsageTime(nItemIndex)
	if nExpiredTime ~= 0 or nLeftUsageTime ~= 4294967295 then
		return 
	end
	
	for k,v in tbItem do
		if k ~= "szName" and type(v) ~= "table" and v ~= -1 and tbRecItem[k] and v~= tbRecItem[k] then
			return
		elseif  k == "tbProp" and type(v) == "table" then
			local tbProp = tbRecItem[k]
			for k1,v1 in v do
				if type(v1) ~= "table" then
					if  k1 ~= "n" and v1 ~= -1 and tbProp[k1] and v1~= tbProp[k1] then
						return 
					end
				else
					if  k1 ~= "n" and v1 ~= -1 and tbProp[k1] and ( v1[1] > tbProp[k1] or tbProp[k1] > v1[2] )  then
						return 
					end
				end
			end
		end
	end		
	for key, value in tbItem do 
		if strfind(key, "Limit") and  type(value) == "function" then
			if value(tbItem, nItemIndex) ~= 1 then
				return
			end
		end
	end			
	return 1
end

function WantBuyBaoshi()
	local nPrice = 400
	local szTitle = format("Ng­¬i muèn ®æi lo¹i B¶o Th¹ch nµo",tostring(nPrice))
	local tbOpt = {}
	local tbFormulaList = 
	{
		[1] = 
		{
			tbMaterial = 
			{
				{szName = "Trang bÞ Thanh C©u", tbProp = {0, {905,1134}}, nQuality = 1 },
			},
			tbProduct = {szName="Thanh c©u th¹ch", tbProp={6, 1, 2710, 1, 0, 0}},
			nWidth = 1,
			nHeight = 1,
			nFreeItemCellLimit = 0.02
		},
		[2] = 
		{
			tbMaterial = 
			{
				{szName = "Trang bÞ V©n Léc", tbProp = {0, {1135,1364}}, nQuality = 1 },
			},
			tbProduct = {szName="V©n Léc Th¹ch", tbProp={6, 1, 2711, 1, 0, 0}},
			nWidth = 1,
			nHeight = 1,
			nFreeItemCellLimit = 0.02
		},
		[3] = 
		{
			tbMaterial = 
			{
				{szName = "Trang bÞ Th­¬ng Lang", tbProp = {0, {1365,1594}}, nQuality = 1 },
			},
			tbProduct = {szName="Th­¬ng Lang Th¹ch", tbProp={6, 1, 2712, 1, 0, 0}},
			nWidth = 1,
			nHeight = 1,
			nFreeItemCellLimit = 0.02
		},
		[4] = 
		{
			tbMaterial = 
			{
				{szName = "Trang bÞ HuyÒn viªn", tbProp = {0, {1595,1824}}, nQuality = 1 },
			},
			tbProduct = {szName="HuyÒn Viªn Th¹ch", tbProp={6, 1, 2713, 1, 0, 0}},
			nWidth = 1,
			nHeight = 1,
			nFreeItemCellLimit = 0.02
		},		
		[5] = 
		{
			tbMaterial = 
			{
				{szName = "Trang bÞ Tõ M·ng", tbProp = {0, {1825,2054}}, nQuality = 1 },
			},
			tbProduct = {szName="Tö M·ng th¹ch", tbProp={6, 1, 3000, 1, 0, 0}},
			nWidth = 1,
			nHeight = 1,
			nFreeItemCellLimit = 0.02
		},	
	}
		
	local tbOpt = {}
	local pEventType = EventSys:GetType("AddNpcOption")
	for i=1, getn(tbFormulaList) do
		local p = tbEquip2Item:new(tbFormulaList[i], "Equip2Stone", INVENTORY_ROOM.room_giveitem)
		local szOpt = format("§æi ®­îc %s", tbFormulaList[i].tbProduct.szName)
		tinsert(tbOpt, {szOpt, p.ComposeGiveUI, {p}})
	end
	tinsert(tbOpt, {"Hñy bá"})
	CreateNewSayEx(szTitle, tbOpt);
end
