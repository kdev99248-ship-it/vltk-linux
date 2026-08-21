IncludeLib("TASKSYS")
Include("\\script\\global\\signet_head.lua")
Include("\\script\\missions\\basemission\\lib.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
IncludeLib("LEAGUE")
Include("\\script\\lib\\droptemplet.lua")
-- NobitaXD
Include("\\script\\lib\\log.lua")
_Message = function (nItemIdx)
	local strItemName = GetItemName(nItemIdx)
	local strMessage = format("<color=green>Chóc mõng <color=yellow>%s<color=green> ®· ®¸nh r¬i <color=yellow>%s<color=green>", GetName(), strItemName)
	local handle = OB_Create();
	ObjBuffer:PushObject(handle, strMessage)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end

--ÎäÁÖÈÙÓþÁî µôÂä
--honour
DROPRATE_BOSS_HONOURRATE = {
		["V­¬ng T¸ "] = {350, 136},--739
		["HuyÒn Gi¸c §¹i S­ "] = {350, 134},--740
		["§­êng BÊt NhiÔm"] = {350, 149},--741
		["B¹ch Doanh Doanh"] = {350, 138},--742
		["Thanh TuyÖt S­ Th¸i"] = {350, 137},--743
		["Yªn HiÓu Tr¸i"] = {350, 168},--744
		["Hµ Nh©n Ng· "] = {350, 171},--
		["§¬n T­ Nam"] = {350, 171},--746745
		["TuyÒn C¬ Tö "] = {350, 144},--747
		--["º«ÃÉ"] = {},--748
		["%ÌìÍõ%"] = {350, 250},--1193
		["ÂÒÊÀÓ¢ºÀ¤²"] = {350, 250},--1194
		["×·Ãü¾ÓÊ¿"] = {350, 250},--1195
		["ÉñÏÉÒ²²»¹ýÈç´Ë"] = {350, 250},--1196
		["¶ìÕ½Ñª"] = {350, 250},--1197
		["ºûµû±´±´"] = {350, 250},--1198
		["Óñº£Â¥¤ÎÎðÍüÎÒ"] = {350, 250},--1199
		["¡áÇåÏã¡©¡ºÌìÈÌ¡»"] = {350, 250},--1200
		["¹ÅµÀ·ç"] = {350, 250},--1201
		["ÈÇ»ðµÄÅ®ÈË"] = {350, 250},--1202
		["§¹i M· Hæ "] = {0, 250},
		["Gia LuËt TÞ Ly"] = {350, 130},--563
		["Hoµn Nhan TuyÕt Y"] = {400, 130},--564
		["§oan Méc DuÖ "] = {400, 127},--565
		["Cæ B¸ch"] = {350, 141},--566
		["§¹o Thanh Ch©n Nh©n"] = {300, 130},--562
		["Chung Linh Tó "] = {400, 130},--567
		["Hµ Linh Phiªu"] = {400, 130},--568
		["Lam Y Y"] = {250, 176},--582
		["M¹nh Th­¬ng L­¬ng"] = {300, 180},--583
		--[] = {},
}
HONOURID = {1257, 1294}
SIGNET_DROPCOUNT = 10
TSK_PLAYER_BOSSKILLED = 2598 -- Íæ¼Ò»÷É±BOSSÊýÁ¿Í³¼Æ
--DC kinh nghiÖm boss HK - Modified By DinhHQ - 20111007
--KILLBOSSEXPAWARD = 20000000	-- »÷É±boss½±Àø
--KILLBOSSNEAREXPAWARD = 12000000	-- »÷É±boss¸½½ü½±Àø
KILLBOSSEXPAWARD = 30000000
KILLBOSSNEAREXPAWARD = 10000000
--Renew boss award - Modified by DinhHQ - 20120319
local tbVnNewItemDropAward = {
	{{szName="§¹i lùc hoµn lÔ bao",tbProp={6,1,2517,1,0,0},nCount=1,nRate=60},},
	{{szName="Phi tèc hoµn lÔ bao",tbProp={6,1,2520,1,0,0},nCount=1,nRate=60},},
	{{szName="T©m T©m T­¬ng ¸nh phï",tbProp={6,1,18,1,0,0},nCount=1,nRate=60},},
	{{szName="Tö Thñy Tinh",tbProp={4,239,1,1,0,0},nCount=1,nRate=80},},
	{{szName="Thiªn s¬n  B¶o Lé",tbProp={6,1,72,1,0,0},nCount=3,nRate=60},},
	{{szName="Lam Thñy Tinh",tbProp={4,238,1,1,0,0},nCount=1,nRate=80},},
	{{szName="Lôc Thñy Tinh",tbProp={4,240,1,1,0,0},nCount=1,nRate=80},},
	{{szName="Bµn Nh­îc T©m Kinh",tbProp={6,1,12,1,0,0},nCount=2,nRate=80},},
	{{szName="Tinh Hång B¶o Th¹ch",tbProp={4,353,1,1,0,0},nCount=2,nRate=80},},
	{{szName="Tiªn Th¶o Lé ®Æc biÖt",tbProp={6,1,1181,1,0,0},nCount=2,nRate=50},},
	{{szName="Tiªn Th¶o Lé ",tbProp={6,1,71,1,0,0},nCount=1,nRate=50},},
	{{szName="ThiÕt La H¸n",tbProp={6,1,23,1,0,0},nCount=5,nExpiredTime=20160,		nRate=10},},
	{{szName="TÈy Tñy Kinh",tbProp={6,1,22,1,0,0},nCount=2,nExpiredTime=20160,					nRate=5},},
	{{szName="Vâ L©m MËt TÞch",tbProp={6,1,26,1,0,0},nCount=2,nExpiredTime=20160,					nRate=5},},
	{{szName="§¹i Thµnh BÝ KÝp 90 vµ 120",tbProp={6,1,random(2424,2425),1,0,0},nCount=1,			nRate=0.5},},	
	{{szName="BÝ quyÕt kü n¨ng cÊp 120",tbProp={6,1,1125,1,0,0},nCount=1,					nRate=0.5},},

	{{szName = " §å phæ Hoµng Kim - An Bang B¨ng Tinh Th¹ch H¹ng Liªn",tbProp = {0,164},nCount = 1,				nRate = 5,nQuality = 1,CallBack = _Message},},
	{{szName = " §å phæ Hoµng Kim - An Bang Cóc Hoa Th¹ch ChØ hoµn",tbProp = {0,165},nCount = 1,				nRate = 5,nQuality = 1,CallBack = _Message},},
	{{szName = " §å phæ Hoµng Kim - An Bang §iÒn Hoµng Th¹ch Ngäc Béi",tbProp = {0,166},nCount = 1,				nRate = 5,nQuality = 1,CallBack = _Message},},
	{{szName = " §å phæ Hoµng Kim - An Bang Kª HuyÕt Th¹ch Giíi ChØ ",tbProp = {0,167},nCount = 1,				nRate = 5,nQuality = 1,CallBack = _Message},},
	{{szName = "HiÖp Cèt ThiÕt HuyÕt Sam",tbProp = {0,186},nCount = 1, 					nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = "HiÖp Cèt §a T×nh Hoµn",tbProp = {0,187},nCount = 1, 					nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = "HiÖp Cèt §an T©m Giíi",tbProp = {0,188},nCount = 1, 					nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = "HiÖp Cèt T×nh ý KÕt",tbProp = {0,189},nCount = 1, 						nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = "Nhu T×nh C©n Quèc NghÖ Th­êng",tbProp = {0,190},nCount = 1,				nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = "Nhu T×nh Thôc N÷ H¹ng Liªn",tbProp = {0,191},nCount = 1, 					nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = "Nhu T×nh Phông Nghi Gi íi ChØ",tbProp = {0,192},nCount = 1, 				nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = "Nhu T×nh TuÖ T©m Ngäc Béi",tbProp = {0,193},nCount = 1, 					nRate = 10,nQuality = 1,CallBack = _Message },},
	{{szName = " §å phæ Hoµng Kim - §Þnh Quèc Thanh Sa Tr­êng Sam",tbProp = {0,159},nCount = 1,					nRate = 5,nQuality = 1,CallBack = _Message },},
	{{szName = " §å phæ Hoµng Kim - §Þnh Quèc ¤ Sa Ph¸t Qu¸n",tbProp = {0,160},nCount = 1,					nRate = 5,nQuality = 1,CallBack = _Message },},
	{{szName = " §å phæ Hoµng Kim - §Þnh Quèc XÝch Quyªn NhuyÔn Ngoa",tbProp = {0,161},nCount = 1,				nRate = 5,nQuality = 1,CallBack = _Message },},
	{{szName = " §å phæ Hoµng Kim - §Þnh Quèc Tö §»ng Hé uyÓn",tbProp = {0,162},nCount = 1,					nRate = 5,nQuality = 1,CallBack = _Message },},
	{{szName = " §å phæ Hoµng Kim - §Þnh Quèc Ng©n Tµm Yªu ®¸i",tbProp = {0,163},nCount = 1,					nRate = 5,nQuality = 1,CallBack = _Message },},
	{{szName = "HuyÒn ThiÕt KiÕm",tbProp = {0,0,0,10,random(0,4),25},tbParam = {10,10,10,10,10,10}, nCount=3,	nRate=50},},
	{{szName = "§¹i Phong §ao",tbProp = {0,0,1,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Kim C« Bæng",tbProp = {0,0,2,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Ph¸ Thiªn KÝch",tbProp = {0,0,3,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Ph¸ Thiªn Chuú",tbProp = {0,0,4,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Th«n NhËt Tr¶m",tbProp = {0,0,5,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "B¸ V­¬ng Tiªu",tbProp = {0,1,0,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "To¸i NguyÖt §ao",tbProp = {0,1,1,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,	nRate=50},},
	{{szName = "Khæng T­íc Linh",tbProp = {0,1,2,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},

}

local tbHKMPCaoCap = 
{	
	[1]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(38,39),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn V­¬ng",tbProp={0,random(20,23)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn V­¬ng",tbProp={0,26},nCount=1,nQuality = 1,			nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn V­¬ng",tbProp={0,random(28,29)},nCount=1,nQuality = 1,		nRate=1,},

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(594,599),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1140,1145),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1031,1036),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(603,608),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(795,800),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1146,1151),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(612,617),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1037,1042),1,0,0},nCount=1,				nRate=1.5,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1152,1157),1,0,0},nCount=1,				nRate=1.5,},
	},
	[2]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(56,58),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i ThiÕu l©m",tbProp={0,random(1,15)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(998,1003),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(789,794),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1122,1127),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(576,581),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1128,1133),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1019,1024),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(585,590),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1134,1139),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1025,1030),1,0,0},nCount=1,				nRate=0.25,},
	},
	[3]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(27,28),1,0,0},nCount=1,nRate=10},
			{szName="BÝ kÝp 90",tbProp={6,1,random(45,46),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i §­êng M«n",tbProp={0,random(71,73)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i §­êng M«n",tbProp={0,75},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i §­êng M«n",tbProp={0,random(86,87)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i §­êng M«n",tbProp={0,89},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i §­êng M«n",tbProp={0,81},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i §­êng M«n",tbProp={0,85},nCount=1,nQuality = 1,		nRate=1,},

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(657,662),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(989,994),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1212,1217),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(666,671),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1218,1223),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1079,1084),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1085,1090),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(843,848),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1224,1229),1,0,0},nCount=1,				nRate=0.25,},

	},
	[4]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(47,48),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Ngò §éc",tbProp={0,random(61,62)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Ngò §éc",tbProp={0,56},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Ngò §éc",tbProp={0,60},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Ngò §éc",tbProp={0,random(66,67)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Ngò §éc",tbProp={0,69},nCount=1,nQuality = 1,		nRate=1,},

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(648,653),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1061,1066),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1194,1199),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1067,1072),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(837,842),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1200,1205),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(980,985),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1073,1078),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1206,1211),1,0,0},nCount=1,				nRate=0.25,},
	},
	[5]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(42,43),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Nga Mi",tbProp={0,random(31,33)},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Nga Mi",tbProp={0,random(39,40)},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Nga Mi",tbProp={0,random(41,42)},nCount=1,nQuality = 1,		nRate=1,},	

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(621,626),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1158,1163),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1043,1048),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1164,1169),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(801,806),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(807,812),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1170,1175),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(813,818),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1049,1054),1,0,0},nCount=1,				nRate=0.25,},

	},
	[6]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(40,41),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thóy Yªn",tbProp={0,random(46,49)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thóy Yªn",tbProp={0,random(51,52)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thóy Yªn",tbProp={0,54},nCount=1,nQuality = 1,		nRate=1,},

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(630,635),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1176,1181),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1055,1060),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(639,644),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1182,1187),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(819,824),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(825,830),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1188,1193),1,0,0},nCount=1,				nRate=1,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(831,836),1,0,0},nCount=1,				nRate=1,},

	},
	[7]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(54,55),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i C¸i Bang",tbProp={0,random(92,94)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i C¸i Bang",tbProp={0,random(96,99)},nCount=1,nQuality = 1,		nRate=1,},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i C¸i Bang",tbProp={0,random(91,100)},nCount=1,nQuality = 1,		nRate=1,},

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(849,854),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1230,1235),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(855,860),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(675,680),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1236,1241),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1091,1096),1,0,0},nCount=1,				nRate=0.25,},

	},
	[8]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(35,36),1,0,0},nCount=1,nRate=10},		
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn NhÉn",tbProp={0,random(107,108)},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn NhÉn",tbProp={0,110},nCount=1,nQuality = 1,		nRate=0.01,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn NhÉn",tbProp={0,random(101,102)},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn NhÉn",tbProp={0,112},nCount=1,nQuality = 1,		nRate=0.01,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Thiªn NhÉn",tbProp={0,random(114,115)},nCount=1,nQuality = 1,		nRate=1,},	

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(684,689),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1097,1102),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1254,1259),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(861,866),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(867,872),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1242,1247),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1103,1108),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1248,1253),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(873,878),1,0,0},nCount=1,				nRate=0.25,},
	},
	[9]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(33,34),1,0,0},nCount=1,nRate=10},
			{szName="Trang Bi Hoµng Kim M«n Ph¸i C«n L«n",tbProp={0,random(136,137)},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i C«n L«n",tbProp={0,139},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i C«n L«n",tbProp={0,132},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i C«n L«n",tbProp={0,random(126,129)},nCount=1,nQuality = 1,		nRate=1,},	

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1010,1015),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1260,1265),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(879,884),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(693,698),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(885,890),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1266,1271),1,0,0},nCount=1,				nRate=0.25,},

	},
	[10]=
	{
			{szName="BÝ kÝp 90",tbProp={6,1,random(50,52),1,0,0},nCount=1,nRate=10},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Vâ §ang",tbProp={0,random(121,123)},nCount=1,nQuality = 1,		nRate=1,},	
			{szName="Trang Bi Hoµng Kim M«n Ph¸i Vâ §ang",tbProp={0,random(118,119)},nCount=1,nQuality = 1,		nRate=1,},	

			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(702,707),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1272,1277),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1109,1114),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1004,1009),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(891,896),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1278,1283),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(897,902),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1284,1289),1,0,0},nCount=1,				nRate=0.25,},
			{szName="M¶nh Hoµng Kim",tbProp={4,1,random(1115,1120),1,0,0},nCount=1,				nRate=0.25,},
	},

}
function OnDeath( nNpcIndex )
	local x, y, world = GetNpcPos(nNpcIndex);
	local maxcount = SIGNET_DROPCOUNT;
	local _, nTongID = GetTongName();
	if (nTongID > 0) then
		if (IsDoubledMoneyBox(nTongID)) then
			maxcount = getSignetDropRate(SIGNET_DROPCOUNT);
		end;
	end;
	local nNpcID = GetNpcParam(nNpcIndex,1);
	local nCurtime = GetCurServerTime() + 7 * 24 *60 * 60
	local nYear = tonumber(FormatTime2String("%Y", nCurtime))
	local nMonth = tonumber(FormatTime2String("%m", nCurtime))
	local nDay = tonumber(FormatTime2String("%d", nCurtime))
	--Bá phÇn th­ëng vËt phÈm khi tiªu diÖt boss - Modified by DinhHQ - 20111012
--	for i = 1, maxcount do
--		local nItemIdx = DropItem(world, x, y, PlayerIndex, 6, 1, 1094, 1, 0, 0, 0, 0, 0, 0, 0, 0);
--		SetSpecItemParam(nItemIdx, 1, nCurtime);
--		SetSpecItemParam(nItemIdx, 2, nYear)
--		SetSpecItemParam(nItemIdx, 3, nMonth)
--		SetSpecItemParam(nItemIdx, 4, nDay)
--		SyncItem(nItemIdx);
--	end;
	for i = 1, 1 do
		local nItemIndex = AddItem(10,6,1,4378,1,0,0);
		SetItemBindState(nItemIndex, -1);
	end;
	--Renew boss award - Modified by DinhHQ - 20120319
		       if nNpcID== 739 or 	nNpcID== 566   then STTID= 1
		elseif nNpcID== 740 or	nNpcID== 1365 then STTID= 2 
		elseif nNpcID== 741 or	nNpcID== 1366 then STTID= 3 
		elseif nNpcID== 742 or 	nNpcID== 582   then STTID= 4
		elseif nNpcID== 743 or 	nNpcID== 568   then STTID= 5 
		elseif nNpcID== 744 or 	nNpcID== 567   then STTID= 6 
		elseif nNpcID== 745 or 	nNpcID== 583   then STTID= 7 
		elseif nNpcID== 563 or	nNpcID== 748 	or nNpcID== 565 	then STTID= 8
		elseif nNpcID== 747 or 	nNpcID== 1368 then STTID= 9
		elseif nNpcID== 1367 or 	nNpcID== 562   then STTID= 10 
	end
	local nzRate = random(1,100)
	local ListItemcaocap=%tbHKMPCaoCap[STTID];
	if nzRate > 90 then
	tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex,ListItemcaocap,format("killed_%s",GetNpcName(nNpcIndex)),1)	
	end
	tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex,%tbVnNewItemDropAward,format("killed_%s",GetNpcName(nNpcIndex)))	
	-- ÎäÁÖÈÙÓþÁîÅÆµôÂä
	if (GetProductRegion() == "cn" or GetProductRegion() == "cn_ib") then
		local szNpcName = GetNpcName(nNpcIndex);
		if (DROPRATE_BOSS_HONOURRATE[szNpcName]) then
			for i = 1, getn(DROPRATE_BOSS_HONOURRATE[szNpcName]) do
				local nrate = random(1, 10000);
				if (nrate < DROPRATE_BOSS_HONOURRATE[szNpcName][i]) then
				DropItem(world, x, y, PlayerIndex, 6, 1, HONOURID[i], 1, 0, 0, 0, 0, 0, 0, 0, 0);
				end;
			end;
		end;
	end;
	
	-- ¸øÉ±µôBOSSµÄÈË»ò¶ÓÎé½±Àø
	local nTeamSize = GetTeamSize();
	local szName;
	
	if (nTeamSize > 1) then
		for i=1,nTeamSize do
			if(doFunByPlayer(GetTeamMember(i), IsCaptain)==1)then
				szName = doFunByPlayer(GetTeamMember(i), GetName);
			end
			doFunByPlayer(GetTeamMember(i), PlayerFunLib.AddExp, PlayerFunLib, KILLBOSSEXPAWARD, 0, format("%s phÇn th­ëng","Kinh nghiÖm ®¶ b¹i BOSS hoµng kim"));
		end
	else -- Ò»¸öÈË
		szName = GetName();
		PlayerFunLib:AddExp(KILLBOSSEXPAWARD, 0, format("%s phÇn th­ëng","Kinh nghiÖm ®¶ b¹i BOSS hoµng kim"));
	end
	
	local tbRoundPlayer, nCount = GetNpcAroundPlayerList(nNpcIndex, 20);
	
	for i=1,nCount do
		doFunByPlayer(tbRoundPlayer[i], PlayerFunLib.AddExp, PlayerFunLib, KILLBOSSNEAREXPAWARD, 0, format("%s phÇn th­ëng","Kinh nghiÖm ®øng gÇn lóc BOSS hoµng kim bÞ tiªu diÖt"));
	end
	
	local szNews = format("§¹i hiÖp <color=yellow>%s<color> t¹i <color=yellow>%s<color> ®· tiªu diÖt thµnh c«ng <color=yellow>%s<color>!", szName, SubWorldName(SubWorld),GetNpcName(nNpcIndex));
	AddGlobalNews(szNews);
	LG_ApplyDoScript(1, "", "", "\\script\\event\\msg2allworld.lua", "battle_msg2allworld", szNews , "", "");
	
	-- BOSS»÷É±Í³¼Æ
	local nCount = GetTask(TSK_PLAYER_BOSSKILLED);
	nCount = nCount + 1;
	SetTask(TSK_PLAYER_BOSSKILLED, nCount);
	
	if (GetNpcParam(nNpcIndex, 1) == 1) then --19:30µÄ»Æ½ðBOSS
		-- »Æ½ðBOSS¼ÆÊý
		RemoteExecute("\\script\\mission\\boss\\bigboss.lua", "ReduceGoldBossCount", 0);
	end
end;

