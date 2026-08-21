Include("\\script\\missions\\challengeoftime\\include.lua")
function OnDeath(index)
	local count = GetMSPlayerCount(MISSION_MATCH) - 1;
	if (count < 0) then
		count = 0;
	end
	SetMissionV(VARV_PLAYER_COUNT, count);
	if (GetMissionV(VARV_NPC_COUNT) ~= 0) then
		local name = GetMissionS(VARS_TEAM_NAME);
		if (name == GetName()) then
			broadcast(name .. " §éi tr­ëng ®· tö vong!");
		end
		
		if (count == 0) then
			broadcast(name .. " Toµn ®éi tö vong hÕt!");
		end
	end
	DelMSPlayer(MISSION_MATCH, 1);
	Msg2MSAll(MISSION_MATCH, GetName() .. " Kh«ng may t¹i trËn tö vong!");	
	SetLogoutRV(0)	
	NewWorld(11,3207,4978)
end