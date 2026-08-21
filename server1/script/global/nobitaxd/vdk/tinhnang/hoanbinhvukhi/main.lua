IncludeLib("TASKSYS");
Include("\\script\\lib\\gb_taskfuncs.lua")
Include("\\script\\lib\\composeex.lua")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\lib\\progressbar.lua")
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\hoanbinhvukhi\\head.lua")
function myplayersex()
if GetSex() == 1 then return "N÷ hiÖp"; else return "§¹i hiÖp"; end
end

function mainhoandoi()
	dofile("script/global/nobitaxd/vdk/tinhnang/hoanbinhvukhi/main.lua")
		local tbOpt = {
			{"Ta muèn Ho¸n §æi Binh KhÝ.",weaponswap},
			{"KÕt thóc dèi tho¹i",No},
		}
	CreateNewSayEx("<npc><color=green>ta ®©y cã nhiÒu sù lùa chän cho "..myplayersex().." , ng­¬i muèn lµm g× ?<color>", tbOpt)
end

function WriteLogAll(szPath, szFile, szMsg)
	local logDir = "log/"
	local check = io.open(logDir.."test.tmp", "w")
	if not check then
		os.execute("mkdir " .. logDir)
	else
		check:close()
		os.remove(logDir.."test.tmp")
	end

	local filePath = logDir.."hoanbinhvukhi_"..date("%d_%m_%Y")..".txt"
	local file = io.open(filePath, "a+")
	if file then
		file:write(string.format("[%s] %s\n", date("%Y-%m-%d %H:%M:%S"), szMsg))
		file:close()
	else
		Msg2Player("<color=red>Kh«ng thÓ ghi log! H·y kiÓm tra quyÒn th­ môc /log/<color>")
	end
end

function weaponswap()
	local tbMaterial = tbMaterial_List;
	local szTitle = format("Ho¸n Binh Vò KhÝ")
	local szContent = "§Æt vò khÝ cÇn ®æi vµo :";
	szContent = szContent.."<enter>------------------";
	szContent = szContent.."<enter>Nguyªn liÖu cÇn :";
	szContent = format("%s<enter>%-20s  %s", szContent, "VËt phÈm", "Sè l­îng")	
	for i = 1, getn(tbMaterial_List) do
		szContent = format("%s<enter>%-20s  %s", szContent, tbMaterial_List[i].szName, tbMaterial_List[i].nCount)
	end
	if nPractice_Fees > 0 then 
		szContent = format("%s<enter>%-20s  %s", szContent, "V¹n l­îng", floor(nPractice_Fees/10000))
		g_GiveItemUI(szTitle, szContent, {weaponswap_action})
	end
	
end

function weaponswap_action(nCount)
	if nCount ~= 1 then
		Talk(1, "", "ChØ ®­îc bá 1 mãn vò khÝ cÇn ho¸n ®æi")
		return
	end
	nItemIndex = GetGiveItemUnit(1)
	local nEquipVer = ITEM_GetItemVersion(nItemIndex)
	local nQuality = GetItemQuality(nItemIndex)
	local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
	local nEquipRandSeed = ITEM_GetItemRandSeed(nItemIndex)
	local arynMagLvl = GetItemAllParams(nItemIndex)	
	local nOldItemIndex = GetItemName(nItemIndex)
	if (nQuality ~= 0) then 
		Talk (1,"","Trang bÞ ®Æt vµo kh«ng ph¶i <color=blue>Trang BÞ Xanh") 
		return 
	end
	if nGenre ~= 0 or nDetailType >= 2 then 
		Talk(1,"","Trang bÞ ng­¬i bá vµo kh«ng ph¶i lµ <color=red>Vò KhÝ<color>!!!") 
		return 
	end

	if (GetCash() < nPractice_Fees) then
		Say(format("RÊt tiÕc! B¹n kh«ng cã ®ñ <color=yellow>%s l­îng<color>!",nPractice_Fees));
		return
	end;
	for i = 1, getn(tbMaterial_List) do
		local nCheck = CalcEquiproomItemCount(tbMaterial_List[i].tbProp[1],tbMaterial_List[i].tbProp[2],tbMaterial_List[i].tbProp[3],tbMaterial_List[i].tbProp[4])
		if (nCheck < tbMaterial_List[i].nCount) then
			Say(""..myplayersex().." mang thiÕu <color=red>"..(tbMaterial_List[i].nCount-nCheck).."<color> <color=yellow>"..tbMaterial_List[i].szName.."<color>!")
			return
		end;
	end;
	
	
	for i = 1, getn(tbMaterial_List) do
		ConsumeEquiproomItem(tbMaterial_List[i].nCount,tbMaterial_List[i].tbProp[1],tbMaterial_List[i].tbProp[2],tbMaterial_List[i].tbProp[3],tbMaterial_List[i].tbProp[4]);
	end;
	RemoveItemByIndex(nItemIndex)
	if nPractice_Fees > 0 then
		Pay(nPractice_Fees);
	end
	local nrate = random(1,EQUIPBLUE_LIST[1]);
	local nsum = 0
	for nkey,nitem in EQUIPBLUE_LIST[2] do
		nsum = nsum + (nitem["nrate"] * 1000)
		if (nsum > nrate) then
			local g = nitem["G"];
			local d = nitem["D"];
			local p = nitem["P"];
			local nNewItemIndex = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,g,d,p,nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
			local msg = format("<color=yellow>Chóc mõng "..myplayersex().." ®· Ho¸n Binh thµnh c«ng tõ <color=blue><%s><color> Thµnh <color=blue><%s><color>.", nOldItemIndex, GetItemName(nNewItemIndex) )
			Msg2Player(msg)
			return 0
		end
	end
end























