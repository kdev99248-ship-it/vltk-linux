
---------------------------------------------------------------------------------
--  ÑÏÖØÉùÃ÷£º´ËÎÄ¼ş²»³é×Ö·û´®
---------------------------------------------------------------------------------

-- Àñ¹Ù½Å±¾
-- Li_Xin 2004-8-17
--Include( "\\script\\global\\ÖĞÇï»î¶¯.lua" )

--TASKID_HOLIDAY_GIFT_DATE = 160;				-- ÈÎÎñ±äÁ¿ID of Íæ¼Ò×îºóÒ»´ÎÁìÈ¡½ÚÈÕÀñÎïÊ±¼ä
--TASKTMPID_HOLIDAY_GIFT_DATE = 160;			-- ÁÙÊ±ÈÎÎñ±äÁ¿ID of Íæ¼Ò×îºóÒ»´ÎÁìÈ¡½ÚÈÕÀñÎïÊ±¼ä
Include( "\\script\\event\\eventhead.lua" )
Include("\\script\\event\\maincity\\event.lua")	-- Ö÷³Ç½±Àø
Include("\\script\\event\\superplayeract2007\\event.lua")----³¬¼¶Íæ¼Ò»î¶¯
Include("\\script\\event\\great_night\\event.lua")	-- »Ô»ÍÖ®Ò¹
Include("\\script\\misc\\ex_goldequp_coin.lua");	-- ¶Ò»»»Æ½ğ×°±¸½ğÅÆ
Include("\\script\\event\\jiefang_jieri\\201004\\main.lua");
Include("\\script\\event\\jiefang_jieri\\201004\\refining_iron\\Npc.lua") -- Á¶½ğ»î¶¯
Include("\\script\\event\\jiefang_jieri\\201004\\longer.lua") -- Á¶½ğ»î¶¯
Include("\\script\\event\\jiefang_jieri\\201004\\plant\\main.lua") -- Á¶½ğ»î¶¯


-- Ô½ÄÏ0904½â·Å»î¶¯
Include("\\script\\event\\jiefang_jieri\\200904\\zhanshenzhujiu\\jiu_hecheng.lua");
Include("\\script\\event\\jiefang_jieri\\200904\\jinnangshijian\\jinnangshijian.lua");
Include("\\script\\event\\jiefang_jieri\\200904\\denggao\\denggao.lua");
Include("\\script\\event\\jiefang_jieri\\200904\\shuizei\\shuizei.lua");
Include("\\script\\event\\jiefang_jieri\\200904\\taskctrl.lua");

Include("\\script\\event\\guoqing_jieri\\200908\\compose.lua")
Include("\\script\\event\\other\\jilixinwanjia\\200908\\npcdailog.lua")

-- Ô½ÄÏ0905ÉúÈÕ»î¶¯
Include("\\script\\event\\birthday_jieri\\200905\\npc\\npc_liguan_dailog.lua");
Include("\\script\\misc\\vngpromotion\\ipbonus\\ipbonus_2_npc.lua");

Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

Include("\\script\\activitysys\\npcfunlib.lua")

Include("\\script\\task\\killmonster\\killmonster.lua")
Include("\\script\\misc\\eventsys\\type\\npc.lua")

--tinhpn 20100817: Online Award
Include("\\script\\bonus_onlinetime\\head.lua")
Include("\\script\\bonus_onlinetime\\func_onlineaward.lua")
Include("\\script\\vonghoa\\exchangitem\\exchangeitem.lua")
Include("\\script\\vonghoa\\item\\head.lua")
Include("\\script\\traogiaithdnb\\thdnb7.lua");--20100908 haint code function trao giai thdnb
Include("\\script\\baoruongthanbi\\dialogmain.lua")
Include("\\script\\vlkh\\vlkh1.lua")

--tinhpn 20101022: Event Thang 10
Include("\\script\\vng_event\\201010\\head.lua")
Include("\\script\\vng_event\\compensate.lua")
Include("\\script\\vng_event\\traogiai\\vldnb2010\\vlbnb.lua")

--[DinhHQ]
	--[20110107]:trao giai Phuong Anh Hao thang 12 2010
	Include("\\script\\vng_event\\traogiai\\pah_12_2010\\head.lua")
	--[20110124]:Vip account 2011
	Include("\\script\\vng_event\\vip_account_2011\\npc\\lequan.lua")
	--[20110216]:THDNB8
	Include("\\script\\vng_event\\20110215_THDNB8\\vng_thdnb8_award.lua")
	--[20110225]: 8/3/2011
	Include("\\script\\vng_event\\20110225_8_thang_3\\npc\\lequan.lua")
	--[20110311]: NPAH thang 02 2011
	Include("\\script\\vng_event\\20110215_THDNB8\\vng_npah0211.lua")
	
	Include("\\script\\vng_event\\traogiai\\NPAH\\vng_ToolAward.lua")
--tinhpn 20110223:Reset pass ruong
Include("\\script\\vng_feature\\resetbox.lua")
Include("\\script\\vng_event\\traogiai\\vlmc2011\\vlmc2011_main.lua")
--- Mr Loc - 08/03/2023 --
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")
Include("\\script\\event\\2006vm_nationalday\\event.lua")
Include("\\script\\event\\change_destiny\\npc.lua");
Include("\\script\\event\\newyear_2009\\npc_caishen.lua")
Include("\\script\\event\\jiefang_jieri\\200804\\zhanshengqi\\hechengqizi.lua");
Include("\\script\\event\\jiefang_jieri\\200804\\mieshanzei\\lingjiang.lua");
--Include("\\script\\missions\\racegame\\dailog.lua")
Include("\\script\\event\\cookies2007\\event.lua");
Include("\\script\\event\\cookies2007\\event.lua");
Include("\\script\\event\\fenghuo_hero\\jackstraw.lua");
Include("\\script\\event\\fenghuo_hero\\letter.lua");
Include("\\script\\event\\fenghuo_hero\\hero_event.lua");
Include("\\script\\event\\funv_jieri\\200803\\liguan_interface.lua");
Include("\\script\\event\\funv_jieri\\200803\\shenmixianhua.lua");
Include("\\script\\event\\funv_jieri\\200903\\dialog.lua")
Include("\\script\\event\\funv_jieri\\200903\\tuoguan.lua")
Include("\\script\\event\\guoqing_jieri\\200808\\npc_zhangxiansheng.lua")
Include( "\\script\\event\\nanfangjiefangri\\event.lua" )
Include("\\script\\event\\jiaoshi_jieri\\200810\\event.lua")
--Include("\\script\\event\\jiaoshi_jieri\\200910\\huadeng.lua")
Include("\\script\\event\\mid_autumn06\\liguan.lua")
Include("\\script\\event\\birthday_jieri\\200905\\npc\\npc_zhanxin_zunzhe.lua");
Include("\\script\\event\\zhongqiu2007\\item\\yuebinglihe.lua")
Include("\\script\\event\\mengjiang2007\\baixiaolaoren.lua")
Include("\\script\\event\\jxanniversary3\\event.lua");
Include("\\script\\event\\newyear_2007\\newyear_head.lua");
Include("\\script\\event\\pingzi\\200805\\pingzi.lua");
Include("\\script\\event\\newbielvlup\\event.lua");
Include("\\script\\event\\playerlvlup\\event.lua");
Include("\\script\\event\\nationalday_2006\\main.lua");
Include("\\script\\event\\poster\\head.lua");
Include("\\script\\event\\shengdan_jieri\\200811\\repute_reward.lua");
Include("\\script\\event\\spring_2006\\spring_2006_head.lua");
Include("\\script\\event\\springfestival07\\dialog.lua");
Include("\\script\\event\\storm\\award_npc.lua");	--Storm
Include("\\script\\event\\vm_birthplan\\event.lua");
Include("\\script\\event\\teacher_day_200711\\composecard.lua");
Include("\\script\\event\\teachersday06_v\\prize_qingyika.lua");
Include("\\script\\event\\zhongqiu_jieri\\200808\\npc_yueming.lua");
Include("\\script\\event\\qingren_jieri\\200902\\event.lua")
Include("\\script\\global\\yuenan_feiyunrenwu.lua")
Include("\\script\\event\\bingo_machine\\bingo_machine_gs.lua")
Include("\\script\\event\\revival\\event.lua")
Include("\\script\\event\\yn_chunjie\\event.lua");
Include("\\script\\event\\ma_chunjie\\event.lua");

function main()
	dofile("script/global/Â·ÈË_Àñ¹Ù.lua");
-- Link to event
	if (CFG_yn_chunjie	== 1) then
		yn_chunjie()
		return
	end
	if (CFG_ma_chunjie	== 1) then
		ma_chunjie()
		return
	end
	if (CFG_zhongqiu2007	== 1) then
		mainzhongqiu2007_entry()
		return
	end
	if (CFG_mid_autumn06	== 1) then
		au06_lg_award()
		return
	end
	if (CFG_jiefang_jieri2008	== 1) then
		jiefang0804_act()
		return
	end
	if (CFG_jiefang_jieri2009	== 1) then
		jiefang0904_act()
		return
	end
	if (CFG_pingzi	== 1) then
		pingzi_act()
		return
	end
	if (CFG_zhongqiu_jieri_2008	== 1) then
		zhongqiu0808_npc_main()
		return
	end
	if (CFG_birthday_jieri_2009	== 1) then
		birthday_jieri_2009_act()
		return
	end
	if (CFG_2006vm_NationalDay	== 1) then
		vm_NationalDay()
		return
	end
	if (CFG_teachersday06	== 1) then
		--tbDailog:AddOptEntry("Ho¹t ®éng Ngµy Nhµ Gi¸o ViÖt Nam 2006",vt06_prizeenter)
		vt06_prizeenter()
		return
	end
	if (CFG_feiyunrenwu	== 1) then
		--tbDailog:AddOptEntry("Tri ©n c¸c anh hïng hµo kiÖt",v_fy_entrance)
		v_fy_entrance()
		return
	end
	if (CFG_nationalday_2006	== 1) then
		--tbDailog:AddOptEntry("Ho¹t ®éng nationalday_2006",nationalday_2006_main)
		nationalday_2006_main()
		return
	end
	if (CFG_menglan_2006	== 1) then
		--tbDailog:AddOptEntry("Ho¹t ®éng LÔ Vu Lan 2006", v_menglanjie)
		v_menglanjie()
		return
	end
	--if (CFG_revival	== 1) then
	--	onRevival_Player()
	--	return
	--end
-- End link to event

	local nCurDate = tonumber(GetLocalDate("%Y%m%d%H%M"))
	local nNpcIndex = GetLastDiagNpc();
	local szNpcName = GetNpcName(nNpcIndex)
	if NpcName2Replace then
		szNpcName = NpcName2Replace(szNpcName)
	end

	local tbDailog = DailogClass:new(szNpcName)

	if (CFG_PhongVanBaoDien == 1) then
		EventSys:GetType("AddNpcOption"):OnEvent(szNpcName, tbDailog, nNpcIndex)	-- Phong van bao dien
	end

	--[DinhHQ]
	--[20110107]:NhËn th­ëng gi¶i ®Êu Ph­¬ng Anh Hµo
	tbPAH122010_Head:addDialog(tbDailog)
	--[20110124]:Vip account 2011
	tbVNG_VipAcc2011_LeQuan:addDialog(tbDailog)
	--[20110216]:THDNB8
	tbVNG_THDNB8:AddDialog(tbDailog)
	--[20110225]: 8/3/2011
	tbVNGWD2011_LeQuan:AddDialog(tbDailog)
	--[20110311]: NPAH thang 02 2011
	tbVNG_NPAH0211:AddDialog(tbDailog)
	--Trao vßng hµo quang VLMC2011 - Modified by DinhHQ - 20110523
	tbVLMC2011_Tittle:AddDialog(tbDailog)
	tbVngToolAward:AddDialog(tbDailog)	

	if (CFG_ThuongToanServerBossDocCoThienPhong	== 1) then
		G_ACTIVITY:OnMessage("ClickNpc", tbDailog, nNpcIndex)	-- Thuong toan server Boss Doc Co Thien Phong
	end
	if (CFG_GreatNight	== 1) then
		tbDailog:AddOptEntry("§ªm Huy Hoµng", onGreat_Night)
	end
	if (CFG_ChangeDestiny	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng thÇn n«ng ch©n ®¬n", main_ChangeDestiny)
	end
	if (CFG_newyear_2009	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng xu©n 2009", main_newyear_2009)
	end
	if (CFG_qingren_jieri_2009	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng lÔ t×nh nh©n 2009", valentine2009_main)
	end
	if (CFG_newyear_2007	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng xu©n 2007", ny07_entrance)
	end
	if (CFG_jiefang_jieri2010	== 1) then
		tbDailog:AddOptEntry("ChiÕc vâng Tr­êng S¬n", FreedomEvent2010.LingFanSoldierItemDlg, {FreedomEvent2010}) 	
		tbDailog:AddOptEntry("Mua ®¹o cô ngµy chiÕn th¾ng", FreedomEvent2010.LingFanPlantItemDlg, {FreedomEvent2010}) 	
		tbDailog:AddOptEntry("§¹o cô tÊm ¸o chiÕn sü", FreedomEvent2010.LiGuanEventItemDlg, {FreedomEvent2010}) 	
		tbDailog:AddOptEntry("Ho¹t ®éng ­¬m mÇm hµnh phóc", FreedomEvent2010.Dialog, {FreedomEvent2010}) 	
		tbDailog:AddOptEntry("§æi ®¹o cô", FreedomEvent2010.LongerEventItemDlg, {FreedomEvent2010})
		tbDailog:AddOptEntry("Ho¹t ®éng t«i luyÖn thĞp", tbRefiningIron.NpcTalk, {tbRefiningIron}) 	
	end
	if (CFG_cookies2007	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng mïng 3 th¸ng 3",cookies2007_main)
	end
	if (CFG_fenghuo_hero	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng Phong Háa Anh Hïng LÖnh",enter_heroling)
	end
	if (CFG_funv_jieri_2008	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng Ngµy quèc tÕ phô n÷ 08-03",funv_jieri200803_act)
	end
	if (CFG_funv_jieri_2009	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng Ngµy quèc tÕ phô n÷ 08-03",funv_jieri200903_act)
	end
	if (CFG_guoqing_jieri_2008	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng D­ìng sinh bİ phæ",guoqing_jieri_2008_main)
	end
	if (CFG_guoqing_jieri_2009	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng Guoqing0908", Guoqing0908_act)
	end
	if (CFG_nanfangjiefangri	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng 30-4 vµ Quèc tÕ lao ®éng",nanfangjiefangri_main)
	end
	if (CFG_jiaoshi0810	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng Ngµy Nhµ Gi¸o ViÖt Nam 2008",jiaoshi0810_DailogMain)
	end
	--if (CFG_jiaoshi0910	== 1) then
	--	tbDailog:AddOptEntry("Ho¹t ®éng Ngµy Nhµ Gi¸o ViÖt Nam 2008",jiaoshi0810_DailogMain)
	--end
	if (CFG_mengjiang2007	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng TriÖu Håi M·nh T­íng",mengjiang2007_main)
	end
	if (CFG_jxanniversary3	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng jxanniversary3",OnEventJxAnniversary)
	end
	if (CFG_newbielvlup	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng t©n thñ luyÖn cÊp newbielvlup",BTNNewbieLevelUp)
	end
	if (CFG_playerlvlup	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng t©n thñ luyÖn cÊp playerlvlup",BTNPlayerLevelUp)
	end
	if (CFG_poster	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng poster",ShowAwardDialog)
	end
	if (CFG_shengdan_jieri2008	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng shengdan_jieri2008",christmas_repute_main)
	end
	if (CFG_spring_2006	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng spring_2006",mainTalk)
	end
	if (CFG_springfestival07	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng TÕt Nguyªn §¸n 2007",main_entrance)
	end
	if (CFG_storm	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng storm",storm_main)
	end
	if (CFG_superplayeract2007	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng ng­êi ch¬i siªu cÊp",SuperPlayerAct2007)
	end
	if (CFG_vm_birthplan	== 1) then
		tbDailog:AddOptEntry("Chµo mõng 'Vâ L©m TruyÒn Kú' trßn mét tuæi",vm_BirthPlan)
	end
	if (CFG_teacher_day_200711	== 1) then
		tbDailog:AddOptEntry("Ho¹t ®éng ghĞp ch÷ T«n “S­” Träng §¹o",composeCard_TeacherDay200711)
	end
--	tbDailog:AddOptEntry("Tham gia ho¹t ®éng B¶o R­¬ng ThÇn Bİ", BRTB_Dialog_main)
	tbDailog:AddOptEntry("Tham gia ho¹t ®éng", OpenBingoMachine)
--	tbDailog:AddOptEntry("NhËn th­ëng Chung KÕt Vâ L©m §Ö NhÊt Bang", GetBonusVLDNB2010_main)
--	tbDailog:AddOptEntry("NhËn l¹i TiÒn §ång", Compensate_main)
--	if (VH_ActiveDay()==1) then
--		tbDailog:AddOptEntry("Ta ®Õn ®æi vËt phÈm event th¸ng 8", ExChangeItem_main)
--	end
	-- tbDailog:AddOptEntry("Më Pass R­¬ng", ResetBox.ShowDialog, {ResetBox})
	
	--tinhpn 20101022: Event Thang 10
--	if (Event201010:IsActive() == 1) then
--		tbDailog:AddOptEntry("§æi th­ëng ho¹t ®éng th¸ng 10", Event201010.ShowDialog, {Event201010}) 	
--	end
	
	if IsIPBonus() then
		tbDailog:AddOptEntry("Hç trî cho m¸y sö dông CSM", IpBonus)
	end
	
	--tinhpn 20100817: Online Award
--	if (OnlineAward_StartDate() ~= 0 and OnlineAward_Check_TransferLife() ~= 0) then
--		tbDailog:AddOptEntry("Tham gia online nhËn th­ëng", OnlineAward); 
--	end
	
	local ncity = gb_GetTask("MAINCITYCFG", 1);
	local nCurMapID = SubWorldIdx2ID(SubWorld);
	if (ncity >= 1 and ncity <= 7 and nCurMapID == TB_MAINCITY_CITYWAR_T[ncity][2]) then
		tbDailog:AddOptEntry("NhËn phÇn th­ëng dµnh cho Th¸i Thó", maincity_award_entry)	
	end
	if tbJILIWanJia0908:IsActDate() then
		tbDailog:AddOptEntry("Ho¹t ®éng kİch t©n thñ", tbJILIWanJia0908.DailogMain, {tbJILIWanJia0908} )
	end
				
	tbDailog:Show()
end

function jiefang0904_act()
	Say("LÔ Quan: HiÖn ®ang trong thêi gian diÔn ra ho¹t ®éng chµo mõng ngµy gi¶i phãng,bµ con ®ang n¸o nøc ¨n mõng chiÕn th¾ng, ®¹i hiÖp cã muèn tham gia kh«ng nµo?", 6, 
			--"Ta ®Õn nhËn cÈm nang sù kiÖn/jf0904_getjinnangshijian",
			format("Ho¹t ®éng r­îu mõng chiÕn th¾ng/#tbJiefang0904_jiu:OnDailogMain()"),
			"Ho¹t ®éng chinh phôc ®Ønh FanXiPan/about_denggao",
			--"Ho¹t ®éng Tiªu DiÖt Thñy TÆc/about_shuizei",
			"Ta chØ ®Õn xem!/OnCancel");
end
function jiefang0804_act()
	Say("LÔ Quan: HiÖn ®ang trong thêi gian diÔn ra ho¹t ®éng chµo mõng ngµy gi¶i phãng,bµ con ®ang n¸o nøc ¨n mõng chiÕn th¾ng, ®¹i hiÖp cã muèn tham gia kh«ng nµo?", 6, 
			format("Ho¹t ®éng hîp thµnh L¸ cê chiÕn th¾ng/#jiefang_0804_zhanshengqi:main()"),
			format("Ho¹t ®éng ThiÕt Ng­u Lang Nha Béi/#jiefang_0804_mieshanzei:main()"),
			"Ta chØ ®Õn xem!/OnCancel");
end
function funv_jieri200803_act()
	Say("LÔ Quan: Ngµy quèc tÕ phô n÷ 08/03 ®· ®Õn råi, ®¹i hiÖp cã muèn tham gia kh«ng nµo?", 6, 
			"Ho¹t ®éng Gãi hoa/funv_jieri200803_main",
			format("Ho¹t ®éng TÆng hoa/#funv_jieri_shenmi:xianhua()"),
			"Ta chØ ®Õn xem!/OnCancel");
end
function funv_jieri200903_act()
	Say("LÔ Quan: Ngµy quèc tÕ phô n÷ 08/03 ®· ®Õn råi, ®¹i hiÖp cã muèn tham gia kh«ng nµo?", 6, 
			format("Ho¹t ®éng chµo mõng ngµy Quèc TÕ Phô N÷ 8 th¸ng 3/#tbFunv0903:DialogMain()"),
			format("Hép Trang Søc/#tbFunv0903:GetItemByTuoGuan()"),
			"Ta chØ ®Õn xem!/OnCancel");
end
function Guoqing0908_act()
	tbGuoqing0908:ComposeDailogMain()
end
function pingzi_act()
	pingzi0805:main()
end
function birthday_jieri_2009_act()
	Say("LÔ Quan: Ho¹t ®éng “Chµo mõng phiªn b¶n míi” diÔn ra tõ %s ®Õn %s. Ng­¬i muèn t×m hiÓu ho¹t ®éng nµo?", 7, 
			format("Ho¹t ®éng “Chµo mõng phiªn b¶n míi”/#tbBirthday0905:OnDailogMain2()"),
			format("Ho¹t ®éng “Tİn vËt khai m«n”/#tbBirthday0905:OnDailogMain3()"),
			format("Ho¹t ®éng (s¨n b¾t nhİm bĞo ph×)/#tbBirthday0905:OnDailogMain4()"),
			format("Ho¹t ®éng (hç trî t©n thñ)/#tbBirthday0905:OnDailogMain5()"),
			format("NhËn CÈm nang sù kiÖn/#tbBirthday0905:GetJinnang()"),
			"Ta chØ ®Õn xem!/OnCancel");
end

Include([[\script\event\menglan_2006\menglan_2006.lua]]);
function v_menglanjie()
	Say("Quı hãa! Quı hãa! Ta thay mÆt Ph­¬ng tr­îng ThiÕu L©m c¶m ¬n vµ chóc phóc cho ng­¬i!", 7, 
		"Ta muèn d©ng tÆng vßng Kim Liªn Hoa/#v_mljaward(1)",
		"Ta muèn d©ng tÆng vßng Méc Liªn Hoa/#v_mljaward(2)",
		"Ta muèn d©ng tÆng vßng Thñy Liªn Hoa/#v_mljaward(3)",
		"Ta muèn d©ng tÆng vßng Háa Liªn Hoa/#v_mljaward(4)",
		"Ta muèn d©ng tÆng vßng Thæ Liªn Hoa/#v_mljaward(5)",
		"Ta muèn d©ng tÆng vßng Liªn Hoa, mçi hÖ mét c¸i./v_mljaward_all",
		"ChØ lµ hiÕu kú ghĞ qua xem th«i!/OnCancel"
	);
end;

function v_mljaward(nIdx)
	if (CalcEquiproomItemCount(6,1,tab_NPCIdx[nIdx][1] + 5,-1) < 1) then
		Say("Ng­¬i ch¼ng ph¶i muèn d©ng tÆng "..tab_NPCIdx[nIdx][2].." sao? H×nh nh­ ng­¬i kh«ng mang theo "..tab_NPCIdx[nIdx][2].."!", 1, "§Ó ta ®i chuÈn bŞ ®·!/OnCancel")
		return
	end;
	
	local nCount = GetTask(tab_NPCIdx[nIdx][3]);
	if (nCount >= SIMGER_LIMIT) then
		Say("Ng­¬i ®· d©ng tÆng ®ñ sè "..tab_NPCIdx[nIdx][2].." nµy råi! H·y d©ng tÆng lo¹i kh¸c ®i!", 0);
		return
	end;
	
	ConsumeEquiproomItem(1, 6, 1, tab_NPCIdx[nIdx][1] + 5, -1);
	SetTask(tab_NPCIdx[nIdx][3], nCount + 1);
	AddOwnExp(500000);
	Say("Quı hãa qu¸! §©y lµ chót t©m ı mµ Ph­¬ng tr­îng ThiÕu L©m vµ ch­ëng m«n Nga Mi gëi tÆng ng­¬i.", 1, "NhËn lÊy lÔ vËt./OnCancel");
	Msg2Player("B¹n nhËn ®­îc <color=yellow>500000<color> ®iÓm kinh nghiÖm.");
end;

function v_mljaward_all()
	for i = 1, getn(tab_NPCIdx) do
		if (CalcEquiproomItemCount(6,1,tab_NPCIdx[i][1] + 5,-1) < 1) then
			Say("Ng­¬i ch¼ng ph¶i muèn d©ng tÆng "..tab_NPCIdx[i][2].." sao? H×nh nh­ ng­¬i kh«ng mang theo "..tab_NPCIdx[i][2].."!", 1, "§Ó ta ®i chuÈn bŞ ®·!/OnCancel")
			return
		end;
	end;
	
	local nCount = GetTask(TK_LOTUS_ALL);
	if (nCount >= TOGETHER_LIMIT) then
		Say("ThËt c¸m ¬n ng­¬i! Nh­ng 12 Bao l× x× cña ta ®· tÆng ng­¬i hÕt råi.", 0);
		return
	end;
	
	for i = 1, getn(tab_NPCIdx) do
		ConsumeEquiproomItem(1, 6, 1, tab_NPCIdx[i][1] + 5, -1);
	end;
	SetTask(TK_LOTUS_ALL, nCount + 1);
	
	AddOwnExp(1000000);
	AddItem(6, 1, 1136, 1, 0, 0, 0); --¼ÓÒ»¸ö´ó·ç°ü£»
	Say("Quı hãa qu¸! §©y lµ chót t©m ı mµ Ph­¬ng tr­îng ThiÕu L©m vµ ch­ëng m«n Nga Mi gëi tÆng ng­¬i.", 1, "NhËn lÊy lÔ vËt./OnCancel");
	Msg2Player("B¹n nhËn ®­îc <color=yellow>1000000<color> ®iÓm kinh nghiÖm vµ 1 <color=yellow>Bao l× x×<color>");
end;

-- ½ÚÈÕÁĞ±í
aryHoliday = {	-- ½ÚÈÕÊ±¼ä, ·ûºÏ½ÚÈÕÊ±¼äËùµ÷º¯ÊıÃû, ÖØ¸´ÁìÀñÆ·µÄÌáÊ¾ÎÄ±¾ 
				{ 20040822, onHoliday_QiXi, "C¶nh ®Ñp trêi trong! Hai b¹n sao kh«ng ®i ch¬i lÔ, cßn ë l¹i ®©y lµm g×?" }
				-- ÆäËü½ÚÈÕ
			 };
	
function valentineGift()
	if (GetBit(GetTask(67),24) == 1) then
		if (GetBit(GetTask(1313),1) ~= 1) then
			SetTask(1313, SetBit(GetTask(1313), 1, 1))
			Talk(1, "", "<#> H«m nay lµ mét ngµy h¹nh phóc cho nh÷ng ®«i l­¬ng duyªn! Ta cã mãn quµ nµy tÆng cho nh÷ng ai ®· kÕt h«n! Chóc c¸c vŞ 'B¸ch niªn giai l·o' ")
			-- ËÍ2¸ö¡°ĞÄĞÄÏàÓ¡·û¡±
			for i = 1, 2 do
				AddItem( 6, 1, 18, 1, 0, 0 ,0);
			end
			Msg2Player( "<#>B¹n nhËn ®­îc 2 T©m T©m T­¬ng ¸nh phï!" );
			-- ËÍ9¶ä¡°Ãµ¹å»¨¡±
			for i = 1, 9 do
				AddItem( 6, 0, 20, 1, 0, 0 ,0);
			end	
			Msg2Player( "<#>B¹n nhËn ®­îc  9 b«ng hoa hång!" );
			-- 50¼¶ÒÔÉÏÍæ¼Ò¼ÓËÍ1¸ö¡°ÌìÉ½ÓñÂ¶¡±
			if( GetLevel() >= 50 ) then
				AddItem(6, 1, 72, 1, 0, 0, 0);
				Msg2Player( "<#>B¹n nhËn ®­îc mét b×nh Thiªn S¬n B¶o Lé!" );
			end
		else
			Talk(1, "", "<#> Ng­¬i ch¼ng ph¶i ®· nhËn quµ råi sao? Nh­êng cho ng­êi kh¸c víi chø!")
		end
	else
		Talk(1, "", "<#> Ng­¬i ch­a kÕt h«n, kh«ng thÓ nhËn ®­îc quµ!")
	end
end		 	
---------------- È¡Ïû ----------------------------------------
function OnCancel()
end

function LiguanLog(object)
	WriteLog(date("%H%M%S") .. ": Tµi kho¶n:" .. GetAccount() .. ", nh©n vËt:" .. GetName() .. "," .. object);
end
