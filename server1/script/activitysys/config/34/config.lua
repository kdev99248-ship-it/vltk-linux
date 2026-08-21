Include("\\script\\activitysys\\config\\34\\variables.lua")
tbConfig = {}
tbConfig[1] = --Ò»¸öÏ¸½Ú
{
	nId = 1,
	szMessageType = "ServerStart",
	szName = "Sù khëi ®Çu",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"lib:Include",	{"\\script\\event\\expansion\\201006\\fuguijinhe\\fuguijinhe.lua"} },
	},
	tbActition = 
	{
		--{"tbBetInfo:Init",	{nil} },
	},
}
tbConfig[2] = --Ò»¸öÏ¸½Ú
{
	nId = 2,
	szMessageType = "ClickNpc",
	szName = "§èi tho¹i thÇn tµi",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"ThÇn Tµi"},
	tbCondition = 
	{
	},
	tbActition = 
	{
		{"AddDialogOpt",	{"Mua Phó Quý CÈm H¹p",6} },
		{"AddDialogOpt",	{"Xem vßng thi nµy",3} },
		{"AddDialogOpt",	{"Xem con sè may m¾n lÇn tr­íc",4} },
		{"AddDialogOpt",	{"NhËn l·nh phÇn th­ëng",5} },
		{"SetDialogTitle",	{"<npc>Phó Quý CÈm H¹p"} },
	},
}
tbConfig[3] = --Ò»¸öÏ¸½Ú
{
	nId = 3,
	szMessageType = "nil",
	szName = "Xem vßng thi nµy",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"lib:Include",	{"\\script\\event\\expansion\\201006\\fuguijinhe\\fuguijinhe.lua"} },
	},
	tbActition = 
	{
		{"tbBetInfo:CurBetInfo_dlg",	{nil} },
	},
}
tbConfig[4] = --Ò»¸öÏ¸½Ú
{
	nId = 4,
	szMessageType = "nil",
	szName = "Xem con sè may m¾n lÇn tr­íc",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"lib:Include",	{"\\script\\event\\expansion\\201006\\fuguijinhe\\fuguijinhe.lua"} },
	},
	tbActition = 
	{
		{"tbBetInfo:LastBetInfo_dlg",	{nil} },
	},
}
tbConfig[5] = --Ò»¸öÏ¸½Ú
{
	nId = 5,
	szMessageType = "nil",
	szName = "NhËn l·nh phÇn th­ëng",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"lib:Include",	{"\\script\\event\\expansion\\201006\\fuguijinhe\\fuguijinhe.lua"} },
	},
	tbActition = 
	{
		{"tbBetInfo:GetAward_dlg",	{nil} },
	},
}

tbConfig[6] = --Ò»¸öÏ¸½Ú
{
	nId = 6,
	szMessageType = "CreateCompose",
	szName = "Buy_TongYaoShi",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"Phó Quý CÈm H¹p",1,1,1,1},
	tbCondition = 
	{
		{"PlayerFunLib:CheckFreeBagCellWH",	{1,1,1,"default"} },
		{"AddOneMaterial",	{"TiÒn §ång",	{tbProp={4,417,1,1,0,0}},	1} },
	},
	tbActition = 
	{
		{"PlayerFunLib:GetItem",	{ITEM_COMMAND_PIECE_1,1,"CaiShen_Buy_TongYaoShi"} },
	},
}