--Á½ºşÇø °ÍÁêÏØ Â·ÈË10Éò¾Å¶Ô»°
--°ÍÁêÏØĞÂÊÖÈÎÎñ£º°¢·¼µÄ¼Ş×±
--suyu
-- Update: Dan_Deng(2003-08-10)
--×¢Òâ£ºÔ½ÄÏÖ»ÓĞÒ»ÖÖÔª±¦£¬Ïàµ±ÓÚÎÒÃÇµÄÒøÔª±¦£¬Ãû³Æ½Ğ½ğÔª±¦£¬Ç§Íò×¢Òâ£¬±àºÅÓÃ 343

function main()
	UTask_world20 = GetTask(48)
	if (CheckStoreBoxState(1) == 0 and  UTask_world20 == 1) then			-- ·ûºÏÂòÏä×ÓµÄÌõ¼ş£¬ÔÊĞí¹ºÂò¸½¼Ó´¢ÎïÏä
		Say(11256,4,"Mua /buy_addibox", "Ta ®Õn lµm nhiÖm vô A Ph­¬ng/task_ring","T×m hiÓu/box_help", "Kh«ng mua/no")
	elseif (UTask_world20 == 1) then
		task_ring()
	elseif (CheckStoreBoxState(1) == 0) then
		Say(11256,3,"Mua/buy_addibox", "T×m hiÓu/box_help", "Kh«ng mua/no")
	else
		other_chat()
	end
end;

function task_ring()
	UTask_world20 = GetTask(48);
	if (UTask_world20 == 1) then
		Say("Muèn mua giïm c« n­¬ng Êy cña håi m«n ­? Hµng hßa cßn l¹i cña ta kh«ng nhiÒu, chØ cßn l¹i ®éi b«ng tai vµng nµy lµ kh¸ rÎ, chØ cã 200 l­îng",2,"Mua/yes", "T¸n gÉu/other_chat","Kh«ng mua/no")
	end
end

function other_chat()
	Talk(3,"","Ta tõ Tø Xuyªn ®Õn, trªn ®­êng cã rÊt nhiÒu thæ phØ,thËt lµ nguy hiÓm!", "ThËt kh«ng thÓ ngê ®­îc ta cã thÓ ®Õn khu vùc hå §éng §×nh nµy mµ kh«ng hÒ bŞ c­íp! Ng­¬i thÊy cã l¹ kh«ng?","ta nghe ng­êi ta nãi míi biÕt, ë ®©y kh«ng chŞu sù qu¶n lı cña quan phñ, mµ tõ mét ph¸i tªn Thiªn V­¬ng Bang g× ®ã, hÌn g× ë ®©y thËt yªn b×nh!")
end

function yes()
	if(GetCash() >= 200)then
		Talk(1,"",11260)
		Pay(200);
		AddEventItem(181);
		AddNote("B¹n nhËn ®­îc 1 ®«i khuyªn tai...")
		Msg2Player("B¹n nhËn ®­îc 1 ®«i khuyªn tai.");
--		SetTask(48, 2);
	else
		Talk(1,"",11261)
	end
end;

function buy_addibox()
		local szMsg = 
		{
				"C¸i r­¬ng nµy ®­îc lµm tõ san h« d­íi biÓn s©u, cã thÓ chøa nhiÒu ®å ®¹c, h¬n n÷a lµ n¬i cÊt gi÷ ®å an toµn. V× thÕ gi¸ c¶ h¬i ®¾t mét chót. Mçi c¸i gi¸ <color=yellow>40 TiÒn ®ång<color>.",	--1
				"Dïng 40 tiÒn ®ång ®Ó mæ réng r­¬ng/#buy_addibox_yes(40)",	--2
				"Dïng 20 tiÒn ®ång ®Ó mæ réng r­¬ng/#buy_addibox_yes(20)",	--3
				"KÕt thóc ®èi tho¹i/no",			--4
		};
		
		local nDate = tonumber(GetLocalDate("%Y%m%d"));
		
		if (nDate >= 20080202 and nDate <= 20080302) then	--´º½Ú»î¶¯ÆÚ¼äÄÚ
			Say(szMsg[1], 2, szMsg[3], szMsg[4]);
		else
			--tinhpn 20100803: Patch Request
			Say(szMsg[1], 2, szMsg[2], szMsg[4]);
			--Say(szMsg[1], 2, szMsg[3], szMsg[4]);
		end;
				
end

function buy_addibox_yes(nNedCount)
	if (nNedCount < 1 or nNedCount == nil) then
		print("Fail!!!!");
		return
	end;
	
	local nCount = CalcEquiproomItemCount(4, 417, 1, 1)
	
	if (nCount < nNedCount) then
		Talk(1,"","Kh¸ch quan ch­a ®ñ tiÒn! Khi nµo cã ®ñ tiÒn h·y quay l¹i. ")
		return 1;
	end
	ConsumeEquiproomItem(nNedCount, 4, 417, 1, 1)
	
	WriteGoldLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName()..format("]: »¨·Ñ %d Í­Ç®, µÃµ½1¸öÀ©Õ¹Ïä.",nNedCount),-2,0,0,0);
	OpenStoreBox(1)
	
	UseSilver(1, 2, nNedCount); -- ½ğÔª±¦¶Ò»»ÎªÍ­Ç®µÄÏûºÄÍ³¼Æ(Ö±½ÓÏûºÄµÄÔª±¦ÒøÆ±£¬ÓëÍ­Ç®¶Ò»»µÈÍ¬´¦Àí)
	SaveNow(); -- Á¢¼´´æÅÌ
	  	
	Talk(1,"","Tèt qu¸! §ñ tiÒn råi! Ta sÏ lËp tøc l¾p ®Æt r­¬ng! VÒ sau kh¸ch quan chØ cÇn ®Õn n¬i cã r­¬ng chøa ®å cña m×nh më <color=yellow>r­¬ng më réng<color> lµ cã thÓ dïng ®­îc. ")
	Msg2Player("Mé réng r­¬ng thµnh c«ng!")
end


function box_help()
	str=
	{
	"<#>R­¬ng më réng co 60 « trèng cã thÓ sö dông chøa c¸c vËt phÈm nh­ng kh«ng thÓ giö tiÒn!",
	"<#>B¹n cã thÓ thiÕt lËp m· khãa cho r­¬ng hµnh! Nh»m b¶o vÖ c¸c tµi s¶n cña b¹n!",
	};
	Talk(2,"",str[1],str[2]);
end
	
	
function no()
end;
