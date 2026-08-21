if MODEL_GAMECLIENT ~= 1 then
	return
end

function OnClickIcon_0()
	OpenActivityGuideUi()
	--IconBar_SetTwinkle(1, 0)
end

function OnClickIcon_1()
	local szScript = "\\script\\event\\bingo_machine\\bingo_machine_c.lua"
	Require(szScript)
	DynamicExecute(szScript, "BingoMachine:ApplyOpenWindon", "")
end

function OnClickIcon_2()
	local szScript = "\\script\\event\\bingo_machine\\bingo_machine_c.lua"
	Require(szScript)
	DynamicExecute(szScript, "BingoMachine:ApplyOpenShop", "")
end

function OnClickIcon_3()
	OpenPetUi()
end

function OnClickIcon_4()
	local szScript = "\\script\\event\\prize\\ui.lua"
	Require(szScript)
	DynamicExecute(szScript, "tbLoginPrize:ApplyData", "")
end

function OnClickIcon_5()
	OpenFuncPrize()
end

function OnClickIcon_6()
	SwitchTaskTrace ()
end