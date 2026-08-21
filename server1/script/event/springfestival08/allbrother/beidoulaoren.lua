Include("\\script\\event\\springfestival08\\allbrother\\event.lua");	-- 
Include("\\script\\event\\BeiDouChuanGong\\zhizuochuangongwan.lua");	-- 
Include("\\script\\event\\other\\xunmashu\\dialog.lua")
Include("\\script\\task\\metempsychosis\\npc_saodiseng.lua");			-- ¶àÖØ×ªÉú¶Ô»°
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\task\\metempsychosis\\translife_4_ex.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function main()
	local nNpcIndex = GetLastDiagNpc();
	local szNpcName = GetNpcName(nNpcIndex)
	
	if NpcName2Replace then
		szNpcName = NpcName2Replace(szNpcName);
	end
	
	local tbDailog = DailogClass:new(szNpcName);
	tbDailog.szTitleMsg = "Xin chµo, t¹i h¹ lµ truyÒn nh©n cña B¾c §Èu M«n, ch¼ng hay c¸c h¹ cÇn g×?";
	
	--G_ACTIVITY:OnMessage("ClickNpc", tbDailog, nNpcIndex)
	
	if (CFG_NhiemVuGiaiHuynhDeBacDauLaoNhan	== 1) then
		tbDailog:AddOptEntry("NhiÖm vô tø h¶i giai huynh ®Ö", allbrother_0801_main);
	end
	if (CFG_LuyenDanTruyenCong	== 1) then
		tbDailog:AddOptEntry("LuyÖn tiªn ®an truyÒn c«ng", BeiDouChuanGong_main, {1});
	end
	if (CFG_TrungSinh	== 1) then
		tbDailog:AddOptEntry("T×m kiÕm B¾c §Èu Tr­êng Sinh ThuËt", beidou_translife_main);
		tbDailog:AddOptEntry("Ta muèn chuyÓn sinh", zhuansheng_ondialog)
	end
	if (CFG_KyNangTrungSinh4	== 1) then
		--T¹m ®ãng kü n¨ng TS 4 - Modified By DinhHQ - 20111102
		tbDailog:AddOptEntry("Ta muèn häc kü n¨ng ChiÕn ý Thiªn Thu", beidou_learn_specialskill);
	end
	if (CFG_BaoRuongThanBiBacDauLaoNhan	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng [B¶o r­¬ng thÇn bÝ]", tbXunMaShu0903.DialogMain_Box, {tbXunMaShu0903});
	end
	if (CFG_ThuanMaThuat	== 1) then
		tbDailog:AddOptEntry("B¾c §Èu ThuÇn M· ThuËt", tbXunMaShu0903.DialogMain_Horse, {tbXunMaShu0903});
	end
	
	tbDailog:Show();
end