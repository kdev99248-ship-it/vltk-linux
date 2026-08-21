IncludeLib("SETTING")
IncludeLib("ITEM");
IncludeLib("FILESYS")
Include("\\script\\task\\system\\task_string.lua")
Include("\\script\\global\\titlefuncs.lua")
Include("\\script\\global\\judgeoffline.lua")
Include("\\settings\\trigger_challengeoftime.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\global\\fuyuan.lua")


function mainreroll()
	dofile("script/global/sang/tinhnang/hoanbinhvukhi/hoanbinh.lua")
		local tbOpt = {
		{"Ho¸n §æi Vò KhÝ",reroll,{2}},
		{"TÈy LuyÖn Thuéc TÝnh ",reroll,{1}},
		{"KÕt Thóc",No},
	}
	CreateNewSayEx("<color=green>Chøc N¨ng Ho¸n §æi Vò KhÝ Vµ Thay §æi Thuéc TÝnh !!!<color>", tbOpt)
	  return 1;
end



NGUYENLIEU = {
	[1] = {nTienVan = 100000 * 5},   -- Tay luyen thuoc tinh
	[2] = {nTienVan = 100000 * 1},  -- Hoan doi vu khi
}

IdVatPham1 = 417
TenVatPham1 = "TiÒn §ång"
IdVatPham2 = 5286
TenVatPham2 = "Th¹ch ChuyÓn Ho¸"

function reroll(nValue)
	SetTaskTemp(101, nValue)
	local nTienVan = NGUYENLIEU[nValue].nTienVan;
	GiveItemUI("Xin bá trang bÞ vµo «", "\n<+> TiÒn V¹n: "..nTienVan.."", "confirm","cancel",1);
end

function confirm(nCount)
	nValue = GetTaskTemp(101)
	local nTienVan = NGUYENLIEU[nValue].nTienVan;
	
	if (GetCash() < nTienVan) then 
		Say(""..myplayersex().." mang thiÕu <color=red>"..nTienVan.."<color> l­îng!") 
		return 
	end
	
	for i = 1, nCount do				
		local nItemIndex = GetGiveItemUnit(i)
		local nQuality = GetItemQuality(nItemIndex)
		local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
		local arynMagLvl = GetItemAllParams(nItemIndex)
		for j = 1, 6 do	
			local nOpt = GetItemMagicAttrib(nItemIndex, j)
			if (nCount ~= 1) then 
				Talk(1, "", ""..myplayersex().." chØ cÇn bá <color=red>"..GetItemName(nItemIndex).."<color> vµo lµ ®­îc!\nnh÷ng thø kh¸c ta sÏ trõ trong hµnh trang...!"); 
				return 
			end
		end
		if nValue == 1 then
			tbProgressBar.tbConfig[1].nTime = 2
			tbProgressBar.tbConfig[1].szTitle = "§ang Xö Lý..."
			tbProgressBar:OpenByConfig(1, _confirm, {nCount}, OnBreak)
		else
			if nDetailType >= 2 then 
				Talk(1,"","Trang bÞ ng­¬i bá vµo kh«ng ph¶i lµ <color=red>Vò KhÝ<color>!!!") 
				return 
			end
			tbProgressBar.tbConfig[1].nTime = 2
			tbProgressBar.tbConfig[1].szTitle = "§ang Xö Lý..."
			tbProgressBar:OpenByConfig(1, _confirm, {nCount}, OnBreak)
		end
	end
end

function _confirm(nCount)
	nValue = GetTaskTemp(101)
	local nTienVan = NGUYENLIEU[nValue].nTienVan;
	
	for i = 1, nCount do				
		local nItemIndex = GetGiveItemUnit(i)
		local nEquipVer = ITEM_GetItemVersion(nItemIndex)
		local nQuality = GetItemQuality(nItemIndex)
		local nEquipRandSeed = ITEM_GetItemRandSeed(nItemIndex)
		local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
		local arynMagLvl = GetItemAllParams(nItemIndex)			
		
		if nItemIndex <= 0 or not GetItemName(nItemIndex) then
			Msg2Player("Kh«ng thÓ x¸c ®Þnh trang bÞ, thao t¸c bÞ hñy!")
			return
		end
		RemoveItemByIndex(nItemIndex)
		Pay(nTienVan);
		
		if nValue == 1 then
			local ItemIndex = AddItemEx(nEquipVer,0,nQuality,nGenre,nDetailType,nParticular,nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
			local msg = format("<color=yellow>Chóc mõng "..myplayersex().." <color=green>%s<color> ®· tÈy luyÖn thuéc tÝnh trang bÞ <color=blue><%s><color> thµnh c«ng. <pic=7>", GetName(), GetItemName(ItemIndex))
			Msg2SubWorld(msg) 
		else
			i = random(1,100)
			if i < 41 then
				local ItemName = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,0,random(0,6),nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
				local msg = format("<color=yellow>Chóc mõng "..myplayersex().." <color=green>%s<color> ®· ®æi vò khÝ thµnh c«ng <color=blue><%s><color>.", GetName(), GetItemName(ItemName))
				Msg2SubWorld(msg)
			elseif i < 81 then
				local ItemName = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,1,random(0,2),nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
				local msg = format("<color=yellow>Chóc mõng "..myplayersex().." <color=green>%s<color> ®· ®æi vò khÝ thµnh c«ng <color=blue><%s><color>.", GetName(), GetItemName(ItemName))
				Msg2SubWorld(msg)
			else
				AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,nDetailType,nParticular,nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
				Msg2Player("Ho¸n binh thÊt b¹i - Trang bÞ ®­îc gi÷ nguyªn.")
			end
		end
	end	
end


function OnBreak()
	Msg2Player("Thao T¸c BÞ Hñy, Xin Thö L¹i!")
end
----------------------------------------------------------------------------------------------
