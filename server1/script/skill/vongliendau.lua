TAB_SKILL = {
	top1=
	{	
		allres_p = {10, -1, 0},
		lifemax_v = {1000, -1, 0},

		},
	top2=
	{	
		-- allres_p = {3, -1, 0},
		lifemax_v = {1000, -1, 0},
		
		},
	top3=
	{	
		-- allres_p = {3, -1, 0},
		lifemax_v = {700, -1, 0},
		},
	top4=
	{	
		-- allres_p = {3, -1, 0},
		lifemax_v = {500, -1, 0},
		},
	vong5doctk=
	{	
		deadlystrikeenhance_p = {20, -1, 0},
		poisonenhance_p = {30, -1, 0},
		},
	tuiyte=
	{	
		lifereplenish_v = {25, -1, 0},		
		manareplenish_v = {25, -1, 0},	
		--lifereplenish_v = CheckTuiYTeSL(),		
		--manareplenish_v = CheckTuiYTeNL(),	
	},			
}

-----------------------------------------------------------
--函数GetSkillLevelData(levelname, data, level)
--levelname：魔法属性名称
--data：技能名称
--level：技能等级
--return：当技能名称为data，技能等级为level
--			时的魔法属性levelname所需求的三个参数的具体值
-----------------------------------------------------------
function CheckTuiYTeSL()
	local w,x,y = GetWorldPos()
	if (w == 396) or (w == 560) or (w == 397) or (w == 540) or (w == 570) or (w == 541) then
		return {0, -1, 0}
	else
		return {25, -1, 0}
	end
end
function CheckTuiYTeNL()
	local w,x,y = GetWorldPos()
	if (w == 396) or (w == 560) or (w == 397) or (w == 540) or (w == 570) or (w == 541) then
		return {0, -1, 0}
	else
		return {25, -1, 0}
	end
end

function GetSkillLevelData(levelname, data, level)
	local skill = TAB_SKILL[data]
	if (not skill) then
		return ""
	end
	local tb = skill[levelname]
	if (not tb) then
		return ""
	end
	return format("%d,%d,%d", tb[1], tb[2], tb[3])
end
