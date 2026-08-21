-- ´óºì°ü¹¦ÄÜ		ºì°üÊ¹ÓÃ
-- By NobitaXD(2024-01-23)

tbma_chunjie = {
			{ "<#> Bét ®¸", 0.20, 956 },
			{ "<#> L­u huúnh", 0.16, 957 },
			{ "<#> Than cñi", 0.16, 958 },
			{ "<#> GiÊy hång", 0.16, 959 },
			{ "<#> Tim ph¸o", 0.16, 960 },
			{ "<#> Háa d­îc mËt t~ch", 0.16, 961 },
}
--Ôö¼ÓÒ»×ÖÎªÊ¦¿¨
function ma_chunjie_addi()
	local base = 0;
	local sum = 0;
	local gift_index = 0;
	for i = 1, getn( tbma_chunjie ) do
		base = base + tbma_chunjie[i][2] * 100000;
	end
	local rannum = random(base);
	for i = 1, getn(tbma_chunjie) do
		sum = tbma_chunjie[i][2] * 100000 + sum
		if ( sum >= rannum ) then
			gift_index = i;
			break
		end;
	end;
	if ( gift_index ~= 0 ) then
		AddEventItem(tbma_chunjie[gift_index][3])
		Msg2Player("<#> B¹n nhËn ®­îc mét c¸i"..tbma_chunjie[gift_index][1])
		WriteLog(date("%y-%m-%d,%H:%M,").."ACCOUNT:"..GetAccount()..",NAME:"..GetName()..",use zhongqiu_lihe , get "..tbma_chunjie[gift_index][1])
	else
		Say("Sao kh«ng cã g× hÕt vËy?", 0)
	end
end;

----------------

TB_firecracker_ID = {
	[1031] = "firecracker_1",
	[1032] = "firecracker_2",
	[1033] = "firecracker_3",
	[1034] = "firecracker_4",
}

function firecracker_1()
	CastSkill(251, 1)
	Msg2Player("Chóc mõng n¨m míi. Haha!");
end;

function firecracker_2()
	AddSkillState(450, 30, 1, 32400)
	Msg2Player("B¹n ®­îc t¨ng 30 ®iÓm may m¾n trong 30 phót.");
end;

function firecracker_3()
	AddSkillState(440, 1, 1, 32400);
	Msg2Player("B¹n ®­îc nh©n ®«i kinh nghiÖm trong 30 phót.");
end;

function firecracker_4()
	local nPreservedPlayerIndex = PlayerIndex;
	local nMemCount = GetTeamSize();
	
	if (nMemCount == 0 ) then
		AddSkillState(440, 1, 1, 32400);
		AddSkillState(450, 30, 1, 32400)
		Msg2Player("B¹n ®­îc nh©n ®«i kinh nghiÖm + 30 ®iÓm may m¾n trong 30 phót.");
		return 0
	end

	for i = 1, nMemCount do
		PlayerIndex = GetTeamMember( i );
		AddSkillState(440, 1, 1, 32400);
		AddSkillState(450, 30, 1, 32400)
		Msg2Player("B¹n ®­îc nh©n ®«i kinh nghiÖm + 30 ®iÓm may m¾n trong 30 phót.");
	end;
	
	PlayerIndex = nPreservedPlayerIndex;
	return 0
end;
