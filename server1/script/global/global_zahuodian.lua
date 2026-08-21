
function store_sel_extend()
	local tbOpp = { 
			"Giao dŞch/yes",
			"Ho¹t ®éng cöa hµng /HuoDongyes", 
			"Kh«ng giao dŞch/no"
			};
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if (nDate >= 20070202 and nDate <= 20500225) then
		tinsert(tbOpp, 1, "Mua thiÖp chóc TÕt/BuySpringFestival07Card");
	end;
	
	if (nDate >= 20070314 and nDate <= 20500321) then
		tinsert(tbOpp, 1, "Mua Kim th¹ch/buy_collect_juanzhou")
	end;
	return tbOpp;
end;

function store_sel_village_extend()
	local tbOpp = {
			"Giao dŞch/yes",
		"Ho¹t ®éng cöa hµng /HuoDongyes",
		"Ta ®Õn nhËn nhiÖm vô S¬ nhËp/zboss",
		"Th«i kh«ng cÇn ®©u/no",
			};
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if (nDate >= 20070314 and nDate <= 20500321) then
		tinsert(tbOpp, 1, "Mua Kim th¹ch/buy_collect_juanzhou")
	end;
	return tbOpp;
end;

function BuySpringFestival07Card()
	Sale(148);
end;

function buy_collect_juanzhou()
	Sale(165);
end;
function HuoDongyes() 
Sale(141,3); --179
end; 