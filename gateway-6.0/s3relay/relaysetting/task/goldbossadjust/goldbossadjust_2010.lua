
Include("\\script\\event\\goldboss_adjust_2011\\boss_initialize.lua")

function TaskShedule()
	-- 设置方案名称
	TaskName( "MAKE GOLDBOSS 20:10" );
	TaskInterval( 1440 );
	TaskTime( 20, 10 );
	TaskCountLimit( 0 );
	-- 输出启动消息
	OutputMsg( "=====> BOSS Hoang Kim zhangxuan XUAT HIEN:  20:10" );
end

function TaskContent()
	makeboss_onlyone_pos(1)
	OutputMsg( "=====> BOSS Hoang Kim jinshiliang XUAT HIEN:  20:10 (goldbossadjust_2010.lua)" );
end

function GameSvrConnected(dwGameSvrIP)
end
function GameSvrReady(dwGameSvrIP)
end
