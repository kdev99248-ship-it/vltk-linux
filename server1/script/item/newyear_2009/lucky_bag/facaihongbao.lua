Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\item\\newyear_2009\\head.lua");
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

tb_facaihongbao_award	=
{
	{szName="1 danh väng", 			nRepute = 1, 		nRate = 1},
	{szName="2 danh väng", 			nRepute = 2, 		nRate = 2},
	{szName="3 danh väng", 			nRepute = 3, 		nRate = 3},
	{szName="10 danh väng",			nRepute = 10, 		nRate = 3.07},
	{szName="50 danh väng",		 	nRepute = 50, 		nRate = 1},
	{szName="§Þnh Quèc ¤ Sa Ph¸t Qu¸n", 	tbProp={0, 160},	nQuality = 1,	nRate = 0.2},
	{szName="§Þnh Quèc Thanh Sa Tr­êng Sam", 	tbProp={0, 159},	nQuality = 1,	nRate = 0.5},
	{szName="§Þnh Quèc Ng©n Tµm Yªu ®¸i", 	tbProp={0, 163}, 	nQuality = 1,	nRate = 1},
	{szName="§Þnh Quèc XÝch Quyªn NhuyÔn Ngoa",	tbProp={0, 161}, 	nQuality = 1,	nRate = 0.8},
	{szName="§Þnh Quèc Tö §»ng Hé uyÓn", 	tbProp={0, 162}, 	nQuality = 1,	nRate = 1.5},
	{szName="An Bang B¨ng Tinh Th¹ch H¹ng Liªn",	tbProp={0, 164},	nQuality = 1,	nRate = 0.03},
	{szName="An Bang Kª HuyÕt Th¹ch Giíi ChØ ",	tbProp={0, 167},	nQuality = 1,	nRate = 0.08},
	{szName="An Bang Cóc Hoa Th¹ch ChØ hoµn",	tbProp={0, 165},	nQuality = 1,	nRate = 0.08},
	{szName="An Bang §iÒn Hoµng Th¹ch Ngäc Béi",	tbProp={0, 166},	nQuality = 1,	nRate = 0.1},
	{szName="§éng S¸t PhØ Thóy Ngäc H¹ng Khuyªn",	tbProp={0, 146},	nQuality = 1,	nRate = 0.05},
	{szName="§éng s¸t b¹ch kim tó phông giíi",	tbProp={0, 145},	nQuality = 1,	nRate = 0.05},
	{szName="§éng s¸t b¹ch kim ®iªu long giíi",	tbProp={0, 143},	nQuality = 1,	nRate = 0.05},
	{szName="§éng s¸t b¹ch ngäc cµn long béi",	tbProp={0, 144},	nQuality = 1,	nRate = 0.05},
	{szName="HuyÒn Tinh Kho¸ng Th¹ch cÊp 6",		tbProp={6, 1, 147, 6, 0, 0},		nRate = 8},
	{szName="HuyÒn Tinh Kho¸ng Th¹ch cÊp 7",		tbProp={6, 1, 147, 7, 0, 0},		nRate = 2},
	{szName="HuyÒn Tinh Kho¸ng Th¹ch cÊp 8",		tbProp={6, 1, 147, 8, 0, 0},		nRate = 0.5},
	{szName="Vâ L©m MËt TÞch", 		tbProp={6, 1, 26, 1, 0, 0},	 		nRate = 0.5},
	{szName="TÈy Tñy Kinh", 			tbProp={6, 1, 22, 1, 0, 0}, 		nRate = 0.5},
	{szName="ThÇn bÝ kho¸ng th¹ch",			tbProp={6, 1, 398, 1, 0, 0},		nRate = 0.02},
	{szName="NÕn C¸t T­êng",			tbProp={6, 1, 1915, 1, 0, 0},		nRate = 15,		nExpiredTime = newyear0901_lazhu_expiredtime},
	{szName="NÕn Nh­ ý",			tbProp={6, 1, 1916, 1, 0, 0},		nRate = 7,		nExpiredTime = newyear0901_lazhu_expiredtime},
	{szName="M·ng CÇu", 			tbProp={6, 1, 1886, 1, 0, 0},		nRate = 12, 	nExpiredTime = newyear0901_item_expiredtime},
	{szName="Dõa", 			tbProp={6, 1, 1887, 1, 0, 0},		nRate = 7, 		nExpiredTime = newyear0901_item_expiredtime},
	{szName="§u §ñ", 			tbProp={6, 1, 1888, 1, 0, 0},		nRate = 7, 		nExpiredTime = newyear0901_item_expiredtime},
	{szName="Xoµi", 			tbProp={6, 1, 1889, 1, 0, 0},		nRate = 7, 		nExpiredTime = newyear0901_item_expiredtime},
	{szName="Sung", 			tbProp={6, 1, 1890, 1, 0, 0},		nRate = 17,		nExpiredTime = newyear0901_item_expiredtime},
	{szName="B¸nh ch­ng th­îng h¹ng", 		tbProp={6, 1, 1894, 1, 0, 0},		nRate = 0.3,	nExpiredTime = newyear0901_item_expiredtime},
	{szName="M¶nh §¹i Nh·n ThÇn Chïy (1/9) /9)",	tbProp={4, 594, 1, 1, 0, 0},	nRate = 0.01},
	{szName="M¶nh §¹i Nh·n ThÇn Chïy (2/9) /9)",	tbProp={4, 595, 1, 1, 0, 0},	nRate = 0.01},
	{szName="M¶nh §¹i Nh·n ThÇn Chïy (4/9) /9)",	tbProp={4, 597, 1, 1, 0, 0},	nRate = 0.01},
	{szName="M¶nh §¹i Nh·n ThÇn Chïy (6/9) /9)",	tbProp={4, 599, 1, 1, 0, 0},	nRate = 0.01},
	{szName="M¶nh §¹i Nh·n ThÇn Chïy (8/9) /9)",	tbProp={4, 601, 1, 1, 0, 0},	nRate = 0.01},
	{szName="M¶nh B¨ng hµn ®µn chØ phi ®ao (1/9)",		tbProp={4, 980, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh B¨ng hµn ®µn chØ phi ®ao (3/9)",		tbProp={4, 982, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh B¨ng hµn ®µn chØ phi ®ao (4/9)",		tbProp={4, 983, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh B¨ng hµn ®µn chØ phi ®ao (7/9)",		tbProp={4, 986, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh B¨ng hµn ®µn chØ phi ®ao (8/9)",		tbProp={4, 987, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh Tø Kh«ng Gi¸ng Ma Giíi ®ao (1/9) /9)",		tbProp={4, 585, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Tø Kh«ng Gi¸ng Ma Giíi ®ao (4/9) /9)",		tbProp={4, 588, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Tø Kh«ng Gi¸ng Ma Giíi ®ao (5/9) /9)",		tbProp={4, 589, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Tø Kh«ng Gi¸ng Ma Giíi ®ao (7/9) /9)",		tbProp={4, 591, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Tø Kh«ng Gi¸ng Ma Giíi ®ao (9/9) /9)",		tbProp={4, 593, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh U Minh Th­¬ng (1/9) /9)",	tbProp={4, 684, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Minh Th­¬ng (3/9) /9)",	tbProp={4, 686, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Minh Th­¬ng (5/9) /9)",	tbProp={4, 688, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Minh Th­¬ng (6/9) /9)",	tbProp={4, 689, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Minh Th­¬ng (8/9) /9)",	tbProp={4, 691, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh Thiªn Niªn Hµn ThiÕt (1/9) /9)",		tbProp={4, 702, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Thiªn Niªn Hµn ThiÕt (4/9) /9)",		tbProp={4, 705, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Thiªn Niªn Hµn ThiÕt (5/9) /9)",		tbProp={4, 706, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Thiªn Niªn Hµn ThiÕt (7/9) /9)",		tbProp={4, 708, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh Thiªn Niªn Hµn ThiÕt (8/9) /9)",		tbProp={4, 709, 1, 1, 0, 0},	nRate = 0.03},
	{szName="M¶nh TÈy T­îng Ngäc KhÊu (2/6) /6)",		tbProp={4, 802, 1, 1, 0, 0},	nRate = 0.04},
	{szName="M¶nh TÈy T­îng Ngäc KhÊu (3/6) /6)",		tbProp={4, 803, 1, 1, 0, 0},	nRate = 0.04},
	{szName="M¶nh TÈy T­îng Ngäc KhÊu (4/6) /6)",		tbProp={4, 804, 1, 1, 0, 0},	nRate = 0.04},
	{szName="M¶nh TÈy T­îng Ngäc KhÊu (5/6) /6)",		tbProp={4, 805, 1, 1, 0, 0},	nRate = 0.04},
	{szName="M¶nh Tª Hoµng Phông NghÜa §ao (2/9) /9)",		tbProp={4, 631, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh Tª Hoµng Phông NghÜa §ao (5/9) /9)",		tbProp={4, 634, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh Tª Hoµng Phông NghÜa §ao (7/9) /9)",		tbProp={4, 636, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh Tª Hoµng Phông NghÜa §ao (8/9) /9)",		tbProp={4, 637, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh Tª Hoµng Phông NghÜa §ao (9/9) /9)",		tbProp={4, 638, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Lung Kim Xµ Ph¸t §¸i (1/6) /6)",		tbProp={4, 825, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Lung Kim Xµ Ph¸t §¸i (2/6) /6)",		tbProp={4, 826, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Lung Kim Xµ Ph¸t §¸i (4/6) /6)",		tbProp={4, 828, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh U Lung Kim Xµ Ph¸t §¸i (6/6) /6)",		tbProp={4, 830, 1, 1, 0, 0},	nRate = 0.05},
	{szName="M¶nh §ång Cõu Kh¸ng Long Hé UyÓn (2/6) /6)",		tbProp={4, 856, 1, 1, 0, 0},	nRate = 0.02},
	{szName="M¶nh §ång Cõu Kh¸ng Long Hé UyÓn (3/6) /6)",		tbProp={4, 857, 1, 1, 0, 0},	nRate = 0.02},
	{szName="M¶nh §ång Cõu Kh¸ng Long Hé UyÓn (4/6) /6)",		tbProp={4, 858, 1, 1, 0, 0},	nRate = 0.02},
	{szName="M¶nh §ång Cõu Kh¸ng Long Hé UyÓn (5/6) /6)",		tbProp={4, 859, 1, 1, 0, 0},	nRate = 0.02},
	{szName="M¶nh L¨ng Nh¹c V« Cùc HuyÒn Ngäc Béi (1/6) /6)",	tbProp={4, 879, 1, 1, 0, 0},	nRate = 0.02},
	{szName="M¶nh L¨ng Nh¹c V« Cùc HuyÒn Ngäc Béi (2/6) /6)",	tbProp={4, 880, 1, 1, 0, 0},	nRate = 0.02},
	{szName="M¶nh L¨ng Nh¹c V« Cùc HuyÒn Ngäc Béi (4/6) /6)",	tbProp={4, 882, 1, 1, 0, 0},	nRate = 0.02},
	{szName="M¶nh L¨ng Nh¹c V« Cùc HuyÒn Ngäc Béi (6/6) /6)",	tbProp={4, 884, 1, 1, 0, 0},	nRate = 0.02},
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
		Say("§¹i hiÖp vÉn ch­a ®ñ cÊp 50 hoÆc vÉn ch­a n¹p thÎ, v× vËy kh«ng thÓ sö dông Ph¸t Tµi Hång Bao.", 0);
		return 1;
	end
	
	local subworld, x, y	= GetWorldPos();
	if (tb_openhongbao_mapid[subworld] == nil) then
		Say("Ph¸t tµi hång bao chØ sö dông ®­îc ë thµnh thÞ vµ th«n trÊn.", 0);
		return 1;
	end
	
	if (CalcFreeItemCellCount() < 20) then
		Say("Hµnh trang cña ®¹i hiÖp kh«ng ®ñ, xin h·y ®Ó trèng 20 « nhÐ!", 0);
		return 1;
	end
	
	if (300 + GetTask(newyear0901_TSK_GetExp_Hongbao) <= GetTask(newyear0901_TSK_GetExpUpLimit))	then
		SetTask(newyear0901_TSK_GetExp_Hongbao, 300 + GetTask(newyear0901_TSK_GetExp_Hongbao));
		AddOwnExp(3000000);
		tbAwardTemplet:GiveAwardByList(tb_facaihongbao_award, "Ph¸t Tµi Hång Bao");
		
		
    	subworld = SubWorldID2Idx(subworld);
    	local n_tree_idx		= random(1, 2);
    	local n_itemid 			= tb_tree_itemid[n_tree_idx];
    	local nItemIdx 			= DropItem(subworld, x * 32, y * 32, -1, 6, 1, n_itemid, 1, 0, 0, 0);
	else
		Say("§¹i hiÖp ®· ®¹t ®Õn giíi h¹n kinh nghiÖm cao nhÊt, v× vËy kh«ng thÓ sö dông Ph¸t Tµi Hång Bao.", 0);
		return 1;
	end
end
