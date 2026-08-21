----------------------------------------------------------------
--FileName:	npcdeath.lua
--Creater:	firefox
--Date:		2005-09-01
--Comment:	Weekend Event: City Defense War
--			Function: NPC Death Script
-----------------------------------------------------------------
--rank = 1, 2, 3, 4, 5 (Soldier, Captain, Vanguard, General, Boss)
Include("\\script\\missions\\newcitydefence\\head.lua")

ITEM_DROPRATE_TABLE = { 	-- Drop rate table
						{ { 6,1,1686,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Metal War Soul
						{ { 6,1,1687,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Wood War Soul
						{ { 6,1,1688,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Water War Soul
						{ { 6,1,1689,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Fire War Soul
						{ { 6,1,1690,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Earth War Soul
						{ { 6,1,1691,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Metal Armor
						{ { 6,1,1692,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Wood Armor
						{ { 6,1,1693,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Water Armor
						{ { 6,1,1694,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Fire Armor
						{ { 6,1,1695,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Earth Armor
						{ { 6,1,1696,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Metal Blade
						{ { 6,1,1697,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Wood Blade
						{ { 6,1,1698,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Water Blade
						{ { 6,1,1699,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Fire Blade
						{ { 6,1,1700,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Earth Blade
						{ { 6,1,1701,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Marching Pill
						{ { 6,1,1702,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Small Return Pill
						{ { 6,1,1703,1,0,0 }, { 0.0005,0.0010,0.0020,0.0100,0.0200 } },	-- Five Flower Dew
					  }
					  
NPC_RANK_DROPRATE_TABLE = { 1, 2, 3, 4, 5 } -- Drop times per rank

function OnDeath( nNpcIndex )
	local state = GetMissionV(MS_STATE);
	if (state ~= 2) then
		return
	end
	
	-- X? lý xe t?ng riêng
	if rank == 6 then
		Msg2MSAll(MISSIONID, format("<color=yellow>%s cña ®èi ph­¬ng ®· bÞ ph¸ hñy!!!<color>", tbSOLDIER_NAME[6]))
		-- V?n tính ?i?m cho ng??i gi?t xe t?ng
		cd_addtotalpoint(tbKILLNPC_AWARD[rank])
		return
	end
	
	-- Thêm ?i?m chi?n công (t??ng t? bt_addtotalpoint)
	cd_addtotalpoint(tbKILLNPC_AWARD[rank])
	
	-- Drop item
	dropItem(nNpcIndex, rank, PlayerIndex);
	
	-- Decrease NPC counter on map
	local nCountNpc = 0
	if rank == 1 and  GetMissionV( MS_RESTCOUNTNPC_1 ) > 0 then 
		nCountNpc = GetMissionV( MS_RESTCOUNTNPC_1 ) - 1
		SetMissionV( MS_RESTCOUNTNPC_1, nCountNpc )
		-- print("Soldier killed, new REST:", nCountNpc)
	elseif rank == 2 and  GetMissionV( MS_RESTCOUNTNPC_2 ) > 0 then
		nCountNpc = GetMissionV( MS_RESTCOUNTNPC_2 ) - 1
		SetMissionV( MS_RESTCOUNTNPC_2, nCountNpc )
		-- print("Captain killed, new REST:", nCountNpc)
	elseif rank == 3 and  GetMissionV( MS_RESTCOUNTNPC_3 ) > 0 then
		nCountNpc = GetMissionV( MS_RESTCOUNTNPC_3 ) - 1
		SetMissionV( MS_RESTCOUNTNPC_3, nCountNpc )
		-- print("Vanguard killed, new REST:", nCountNpc)
	elseif rank == 4 and  GetMissionV( MS_RESTCOUNTNPC_4 ) > 0 then
		nCountNpc = GetMissionV( MS_RESTCOUNTNPC_4 ) - 1
		SetMissionV( MS_RESTCOUNTNPC_4, nCountNpc )
		-- print("General killed, new REST:", nCountNpc)
	end

	
	-- Check mission end condition (boss spawned and all NPCs killed)
	if GetMissionV(MS_BOSS5_DOWN) == 1 then
		local total_rest = 0
		for i = 1, 5 do
			total_rest = total_rest + GetMissionV(MS_RESTCOUNTNPC_1 + i - 1)
		end
		if total_rest <= 0 then
			Msg2MSAll(MISSIONID, "<color=yellow>Chñ so¸i qu©n ®Þch ®· bÞ tiªu diÖt!!!")
			SetMissionV(MS_CITYDEFENCE, 1)
			CloseMission(MISSIONID)
		end
	end

end

function dropItem( nNpcIndex, nNpcRank, nBelongPlayerIdx )
	local nItemCount = getn( ITEM_DROPRATE_TABLE );
	local nMpsX, nMpsY, nSubWorldIdx = GetNpcPos( nNpcIndex );
	local oldPlayerIdx = PlayerIndex;
	for nDropTimes = 1, NPC_RANK_DROPRATE_TABLE[nNpcRank] do
		local nRandNum = random();
		local nSum = 0;
		for i = 1, nItemCount do
			nSum = nSum + ITEM_DROPRATE_TABLE[i][2][nNpcRank];
			if( nSum > nRandNum ) then
				DropItem( nSubWorldIdx, nMpsX, nMpsY, nBelongPlayerIdx, ITEM_DROPRATE_TABLE[i][1][1], ITEM_DROPRATE_TABLE[i][1][2], ITEM_DROPRATE_TABLE[i][1][3], ITEM_DROPRATE_TABLE[i][1][4], ITEM_DROPRATE_TABLE[i][1][5], ITEM_DROPRATE_TABLE[i][1][6], ITEM_DROPRATE_TABLE[i][1][7] );
				break
			end
		end
	end
	-- for boss
	if nNpcRank == 5 then
		PlayerIndex = nBelongPlayerIdx;
		local nBaseExp = 1000000 -- 1 million exp
		local nExpPlayerKillBoss = 50 * nBaseExp
		local nCountPHL = 1 -- Boss Reward Item PHL count
		local szName = GetName();
		local szMonPhai = getMonPhai(PlayerIndex)
		local nZhanGong = tonumber(GetTask(TSKID_PLAYER_ZHANGONG)) or 0
		local szTitleName, _ = getTitleByPoint(PlayerIndex, nZhanGong)
		local nPoint_Award_Boss = 1000
		Msg2MSAll(MISSIONID, "<color=red>/////////////////////////////////<color>")
		Msg2MSAll(MISSIONID, "<color=yellow>==============================<color>")
		Msg2MSAll(MISSIONID, format("<color=green>Chóc mõng <color=yellow>%s %s %s<color> ®· tiªu diÖt Chñ so¸i qu©n ®Þch, th­­ëng <color=yellow>"..nPoint_Award_Boss.."<color> ®iÓm !!!", szTitleName, szMonPhai, szName))
		Msg2MSAll(MISSIONID, "<color=yellow>==============================<color>")
		Msg2MSAll(MISSIONID, "<color=red>/////////////////////////////////<color>")
		SetTask(TSKID_PLAYER_ZHANGONG, nZhanGong + nPoint_Award_Boss) -- Add 1000 battle points for killing boss
		if GetTeamSize() >= 2 then 
			for k=1,GetTeamSize() do 
				PlayerIndex = GetTeamMember(k);
				AddPlayerExp(nExpPlayerKillBoss);
				AddStackItem(nCountPHL,6,1,4907,1,0,0); -- Boss Reward Item PHL
				Msg2Player("§éi cña b¹n giÕt boss nªn nhËn ®­îc <color=green>"..nExpPlayerKillBoss.."<color> ®iÓm kinh nghiÖm vµ <color=green>"..nCountPHL.."<color> Phong Háa LÖnh");
			end
		else
			AddPlayerExp(nExpPlayerKillBoss);
			AddStackItem(nCountPHL,6,1,4907,1,0,0);
			Msg2Player("B¹n giÕt boss nªn nhËn ®­îc <color=green>"..nExpPlayerKillBoss.."<color> ®iÓm kinh nghiÖm vµ <color=green>"..nCountPHL.."<color> Phong Háa LÖnh");
		end	
		--local tbplayer = GetPlayerAroundNpc(nNpcIndex,50); -- Get players around boss
		--if tbplayer and getn(tbplayer) > 0 then 
		--	for k = 1, getn(tbplayer) do 
		--		PlayerIndex = tbplayer[k];
		--		AddPlayerExp(nExpPlayerKillBoss);
		--		AddStackItem(nCountPHL,6,1,4907,1,0,0);
		--		Msg2Player("B¹n cïng giÕt boss nªn nhËn ®­îc <color=green>"..nExpPlayerKillBoss.."<color> ®iÓm kinh nghiÖm vµ <color=green>"..nCountPHL.."<color> Phong Háa LÖnh.");
		--	end
		--end
	end
	PlayerIndex = oldPlayerIdx;
end
