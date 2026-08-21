MONEY_CREATECHATROOM = 50000

function Checkup()
	if (GetCash() < MONEY_CREATECHATROOM) then
		Msg2Player("<#>Trong hµnh trang kh«ng cã ®ñ <color=yellow>" .. MONEY_CREATECHATROOM.." l­îng.<color>")
		return 0
	end
	return 1
end

function Consume()
	return Pay(MONEY_CREATECHATROOM)
end
