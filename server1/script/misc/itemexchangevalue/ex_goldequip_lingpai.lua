-- ====================== ÎÄ¼þÐÅÏ¢ ======================

-- ½£ÏÀÇéÔµÍø¢ç°æÔ½ÄÏÊÕ·Ñ°æ - ¶Ò»»Ð¢×°±¸ÁîÅÆ£¨×ÏòþµÈ£©
-- ÎÄ¼þÃû¡¡£ºex_goldequip_lingpai.lua
-- ´´½¨Õß¡¡£º×Ó·Çô~
-- ´´½¨Ê±¼ä£º2010-06-22 11:02:54

-- ======================================================


IncludeLib("ITEM")
Include("\\script\\misc\\itemexchangevalue\\ex_goldequip_head.lua")	-- ¶Ò»»Ð¢×°±¸ÁîÅÆ£¨×ÏòþµÈ£©
Include( "\\script\\task\\system\\task_string.lua" );
Include("\\script\\lib\\log.lua");

function exchange_lingpai2goldequip()
	local aryDescribe =
	{
		"<dec><npc>Ng­¬i muèn ®æi trang bÞ nµo?",
		format("Trang bÞ Thanh C©u /#take_xp_equip_1(1, %d)", 905),
		format("Trang bÞ V©n Léc/#take_xp_equip_1(2, %d)", 1135),
		format("Trang bÞ Th­¬ng Lang/#take_xp_equip_1(3, %d)", 1365),
		format("Trang bÞ HuyÒn Viªn/#take_xp_equip_1(4, %d)", 1595),
		format("Trang bÞ Tö M·ng/#take_xp_equip_1(5, %d)", 1825),
		format("Trang bÞ Kim ¤ /#take_xp_equip_1(6, %d)", 2055),
		format("Trang bÞ B¹ch Hæ/#take_xp_equip_1(7, %d)", 2285),
		format("Trang bi XÞch L©n/#take_xp_equip_1(8, %d)", 2515),
		--format("Trang bÞ Ngò §Õ/#take_xp_equip_91(9, %d)", 1),
		--format("Trang bÞ M· Hæ/#take_xp_equip_101(10, %d)", 194),
		format("Trang bÞ Viªm §Õ/#take_xp_equip_111(11, %d)", 422),
		"Kh«ng ®æi n÷a./no",
	};
	
	CreateTaskSay(aryDescribe);
end

----------------------------Ð¢¼ÓÈëÎå»Æ ¢í»¢ Ñ×»Æ---------------------------------
function take_xp_equip_91(n_g, n_d)
	
	if (CalcItemCount(3, tbLingpai[n_g].tbProp[1],tbLingpai[n_g].tbProp[2],tbLingpai[n_g].tbProp[3],-1) <= 0) then
		Talk(1, "", "H×nh nh­ ®¹i hiÖp quªn mang lÖnh bµi th× ph¶i.")
		return
	end
	
	CreateTaskSay({"<dec><npc>§¹i hiÖp muèn ®æi lÊy hÖ ph¸i trang bÞ nµo:", 
						format("ThiÕu L©m quyÒn/#take_xp_equip_92(%d,%d, 1)", n_g, n_d),
						format("ThiÕu L©m c«n/#take_xp_equip_92(%d,%d, 2)", n_g, n_d),
						format("ThiÕu L©m ®ao/#take_xp_equip_92(%d,%d, 3)", n_g, n_d),
						format("Thiªn V­¬ng chïy/#take_xp_equip_92(%d,%d, 4)", n_g, n_d),
						format("Thiªn V­¬ng th­¬ng/#take_xp_equip_92(%d,%d, 5)", n_g, n_d),
						format("Thiªn V­¬ng ®ao/#take_xp_equip_92(%d,%d, 6)", n_g, n_d),
						format("Nga Mi kiÕm/#take_xp_equip_92(%d,%d, 7)", n_g, n_d),
						format("Nga Mi ch­ëng/#take_xp_equip_92(%d,%d, 8)", n_g, n_d),
						format("Nga Mi phô trî /#take_xp_equip_92(%d,%d, 9)", n_g, n_d),
						format("Thóy Yªn ®ao/#take_xp_equip_92(%d,%d, 10)", n_g, n_d),
						format("Thóy Yªn kiÕm/#take_xp_equip_92(%d,%d, 11)", n_g, n_d),
						format("Ngò §éc ch­ëng/#take_xp_equip_92(%d,%d, 12)", n_g, n_d),
						format("Trang sau.../#take_xp_equip_911(%d,%d)", n_g, n_d),
						"Tho¸t/no"});
end

function take_xp_equip_911(n_g, n_d)
	CreateTaskSay({"<dec><npc>§¹i hiÖp muèn ®æi lÊy hÖ ph¸i trang bÞ nµo:", 
						format("Ngò §éc ®ao/#take_xp_equip_92(%d,%d, 13)", n_g, n_d),
						format("Ngò §éc bïa/#take_xp_equip_92(%d,%d, 14)", n_g, n_d),
						format("§­êng M«n phi ®ao/#take_xp_equip_92(%d,%d, 15)", n_g, n_d),
						format("§­êng M«n ná /#take_xp_equip_92(%d,%d, 16)", n_g, n_d),
						format("§­êng M«n phi tiªu/#take_xp_equip_92(%d,%d, 17)", n_g, n_d),
						format("§­êng M«n bÉy/#take_xp_equip_92(%d,%d, 18)", n_g, n_d),
						format("C¸i Bang ch­ëng/#take_xp_equip_92(%d,%d, 19)", n_g, n_d),
						format("C¸i Bang bæng/#take_xp_equip_92(%d,%d, 20)", n_g, n_d),
						format("ChiÕn NhÉn/#take_xp_equip_92(%d,%d, 21)", n_g, n_d),
						format("Thiªn NhÉn bïa/#take_xp_equip_92(%d,%d, 22)", n_g, n_d),
						format("Ma NhÉn/#take_xp_equip_92(%d,%d, 23)", n_g, n_d),
						format("Trang sau.../#take_xp_equip_912(%d,%d)", n_g, n_d),
						"Tho¸t/no"});
end

function take_xp_equip_912(n_g, n_d)
	CreateTaskSay({"<dec><npc>§¹i hiÖp muèn ®æi lÊy hÖ ph¸i trang bÞ nµo:", 
						format("Vâ §ang ch­ëng/#take_xp_equip_92(%d,%d, 24)", n_g, n_d),
						format("Vâ §ang kiÕm/#take_xp_equip_92(%d,%d, 25)", n_g, n_d),
						format("C«n L«n ®ao/#take_xp_equip_92(%d,%d, 26)", n_g, n_d),
						format("C«n L«n kiÕm/#take_xp_equip_92(%d,%d, 27)", n_g, n_d),
						format("C«n L«n bïa/#take_xp_equip_92(%d,%d, 28)", n_g, n_d),
						format("Trë vÒ.../#take_xp_equip_91(%d,%d)", n_g, n_d),
						"Tho¸t/no"});
end

function take_xp_equip_92(n_g, n_d, n_p)
	local n_count = 5;
	
--	if (n_g == 5) then		
--		n_count = 5;
--	end
	
	local n_s =(n_p - 1)*n_count + 1;
	
	local aryDescribe = {
		"<dec><npc>§¹i hiÖp muèn ®æi trang bÞ m«n ph¸i nµo:",
	};
	for i = n_s, n_s+n_count-1 do
		tinsert(aryDescribe, tbGoldEquip_Lingpai[n_g][i][1]..format("/#take_xp_equip_3(%d, %d, %d, %d)", n_g, n_d, n_p,i));
	end
	
	tinsert(aryDescribe, "Chê mét chót./no");
	CreateTaskSay(aryDescribe);
end

-----------¢í»¢

function take_xp_equip_101(n_g, n_d)
	
	if (CalcItemCount(3, tbLingpai[n_g].tbProp[1],tbLingpai[n_g].tbProp[2],tbLingpai[n_g].tbProp[3],-1) <= 0) then
		Talk(1, "", "H×nh nh­ ®¹i hiÖp quªn mang lÖnh th× ph¶i.")
		return
	end
	
	CreateTaskSay({"<dec><npc>§¹i hiÖp muèn ®æi lÊy hÖ ph¸i trang bÞ nµo:", 
						format("Trang bÞ §¹i M· Hæ /#take_xp_equip_102(%d,%d, 1)", n_g, n_d),
						"Tho¸t/no"});
end

function take_xp_equip_102(n_g, n_d, n_p)
	local n_count = 10;
	
--	if (n_g == 5) then		
--		n_count = 5;
--	end
	
	local n_s =(n_p - 1)*n_count + 1;
	
	local aryDescribe = {
		"<dec><npc> ®¹i hiÖp muèn thay cho mÆt c¸i ®ã hÖ ph¸i ®Ých trang bÞ :",
	};
	for i = n_s, n_s+n_count-1 do
		tinsert(aryDescribe, tbGoldEquip_Lingpai[n_g][i][1]..format("/#take_xp_equip_3(%d, %d, %d, %d)", n_g, n_d, n_p,i));
	end
	
	tinsert(aryDescribe, "Chê mét chót trë l¹i /no");
	CreateTaskSay(aryDescribe);
end

---------Ñ×µÛ×°±¸
function take_xp_equip_111(n_g, n_d)
	
if (CalcItemCount(3, tbLingpai[n_g].tbProp[1],tbLingpai[n_g].tbProp[2],tbLingpai[n_g].tbProp[3],-1) <= 0) then 
Talk(1, "","H×nh nh­ ®¹i hiÖp quªn mang lÖnh bµi th× ph¶i. ?") 
return 
end 
	
	CreateTaskSay({"<dec><npc>§¹i hiÖp muèn trang bÞ g×:", 
						format("Trang bÞ To¹i Nh©n/#take_xp_equip_112(%d,%d, 1)", n_g, n_d),
						format("Trang bÞ Phôc Hi/#take_xp_equip_112(%d,%d, 2)", n_g, n_d),
						format("Trang BÞ N÷ Oa/#take_xp_equip_112(%d,%d, 3)", n_g, n_d),
						format("Trang bÞ Chóc Dung/#take_xp_equip_112(%d,%d, 4)", n_g, n_d),
						format("Trang bÞ ThÇn N«ng/#take_xp_equip_112(%d,%d, 5)", n_g, n_d),
						"KÕt thóc ®èi tho¹i /no"});
end

function take_xp_equip_112(n_g, n_d, n_p)
	local n_count = 10;
	
--	if (n_g == 5) then		
--		n_count = 5;
--	end
	
	local n_s =(n_p - 1)*n_count + 1;
	
	local aryDescribe = {
		"<dec><npc>§¹i hiÖp muèn thay hÖ ph¸i trang bÞ:",
	};
	for i = n_s, n_s+n_count-1 do
		tinsert(aryDescribe, tbGoldEquip_Lingpai[n_g][i][1]..format("/#take_xp_equip_3(%d, %d, %d, %d)", n_g, n_d, n_p,i));
	end
	
	tinsert(aryDescribe, "KÕt thóc ®èi tho¹i /no");
	CreateTaskSay(aryDescribe);
end
--------------------------------------------------------------------------------

function take_xp_equip_1(n_g, n_d)
	
	if (CalcItemCount(3, tbLingpai[n_g].tbProp[1],tbLingpai[n_g].tbProp[2],tbLingpai[n_g].tbProp[3],-1) <= 0) then
		Talk(1, "", "H×nh nh­ ®¹i hiÖp quªn mang lÖnh bµi th× ph¶i.")
		return
	end
	
	CreateTaskSay({"<dec><npc>§¹i hiÖp muèn ®æi lÊy hÖ ph¸i trang bÞ nµo:", 
						format("ThiÕu L©m quyÒn/#take_xp_equip_2(%d,%d, 1)", n_g, n_d),
						format("ThiÕu L©m c«n/#take_xp_equip_2(%d,%d, 2)", n_g, n_d),
						format("ThiÕu L©m ®ao/#take_xp_equip_2(%d,%d, 3)", n_g, n_d),
						format("Thiªn V­¬ng chïy/#take_xp_equip_2(%d,%d, 4)", n_g, n_d),
						format("Thiªn V­¬ng th­¬ng/#take_xp_equip_2(%d,%d, 5)", n_g, n_d),
						format("Thiªn V­¬ng ®ao/#take_xp_equip_2(%d,%d, 6)", n_g, n_d),
						format("Nga Mi kiÕm/#take_xp_equip_2(%d,%d, 7)", n_g, n_d),
						format("Nga Mi ch­ëng/#take_xp_equip_2(%d,%d, 8)", n_g, n_d),
						format("Thóy Yªn ®ao /#take_xp_equip_2(%d,%d, 9)", n_g, n_d),
						format("Thóy Yªn song ®ao/#take_xp_equip_2(%d,%d, 10)", n_g, n_d),
						format("Ngò §éc ch­ëng/#take_xp_equip_2(%d,%d, 11)", n_g, n_d),
						format("Ngò §éc ®ao/#take_xp_equip_2(%d,%d, 12)", n_g, n_d),
						format("Trang sau.../#take_xp_equip_11(%d,%d)", n_g, n_d),
						"Tho¸t/no"});
end

function take_xp_equip_11(n_g, n_d)
	CreateTaskSay({"<dec><npc>§¹i hiÖp muèn ®æi lÊy hÖ ph¸i trang bÞ nµo:", 
						format("§­êng M«n phi ®ao/#take_xp_equip_2(%d,%d, 13)", n_g, n_d),
						format("§­êng M«n tô tiÔn/#take_xp_equip_2(%d,%d, 14)", n_g, n_d),
						format("§­êng M«n phi tiªu/#take_xp_equip_2(%d,%d, 15)", n_g, n_d),
						format("C¸i Bang ch­ëng/#take_xp_equip_2(%d,%d, 16)", n_g, n_d),
						format("C¸i Bang bæng/#take_xp_equip_2(%d,%d, 17)", n_g, n_d),
						format("ChiÕn NhÉn/#take_xp_equip_2(%d,%d, 18)", n_g, n_d),
						format("Ma NhÉn/#take_xp_equip_2(%d,%d, 19)", n_g, n_d),
						format("Vâ §ang khÝ/#take_xp_equip_2(%d,%d, 20)", n_g, n_d),
						format("Vâ §ang kiÕm/#take_xp_equip_2(%d,%d, 21)", n_g, n_d),
						format("C«n L«n ®ao/#take_xp_equip_2(%d,%d, 22)", n_g, n_d),
						format("C«n L«n kiÕm/#take_xp_equip_2(%d,%d, 23)", n_g, n_d),
						format("Trë vÒ.../#take_xp_equip_1(%d,%d)", n_g, n_d),
						"Tho¸t/no"});
end


function take_xp_equip_2(n_g, n_d, n_p)
	local n_count = 10;
	
--	if (n_g == 5) then		
--		n_count = 5;
--	end
	
	local n_s =(n_p - 1)*n_count + 1;
	
	local aryDescribe = {
		"<dec><npc>§¹i hiÖp muèn ®æi lÊy hÖ ph¸i trang bÞ nµo:",
	};
	for i = n_s, n_s+n_count-1 do
		tinsert(aryDescribe, tbGoldEquip_Lingpai[n_g][i][1]..format("/#take_xp_equip_3(%d, %d, %d, %d)", n_g, n_d, n_p,i));
	end
	
	tinsert(aryDescribe, "Kh«ng ®æi n÷a./no");
	CreateTaskSay(aryDescribe);
end

function take_xp_equip_3(n_g, n_d, n_p, n_x)
	if (CountFreeRoomByWH(2,4,1) < 1) then
		Talk(1, "", "Kh«ng ®ñ chç trèng, xin söa sang l¹i hµnh trang");
		return
	end
	
	local nLingpaiIdx = GetNextItemIndexInRoom(0, tbLingpai[n_g].tbProp[1],tbLingpai[n_g].tbProp[2],tbLingpai[n_g].tbProp[3],-1, 3);
	local n_bindstate = GetItemBindState(nLingpaiIdx);
	local n_expiredtime = ITEM_GetExpiredTime(nLingpaiIdx);
	
	if (ConsumeItem(3,1, tbLingpai[n_g].tbProp[1],tbLingpai[n_g].tbProp[2],tbLingpai[n_g].tbProp[3],-1) ~= 1) then
		Talk(1, "", "H×nh nh­ ®¹i hiÖp quªn mang lÖnh bµi th× ph¶i.")
		return
	end
	
	local nItemIdx = AddGoldItem(0, tbGoldEquip_Lingpai[n_g][n_x][2]);
	
--	Ô½ÄÏ°æ±¾Ã»ÓÐ´ËÐèÇó
--	if (n_expiredtime ~= 0 ) then
--		ITEM_SetExpiredTime(nItemIdx,86400)
--		SyncItem(nItemIdx)
--	end
	
	if (n_bindstate ~= 0) then
		
		if (n_bindstate == -2) then
			n_new_bindtime = take_xp_equip_calc_binditem(tbLingpai_BindTime[n_g].nBindState);
		else
			n_new_bindtime = n_bindstate;
		end
		
		SetItemBindState(nItemIdx, n_new_bindtime);
	end
	
	Msg2Player("§¹t ®­îc "..GetItemName(nItemIdx));
	
	local szLog = format("%s\t%s\t%u",tbLingpai[n_g].szName, GetItemName(nItemIdx), ITEM_GetItemRandSeed(nItemIdx))
	
	_WritePlayerLog("Token Exchange Equip", szLog)
end

TIME_2000_1_1 = 946656000;		-- 2000Äê1Ô¢1ÈÕ Ïµ¶ÔÓÚ 1970Äê1Ô¢1ÈÕµÄÃëÊý

function take_xp_equip_calc_binditem(nLingpaiBindTime)
	if (nLingpaiBindTime == -2) then
		return -2;
	end
	local n_new_bindtime = nLingpaiBindTime - 7*24 + floor((GetCurServerTime() - TIME_2000_1_1) / 3600);
	return n_new_bindtime;
end

