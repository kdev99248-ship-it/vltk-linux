--Ô½ÄÏ½ÌÊ¦½Ú»î¶¯Í·ÎÄ¼ş

tbyn_chunjie = {
			{ "<#> M·ng cÇu", 0.50, 951 },
			{ "<#> Dõa", 0.25, 952 },
			{ "<#> §u ®ñ", 0.12, 953 },
			{ "<#> Xoµi", 0.08, 954 },
			{ "<#> Sung", 0.05, 955 },
}
--Ôö¼ÓÒ»×ÖÎªÊ¦¿¨
function yn_chunjie_addi()
	local base = 0;
	local sum = 0;
	local gift_index = 0;
	for i = 1, getn( tbyn_chunjie ) do
		base = base + tbyn_chunjie[i][2] * 100000;
	end
	local rannum = random(base);
	for i = 1, getn(tbyn_chunjie) do
		sum = tbyn_chunjie[i][2] * 100000 + sum
		if ( sum >= rannum ) then
			gift_index = i;
			break
		end;
	end;
	if ( gift_index ~= 0 ) then
		AddEventItem(tbyn_chunjie[gift_index][3])
		Msg2Player("<#> B¹n nhËn ®­îc mét tr¸i"..tbyn_chunjie[gift_index][1])
		WriteLog(date("%y-%m-%d,%H:%M,").."ACCOUNT:"..GetAccount()..",NAME:"..GetName()..",use zhongqiu_lihe , get "..tbyn_chunjie[gift_index][1])
	else
		Say("Sao kh«ng cã g× hÕt vËy?", 0)
	end
end;
