-- Edited by Giangleloi WwW.ClbGamesVN.COM

G_COIN = 20 -- 1 lan rut duoc bao nhieu tien dong, mac dinh 20, by Giangleloi
function OnExtPointChange_Proc(nExtPointIndex, nChangeValue)
	if (ExtFunTab[nExtPointIndex + 1] == nil) then
		--print("Error!!!!!!!!, No ExtPoint Fun On"..nExtPointIndex)
		--WriteGoldLog("Importacne Error!!!!!!!!, No ExtPoint CallFun On"..nExtPointIndex..", "..GetAccount().." "..GetName().." nExtPointIndex"..nExtPointIndex.." nChangeValue"..nChangeValue, 0, 0, 0, 0)
		return 0;
	end
	ExtFunTab[nExtPointIndex + 1](nChangeValue)
	return 1;
end

function OnPayYuanBao(nChangeValue)
	nValue = -nChangeValue
	if (nValue == 1) then
	--ÄÃÒøÔª±¦
AddStackItem(5, 6, 1, 147, 6, 1, 1, 1)
				AddStackItem(5, 6, 1, 147, 7, 1, 1, 1)
		AddStackItem(G_COIN,4,417,1,1,0,0,0)--Add G_COIN tien dong
		SaveNow(); -- Á¢¼´´æÅÌ
		WriteGoldLog( GetAccount().."("..GetName()..") MAKE a SILVER with a LOW CARD", 0, 1, 0, 0 );
		local nCurValue = GetExtPoint(1)
		WriteLog(date("%Y%m%d %H%M%S").."\t".." Tµi kho¶n"..GetAccount().."\t"..GetName().."\t".." lÊy 20 tiÒn ®ång"..nCurValue*20)
 		Say("Kh¸ch quan ®· rót thµnh c«ng 20 TiÒn ®ång! Xin kiÓm tra l¹i!", 0)
		Msg2Player("NhËn ®­îc 20 TiÒn ®ång!");
 	elseif( nValue > 1) then
			WriteGoldLog(GetAccount().."("..GetName()..") PAY EXPOINT ERROR ON YUANBAO , MUST PAY(1) BUT PAY("..nValue..")!!!!", 0,0,0,0)
			Msg2Player("Cã lçi x¶y ra trong qu¸ tr×nh quy ®æi! Xin liªn hÖ GM ®Ó söa lçi!")
	else
			WriteGoldLog(GetAccount().."("..GetName()..") PAY EXPOINT ERROR ON YUANBAO PAYVALUE <= 0", 0,0,0,0)
			Say("Xin lçi, kh¸ch quan kh«ng kh«ng cã göi TiÒn ®ång ë chç bæn trang!", 0)
	end
end

ExtFunTab=
{
	nil,
 	OnPayYuanBao,
 	nil,
 	nil,
 	nil,
 	nil,
 	nil,
 	nil
};
