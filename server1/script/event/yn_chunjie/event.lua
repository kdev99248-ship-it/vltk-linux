-- Qu¶ng Ng·i, 23/01/2024
-- modify by NobitaXD

function yn_chunjie()
	Say("<#> Sù kiÖn m©m ngò qu¶ lµ sù kiÖn ®Çu tiªn cña Vâ L©m TruyÒn Kú, Ta còng quªn lu«n lêi tho¹i gèc, nªn kh«ng cßn g× ngoµi lêi chóc mõng n¨m míi ®Õn toµn thÓ ®ång ®¹o vâ l©m!<enter>Vâ L©m TruyÒn Kú ngµy Êy n¨m 2005 thËt lµ mét kû niÖm khã quªn.!", 7,
	"<#> Ta muèn ®æi Ngò hoa ngäc lé hoµn./yn_chunjie_want1",
	"<#> Ta muèn ®æi B¸nh ch­ng thËp cÈm./yn_chunjie_want2",
	"<#> Ta muèn ®æi B¸nh tĞt nh©n ®Ëu./yn_chunjie_want3",
	"<#> Ta muèn ®æi B¸nh tĞt thËp cÈm./yn_chunjie_want4",
	"<#> Ta muèn ®æi B¸nh ch­ng th­îng h¹ng./yn_chunjie_want5",
	"<#> Ta muèn ®æi Thñy tinh./yn_chunjie_want6",
	"<#> Ta chØ ®Õn ch¬i th«i!/OnCancel")
end

function yn_chunjie_want1()
	Say("<#> §æi Ngò hoa ngäc lé hoµn cÇn <color=yellow>5 M·ng cÇu<color>. §æi ngay chø?", 2,
	"<#> §óng! Ta muèn ®æi!/yn_chunjie_make1",
	"<#> L¸t n÷a sÏ quay l¹i!/OnCancel")
end
function yn_chunjie_want2()
	Say("<#> §æi B¸nh ch­ng thËp cÈm cÇn <color=yellow>5 Dõa xiªm<color>. §æi ngay chø?", 2,
	"<#> §óng! Ta muèn ®æi!/yn_chunjie_make2",
	"<#> L¸t n÷a sÏ quay l¹i!/OnCancel")
end
function yn_chunjie_want3()
	Say("<#> §æi B¸nh tĞt nh©n ®Ëu cÇn <color=yellow>5 §u ®ñ<color>. §æi ngay chø?", 2,
	"<#> §óng! Ta muèn ®æi!/yn_chunjie_make3",
	"<#> L¸t n÷a sÏ quay l¹i!/OnCancel")
end
function yn_chunjie_want4()
	Say("<#> §æi B¸nh tĞt thËp cÈm cÇn <color=yellow>5 Xoµi<color>. §æi ngay chø?", 2,
	"<#> §óng! Ta muèn ®æi!/yn_chunjie_make4",
	"<#> L¸t n÷a sÏ quay l¹i!/OnCancel")
end
function yn_chunjie_want5()
	Say("<#> §æi B¸nh ch­ng th­îng h¹ng cÇn <color=yellow>5 Sung<color>. §æi ngay chø?", 2,
	"<#> §óng! Ta muèn ®æi!/yn_chunjie_make5",
	"<#> L¸t n÷a sÏ quay l¹i!/OnCancel")
end
function yn_chunjie_want6()
	Say("<#> §æi Thñy tinh cÇn <color=yellow>5 M·ng cÇu + 5 Dõa xiªm + 5 §u ®ñ + 5 Xoµi + 5 Sung<color>. May m¾n nhËn l× x× tõ LÔ Quan ta. Haha !", 2,
	"<#> §óng! Ta muèn ®æi!/yn_chunjie_make6",
	"<#> L¸t n÷a sÏ quay l¹i!/OnCancel")
end

function yn_chunjie_make5()
	local nCount_chengqunguo = CalcEquiproomItemCount(4, 955, 1, 1)
	if (nCount_chengqunguo >= 5) then
		ConsumeEquiproomItem(5, 4, 955, 1, -1)
		AddItem(6,1,1026,1,1,1)--B¸nh Ch­ng th­îng h¹ng
		Say("<#> §©y lµ B¸nh Ch­ng th­îng h¹ng! H·y mang ®i chung vui víi mäi ng­êi!", 0)
		WriteLog(GetLocalDate("%Y%m%d").."\t m©m ngò qu¶ 2005 Vâ l©m TruyÒn Kú \t"..GetName().."\t"..GetAccount().."\t §æi B¸nh Ch­ng th­îng h¹ng.")
	else
		Say("<#> §æi B¸nh Ch­ng th­îng h¹ng cÇn <color=yellow>5 Sung<color>, cã ®ñ nguyªn liÖu l¹i ®Õn nhĞ!", 0)
	end
end

function yn_chunjie_make4()
	local nCount_mangguo = CalcEquiproomItemCount(4, 954, 1, 1)
	if (nCount_mangguo >= 5) then
		ConsumeEquiproomItem(5, 4, 954, 1, -1)
		AddItem(6,1,1025,1,1,1)--B¸nh tĞt thËp cÈm
		Say("<#> §©y lµ B¸nh tĞt thËp cÈm! H·y mang ®i chung vui víi mäi ng­êi!", 0)
		WriteLog(GetLocalDate("%Y%m%d").."\t m©m ngò qu¶ 2005 Vâ l©m TruyÒn Kú \t"..GetName().."\t"..GetAccount().."\t §æi B¸nh tĞt thËp cÈm.")
	else
		Say("<#> §æi B¸nh tĞt thËp cÈm cÇn <color=yellow>5 Xoµi<color>, cã ®ñ nguyªn liÖu l¹i ®Õn nhĞ!", 0)
	end
end

function yn_chunjie_make3()
	local nCount_mugua = CalcEquiproomItemCount(4, 953, 1, 1)
	if (nCount_mugua >= 5) then
		ConsumeEquiproomItem(5, 4, 953, 1, -1)
		AddItem(6,1,1024,1,1,1)--B¸nh tĞt nh©n ®Ëu
		Say("<#> §©y lµ B¸nh tĞt nh©n ®Ëu! H·y mang ®i chung vui víi mäi ng­êi!", 0)
		WriteLog(GetLocalDate("%Y%m%d").."\t m©m ngò qu¶ 2005 Vâ l©m TruyÒn Kú \t"..GetName().."\t"..GetAccount().."\t §æi B¸nh tĞt nh©n ®Ëu.")
	else
		Say("<#> §æi B¸nh tĞt nh©n ®Ëu cÇn <color=yellow>5 §u ®ñ<color>, cã ®ñ nguyªn liÖu l¹i ®Õn nhĞ!", 0)
	end
end

function yn_chunjie_make2()
	local nCount_yezi = CalcEquiproomItemCount(4, 952, 1, 1)
	if (nCount_yezi >= 5) then
		ConsumeEquiproomItem(5, 4, 952, 1, -1)
		AddItem(6,1,1023,1,1,1)--B¸nh ch­ng ThËp cÈm
		Say("<#> §©y lµ B¸nh ch­ng ThËp cÈm! H·y mang ®i chung vui víi mäi ng­êi!", 0)
		WriteLog(GetLocalDate("%Y%m%d").."\t m©m ngò qu¶ 2005 Vâ l©m TruyÒn Kú \t"..GetName().."\t"..GetAccount().."\t §æi B¸nh ch­ng ThËp cÈm.")
	else
		Say("<#> §æi B¸nh ch­ng ThËp cÈm cÇn <color=yellow>5 Dõa xiªm<color>, cã ®ñ nguyªn liÖu l¹i ®Õn nhĞ!", 0)
	end
end

function yn_chunjie_make1()
	local nCount_manqiuguo = CalcEquiproomItemCount(4, 951, 1, 1)
	if (nCount_manqiuguo >= 5) then
		ConsumeEquiproomItem(5, 4, 951, 1, -1)
		AddItem(1,3,0,0,5,0)--Ngò Hoa Ngäc Lé Hoµn
		Say("<#> §©y lµ Ngò hoa ngäc lé hoµn! H·y mang ®i chung vui víi mäi ng­êi!", 0)
		WriteLog(GetLocalDate("%Y%m%d").."\t m©m ngò qu¶ 2005 Vâ l©m TruyÒn Kú \t"..GetName().."\t"..GetAccount().."\t §æi Ngò hoa ngäc lé hoµn.")
	else
		Say("<#> §æi Ngò hoa ngäc lé hoµn cÇn <color=yellow>5 M·ng cÇu<color>, cã ®ñ nguyªn liÖu l¹i ®Õn nhĞ!", 0)
	end
end

function yn_chunjie_make6()
	local nCount_manqiuguo = CalcEquiproomItemCount(4, 951, 1, 1)
	local nCount_yezi = CalcEquiproomItemCount(4, 952, 1, 1)
	local nCount_mugua = CalcEquiproomItemCount(4, 953, 1, 1)
	local nCount_mangguo = CalcEquiproomItemCount(4, 954, 1, 1)
	local nCount_chengqunguo = CalcEquiproomItemCount(4, 955, 1, 1)
	if (nCount_manqiuguo >= 5 and nCount_yezi >= 5 and nCount_mugua >= 5 and nCount_mangguo >= 5 and nCount_chengqunguo >= 5) then
		ConsumeEquiproomItem(5, 4, 951, 1, -1)
		ConsumeEquiproomItem(5, 4, 952, 1, -1)
		ConsumeEquiproomItem(5, 4, 953, 1, -1)
		ConsumeEquiproomItem(5, 4, 954, 1, -1)
		ConsumeEquiproomItem(5, 4, 955, 1, -1)
		local nzRate = random(1,100)
		if nzRate > 50 then
			AddItem(4,random(238,240),1,0,0,0)
			AddItem(6,1,random(1027,1028),1,1,1)--TiÓu Hång bao §¹i Hång bao Bao l× x× n¨m míi (tiÓu) Bao l× x× n¨m míi (®¹i)
			Say("<#> §¹i hiÖp thËt may m¾n, h·y nhËn l× x× cña ta, n¨m míi vui vÎ. Haha!", 0)
		else
			AddItem(4,random(238,240),1,0,0,0)
			Say("<#> Thñy tinh! Mét b¶o vËt rÊt cã gi¸ trŞ Vâ L©m lóc bÊy giê!", 0)
		end
		WriteLog(GetLocalDate("%Y%m%d").."\t m©m ngò qu¶ 2005 Vâ l©m TruyÒn Kú \t"..GetName().."\t"..GetAccount().."\t Thñy tinh")
	else
		Say("<#> §æi Thñy tinh <color=yellow>5 M·ng cÇu + 5 Dõa xiªm + 5 §u ®ñ + 5 Xoµi + 5 Sung<color>, cã ®ñ nguyªn liÖu l¹i ®Õn nhĞ!", 0)
	end
end