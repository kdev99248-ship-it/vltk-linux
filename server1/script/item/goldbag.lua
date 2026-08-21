Include("\\script\\global\\login_head.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function main(nItemIdx)
local nDate = tonumber(GetLocalDate("%d"))
local	nlimitit	=	CGF_SL_CamNangHK
if ( GetTask(DAY) ~= nDate ) then
	SetTask(DAY, nDate);
	SetTask(352,0);
	if (GetTask(352) <= nlimitit) then
		local k = random(1,100)
		SetTask(352,GetTask(352) + 1)
		if (k >= 90) then
			local x = random(1,100)
				if (x >= 70) then
 					AddItem(6,1,125,1,1,1)
					AddGlobalNews("§¹i hiÖp <color=green>"..GetName().."<color> më tói Hoµng Kim , may m¾n nhËn ®­îc <color=green>QuÕ Hoa Töu<color> !")
					Msg2Player("Më cÈm nang Hoµng Kim, nhËn ®­îc  QuÕ Hoa Töu ")
				elseif (x >=80)  then
 					AddItem(6,1,71,1,1,1)
					AddGlobalNews("§¹i hiÖp <color=green>"..GetName().."<color> më tói Hoµng Kim , may m¾n nhËn ®­îc <color=green>Tiªn Th¶o Lé<color> !")
					Msg2Player("Më cÈm nang Hoµng Kim, nhËn ®­îc  Tiªn Th¶o Lé ")
				else
					local p = random(122,124)
					AddItem(6,1,p,1,1,1)
					AddGlobalNews("§¹i hiÖp <color=green>"..GetName().."<color> më tói Hoµng Kim , may m¾n nhËn ®­îc <color=pink>Phóc Duyªn Lé<color> !")
					Msg2Player("Më cÈm nang Hoµng Kim, nhËn ®­îc  Phóc Duyªn Lé")
				end
		elseif (k >=50) then
			local m = random (5,45)
			n = GetLevel()
			AddOwnExp(n*m*30)
		else
			local m = random (5,45)
			n = GetLevel()
			Earn(n*m*5)
		end
	else
		Talk(1,"","<color=green>H«m nay ®· më ®ñ "..nlimitit.." C¶m nang Hoµng Kim råi, ngµy mai h·y më tiÕp<color>")
	end
	
else	--Sau khi da set ngay

if (GetTask(352) <= nlimitit) then
	local k = random(1,100)
	SetTask(352,GetTask(352) + 1)
	if (k >= 90) then
		local x = random(1,100)
		if (x >= 70) then
 			AddItem(6,1,125,1,1,1)
			AddGlobalNews("§¹i hiÖp <color=green>"..GetName().."<color> më tói Hoµng Kim , may m¾n nhËn ®­îc <color=green>QuÕ Hoa Töu<color> !")
			Msg2Player("Më cÈm nang Hoµng Kim, nhËn ®­îc  QuÕ Hoa Töu ")
		elseif (x >=80)  then
 			AddItem(6,1,71,1,1,1)
			AddGlobalNews("§¹i hiÖp <color=green>"..GetName().."<color> më tói Hoµng Kim , may m¾n nhËn ®­îc <color=green>Tiªn Th¶o Lé<color> !")
			Msg2Player("Më cÈm nang Hoµng Kim, nhËn ®­îc  Tiªn Th¶o Lé ")
		else
			local p = random(122,124)
			AddItem(6,1,p,1,1,1)
			AddGlobalNews("§¹i hiÖp <color=green>"..GetName().."<color> më tói Hoµng Kim , may m¾n nhËn ®­îc <color=pink>Phóc Duyªn Lé<color> !")
			Msg2Player("Më cÈm nang Hoµng Kim, nhËn ®­îc  Phóc Duyªn Lé")
		end
	elseif (k >=50) then
		local m = random (5,45)
		n = GetLevel()
		AddOwnExp(n*m*30)
	else
		local m = random (5,45)
		n = GetLevel()
		Earn(n*m*5)
	end
else
	Talk(1,"","<color=green>H«m nay ®· më ®ñ "..nlimitit.." C¶m nang Hoµng Kim råi, ngµy mai h·y më tiÕp<color>")
end

end
end 