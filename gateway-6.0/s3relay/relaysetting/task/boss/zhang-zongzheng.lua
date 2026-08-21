Include("\\RelaySetting\\Task\\boss\\bosswhere.lua")
Include("\\RelaySetting\\Task\\boss\\GoldBossHead.lua");
Sid = 511
Interval = 1440;
Count = 0;
StartHour=-1;
StartMin=-1;

function NewBoss()
	str = "GÇn ®©y quan phñ ph¸i Tr­¬ng T«ng ChÝnh ®i tra n¶ téi ph¹m!"
	GlobalExecute(format("dw AddLocalNews([[%s]])", str));
	return 1, where["zhangzongzheng"][Random(getn(where.zhangzongzheng))+1], 511, 90;
end;



