MONEY_ADDLIFETIME = 1000000

function Checkup()
	-- 因为通过使用物品增加聊天室时间，检查金钱的代㈦放到\\item\\chatroom\\pay.lua中
	return 1
end

function Consume()
	if (DelCommonItem(6,1,1062) == 1) then
		Msg2Player("<#><color=green>N鉯 chuy謓 phi誱 th蕋 th猰 l骳 th祅h c玭g<color>!")
		return 1
	end
	return 0
end
