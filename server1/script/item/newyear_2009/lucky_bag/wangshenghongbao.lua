Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\item\\newyear_2009\\head.lua");
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

tb_wangshenghongbao_award	=
{
	{szName="1 danh väng", 			nRepute = 1, 		nRate = 25},
	{szName="2 danh väng", 			nRepute = 2, 		nRate = 20},
	{szName="3 danh väng", 			nRepute = 3, 		nRate = 15},
	{szName="10 danh väng",			nRepute = 10, 		nRate = 3},
	{szName="50 danh väng",		 	nRepute = 50, 		nRate = 0.1},
	{szName="HuyÒn tinh kho¸ng th¹ch cÊp 3", 		tbProp={6, 1, 147, 3, 0, 0}, 	nRate = 5},
	{szName="HuyÒn Tinh Kho¸ng Th¹ch cÊp 4", 		tbProp={6, 1, 147, 4, 0, 0},	nRate = 3},
	{szName="HuyÒn Tinh Kho¸ng Th¹ch cÊp 5", 		tbProp={6, 1, 147, 5, 0, 0},	nRate = 2},
	{szName="T©m T©m T­¬ng ¸nh phï ",		tbProp={6, 1, 18,  1, 0, 0},	nRate = 3},
	{szName="Phi Tèc hoµn",			tbProp={6, 0, 6,   1, 0, 0}, 	nRate = 5},
	{szName="§¹i Lùc hoµn",			tbProp={6, 0, 3,   1, 0, 0}, 	nRate = 5},
	{szName="Vâ L©m MËt TÞch", 		tbProp={6, 1, 26, 1, 0, 0},	 	nRate = 0.1},
	{szName="TÈy Tñy Kinh", 			tbProp={6, 1, 22, 1, 0, 0}, 	nRate = 0.1},
	{szName="Bµn Nh­îc T©m Kinh", 		tbProp={6, 1, 12, 1, 0, 0}, 	nRate = 1},
	{szName="ThiÕt La H¸n", 			tbProp={6, 1, 23, 1, 0, 0}, 	nRate = 3},
	{szName="ThÇn bÝ §¹i Hång Bao", 		tbProp={6, 1, 402,1, 0, 0}, 	nRate = 7.779},
	{szName="§Þnh Quèc ¤ Sa Ph¸t Qu¸n", 	tbProp={0, 160},	nQuality = 1,	nRate = 0.008},
	{szName="§Þnh Quèc Thanh Sa Tr­êng Sam", 	tbProp={0, 159},	nQuality = 1,	nRate = 0.01},
	{szName="§Þnh Quèc Ng©n Tµm Yªu ®¸i", 	tbProp={0, 163}, 	nQuality = 1,	nRate = 0.1},
	{szName="§Þnh Quèc XÝch Quyªn NhuyÔn Ngoa",	tbProp={0, 161}, 	nQuality = 1,	nRate = 0.015},
	{szName="§Þnh Quèc Tö §»ng Hé uyÓn", 	tbProp={0, 162}, 	nQuality = 1,	nRate = 0.2},
	{szName="Nhu T×nh C©n Quèc Nghª Th­êng", 	tbProp={0, 190}, 	nQuality = 1,	nRate = 0.008},
	{szName="Nhu T×nh  TuÖ T©m Ngäc Béi", 	tbProp={0, 193}, 	nQuality = 1,	nRate = 0.07},
	{szName="Nhu T×nh  Phông Nghi Giíi ChØ ", 	tbProp={0, 192}, 	nQuality = 1,	nRate = 0.3},
	{szName="Nhu T×nh Thôc N÷ H¹ng Liªn", 	tbProp={0, 191}, 	nQuality = 1,	nRate = 0.4},
	{szName="HiÖp Cèt T×nh ý KÕt", 	tbProp={0, 189}, 	nQuality = 1,	nRate = 0.01},
	{szName="HiÖp Cèt ThiÕt HuyÕt Sam", 	tbProp={0, 186}, 	nQuality = 1,	nRate = 0.1},
	{szName="HiÖp Cèt §an T©m Giíi", 	tbProp={0, 188}, 	nQuality = 1,	nRate = 0.3},
	{szName="HiÖp Cèt §a T×nh Hoµn", 	tbProp={0, 187}, 	nQuality = 1,	nRate = 0.4},
};

tb_tree_itemid	=
{
	[1]	= 1917,
	[2]	= 1918,
};

tb_openhongbao_mapid	=
{
	[11]	= 1,
	[1] 	= 1,
	[37] 	= 1,
	[176] 	= 1,
	[162] 	= 1,
	[78] 	= 1,
	[80] 	= 1,
	[174] 	= 1,
	[121] 	= 1,
	[153] 	= 1,
	[101] 	= 1,
	[99] 	= 1,
	[100] 	= 1,
	[20]	= 1,
	[53] 	= 1,
	[54] 	= 1,
	[175] 	= 1,
	[55] 	= 1,
};

function main()
	newyear0901_resettask();
	
	local ndate = tonumber(GetLocalDate("%Y%m%d"));
	if (CFG_newyear_2009	==	0) then
		Msg2Player("VËt phÈm nµy ®· qu¸ h¹n.");
		return 0;
	end
	
	if (GetLevel() < 50 or GetExtPoint(0) < 1) then
		Say("§¹i hiÖp vÉn ch­a ®ñ cÊp 50 hoÆc vÉn ch­a n¹p thÎ, v× vËy kh«ng thÓ sö dông ThÞnh V­îng Hång Bao.", 0);
		return 1;
	end
	
	local subworld, x, y	= GetWorldPos();
	if (tb_openhongbao_mapid[subworld] == nil) then
		Say("ThÞnh V­îng Hång Bao chØ sö dông t¹i thµnh thÞ vµ th«n trÊn.", 0);
		return 1;
	end
	
	if (CalcFreeItemCellCount() < 20) then
		Say("Hµnh trang cña ®¹i hiÖp ®· ®Çy!", 0);
		return 1;
	end
	
	if (100 + GetTask(newyear0901_TSK_GetExp_Hongbao) <= GetTask(newyear0901_TSK_GetExpUpLimit))	then
		SetTask(newyear0901_TSK_GetExp_Hongbao, 100 + GetTask(newyear0901_TSK_GetExp_Hongbao));
		AddOwnExp(1000000);
		
    	subworld = SubWorldID2Idx(subworld);
    	local n_tree_idx		= random(1, 2);
    	local n_itemid 			= tb_tree_itemid[n_tree_idx];
    	local nItemIdx 			= DropItem(subworld, x * 32, y * 32, -1, 6, 1, n_itemid, 1, 0, 0, 0);
			
		tbAwardTemplet:GiveAwardByList(tb_wangshenghongbao_award, "ThÞnh V­îng Hång Bao");	
	else
		Say("§¹i hiÖp ®· ®¹t ®Õn giíi h¹n kinh nghiÖm cao nhÊt, v× vËy kh«ng thÓ sö dông thªm ThÞnh V­îng Hång Bao.", 0);
		return 1;
	end
end