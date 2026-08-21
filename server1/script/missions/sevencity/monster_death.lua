Include("\\script\\missions\\sevencity\\war.lua")
Include("\\script\\missions\\sevencity\\simsevencity.lua")

-- Áú�?ù�?�?Íö½�?±¾
-- OnDeath cua tru. 2 case:
-- 1) Player giet: PlayerIndex hop le + GetWorldPos tra ve map trong FIELD_LIST
--    -> default flow (field:KillMonster(player) -> Monster:Down -> Long Tru [Destroy])
-- 2) Bot/sim/npc giet: PlayerIndex invalid HOAC player khong o trong map TTDC nao
--    -> HandleBotKillPillar(killed_idx, attackerIndex)
--      Trong HandleBotKillPillar, neu attackerIndex la sim keo xe cua player
--      thi treat nhu player capture, khong thi respawn defender bang cu.
function OnDeath(killed_index, attackerIndex)
	local pIdx = PlayerIndex or 0
	local validPlayer = 0
	local mapid = 0
	local player = nil
	
	print(format("[SEVENCITY] OnDeath killed_idx=%d PlayerIndex=%d attacker=%d",
		killed_index, pIdx, attackerIndex or 0))
	
	if (pIdx > 0) then
		player = Player:New(pIdx)
		if (player) then
			local pMap, _, _ = player:GetWorldPos()
			if (pMap and pMap > 0) then
				-- Check map thuoc FIELD_LIST TTDC
				if (FIELD_LIST) then
					for i = 1, getn(FIELD_LIST) do
						if (FIELD_LIST[i] == pMap) then
							validPlayer = 1
							mapid = pMap
							break
						end
					end
				end
				-- Fallback: neu khong co FIELD_LIST van coi la valid neu map > 0
				if (validPlayer == 0 and pMap > 0) then
					validPlayer = 1
					mapid = pMap
				end
			end
		end
	end
	
	print(format("[SEVENCITY] OnDeath validPlayer=%d mapid=%d", validPlayer, mapid))
	
	if (validPlayer == 1) then
		-- PLAYER kill -> default flow
		local field = BattleWorld:FindField(mapid)
		if (field ~= nil) then
			print("[SEVENCITY] OnDeath -> PLAYER kill, field:KillMonster")
			field:KillMonster(player)
		else
			BattleWorld:Log(format("[ERROR SEVENCITY]MonsterDeath: field(%d) not found", mapid))
		end
		return
	end
	
	-- BOT/SIM/NPC-KILL DETECTED - pass attackerIndex de tra owner cua sim
	print("[SEVENCITY] OnDeath -> BOT-KILL, call HandleBotKillPillar")
	if (SimThatThanh and SimThatThanh.HandleBotKillPillar) then
		SimThatThanh:HandleBotKillPillar(killed_index, attackerIndex)
	else
		BattleWorld:Log("[SEVENCITY] BOT-KILL but SimThatThanh handler not loaded")
	end
end
