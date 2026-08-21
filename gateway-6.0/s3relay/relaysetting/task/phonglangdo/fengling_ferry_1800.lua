function TaskShedule()
	--设置方案名称
	TaskName("Phong L╪g ч")
	TaskTime(18, 0);
	
	--设置间隔时间，单位为分钟
	TaskInterval(1440) --60分钟一次
	
	--设置触发次数，0表示无限次数
	TaskCountLimit(0)
	OutputMsg("=====> [phonglangdo] Phong Lang Do 18h");
end

function TaskContent()
    GlobalExecute("dwf \\script\\missions\\fengling_ferry\\fldmap_boat1.lua fenglingdu_main()")
	OutputMsg("=====> [phonglangdo] Phong Lang Do 18h");
end

function GameSvrConnected(dwGameSvrIP)
end
function GameSvrReady(dwGameSvrIP)
end