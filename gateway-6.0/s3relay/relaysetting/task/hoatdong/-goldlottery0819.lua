STARTHOUR = 20;
STARTMIN = 0;

function getCurrTime()
	return date( "%m%d" );
end

szMainString = "GoldLottery";
szResultString = "GoldLtyResult"

function TaskShedule()
	--ÉèÖÃ·½°¸Ãû³Æ
	TaskName("Olympic Gold")
	TaskInterval(1440)
	
	
	-- 20µã00·Ö¿ªÕ½
	TaskTime(STARTHOUR , STARTMIN);
	
	TaskCountLimit(0);
end

--"GoldLottery" timestamp id  Account|RoleName

function TaskContent()
	OutputMsg("----------------Lay Hoang Kim Ve So 'Xo So Vang'---------------------------");
	OutputMsg(date());
	if (tonumber(getCurrTime()) ~= 820) then
		return
	end

	randomseed( tonumber( date("%m%d%H%M%S") ) )
	RecordString = szMainString.."0819" 
	ResultString = szResultString.."0819"
	result , P1, P2 = GetCustomDataFromSDB(ResultString, 0,0,"ii")
	
	if (result > 0 ) then
		OutputMsg("Nhan thuong Hoang Kim Ve So ID 08-19 "..P2.."-"..P1)
		NotifySDBRecordChanged(ResultString, 0, 0, 1)
	else
		GenGoldLottery(RecordString, ResultString)
	end

	OutputMsg("--------------------------------------------");
end

function GenGoldLottery(RdString, RsString)
	nCount , key1, key2 = GetRecordCount(RdString,0,0,0,0);
	OutputMsg("GoldLottery Count "..nCount);
	if (nCount > 0) then
		nRand =	random(1, nCount)
		bFound , P1,P2 = GetRecordInfoFromNO(RdString, 0, 0, 0, 0, nRand)
		if(bFound == 1) then
			bResult , m = GetCustomDataFromSDB(RdString, P1, P2, "i");		
			str = format("Hoang Kim ve so nhan thuong ID vi %d-%d", P1, P2);
			success = SaveCustomDataToSDBOw(RsString , 0, 0, "ii", P1,P2);
			NotifySDBRecordChanged(RsString, 0, 0 ,1);
			strNews = format("dw AddLocalNews ( [ [Hoµng Kim vÐ sè tróng th­ëng %d ngµy %d th¸ng ®· më[%d-%d]. Xin mêi tíi LÔ quan nhËn th­ëng !]], 1) ", P2,P1)
			GlobalExecute(strNews);
			OutputMsg(str);
		else
			OutputMsg("Kiem tra thong tin, khong tim duoc nguoi trung thuong.")
		end
	else
		OutputMsg("Khong co nguoi trung thuong nen khong nhan thuong.")
	end
end;
