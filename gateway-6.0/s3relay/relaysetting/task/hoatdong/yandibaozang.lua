-- Ñ×µÛµÄ±¦²Ø±ÈÈü¶¨Ê±Æ÷
--Ã¿ÌìÏ¢Îç2µãµ½Ï¢Îç12µãÕûµã´¥·¢

--by Ð¡ÀË¶µ¶µ
--2007.10.22
INTERVAL_TIME = 60	-- Ã¿Ð¡Ê±´¥·¢
Include("\\script\\gb_modulefuncs.lua")
Include("\\script\\leaguematch\\timetable.lua")
Include("\\script\\leaguematch\\head.lua")

function GetNextTime()	--Ã¿ÌìÏ¢Îç1µã55µ½ÍíÉÏ23µã55 ´¥·¢±¨Ãû
	-- ¸Ä±äÑ×µÛÐÔÄÜ²Î¼ÓµÄ±¨ÃûÊ±¼ä-Modifiled by AnhHH - 20110802
    local hour = tonumber(date("%H"));
    if (hour == 24) then
    	hour = 1;
    elseif(hour <= 1) then
    	hour = 1
    else
    	hour = hour + 1;
    end
    return hour, 25;
end

function TaskShedule()
	TaskName("YANDIBAOZANG");	
	
	-- 60·ÖÖÓÒ»´Î
	TaskInterval(INTERVAL_TIME);
	-- ÉèÖÃ´¥·¢Ê±¼ä
	local h, m = GetNextTime();
	TaskTime(h, m);
	OutputMsg(format("=====> HOAT DONG [VIEM DE BAO TANG] SE BAT DAU VAO LUC %d:%d...", h, m));
	-- Ö´ÐÐÎÞÏÞ´Î
	TaskCountLimit(0);
	-- OutputMsg("Æô¶¯×Ô¶¯¹ö¶¯¹«¸æ...");
end

function TaskContent()
	local TB_YDBZ_DATE_START =	--Æô¶¯³¡´Î(Ê±)
	{
		2,3,4,5,6,7,8,9,10,11,12,13,14,16,18,20,22,
	}
	
	local nhour = tonumber(date("%H"))
	for nindex,ndate_hour in TB_YDBZ_DATE_START do
		-- ¸Ä±äÑ×µÛÐÔÄÜ²Î¼ÓµÄ±¨ÃûÊ±¼ä -Modifiled by AnhHH - 20110802
		if (nhour == ndate_hour) then
			
--			if gb_GetModule("YANDIBAOZANG") == 1 and gb_GetModule("YANDIBAOZANG_TALK") == 1 then
				OutputMsg("[YANDIBAOZANG]"..tonumber(date("%H"))..":55 StartSignUp...");
				-- ´¥·¢GameServerÉÏµÄ½Å±¾
				--GlobalExecute("dw LoadScript([[\\settings\\trigger_challengeoftime.lua]])");
				GlobalExecute("dwf \\script\\missions\\yandibaozang\\yandibaozang_trigger.lua YDBZ_OnTrigger()");
				szMsg = "Viªm ®Õ b¶o tµng ho¹t ®éng ®· më vµ b¾t ®Çu b¸o danh, c¸c §¹i HiÖp nhanh ch©n ®i BiÖn Kinh gÆp B×nh B×nh C« N­¬ng ®Ó ghi danh, thêi gian ghi danh lµ 5 phót."
				GlobalExecute(format("dw AddLocalCountNews([[%s]], 2)", szMsg))
--			end
			break;
		end
	end
end

function GameSvrConnected(dwGameSvrIP)
end
function GameSvrReady(dwGameSvrIP)
end
