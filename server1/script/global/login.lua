Include("\\script\\global\\login_head.lua")
-- µÇ¢¼½Å±¾
-- By: LaiLiGao(2004-06-20)
-- Update: Dan_Deng(2004-07-09) Ìí¼Ó×Ô¶¯¸üÐ¢¼¼ÄÜ¹¦ÄÜ
-- Update: FanZai ¸ÄÓÃÐ¢µÄ»úÖÆ£¬Ö»ÐèÈ¥µôInclude¾Í¿ÉÒÔÊµÏÖ¹¦ÄÜ¿ª¹Ø


--Ò»°ãÖ»ÐèÐÞ¸Ä£¨Ìí¼Ó/É¾³ý£©ÕâÀïµÄIncludeÎÄ¼þ£º
--£¨ÔÚÎÄ¼þÖÐÖ´ÐÐÒ»Ï¢login_add(fun, n_time)¼´¿É£¬Àý×Ó²Î¼û"\\script\\missions\\leaguematch\\wlls_login.lua"£©

--Include("\\script\\global\\nobitaxd\\xephang\\top10_all.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_activity_bonus.lua")
--------------------------------------------------------------------------------------
Include("\\script\\global\\login_old.lua")	--¾ÉµÄLogin½Å±¾£¨°üº¬¶µ¸ö»î¶¯£©
Include("\\script\\missions\\leaguematch\\wlls_login.lua")	--WLLSÎäÁÖÁªÈü
Include("\\script\\misc\\extpoint_loginmsg\\login_msg.lua")
Include("\\script\\global\\offline_login.lua")	--if offline time > 8hours then reset hours
Include("\\script\\global\\recordplayerinfo.lua")
Include("\\script\\nationalwar\\login.lua")
Include("\\script\\misc\\daiyitoushi\\toushi_resetbase.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\global\\playerlist.lua")
Include ("\\script\\global\\login_hint.lua")	--µÇ¢½»î¶¯ÌáÊ¾
--================================================================
Include("\\script\\tasktrace\\tasktrace.lua")
Include("\\script\\activitysys\\g_activity.lua")	


if (GetProductRegion() ~= "vn") then
	Include("\\script\\global\\chuangong_login.lua")
	Include("\\script\\task\\lv120skill\\head.lua")	-- 120¼¶¼¼ÄÜÈÎÎñ

	-- LLG_ALLINONE_TODO_20070802 ´ýÈ·ÈÏ
	Include("\\script\\battles\\battle_login.lua")	--ËÎ½ðÈÙÓþ½±ÀøµÄÌáÊ¾
end

if (GetProductRegion() == "cn_ib") then
	Include("\\script\\misc\\spreader\\emigration.lua")
	Include("\\script\\misc\\lost_item\\takelostitem.lua")
	Include([[\script\item\ib\tishenzhiren.lua]])	-- ÌæÉíÖ½ÈË
	Include("\\script\\item\\ib\\zimudai.lua");
end

Include("\\script\\tong\\tong_login.lua");
Include("\\script\\item\\tianziyuxi.lua");	-- ÌìÖ®Óñçô
Include("\\script\\misc\\taskmanager.lua")
Include("\\script\\misc\\eventsys\\type\\player.lua")

--tinhpn 20100817: Online Award
Include("\\script\\bonus_onlinetime\\head.lua")
--tinhpn 20110223:Reset pass ruong
Include("\\script\\vng_feature\\resetbox.lua")
Include("\\script\\vng_feature\\top10\\vngtop10.lua");
Include("\\script\\global\\nobitaxd\\gm\\gm_script.lua")
Include("\\script\\rankexp\\rankexp.lua") 

function main(bExchangeIn)	
	SendExpRanking()	
	AddMagic(210,1)
	if PartyClearPlayer and PlayerIndex then PartyClearPlayer(PlayerIndex) end   -- [2026-07-02] login/re-login: clear party bot ket voi index nay (re-login xai lai index cu -> bot stale khong dinh nua)
	--============================Skill Kh¸ng ¢m  ============================
	local seris = GetSeries()
	if seris == 0 then --hÖ kim
	AddSkillState(1995,30,1,279936000,1)--18*60*60*24*30=46656000 30 ngµy
	end

	local seris = GetSeries()
	if seris == 1 then --hÖ méc
	AddSkillState(1996,30,1,279936000,1)--18*60*60*24*30=46656000 30 ngµy
	end

	local seris = GetSeries()
	if seris == 2 then --hÖ thñy
	AddSkillState(1997,30,1,279936000,1)--18*60*60*24*30=46656000 30 ngµy
	end

	local seris = GetSeries()
	if seris == 3 then --hÖ háa
	AddSkillState(1998,30,1,279936000,1)--18*60*60*24*30=46656000 30 ngµy
	end

	local seris = GetSeries()
	if seris == 4 then --hÖ thæ
	AddSkillState(1999,30,1,279936000,1)--18*60*60*24*30=46656000 30 ngµy
	end

	if GetAccount() == "gm01" then
		NewWorld(53,1621, 3190)
	end
	local W,X,Y = GetWorldPos();
	local nMapId = W;	
	if ( nMapId == 341 ) or ( nMapId == 162 ) then
			Msg2Player("N¬i ®©y ®å th­îng tuyÕn s¾p trë vÒ thµnh...");
			SetRevPos(19);		--ÉèÖÃÖØÉúµã
			UseTownPortal();        --Ö´ÐÐ»Ø³Ç
		end		
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- gm login
	tbAloneScript:GMLoginInGame();
	--add_timer_mns()
--	Ladder_ClearLadder(10296)	
--	XepHang()
	logplayer("dulieu/login/LoginSuccess_HwD_IP_"..date("%d_%m_%Y")..".txt",(""..date("%y-%m-%d_%H:%M:%S").." - TK : ["..GetAccount().."] - NV : ["..GetName().."] - IP : ["..GetIP().."] - HwD : ["..GetIP().."]"))
	-- Usser login
	-- Add lenh bai Tan thu
	if (CalcEquiproomItemCount(6,1,4258,-1) == 0) then
		local nItemIndex = AddItem(6,1,4258,1,0,0);
		SetItemBindState(nItemIndex, -1);
	end;
	-- Ho tro tan thu
	if	((GetLevel() == 1) and CFG_HoTroTanThu == 1)	then
		HoTroTanThu()
	end;
	-- them bang theo doi nhiem vu
	open_task_trace()

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	--tinhpn 20110223:Reset pass ruong
	ResetBox:AnnounceResetBoxDate()
	--tinhpn 20100817: Online Award
	if (OnlineAward_StartDate() == 1 and OnlineAward_Check_TransferLife() ~= 0) then
		Msg2Player("Ngµi cã thÓ nhËn lÊy phÇn th­ëng online mçi ngµy!")
		OnlineAward_ResetDaily()
		OnlineAward_SummaryOnlineTime()
		OnlineAward_StartTime()
	end
	
	PlayerList:AddPlayer(PlayerIndex)
	--ÔØÈëÈ«²¿login½Å±¾
	if (TB_LOGIN_FUN[0]) then
		for i = 1, getn(TB_LOGIN_FUN[0]) do
			local func = TB_LOGIN_FUN[0][i]
			if (func) then
				func(bExchangeIn)
			end
		end
	end
	
	EventSys:GetType("OnLogin"):OnPlayerEvent(0, PlayerIndex, bExchangeIn)
	G_ACTIVITY:OnMessage("OnLogin", PlayerIndex)
	
	
	for i = 1, getn(TB_LOGIN_FILEFUN) do
		local reg = TB_LOGIN_FILEFUN[i]
		DynamicExecute(reg[1], reg[2], PlayerIndex, bExchangeIn)
	end
	TaskManager:ResetUseGroup()
	LoginDelaySync(1)  -- 1 ±íÊ¾ÐèÒªÑÓÊ±Í¬²½Êý¾Ý, 0 ±íÊ¾²»ÐèÒª
	-- ÇëÎðÔÚ´Ëº¯ÊýÖÐÖ±½ÓÌí¼Ó¢ß¼­´¦Àí£¬Çë·â×°³Éº¯Êý²¢Í¨¹ýlogin_add·ÅÖÃµ½TB_LOGIN_FUN[0]Êý×éÀï
end

-------------------------------------------
--  ¹¦ÄÜ£ºµÇ¢¼Ê±£¬ÑÓÊ±Í¬²½Ò»Ð©²»Ó°ÏìÏµÍ³ÔËÐÐµÄÊý¾Ýµ½¿Í»§¶Ë£¬¼õÉÙµÇ¢¼ºÄ·ÑµÄÊ±¼ä
--  Ä¿Ç°ÑÓÊ±Ê±¼äÎª2Ãë(¼´£ºÖ´ÐÐmain_delaysyncµÄ¼ä¸ô£ºÁ½Ãë)
--- ²ÎÊý£ºnStep ±íÊ¾µ±Ç°ÊÇµÚ¼¸´ÎÍ¬²½
-- ·µ»Ø£º0 - ±íÊ¾Í¬²½Î´½áÊø£¬ÏµÍ³ÔÚ±¾´Îµ÷ÓÃÍê³Éºó£¬ÈÔ»áÔÙ´Îµ÷ÓÃ main_delaysync
--		 1 - ±íÊ¾ËùÓÐÍ¬²½½áÊø
function main_delaysync(nStep)	
	if (nStep < 1 or nStep > getn(TB_LOGIN_FUN)) then
		print("main_delaysync error: "..nStep.." funccount:"..getn(TB_LOGIN_FUN));
		return 1;
	end
	
	--ÔËÐÐµÚnStep´ÎÑÓÊ±Í¬²½µÄËùÓÐº¯Êý
	if (TB_LOGIN_FUN[nStep]) then
		for i = 1, getn(TB_LOGIN_FUN[nStep]) do
			if (TB_LOGIN_FUN[nStep][i]) then TB_LOGIN_FUN[nStep][i]() end
		end
	end

	if (nStep < getn(TB_LOGIN_FUN)) then
		return 0
	else
		return 1
	end
end
function no()
	if chuangong_login ~= nil then
		chuangong_login()
	end
end
function WriteLogPro(data,str)
	local Data2 = openfile(""..data.."", "a+");
	write(Data2,tostring(str));
	closefile(Data2);
end
function logplayer(zFile,szMsg)
  local handle = openfile(zFile,"a")
  write(handle,format("%s\n",szMsg));
  closefile(handle);
 end