IncludeLib("SETTING")

function main()	
	if (GetSkillState(440) ~= -1) then
		Say("B¹n ®ang sö dông <color=yellow>Tiªn Th¶o Lé §Æc BiÖt<color>, kh«ng thÓ sö dông <color=green>Tiªn Th¶o Lé<color> th­êng nµy!.", 0)
		return 1
	end

	if (GetSkillState(1217) ~= -1) then
		Say("B¹n ®ang sö dông <color=green>Tiªn Th¶o Lé<color>, kh«ng cÇn dïng thªm n÷a!!!.", 0)
		return 1
	end
	AddSkillState(1217, 1, 1, 64800)
	Msg2Player("§· sö dông <color=green>Tiªn Th¶o Lé<color>, hiÖu lùc trong 1 giê.")
	return 0
end
