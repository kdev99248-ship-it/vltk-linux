function TaskShedule()
	TaskName("2009Xinnian_FuLuShou");
	TaskInterval(60);
	local nhour = tonumber(date("%H"));
	local nstarth = 0;
	if nhour >= 23 then
		nstarth = 06;
	else
		tb_xmas2009_strattime = {06,19};
		for ni,nh in tb_xmas2009_strattime do
			if nh >= nhour then
				nstarth = nh;
				break
			end
		end
	end
	
	TaskTime(nstarth, 0);
	OutputMsg(format("HOAT DONG TIM KIEM 3 VI THAN %d:%d Start...",nstarth,0));
	TaskCountLimit(0);
end

function TaskContent()
	local ndate = tonumber(date("%y%m%d%H"));
	if ndate < 09011612 or ndate > 29021519 then
		return 
	end
	
	local nhm = tonumber(date("%H%M"))
	
	if nhm >= 0600 and nhm < 1300 then
		--Í¨¹ýpass
	elseif nhm >= 1900 and nhm < 2000 then
		--Í¨¹ýpass
	else
		return
	end
	
	local nrand = random(1, 2);
	local narry = random(1, 6);
	
	GlobalExecute(format("dwf \\script\\event\\chunjie_jieri\\200901\\fulushou\\findnpc.lua chunjie0901_findnpc(%d, %d, %d)",nrand, ndate, narry));
	
	local szMsg = "Tr­íc m¾t chóng ta 3 vÞ thÇn ®ang t×m víi nhau, cïng tiÕn lªn thiªn ®×nh b¸i kiÕn Ngäc hoµng ®¹i ®Õ, c¸c vÞ nh©n sÜ cïng nhau trî gióp bän hä ®i.";
	GlobalExecute(format("dw AddLocalNews([[%s]])", szMsg));
	GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg));
end

function GameSvrConnected(dwGameSvrIP)
end

function GameSvrReady(dwGameSvrIP)
end
