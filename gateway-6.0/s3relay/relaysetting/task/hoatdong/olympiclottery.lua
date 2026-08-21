szMainString = "Lottery";
nMaxServerCount = 8;

function GameSvrConnected(dwGameSvrIP)
	SyncLottery(dwGameSvrIP, szMainString);
end

function GameSvrReady(dwGameSvrIP)
end

function TaskShedule()
	--设置方案名称
	TaskName("HOAT DONG Olympic")
	
	--设置间隔时间，单位为分钟
	TaskInterval(10)
	
	--设置触发次数，0表示无限次数
	TaskCountLimit(0)
end

function TaskContent()
	OutputMsg("--------------HOAT DONG DOAN OLYMPIC "..date().."-----------------");
	CheckLotteryState("RelaySetting\\Lottery.txt", szMainString, nMaxServerCount);
	--OutputMsg("-----------------------------------------------------------------------");
end

