-- Ç®×¯¹¦ÄÜ.lua		¢ôºì°üµÄ±ê×¼ÎÄ¼ş
-- By Dan_Deng(2003-12-31)
-- Update: Dan_Deng(2004-01-06) ½«ÒøÆ±¹¦ÄÜÒÆ³öµ½ÁÙ°²Ç®×¯¶ÀÓĞ
Include("\\script\\global\\head_qianzhuang.lua") -- Ç®×¯Í·ÎÄ¼ş
IncludeForRegionVer("\\script\\global\\", "gamebank_proc.lua")

function main_proc()
	dofile("script/global/Ç®×¯¹¦ÄÜ.lua");
	if (GetSex() == 0) then
		Say("¤ng chñ tiÒn trang:  VŞ thiÕu hiÖp kia cÇn l·o phu gióp g× ? ",1,"Ta chØ ghĞ qua th«i./no")
	else
		Say("¤ng chñ tiÒn trang:  VŞ c« n­¬ng kia cÇn l·o phu gióp g× ? ",1,"Ta chØ ghĞ qua th«i./no")
	end
end
------------ ¢òºì°ü ---------------------
function buy_sele()
	Say("§­îc ®­îc, chç nµy ®óng lµ cã b¸n bao l× x×, tiÓu hång bao 10v, ®¹i hång bao 100v.\n§Æc biÖt cã <color=green>Hång bao nh­ ı vµ Hång bao mõng thä<color> cã thÓ cã nhiÒu <color=green>TiÒn V¹n<color> vµ <color=yellow>TiÒn §ång<color>. \nNgµi muèn mua lo¹i nµo ? ",5,"TiÓu hång bao/buy1","§¹i hång bao /buy2","Hång bao nh­ ı /buy3","Hång bao mõng thä /hesui_hongbao","Kh«ng mua n÷a./no")
	--Say("§­îc ®­îc, chç nµy ®óng lµ cã b¸n bao l× x×, tiÓu hång bao 1v, ®¹i hång bao 10v, ng­êi muèn mua lo¹i nµo ? ",3,"Mua tiÓu hång bao/buy1","Mua ®¹i hång bao/buy2","Kh«ng mua n÷a./no")
end

function buy1()
	if (GetCash() >= 100000) then
		Pay(100000)
		AddItem(6,1,14,1,0,0,0)
		Talk(1,"","¤ng chñ tiÒn trang: §©y lµ TiÓu hång bao cña ng­¬i, xin h·y cÇm lÊy!")
	else
		Talk(1,"","¤ng chñ tiÒn trang: H©y dµ! Ngµi kh«ng cã ®ñ tiÒn råi!")
	end
end

function buy2()
	if (GetCash() >= 1000000) then
		Pay(1000000)
		AddItem(6,1,13,1,0,0,0)
		Talk(1,"","¤ng chñ tiÒn trang: §©y lµ §¹i hång bao cña ng­¬i, xin h·y cÇm lÊy!")
	else
		Talk(1,"","¤ng chñ tiÒn trang: H©y dµ! Ngµi kh«ng cã ®ñ tiÒn råi!")
	end
end

function buy3()
	if (GetCash() >= 10000000) then
		Pay(10000000)
		AddItem(6,1,13,1,0,0,0)
		Talk(1,"","¤ng chñ tiÒn trang: §©y lµ §¹i hång bao cña ng­¬i, xin h·y cÇm lÊy!")
	else
		Talk(1,"","¤ng chñ tiÒn trang: H©y dµ! Ngµi kh«ng cã ®ñ tiÒn råi!")
	end
end

function no()
end

function hesui_hongbao()	--×Ô¶¨ÒåÍ­Ç®
	AskClientForNumber("Package_Hesui", 1, 100, "Xin mêi ®­a vµo tiÒn ®ång ");
end
function Package_Hesui(nMoney)
	if (CalcEquiproomItemCount(4, 417, 1, 1) < nMoney) then
		Talk(1,"","¤ng chñ tiÒn trang: Ngµi kh«ng mang ®ñ "..nMoney.." tiÒn ®ång.")
	else
		ConsumeEquiproomItem(nMoney, 4, 417, 1, -1)
		local nItem = AddItem(6,1,1052,1,0,0,0)
		SetSpecItemParam(nItem, 1, nMoney)
		SyncItem(nItem)
		Talk(1,"","¤ng chñ tiÒn trang: §©y lµ hång bao cña ng­¬i, xin h·y cÇm lÊy!")
	end
end


function ruyi_hongbao()		--×Ô¶¨Òå½ğÇ®
	AskClientForNumber("Package_Ruyi", 1, 10000000, "Xin mêi ®­a vµo bao tiÒn l× x× ");
end
function Package_Ruyi(nMoney)
	if (GetCash() < nMoney) then
		Talk(1,"","¤ng chñ tiÒn trang: ngµi kh«ng mang ®ñ "..nMoney.." ")
	else
		Pay(nMoney)
		local nItem = AddItem(6,1,1051,1,0,0,0)
		SetSpecItemParam(nItem, 1, nMoney)
		local nM1 = floor(nMoney / 1000000)
		local nM2 = floor(mod(nMoney, 1000000))
		local nM3 = mod(nMoney, 1000)
		SetSpecItemParam(nItem, 2, nM1)
		SetSpecItemParam(nItem, 3, nM2)
		SetSpecItemParam(nItem, 4, nM3)
		SyncItem(nItem)
		Talk(1,"","¤ng chñ tiÒn trang: §©y lµ hång bao cña ng­¬i, xin h·y cÇm lÊy!")
	end
end
