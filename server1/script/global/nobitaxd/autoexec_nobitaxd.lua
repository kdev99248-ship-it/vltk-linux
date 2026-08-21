--new_npc = {{1849,80,4,53,1622,3184,0,"T©n Thñ Quan",0,"\\script\\global\\nobitaxd\\npc\\npcthunghiem.lua"},}

function add_npc_nobitaxd()
	add_nobitaxd(new_npc)
end

------------------------------------------------------------------------------------------------------------------------------
function add_nobitaxd(tbnpc)
	for i = 1 , getn(tbnpc) do
		Mid = SubWorldID2Idx(tbnpc[i][4]);
		if (Mid >= 0 ) then
			TabValue5 = tbnpc[i][5] * 32;
			TabValue6 = tbnpc[i][6] * 32;
			local nNpcIdx = AddNpc(tbnpc[i][1],tbnpc[i][2],Mid,TabValue5,TabValue6,tbnpc[i][7],tbnpc[i][8]);
			SetNpcScript(nNpcIdx, tbnpc[i][10]);
		end;
	end;
end