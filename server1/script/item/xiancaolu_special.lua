IncludeLib("SETTING")

function main()	
	if (GetSkillState(440) ~= -1) then
		Say("B¹n ®ang sö dông <color=yellow>Tiªn Th¶o Lé §Æc BiÖt<color>, kh«ng cÇn dïng thªm n÷a!!!.", 0)
		return 1
	end
	if (GetSkillState(1217) ~= -1) then
		RemoveSkillState(1217)		
	end
	AddSkillState(440, 1, 1, 64800 * 8)
	Msg2Player("§· sö dông <color=yellow>Tiªn Th¶o Lé §Æc BiÖt<color>, hiÖu lùc trong 8 giê.")
	return 0
end
