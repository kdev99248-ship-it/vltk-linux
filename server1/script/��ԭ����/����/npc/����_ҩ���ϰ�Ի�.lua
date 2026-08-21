-- ÖÐÔ­ÄÏÇø ÑïÖÝ¸® Ò©µêÀÏ°å¶Ô»°£¨Îå¶¾40¼¶ÈÎÎñ£©
-- Update£ºDan_Deng ¼ÓÈëÎå¶¾ÈÎÎñ£¨2003-10-12£©
Include("\\script\\config\\cfg_features.lua")

-- Á¶ÖÆ»ìÔªÁéÂ¶
function refine()
	DynamicExecute("\\script\\global\\jingli.lua", "dlg_entrance", PlayerIndex)
end

function main()
	UTask_wu = GetTask(10)
	if (UTask_wu == 40*256+10) and (HaveItem(142) == 0) then 		--ÈÎÎñÖÐ
		local tbSay = {}
		tinsert(tbSay,"Mua ®­îc X¹ h­¬ng/L40_buy_yes")
		tinsert(tbSay,"Giao dÞch/yes")
		if CFG_HONNGUYENLINHLO == 1 then
			tinsert(tbSay,"Ta muèn chÕ t¹o Hçn Nguyªn Linh Lé/refine")
		end
		tinsert(tbSay,"Kh«ng giao dÞch/no")
		Say("Gi¸ d­îc liÖu quý X¹ H­¬ng h«m nay lµ 500 l­îng th«i!",getn(tbSay),tbSay)
	else
		local tbSay = {}
		tinsert(tbSay,"Giao dÞch/yes")
		if CFG_HONNGUYENLINHLO == 1 then
			tinsert(tbSay,"Ta muèn chÕ t¹o Hçn Nguyªn Linh Lé/refine")
		end
		tinsert(tbSay,"Kh«ng giao dÞch/no")
		Say("Chç t«i ®©y d­îc liÖu g× còng cã, cã bÖnh th× khái bÖnh, kh«ng bÖnh kháe ng­êi, b¸n thuèc ®óng gi¸ kh«ng lõa g¹t, ngµi mua mét Ýt chø?",getn(tbSay),tbSay)
	end
end;

function L40_buy_yes()
	if (GetCash() >= 500) then
		Pay(500)
		AddEventItem(142)
		AddNote("Mua ®­îc X¹ h­¬ng.")
		Msg2Player("Mua ®­îc X¹ h­¬ng.")
	else
		Talk(1,"","Gi¸ vËy còng mua kh«ng næi, ®i ra cho ta lµm ¨n!")
	end
end;

function yes()
Sale(96);  			--µ¯³ö½»Ò×¿ò
end;

function no()
end;
