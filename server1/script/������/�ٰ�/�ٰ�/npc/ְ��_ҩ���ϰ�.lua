-- ÁÙ°²¡¡Ö°ÄÜ¡¡Ò©µêÀÏ°å
-- by£ºDan_Deng(2003-09-16)
Include("\\script\\config\\cfg_features.lua")

-- Á¶ÖÆ»ìÔªÁéÂ¶
function refine()
	DynamicExecute("\\script\\global\\jingli.lua", "dlg_entrance", PlayerIndex)
end

function main()
	local tbSay = {}
	tinsert(tbSay,"Giao dŞch/yes")
	if CFG_HONNGUYENLINHLO == 1 then
		tinsert(tbSay,"Ta muèn chÕ t¹o Hçn Nguyªn Linh Lé/refine")
	end
	tinsert(tbSay,"Kh«ng giao dŞch/Cancel")
	Say(10855,getn(tbSay),tbSay)
end;

function yes()
	Sale(12)  				--µ¯³ö½»Ò×¿ò
end
