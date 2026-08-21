--Î÷ÄÏ±±Çø ³É¶¼¸® Ò©µêÀÏ°å¶Ô»°
Include("\\script\\config\\cfg_features.lua")
-- Á¶ÖÆ»ìÔªÁéÂ¶
function refine()
	DynamicExecute("\\script\\global\\jingli.lua", "dlg_entrance", PlayerIndex)
end

function main(sel)
	local tbSay = {}
	tinsert(tbSay,"Giao dŞch/yes")
	if CFG_HONNGUYENLINHLO == 1 then
		tinsert(tbSay,"Ta muèn chÕ t¹o Hçn Nguyªn Linh Lé/refine")
	end
	tinsert(tbSay,"Kh«ng giao dŞch/Cancel")
	Say("Lóc ta cßn trÎ, muèn lµm mét danh y gièng nh­ Hoa §µ, sau nµy lËp gia thÊt sinh con ®Î c¸i, v× nu«i mÊy miÖng ¨n mµ chØ cã thÓ më c¸i tiÖm thuèc nµy th«i. Chao!Con ng­êi cña ta, nhiÒu chuyÖn n·y giê mµ vÉn ch­a hái kh¸ch quan cÇn mua thuèc g×?",getn(tbSay),tbSay)
end

function yes()
	Sale(15) 		--µ¯³ö½»Ò×¿ò
end
