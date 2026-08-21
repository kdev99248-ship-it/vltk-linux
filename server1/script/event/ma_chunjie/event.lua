-- Qu¶ng Ng·i, 23/01/2024
-- modify by NobitaXD

function ma_chunjie()
	Say("<#> GhĞp ph¸o cÇn <color=yellow>5 Bét ®¸ + 5 L­u huúnh + 5 Than cñi + 5 GiÊy hång + 5 Tim ph¸o + 5 Háa d­îc mËt t~ch<color>. Lµm ngay chø?", 2,
	"<#> §óng! Xin s­ phô træ tµi!/ma_chunjie_make1",
	"<#> L¸t n÷a sÏ quay l¹i!/OnCancel")
end

function ma_chunjie_make1()
	local nCount_1 = CalcEquiproomItemCount(4, 956, 1, 1)
	local nCount_2 = CalcEquiproomItemCount(4, 957, 1, 1)
	local nCount_3 = CalcEquiproomItemCount(4, 958, 1, 1)
	local nCount_4 = CalcEquiproomItemCount(4, 959, 1, 1)
	local nCount_5 = CalcEquiproomItemCount(4, 960, 1, 1)
	local nCount_6 = CalcEquiproomItemCount(4, 961, 1, 1)
	if (nCount_1 >= 5 and nCount_2 >= 5 and nCount_3 >= 5 and nCount_4 >= 5 and nCount_5 >= 5 and nCount_6 >= 5) then
		ConsumeEquiproomItem(5, 4, 956, 1, -1)
		ConsumeEquiproomItem(5, 4, 957, 1, -1)
		ConsumeEquiproomItem(5, 4, 958, 1, -1)
		ConsumeEquiproomItem(5, 4, 959, 1, -1)
		ConsumeEquiproomItem(5, 4, 960, 1, -1)
		ConsumeEquiproomItem(5, 4, 961, 1, -1)
		local nzRate = random(1,100)
		if nzRate > 50 then
			AddItem(6,1,random(1031,1034),1,1,1)
			AddItem(6,1,random(1029,1030),1,1,1)--TiÓu Hång bao §¹i Hång bao Bao l× x× n¨m míi (tiÓu) Bao l× x× n¨m míi (®¹i)
			Say("<#> Ph¸o ®· chÕ t¹o xong, h·y nhËn l× x× cña ta, n¨m míi vui vÎ. Haha!", 0)
		else
			AddItem(6,1,random(1031,1034),1,1,1)
			Say("<#> Ph¸o ®· chÕ t¹o xong, h·y nhËn lÊy, n¨m míi vui vÎ. Haha!", 0)
		end
		WriteLog(GetLocalDate("%Y%m%d").."\t GhĞp ph¸o 2006 Vâ l©m TruyÒn Kú \t"..GetName().."\t"..GetAccount().."\t GhĞp ph¸o")
	else
		Say("<#> GhĞp ph¸o cÇn <color=yellow>5 Bét ®¸ + 5 L­u huúnh + 5 Than cñi + 5 GiÊy hång + 5 Tim ph¸o + 5 Háa d­îc mËt t~ch<color>, cã ®ñ nguyªn liÖu l¹i ®Õn nhĞ!", 0)
	end
end