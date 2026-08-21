Include("\\script\\missions\\challengeoftime\\include.lua")
Include("\\script\\lib\\log.lua")
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\settings\\trigger_challengeoftime.lua")

--=========================== so cap - don dau =====================================
function want_playboat_socap_dondau()
	OldSubWorld = SubWorld
	OldPlayer = PlayerIndex
	local totalboat = 0
	local freeboat = 0
	local startboat = 0
	local blevel = 0 -- 0 la so cap. 1 la cao cap
	
	if(GetLevel() < 50) then	-- kiem tra cap do 
		Say("Xin lçi! §¼ng cÊp d­íi 50 kh«ng thÓ tham gia 'NhiÖm vô Th¸ch thøc thêi gian'.",0);
		return
	end

	OnTrigger() -- chay khoi dong vuot ai

	PlayerIndex = OldPlayer
	for i = 1, getn(map_map) do
		sub = SubWorldID2Idx(map_map[i])
		if (sub >= 0) then
			totalboat = totalboat + 1
			SubWorld = sub
			local state = GetMissionV(VARV_STATE)
			if (state > 0) then
				startboat = 1
			end
			if ( state == 1 and GetMSPlayerCount(MISSION_MATCH, 1) == 0 and map_isadvanced[map_map[i]] == blevel) then
				freeboat = freeboat + 1
			end
		end
	end

	local strlevel = ""
	if (blevel == 0) then
		strlevel = "V­ît ¶i C¸ Nh©n"
	else
		strlevel = "V­ît ¶i (cao cÊp - ®¬n ®Êu)"
	end
	

	if (startboat == 1) then
		Say(""..strlevel.." Yªu cÇu: <enter>1 v¹n l­îng<enter>1 s¸t thñ gi¶n",2, "Ph¶i! Ta muèn tham gia./dragon_join_socap_dondau", "Kh«ng cÇn/onCancel")
		return
	end
end

function dragon_join_socap_dondau()
	local blevel = 0 -- 0 la so cap. 1 la cao cap
	local havesword = 0
	local nNowDate = tonumber(GetLocalDate("%y%m%d"));
	
	if(GetTask(1551) == nNowDate) then
		if (GetTask(1550) <= 0) then
			Say("NhiÕp ThÝ TrÇn: H«m nay nhiÖm vô th¸ch ®Êu ®· lµm hÕt råi, ®îi ngµy mai h·y ®Õn l¹i.",0);
			return
		end
	end

	if(GetLevel() < 50) then
		Say("Xin lçi! §¼ng cÊp d­íi 50 kh«ng thÓ tham gia 'NhiÖm vô Th¸ch thøc thêi gian'.",0);
		return
	end

	if (GetCash() < 10000) then
		Say("Tham gia ho¹t ®éng “V­¬t ¶i” cÇn <color=red>1 v¹n l­îng<color>. ChuÈn bÞ ®ñ tiÒn råi h·y quay l¹i!", 0)
		return
	end

	local havesword = CalcEquiproomItemCount( 6, 1, 400, 90 )
		
	if (havesword < 1) then
		Say("NhiÕp ThÝ ThÇn: H·y chuÈn bÞ thªm 1 s¸t thñ gi¶n råi h·y quay l¹i !",0)
		return
	end

	local OldPlayer = PlayerIndex
	
	PlayerIndex = PlayerIndex
	local bmbrlevel = 0
	local MemberNowDate = tonumber(GetLocalDate("%y%m%d"));
	
	PlayerIndex = OldPlayer

	OldSubWorld = SubWorld

	for i = 1, getn(map_map) do
		sub = SubWorldID2Idx(map_map[i])
		if (sub >= 0) then
			SubWorld = sub
			local state = GetMissionV(VARV_STATE)
			if ( state == 1 and GetMSPlayerCount(MISSION_MATCH, 1) == 0 and blevel == map_isadvanced[map_map[i]] ) then
			
			end
				PlayerIndex = PlayerIndex
				w,x,y = GetWorldPos()
				SetMissionV(VARV_SIGNUP_WORLD, w)
				SetMissionV(VARV_SIGNUP_POSX, x)
				SetMissionV(VARV_SIGNUP_POSY, y)
				SetMissionS(VARS_TEAM_NAME,GetName())
				SetMissionS(VARS_TEAMLEADER_FACTION,GetLastFactionNumber())
				SetMissionS(VARS_TEAMLEADER_GENDER,GetSex())
				
				Pay(10000)
				ConsumeEquiproomItem( 1, 6, 1, 400, 90)
				
				local w,x,y = GetWorldPos();
				if w==208 then
					
				else
					local MemberNowDate = tonumber(GetLocalDate("%y%m%d"));
					if(GetTask(1551) ~= MemberNowDate) then
						SetTask(1550,COUNT_LIMIT);
						SetTask(1551,MemberNowDate);
					end
					SetTask(1550,GetTask(1550)-1);
					JoinMission(MISSION_MATCH, 1)
				end

				G_ACTIVITY:OnMessage("SignUpChuangguan", PlayerIndex, blevel + 1)
					--Ghi log c¸c tÝnh n¨ng key - Modified By DinhHQ - 20120410
				PlayerFunLib:AddTaskDaily(3079, 1)
				if PlayerFunLib:GetTaskDailyCount(3079) > 1 then
					tbLog:PlayerActionLog("TinhNangKey","BaoDanhVuotAiThuPhi")
				else
					tbLog:PlayerActionLog("TinhNangKey","BaoDanhVuotAiMienPhi")
				end

				local ndate = tonumber(GetLocalDate("%H"))
				if ndate <= 22 and ndate >= 10 and blevel == 1 then
					SetMissionV(VARV_BATCH_MODEL,1)
				else
					SetMissionV(VARV_BATCH_MODEL,0)
				end

				tbLog:PlayerActionLog("EventChienThang042011","BaoDanhVuotAi")-- ±¨ÃûÈÕÖ¾
				return
		end
	end

	SubWorld = OldSubWorld
	PlayerIndex = OldPlayer
	local strlevel ="";
	if (blevel == 0) then
		strlevel = " 'NhiÖm vô Th¸ch thøc thêi gian' C¸ Nh©n "
	else
		strlevel = " 'NhiÖm vô Th¸ch thøc thêi gian' Cao cÊp "
	end
	Say("Xin lçi! HiÖn t¹i khu vùc <color=red>"..strlevel.."<color>®· kh«ng cßn chç. Xin ®îi vßng sau!",0)
end
