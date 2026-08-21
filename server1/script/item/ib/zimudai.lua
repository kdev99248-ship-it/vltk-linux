function main(nItemIdx)
	if (GetPartnerBagLevel() == 10) then
		Say("<#>Tói tö mÉu cña ®¹i hiÖp ®· ®­îc kİch ho¹t råi", 0);
		return 1;
	end
	local szMsg = "<#>Sö dông vËt phÈm nµy ®Ó kİch ho¹t tói tö mÉu <color=yellow>vÜnh viÔn<color>?";
	Say(szMsg, 2, "§ång ı kİch ho¹t/#recharge("..nItemIdx..")", "Hñy bá /cancel");
	return 1;
end

function recharge(nItemIdx)
	if (RemoveItemByIndex(nItemIdx) ~= 1) then
		return
	end
	SetPartnerBagLevel(10);
	Say("<#>Kİch ho¹t thµnh c«ng, tói tö mÉu cã thÓ sö dông <color=yellow>vÜnh viÔn<color>", 0);
end

function cancel()
end