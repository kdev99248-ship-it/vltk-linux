Include("\\script\\global\\nobitaxd\\config\\cfg_activity_bonus.lua")

ITEM_SuKien	=	{szName="CÈm nang thÇn bÝ",tbProp={6,1,1502,1,0,0},}
EVENT_LOG_TITLE	=	"Event VLTK OFFLINE 2023"

tbConfig = {}
tbConfig[1] = 
{
	nId = 1,
	szMessageType = "Chuanguan",
	szName = "Chuanguan_17",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"17"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{90,"",">="} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien,10,EVENT_LOG_TITLE,"VuotAi17"} },
	},
}
tbConfig[2] = 
{
	nId = 2,
	szMessageType = "Chuanguan",
	szName = "Chuanguan_28",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {"28"},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{90,"",">="} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien,20,EVENT_LOG_TITLE,"VuotAi28"} },
	},
}
tbConfig[3] = 
{
	nId = 3,
	szMessageType = "FinishSongJin",
	szName = "songjin mark >= 5000",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"",">="} },
		{"PlayerFunLib:CheckTask",	{"751",5000,"",">="} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien_2,500,EVENT_LOG_TITLE,"TongKim5000"} },
	},
}
tbConfig[4] = 
{
	nId = 4,
	szMessageType = "FinishSongJin",
	szName = "songjin mark >= 1000 and < 5000",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{80,"",">="} },
		{"PlayerFunLib:CheckTask",	{"751",5000,"","<"} },
		{"PlayerFunLib:CheckTask",	{"751",1000,"",">="} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien_2,100,EVENT_LOG_TITLE,"TongKim1000"} },
	},
}
tbConfig[5] = 
{
	nId = 5,
	szMessageType = "NpcOnDeath",
	szName = "fenglingdu_boatboss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{90,"",">="} },
		{"NpcFunLib:CheckBoatBoss",	{nil} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien,50,EVENT_LOG_TITLE,"TieuDietThuyTacDauLinh"} },
	},
}
tbConfig[6] = 
{
	nId = 6,
	szMessageType = "NpcOnDeath",
	szName = "fenglingdu_bigboatboss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{90,"",">="} },
		{"NpcFunLib:CheckId",	{"1692"} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien_2,5,EVENT_LOG_TITLE,"TieuDietThuyTacDaiDauLinh"} },
	},
}
tbConfig[7] = 
{
	nId = 7,
	szMessageType = "NpcOnDeath",
	szName = "kill_gold_boss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{90,"",">="} },
		{"NpcFunLib:CheckWorldBoss",	{nil} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien,50,EVENT_LOG_TITLE,"TieuDietBossTheGioi"} },
	},
}
tbConfig[8] = 
{
	nId = 8,
	szMessageType = "NpcOnDeath",
	szName = "kill_killer_boss",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"PlayerFunLib:CheckTotalLevel",	{90,"",">="} },
		{"NpcFunLib:CheckKillerdBoss",	{90} },
	},
	tbActition = 
	{
		--{"PlayerFunLib:GetItem",	{ITEM_SuKien_2,100,EVENT_LOG_TITLE,"TieuDietBossSatThu"} },
	},
}
tbConfig[9] =
{
	nId = 9,
	szMessageType = "NpcOnDeath",
	szName = "§¸nh qu¸i rít ®¹i hØ b¶o h¹p",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
		{"NpcFunLib:CheckNormalMonster",	{"10,20,30,40,50,60,70,80,90"} },
	},
	tbActition = 
	{
		{"NpcFunLib:DropSingleItem",	{ITEM_SuKien,1,"5"} },
	},
}