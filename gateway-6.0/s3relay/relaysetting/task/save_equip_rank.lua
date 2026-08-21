Include("\\script\\misc\\rank\\rank.lua")

function TaskShedule()
	-- 设置方案名称
	TaskName( "Save Equip Rank At Monday 4:00" );
	TaskInterval(1440);
	TaskTime(4,10);
	TaskCountLimit( 0 );
	-- 输出启动消息
	OutputMsg( "LUU XEP HANG VAO THU HAI HANG TUAN VAO LUC 04:00" );
end

function TaskContent()
	local nCurWeekDay = tonumber(date("%w"));

	if (nCurWeekDay == 0 or nCurWeekDay == 1 or nCurWeekDay == 2 or nCurWeekDay == 3 or nCurWeekDay == 4 or nCurWeekDay == 5 or nCurWeekDay == 6 or nCurWeekDay == 7) then --星期一
		tbRankClass:SortAndSave("FUNC_RANK_EQUIPVALUE");
	end
	
end

function GameSvrConnected(dwGameSvrIP)
end
function GameSvrReady(dwGameSvrIP)
end