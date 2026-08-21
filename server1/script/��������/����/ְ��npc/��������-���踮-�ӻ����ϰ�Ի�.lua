--Î÷±±ÄÏÇø ·ïÏè¸® ÔÓ»õµêÀÏ°å¶Ô»°
Include("\\script\\global\\global_zahuodian.lua");

function main(sel)
	local Buttons = store_sel_extend();
	Say("Bæn tiÖm tuy nhá nh­ng thø g× còng cã. Kh¸ch quan muèn mua g×?", getn(Buttons), Buttons);
end;


function yes()
Sale(20); 		--µ¯³ö½»Ò×¿ò
end;

function BuyChristmasCard()
	Sale(97);
end


function no()
end;

