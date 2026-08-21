--==========================--
-- NPC Qu¶n Lý Sù KiÖn
-- Vâ L©m Cñ Chuèi - Edit by NobitaXD
Task_QuanLySuKien = 5000		-- GetTask(Task_QuanLySuKien)	SetTask(Task_QuanLySuKien,)
--==========================--
IncludeLib("ITEM");
IncludeLib("FILESYS")
IncludeLib("LEAGUE");
IncludeLib("TONG")
IncludeLib("RELAYLADDER");
IncludeLib("SETTING")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\global\\fuyuan.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua");
Include("\\script\\lib\\alonelib.lua");
Include("\\script\\lib\\itemblue.lua");
Include("\\script\\global\\nobitaxd\\npc\\doiraclayvk.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_activity_bonus.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\global\\skills_table.lua");
Include("\\script\\task\\newtask\\tasklink\\tasklink_head.lua"); 
Include("\\script\\task\\newtask\\tasklink\\tasklink_award.lua"); 
Include("\\script\\event\\storm\\function.lua")	--Storm
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\log.lua")
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\task\\system\\task_string.lua");
Include("\\script\\global\\seasonnpc.lua");
Include("\\script\\global\\nobitaxd\\item\\nhiemvuhoangkim.lua")
Include("\\script\\gm_tool\\laoanmay.lua")	--/home/jxser/server1/script/gm_tool


--Khoi tao doi thoai NPC
function main()
	dofile("script/global/nobitaxd/npc/npcsukien_quanly.lua");
	local szTitlez =  "<color=yellow>VLTK OFFLINE - Phiªn b¶n 2024<color> - <color=blue>Ta phô tr¸ch qu¶n lý toµn bé sù kiÖn ë ®©y.<color>\nB¹n cÇn g× ?\nLiªn hÖ Zalo: <color=yellow>039 36 444 75<color>"
	local tbOpt =
		{
		{"BËt sù kiÖn th¸ng 01", Event_01},
		{"BËt sù kiÖn th¸ng 02", Event_02},
		{"BËt sù kiÖn th¸ng 03", Event_03},
		{"BËt sù kiÖn th¸ng 04", Event_04},
		{"BËt sù kiÖn th¸ng 05", Event_05},
		{"BËt sù kiÖn th¸ng 06", Event_06},
		{"BËt sù kiÖn th¸ng 07", Event_07},
		{"BËt sù kiÖn th¸ng 08", Event_08},
		{"BËt sù kiÖn th¸ng 09", Event_09},
		{"BËt sù kiÖn th¸ng 10", Event_10},
		{"BËt sù kiÖn th¸ng 11", Event_11},
		{"BËt sù kiÖn th¸ng 12", Event_12},
		{"Tho¸t"},
		}
	CreateNewSayEx(szTitlez, tbOpt)	
end
--===== Danh s¸ch sù kiÖn th¸ng 01 =====---
function Event_01()
	local tbOpt =
	{
		{"Sù kiÖn 01", Event_01_1},
		{"Sù kiÖn 01", Event_01_1},
		{"Sù kiÖn 01", Event_01_1},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Danh s¸ch sù kiÖn th¸ng 01<color>:<enter>Mêi b¹n chän sù kiÖn b¹n thÝch. Haha !", tbOpt)
end
function Event_01_1()
	SetTask(Task_QuanLySuKien,202501)
	Say("B¹n võa më sù kiÖn nµy, chóc b¹n tr¶i nghiÖm sù kiÖn vui vÎ !\nCÇn thªm sù kiÖn Liªn hÖ Zalo: <color=yellow>039 36 444 75<color> ",0);
end

--===== Danh s¸ch sù kiÖn th¸ng 03 =====---
function Event_03()
	local tbOpt =
	{
		{"Sù kiÖn 03 2007", Event_03_1},	-- CFG_cookies2007		= 0	-- 10/3		03/2007			Done
		{"Sù kiÖn 03 2006", Event_03_2},	-- CFG_nationalday_2006		= 0	--			01/10/2006	03/10/2006	Done
		{"Sù kiÖn 03", Event_03_1},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Danh s¸ch sù kiÖn th¸ng 01<color>:<enter>Mêi b¹n chän sù kiÖn b¹n thÝch. Haha !", tbOpt)
end
function Event_03_1()
	SetTask(Task_QuanLySuKien,200703)
	Say("B¹n võa më sù kiÖn nµy, chóc b¹n tr¶i nghiÖm sù kiÖn vui vÎ !\nCÇn thªm sù kiÖn Liªn hÖ Zalo: <color=yellow>039 36 444 75<color> ",0);
end
function Event_03_2()
	SetTask(Task_QuanLySuKien,200603)
	Say("B¹n võa më sù kiÖn nµy, chóc b¹n tr¶i nghiÖm sù kiÖn vui vÎ !\nCÇn thªm sù kiÖn Liªn hÖ Zalo: <color=yellow>039 36 444 75<color> ",0);
end

--===== Danh s¸ch sù kiÖn th¸ng 07 =====---
function Event_12()
	local tbOpt =
	{
		{"Sù kiÖn 12 2006", Event_12_1},	--CFG_xmas2006			= 0	-- Giang sinh		12/2006			Done
		{"Sù kiÖn 12 2007", Event_12_2},	--CFG_xmas2007			= 0	-- Giang sinh		12/2007			Done
	--	{"Sù kiÖn 03", Event_03_1},
		{"Tho¸t"},
	}
	CreateNewSayEx("<color=yellow>Danh s¸ch sù kiÖn th¸ng 01<color>:<enter>Mêi b¹n chän sù kiÖn b¹n thÝch. Haha !", tbOpt)
end
function Event_12_1()
	SetTask(Task_QuanLySuKien,200612)
	Say("B¹n võa më sù kiÖn nµy, chóc b¹n tr¶i nghiÖm sù kiÖn vui vÎ !\nCÇn thªm sù kiÖn Liªn hÖ Zalo: <color=yellow>039 36 444 75<color> ",0);
end
function Event_12_2()
	SetTask(Task_QuanLySuKien,200712)
	Say("B¹n võa më sù kiÖn nµy, chóc b¹n tr¶i nghiÖm sù kiÖn vui vÎ !\nCÇn thªm sù kiÖn Liªn hÖ Zalo: <color=yellow>039 36 444 75<color> ",0);
end