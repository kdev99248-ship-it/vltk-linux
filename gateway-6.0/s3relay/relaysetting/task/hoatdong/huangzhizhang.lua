Include("\\script\\gb_taskfuncs.lua")
GN_EVENTNAME = "HOAT DONG HOANG CHI CHUONG"
GN_HUANG_EVENTID = 1
GN_HUANG_SWITH = 2
GN_HUANG_DATE = 3
TB_HUANGZHIZHANG_EVENT = {
		"THAM GIA TONG KIM",
		"NHIEM VU TIN SU",
		"KHIEU CHIEN THOI GIAN",
		"NHIEM VU DA TAU",
		--"Í¬°é¾çÇéÈÎÎñÐÞÁ¶Æª¡¢Í¬°éÐÞÁ¶ÈÎÎñ",
	}
	
TB_HUANGZHIZHANG_RATE = {
		50,
		0,
		25,
		25,
}

function GetNextTime()
    local hour = tonumber(date("%H"));
    if (hour == 23) then
    	hour = 0;
    else
    	hour = hour + 1;
    end
    return hour, 25;
end
function TaskShedule()
	--ÉèÖÃ·½°¸Ãû³Æ
	TaskName(GN_EVENTNAME)

	h, m = GetNextTime()
	TaskTime(h, m);
	--ÉèÖÃ¼ä¸ôÊ±¼ä£¬µ¥Î»Îª·ÖÖÓ
	TaskInterval(30)
	--ÉèÖÃ´¥·¢´ÎÊý£¬0±íÊ¾ÎÞÏÞ´ÎÊý
	TaskCountLimit(0)
--Ã¿´ÎÖØÆôÇå³ý»î¶¯ÄÚÈÝ
	if (gb_GetTask(GN_EVENTNAME, GN_HUANG_EVENTID) == 0) then
		gb_SetTask(GN_EVENTNAME, GN_HUANG_DATE, 0)
	end
	gb_SetTask(GN_EVENTNAME, GN_HUANG_SWITH, 0)
	OutputMsg("=====> HOAT DONG HOANG CHI CHUONG")
end

function TaskContent()
	local nDate = tonumber(date("%m%d"))
	local nHour = tonumber(date("%H%M"))
	--»î¶¯Ê±¼äÔÚ21£º00~23£º00
	--00:00Í¨Öªµ±Íí»î¶¯ÄÚÈÝ
	
	local event_date = gb_GetTask(GN_EVENTNAME, GN_HUANG_DATE)
	--Ã¿ÌìµÚÒ»´Î»î¶¯Ê±¼äÄÚ£¬Ëæ»úÑ¡»î¶¯
	if (event_date == 0 or event_date ~= nDate) then
		local nrand = random(1, 100);
		local nsum = 0;
		local event_event = 1;
		for i = 1, getn(TB_HUANGZHIZHANG_RATE) do
			nsum = nsum + TB_HUANGZHIZHANG_RATE[i];
			if (nsum >= nrand) then
				event_event = i;
				break
			end;
		end;
		gb_SetTask(GN_EVENTNAME, GN_HUANG_EVENTID, event_event)
		gb_SetTask(GN_EVENTNAME, GN_HUANG_DATE, nDate)
		OutputMsg(date().."DEM HUY HOANG, DEM HUY HOANG HOAT DONG LA "..TB_HUANGZHIZHANG_EVENT[event_event])
		local szMsg = format("[Ho¹t ®éng §ªm Huy Hoµng]: Tèi nay, ho¹t ®éng <color=yellow>%s<color> gÊp ®«i nhËn th­ëng v× %s, b¾t ®Çu lóc 19h45, c¸c vÞ ®¹i hiÖp nhanh ®i tham gia.",
						"Hoµng Chi Ch­¬ng",
						TB_HUANGZHIZHANG_EVENT[event_event]);
		GlobalExecute(format("dw AddLocalNews([[%s]])", szMsg))
		GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
		return
	end
	
	--·Ç»î¶¯Ê±¼ä¹Ø±Õ¿ª¹Ø
	if (nHour < 1945 or nHour >= 2145) then
		if (gb_GetTask(GN_EVENTNAME, GN_HUANG_SWITH) ~= 0) then
			gb_SetTask(GN_EVENTNAME, GN_HUANG_EVENTID, 0)
			gb_SetTask(GN_EVENTNAME, GN_HUANG_SWITH, 0)
			local szMsg = format("Tèi nay, <color=yellow><color> gÊp ®«i nhËn th­ëng ho¹t ®éng ®· kÕt thóc.", "Hoµng Chi Ch­¬ng");
			GlobalExecute(format("dw AddLocalNews([[%s]])", szMsg))
			GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
		end
		return
	end
	
	--ÔÚ20£º55Ê±¼ä¿ªÆô»î¶¯¿ª¹Ø
	if (nHour >= 1945 and nHour <= 2145 + 3) then
		local event_event = gb_GetTask(GN_EVENTNAME, GN_HUANG_EVENTID)
		gb_SetTask(GN_EVENTNAME, GN_HUANG_SWITH, 1)
		OutputMsg(date().."BAT DAU HOAT DONG DEM HUY HOANG")
		local szMsg = format("[Ho¹t ®éng §ªm Huy Hoµng]: Ho¹t ®éng <color=yellow>%s<color> ®· míi më, néi dung ho¹t ®éng v× %s. mäi ng­êi nhanh ®i tham gia.",
							"Hoµng Chi Ch­¬ng",
							TB_HUANGZHIZHANG_EVENT[event_event])
		GlobalExecute(format("dw AddLocalNews([[%s]])", szMsg))
		GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
	end
--	GlobalExecute("dw AddLocalNews([[[»Ô»ÍÖ®Ò¹»î¶¯]£º»ÍÖ®Õ¢»î¶¯ÕýÔÚ½øÐÐÖÐ£¬¸÷Î»Íæ¼Ò¿ÉÒÔÔÚÀñ¹Ù´¦²éÑ¯½±ÀøË«±¶µÄ»î¶¯ÄÚÈÝ£¬Çë¸÷Î»¾¡ÇéÏíÊÜ¶À¹¢ÃËÖ÷µÄÀ¡Ôù¡£]])")
end

function GameSvrConnected(dwGameSvrIP)
end
function GameSvrReady(dwGameSvrIP)
end
