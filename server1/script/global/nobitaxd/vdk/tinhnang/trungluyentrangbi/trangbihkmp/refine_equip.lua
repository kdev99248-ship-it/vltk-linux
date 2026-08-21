Include("\\script\\lib\\composeex.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua")
Include("\\script\\lib\\log.lua")

tbBaiHuRefineEquip = tbActivityCompose:new()

tbBaiHuRefineList = 
{
	[1]= {szName="Trang BÞ HKMP", nWidth = 2, nHeight = 1, nFreeItemCellLimit = 1},
}

function tbBaiHuRefineEquip:ComposeGiveUI()
	local szTitle = format("  %-15s\t%s", "Trang bÞ HKMP", "Trïng LuyÖn \nTrang bÞ HKMP")
	local strDesc = "ChØ cÇn bá trang bÞ HKMP vµo, kh«ng cÇn nguyªn liÖu."
	g_GiveItemUI(szTitle, strDesc, {self.GiveUIOk, {self}}, nil, self.bAccessBindItem)
end

function tbBaiHuRefineEquip:Compose(nComposeCount)
	local nCurTime = GetCurServerTime()
	nComposeCount = nComposeCount or 1
	
	if type(self.tbFormula.pLimitFun) == "function" then
		if self.tbFormula:pLimitFun(nComposeCount) ~= 1 then
			return 0
		end
	end
	
	local tbRoomItems = self:GetRoomItems(self.nRoomType)
	local tbGoldEquip = nil
	local nEquType = 0
	local nEqIndex = 0
	local nOldItemIndex = nil
	local tbEquip_Hkmp1 = nil
	
	for i = 1, getn(tbRoomItems) do 
		local nItemQuality = GetItemQuality(tbRoomItems[i])
		local nItemTime = ITEM_GetExpiredTime(tbRoomItems[i])
		local nTimeLeftCount = (nItemTime - nCurTime)/(60*60*24)
		
		if nItemQuality == 1 then
			tbEquip_Hkmp1 = {[1] = {}}
			for nId = 1, 140 do
				tbEquip_Hkmp1[1][nId] = {
					szName = "Trang bÞ HKMP",
					tbProp = {0, nId},
					nQuality = 1,
					nExpiredTime = nTimeLeftCount * 24 * 60,
				}
			end
			
			nEqIndex = GetGlodEqIndex(tbRoomItems[i])
			if nEqIndex >= 1 and nEqIndex <= 140 then
				local nBindState = GetItemBindState(tbRoomItems[i])
				if nBindState ~= 0 then
					Say("Trang bÞ cña ng­¬i ®ang trong tr¹ng th¸i khãa, kh«ng thÓ trïng luyÖn.")
					return 0
				end
				
				local nG, _, _ = GetItemProp(tbRoomItems[i])
				if nG == 7 then
					Say("Trang bÞ cña ng­¬i ®· bÞ h­ h¹i kh«ng thÓ trïng luyÖn.")
					return 0
				end
				
				nEquType = 1
				tbGoldEquip = {0, nEqIndex}
				nOldItemIndex = tbRoomItems[i]
				break
			end
		end	
	end
	
	if tbGoldEquip == nil then
		Say("Ng­¬i ch­a ®Æt trang bÞ HKMP nµo vµo ®©y c¶.")
		return 0	
	end
	
	-- Xoa trang bi cu truc tiep, khong can ConsumeMaterial
	RemoveItemByIndex(nOldItemIndex)
	
	-- Cap trang bi moi (luon thanh cong)
	local tbProduct = tbEquip_Hkmp1[1][nEqIndex]
	tbAwardTemplet:GiveAwardByList(tbProduct, self.szLogTitle, nComposeCount)
	Msg2SubWorld("<color=cyan>Chóc mõng ®¹i hiÖp <color=green>"..GetName().."<color=yellow> Trïng LuyÖn Thµnh C«ng <color=green>Trang BÞ HKMP!")
	
	if type(self.tbFormula.pProductFun) == "function" then
		self.tbFormula:pProductFun(nComposeCount)
	end
	return 1
end

function refine_HKMP()
	local strDesc = "<npc>§Æt <color=yellow>trang bÞ HKMP<color> muèn trïng luyÖn vµo phÝa d­íi. <color=green>Kh«ng cÇn nguyªn liÖu, lu«n thµnh c«ng!<color>"
	local tbOpt = {}
	local tbMate = {
		tbMaterial = {
			{szName = "Trang bÞ HKMP", tbProp = {0, {1,904}}, nQuality = 1},
		},
		tbProduct = {szName = "Trang bÞ HKMP", tbProp = {0, {1,904}}},
	}
	local p = tbBaiHuRefineEquip:new(tbMate, "BaiHuRefineEquip", INVENTORY_ROOM.room_giveitem)
	tinsert(tbOpt, {"Trïng luyÖn trang bÞ Hoµng Kim M«n Ph¸i", p.ComposeGiveUI, {p}})
	tinsert(tbOpt, {"Hñy bá"})
	CreateNewSayEx(strDesc, tbOpt)
end