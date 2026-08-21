--长歌门禁地　祭坛任务
Include("\\script\\gb_taskfuncs.lua")
LG_PARTNER_JITAN_NAME = "祭坛"
function GetNextTime()
    local hour = tonumber(date("%H"));
    if (hour == 23) then
    	hour = 0;
    else
    	hour = hour + 1;
    end
    return hour, 0;
end

function TaskShedule()
	TaskName( "长歌门禁地　祭坛任务" );
	--启动后的正点开始
	local h, m = 19,00;
	TaskTime(h, m);
	TaskInterval( 60 );
	TaskCountLimit( 0 );
	for i = 1, 5 do
		gb_SetTask(LG_PARTNER_JITAN_NAME, i, 0)
	end
	-- 输出启动消息
	OutputMsg( "TRUONG CA MON CAM DIA : TE DAN NHIEM VU");
end

function TaskContent()
	for i = 1, 5 do
		gb_SetTask(LG_PARTNER_JITAN_NAME, i, 1)
	end
	GlobalExecute("dw Msg2SubWorld ( [ [Trng ca m玭 c蕀 a, S竧 Уn Linh L鵦  s鑞g l筰, h緉 產ng g鋓 ng b鋘,mang theo ng b鋘 v祇<color=yellow>Trng ca m玭 c蕀 a <color> x﹎ nh藀 th竚 hi觤 c蕀 a.]]) ")
end

function GameSvrConnected(dwGameSvrIP)
end
function GameSvrReady(dwGameSvrIP)
end
