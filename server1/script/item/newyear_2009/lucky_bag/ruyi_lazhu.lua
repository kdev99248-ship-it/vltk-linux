IncludeLib("SETTING"); --‘ÿ»ÎSETTINGΩ≈±æ÷∏¡Óø‚
Include("\\script\\item\\newyear_2009\\head.lua");
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function main()
	local ndate = tonumber(GetLocalDate("%Y%m%d"));
	if (CFG_newyear_2009	==	0) then
		Msg2Player("VÀt ph»m nµy Æ∑ qu∏ hπn.");
		return 0;
	end
	AddSkillState(440, 1, 1, 64800*8);
end