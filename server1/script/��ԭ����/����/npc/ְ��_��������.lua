-- ÑïÖİ¡¡Ö°ÄÜ¡¡ÉñÃØÉÌÈË
-- By Li_Xin (2004-08-17)
-- By Ren Bin (2004-12-15) Ôö¼ÓÇ§Ææ°Ù¹Ö¶¯ÎïĞãµÄ»î¶¯Èë¿Ú



Include("\\script\\global\\shenmi_chapman.lua") 
Include( "\\script\\global\\mask_ani.lua" )
Include( "\\script\\global\\weapon_ring.lua" )
Include("\\script\\event\\act2years_yn\\baibaoxiang.lua") 


function main()
	Say("Quªn mang tiÒn µ? Kh«ng sao! Ta ë ®©y ®îi ng­¬i! Nh­ng nhí quay l¹i sím nhĞ!",1,"§­îc!/no")	
end;

function chr_buy()

	Say("Ta cã 2 b¶o vËt dµnh cho dŞp Gi¸ng sinh nµy, ®ã lµ <color=red>¤ng Giµ Noel<color> vµ <color=red>Thiªn Sø Gi¸ng sinh<color>. NÕu mau riªng mçi c¸i lµ <color=red>399 v¹n l­îng<color>, mua c¶ 2 c¸i chØ cã <color=red>688 v¹n l­îng<color>. Cßn do dù g× n÷a?",4,"Mua MÆt n¹ ¤ng Giµ Noel (399 v¹n) /mask","Mua MÆt n¹ Thiªn Sø Gi¸ng sinh (399 v¹n) /mask","Mua c¶ 2 MÆt n¹ (688 v¹n) /mask_all","§Ó ta suy nghÜ kü l¹i xem/no")

end

function mask_all()

	on_Pay = 6880000
	if ( GetCash() >= on_Pay ) then
		Pay( on_Pay )
		AddItem(0,11,70,0,0,0,0)
		AddItem(0,11,71,0,0,0,0)
		Msg2Player("B¹n nhËn ®­îc 1 bé MÆt n¹ ")
	else
		Say("Quªn mang tiÒn µ? Kh«ng sao! Ta ë ®©y ®îi ng­¬i! Nh­ng nhí quay l¹i sím nhĞ!",1,"§­îc!/no")
	end
end


function mask(msel)

	on_Pay = 3990000
	if ( GetCash() >= on_Pay ) then
		Pay( on_Pay )
		if ( msel == 0 ) then
			AddItem(0,11,70,0,0,0,0)
			Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ¤ng Giµ Noel")
		else
			AddItem(0,11,71,0,0,0,0)
			Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ Thiªn Sø Gi¸ng sinh")
		end
	else
		Say("Quªn mang tiÒn µ? Kh«ng sao! Ta ë ®©y ®îi ng­¬i! Nh­ng nhí quay l¹i sím nhĞ!",1,"§­îc!/no")
	end

end

function no()

end