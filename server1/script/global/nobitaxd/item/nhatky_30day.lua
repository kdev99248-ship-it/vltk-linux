
Include("\\script\\activitysys\\playerfunlib.lua")
function main()
	if PlayerFunLib:CheckLevel(10,"default",">=") ~= 1 then
		return 1
	end
	PlayerFunLib:AddSkillState(966,1,3,46656000,1)
	PlayerFunLib:AddSkillState(979,1,3,46656000,1)
	-- PlayerFunLib:AddSkillState(967,1,3,46656000,1)
	PlayerFunLib:AddSkillState(1208,1,3,46656000,1)
	PlayerFunLib:AddSkillState(314,1,3,46656000,1)
	PlayerFunLib:AddSkillState(892,1,3,46656000,1)
	-- PlayerFunLib:AddSkillState(1697,1,3,1080*60*24,1) ---- 24h
	
	WriteLog(date("%Y%m%d %H%M%S").."\t".."Sö dông NhÊt Kû Cµn Kh«n Phï".."\t".. GetAccount().."\t"..GetName())
end