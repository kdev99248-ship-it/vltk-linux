Include("\\script\\item\\newyear_2009\\head.lua");
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function main()
	newyear0901_resettask();
	local ndate = tonumber(GetLocalDate("%Y%m%d"));
	if (CFG_newyear_2009	==	0) then
		Msg2Player("VÀt ph»m nµy Æ∑ qu∏ hπn.");
		return 0;
	end
	SetTask(newyear0901_TSK_GetExpUpLimit, 300000);
	Say("ßπi hi÷p c„ th” thu Æ≠Óc kinh nghi÷m cao nh t lµ 3 t˚.", 0);
end