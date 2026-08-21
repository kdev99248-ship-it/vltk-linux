-------------------------------------------------------------------------
-- FileName		:	posthouse.lua
-- Author		:	xiaoyang
-- CreateTime	:	2005-04-04 15:30:14
-- Desc			:	ËÍĞÅÈÎÎñæä¹Ù½Å±¾
-------------------------------------------------------------------------
Include("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\task\\tollgate\\messenger\\messenger_timeer.lua")    --µ÷ÓÃ¼ÆÊ±Æ÷
Include("\\script\\task\\tollgate\\messenger\\messenger_losetask.lua")  --È¡ÏûÈÎÎñ
Include("\\script\\task\\task_addplayerexp.lua")  --¸øÍæ¼ÒÀÛ¼Ó¾­ÑéµÄ¹«¹²º¯Êı
Include("\\script\\task\\tollgate\\killbosshead.lua") --°üº¬ÁËÍ¼Ïóµ÷ÓÃ
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\task\\tollgate\\messenger\\qianbaoku\\messenger_baoxiangtask.lua")--¿ª±¦Ïä¹¤¾ßº¯Êı
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\lib\\log.lua")
--Include("\\script\\lib\\awardtemplet.lua")--¸ø½±Àø½Ó¿Ú

IncludeLib("RELAYLADDER");	--ÅÅĞĞ°ñ


--¹¹Ôì¸÷³ÇÊĞÈ¥ÆäËû³ÇÊĞµÄÈÎÎñ±äÁ¿¶ÔÓ¦±í        60-89¼¶£¬90-119¼¶£¬120ÒÔÉÏÈıÖÖ
--citygo µÄ¹¹Ôì·½Ê½
--µ½¸÷³ÇÊĞµÄÈÎÎñ±äÁ¿£¬¶ÔÓ¦Öµ£¬µ±Ç°³ÇÊĞÃû×Ö£¬È¥µ½³ÇÊĞÃû×Ö£¬Ïµ¶ÔÈÎÎñid£¬µ±Ç°³ÇÊĞid£¬È¥µ½³ÇÊĞµØÍ¼id£¬x£¬y
--1201 ®­a tin nhiÖm vô phong chi kş nhiÖm vô thay ®æi l­îng 
--1202 ®­a tin nhiÖm vô miÕu s¬n thÇn nhiÖm vô thay ®æi l­îng 
--1203 ®­a tin nhiÖm vô thiªn b¶o kho nhiÖm vô thay ®æi l­îng

citygo = {
---- D­¬ng Ch©u ®i nh÷ng thµnh thŞ kh¸c (mapid:80) 
{1204,1,"D­¬ng Ch©u","BiÖn Kinh",1201,80,37,1601,3001}, 
{1204,2,"D­¬ng Ch©u","Ph­îng T­êng ",1201,80,1,1561,3114}, 
{1204,3,"D­¬ng Ch©u","L©m An",1201,80,176,1592,2925}, 
{1204,4,"D­¬ng Ch©u","Thµnh §«",1201,80,11,3021,5090}, 
{1204,5,"D­¬ng Ch©u","T­¬ng D­¬ng",1201,80,78,1596,3379}, 
{1204,6,"D­¬ng Ch©u","§¹i Lı",1201,80,162,1674,3132}, 

---- biÖn kinh ®i nh÷ng thµnh thŞ kh¸c (mapid:37) 
{1204,7,"BiÖn Kinh","D­¬ng Ch©u",1201,37,80,1676,3000}, 
{1204,8,"BiÖn Kinh","Ph­îng T­êng ",1201,37,1,1561,3114}, 
{1204,9,"BiÖn Kinh","L©m An",1201,37,176,1592,2925}, 
{1204,10,"BiÖn Kinh","Thµnh §«",1201,37,11,3021,5090}, 
{1204,11,"BiÖn Kinh","T­¬ng D­¬ng",1201,37,78,1596,3379}, 
{1204,12,"BiÖn Kinh","§¹i Lı",1201,37,162,1674,3132},

---- ph­îng t­êng ®i nh÷ng thµnh thŞ kh¸c (mapid:1) 
{1204,13,"Ph­îng T­êng","D­¬ng Ch©u",1202,1,80,1676,3000}, 
{1204,14,"Ph­îng T­êng","BiÖn Kinh",1202,1,37,1601,3001}, 
{1204,15,"Ph­îng T­êng","L©m An",1202,1,176,1592,2925}, 
{1204,16,"Ph­îng T­êng","Thµnh §«",1202,1,11,3021,5090}, 
{1204,17,"Ph­îng T­êng","T­¬ng D­¬ng",1202,1,78,1596,3379}, 
{1204,18,"Ph­îng T­êng","§¹i Lı",1202,1,162,1674,3132}, 
-- 
---- tr­íc khi an ®i nh÷ng thµnh thŞ kh¸c (mapid:176) 
{1204,19,"L©m An","D­¬ng Ch©u",1202,176,80,1676,3000}, 
{1204,20,"L©m An","Ph­îng T­êng",1202,176,1,1561,3114}, 
{1204,21,"L©m An","BiÖn Kinh",1202,176,37,1601,3001}, 
{1204,22,"L©m An","Thµnh §«",1202,176,11,3021,5090}, 
{1204,23,"L©m An","T­¬ng D­¬ng",1202,176,78,1596,3379}, 
{1204,24,"L©m An"," §¹i Lı ",1202,176,162,1674,3132}, 
-- 
---- thµnh ®« ®i nh÷ng thµnh thŞ kh¸c (mapid:11) 
{1204,25,"Thµnh §«","D­¬ng Ch©u",1203,11,80,1676,3000}, 
{1204,26,"Thµnh §«","Ph­îng T­êng",1203,11,1,1561,3114}, 
{1204,27,"Thµnh §«","BiÖn Kinh",1203,11,37,1601,3001}, 
{1204,28,"Thµnh §«","L©m An",1203,11,176,1592,2925}, 
{1204,29,"Thµnh §«","T­¬ng D­¬ng",1203,11,78,1596,3379}, 
{1204,30,"Thµnh §«","§¹i Lı",1203,11,162,1674,3132},

---- t­¬ng d­¬ng ®i nh÷ng thµnh thŞ kh¸c (mapid:78) 
{1204,31,"T­¬ng D­¬ng","D­¬ng Ch©u",1203,78,80,1676,3000}, 
{1204,32,"T­¬ng D­¬ng","Ph­îng T­êng",1203,78,1,1561,3114}, 
{1204,33,"T­¬ng D­¬ng","BiÖn Kinh",1203,78,37,1601,3001}, 
{1204,34,"T­¬ng D­¬ng","L©m An",1203,78,176,1592,2925}, 
{1204,35,"T­¬ng D­¬ng","Thµnh §«",1203,78,11,3021,5090}, 
{1204,36,"T­¬ng D­¬ng","§¹i Lı",1203,78,162,1674,3132}, 
-- 
---- §¹i Lı ®i nh÷ng thµnh thŞ kh¸c (mapid:162) 
{1204,37,"§¹i Lı","D­¬ng Ch©u",1201,162,80,1676,3000}, 
{1204,38,"§¹i Lı","Ph­îng t­êng",1201,162,1,1561,3114}, 
{1204,39,"§¹i Lı","BiÖn kinh",1202,162,37,1601,3001}, 
{1204,40,"§¹i Lı","L©m An",1202,162,176,1592,2925}, 
{1204,41,"§¹i Lı","T­¬ng D­¬ng",1203,162,78,1596,3379}, 
{1204,42,"§¹i Lı","Thµnh §«",1203,162,11,3021,5090}, 

--³É¶¼È¥ÆäËû³ÇÊĞ(mapid:11)
--{1204,1,"Thµnh §«","§¹i Lı",1203,11,162,1674,3132}, 

-- §¹i Lı ®i nh÷ng thµnh thŞ kh¸c (mapid:162) 
--{1204,2,"§¹i Lı","Thµnh §«",1203,162,11,3021,5090},

}

-------------------------------------------ÌØÊâĞÅÊ¹ÈÎÎñµÄÖ÷½çÃæ-------------------------------------------------
function especiallymessenger()
	if ( nt_getTask(1270) == 0 ) then
		nt_setTask(1270,1)
		nt_setTask(1205,0)
		Msg2Player("Xin lçi, ng­¬i nhËn nhiÖm vô tİn sø ®· qu¸ h¹n.")
	end

	--Æß´óÖ÷³Çæä¹ÙÖ»ÓĞ³É¶¼ºÍ´óÀíÓĞÈÎÎñ
	local _, _, nMapIndex = GetPos()
	local MapId = SubWorldIdx2ID( nMapIndex )
	--if MapId ~= 11 and MapId ~= 162 then
	--	Talk(1,"","Tham gia nhiÖm vô Tİn Sø h·y ®i t×m DŞch Quan <color=red>Thµnh §«<color> hoÆc <color=red> §¹i Lı<color>!")
	--	return
	--end
	nt_setTask(1211,0)
	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);--»ı·ÖÅÅÃû
	Describe(DescLink_YiGuan..": ViÖc qu©n c¬ cña TriÒu ®×nh gÇn ®©y lu«n bŞ giÆc Kim biÕt tr­íc, ta nghi ngê cã néi gi¸n. Nh­ng tr­íc khi mÊy tªn b¹i lo¹i nµy bŞ ph¸t hiÖn, ta muèn r»ng tin nµy kh¾p n¬i ®Òu biÕt, ng­¬i cã muèn gãp mét phÇn søc cho Quèc gia kh«ng?",8,
	"Ta b»ng lßng!/messenger_ido",
	"Ta ®Õn ®Ó giao nhiÖm vô Tİn sø /messenger_finishtask",
	"Ta muèn xãa bá nhiÖm vô Tİn sø /messenger_losemytask",
	"Ta muèn kiÓm tra sè ®iÓm Tİn sø /testtinsu",
	"Ta muèn th¨ng cÊp nhiÖm vô tİn sø danh hiÖu/messenger_getlevel", 
     	 "Ta muèn lÊy ®iÓm tİn sø ®Ó ®æi phÇn th­ëng/messenger_duihuanprize", 
     	 "Ta muèn t×m hiÓu nhiÖm vô tİn sø/messenger_what", 
     	 "GÇn ®©y ta cã chuyÖn bËn rén/no")
end

function testtinsu()
	Talk(1,"","<color=green>DŞch Quan<color>: Sè ®iÓm tİn sø hiÖn t¹i cña c¸c h¹ lµ: <color=red>"..nt_getTask(1205).."<color>!")
end

-------------------------------------------½ÓÊÜÌØÊâĞÅÊ¹ÈÎÎñµÄÖ÷½çÃæ-----------------------------------------------


function messenger_ido()
	local _, _, nMapIndex = GetPos()
	
	local Uworld1204 = nt_getTask(1204)  --¼Ç¢¼Íæ¼ÒµÄÈÎÎñ±äÁ¿£¬Ã¿´ÎÈÎÎñ½áÊøÊ±Çå¿Õ
	local Uworld1028 = nt_getTask(1028)  --ÈÎÎñÁ´ÈÎÎñ±äÁ¿
	local MapId = SubWorldIdx2ID( nMapIndex )
	if ( GetLevel() < 120 ) then
		Describe(DescLink_YiGuan..": Xin l­îng thø, ®¼ng cÊp cña ng­¬i hiÖn t¹i ch­a ®ñ 120. h·y tiÕp tôc t«i luyÖn råi ®Õn gÆp ta.",1,"KÕt thóc ®èi tho¹i/no")	
	elseif ( Uworld1204 ~= 0 )  then
		Describe(DescLink_YiGuan..":Xin lçi! NhiÖm vô Tİn sø cña b¹n ch­a hoµn thµnh, kh«ng thÓ tiÕp nhËn nhiÖm vô gièng nhau, xin hoµn thµnh nhiÖm vô nµy tr­íc, c¸m ¬n!",1,"KÕt thóc ®èi tho¹i/no")
	elseif (  messenger_givetime() == 10 ) then  --²é¿´½ñÈÕÊÇ·ñ»¹ÓĞ¹Ø¿¨Ê±¼ä
		Describe(DescLink_YiGuan.."£º¶Ô²»Æğ£¬Äú½ñÌìÔÚĞÅÊ¹ÈÎÎñÖĞµÄÊ±¼äÒÑºÄ¾¡£¬ÇëÃ÷ÈÕÔÙÀ´,Ğ»Ğ»¡£",1,"½áÊø¶Ô»°/no")
	else
    	local nTaskFlag = check_daily_task_count()--¼ì²é»¹ÓĞÃ»ÓĞÈÎÎñ»ú»á
    	if nTaskFlag == 0 then
    		Describe(DescLink_YiGuan..": Xin l­îng thø, H«m nay ng­¬i ®· vÊt v¶ råi. Ngµy mai h·y quay l¹i nhĞ.",1,"KÕt thóc ®èi tho¹i/no")
    		return
    	elseif nTaskFlag == -1 then
    		Describe(DescLink_YiGuan..": H«m nay ng­¬i ®· mÖt mái råi. NÕu ng­¬i cã <color=yellow>Thiªn Khè B¶o LÖnh<color>, ta sÏ ph¸ lÖ cho ng­¬i tham gia thªm mét lÇn n÷a.",1,"KÕt thóc ®èi tho¹i/no")
    		return
    	elseif nTaskFlag == 2 then
    		Msg2Player("Ng­¬i cø cÇm Thiªn Khè B¶o LÖnh tham gia nhiÖm vô, <color=yellow>nhiÖm vô hoµn thµnh<color> ta sÏ thu håi LÖnh Bµi")
    	end
    	
    	WriteLog(format("Account:%s[Name:%s] tiÕp nhËn nhiÖm vô Tİn Sø, h«m nay ®· hoµn thµnh [%d] lÇn.",
				GetAccount(),
				GetName(),
				nTaskFlag
				)
			);
	if nTaskFlag == 2 then
		tbLog:PlayerActionLog("TinhNangKey","NhanNhiemVuTinSuSuDungThienBaoKhoLenh")		
	else
		tbLog:PlayerActionLog("TinhNangKey","NhanNhiemVuTinSu")
	end
		if ( MapId == 80 ) then
			local CityId = random(1,6)
			for i=1,6 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		elseif ( MapId == 37 ) then
			local CityId = random(7,12)
			for i=7,12 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		elseif ( MapId == 1 ) then
			local CityId = random(13,18)
			for i=13,18 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end	
		elseif ( MapId == 176 ) then
			local CityId = random(19,24)
			for i=19,24 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end		
		elseif ( MapId == 11 ) then
			--if ( messenger_choice(1,1) ~= 10 ) then
			--		print("messenger_choice error:1")
			--end
			local CityId = random(25,30)
			for i=25,30 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end		
		elseif ( MapId == 78 ) then
			local CityId = random(31,36)
			for i=31,36 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		elseif ( MapId == 162 ) then
		--	if ( messenger_choice(2,2) ~= 10 ) then
		--			print("messenger_choice error:2")
		--	end
			local CityId = random(37,42)
			for i=37,42 do
				if ( messenger_choice(CityId,i) == 10 ) then
					break
				end
			end
		else
			Msg2Player("Xin lçi! Kh«ng biÕt t¹i sao b¹n l¹i kh«ng thÓ nhËn nhiÖm vô Tİn sø? Xin liªn hÖ víi GM!")
		end
	end
end

--Ç°ÍùÇ§±¦¿â
function messenger_storewagoner()
	SetRevPos(11,10)
	
	NewWorld(395,1417,3207)
end

-----------------------------------------------¸ø·ûºÏÒªÇóµÄÍæ¼ÒÒ»¸öÌØÊâĞÅÊ¹ÈÎÎñ£¬²¢¸Ä±äÆäĞÅÊ¹ÈÎÎñ±äÁ¿ºÍµ½´ï¹Ø¿¨±äÁ¿------------------------
function messenger_choice(CityIdTwo,j)
	if ( CityIdTwo == citygo[j][2] ) then	
		--ÉèÖÃÓÉ´ËµØÈ¥±ËµØµÄÈÎÎñ±äÁ¿	
		nt_setTask( 1204,citygo[j][2] )
		--ÉèÖÃÈ¥µ½ÄÄ¸ö¹Ø¿¨µÄÈÎÎñ±äÁ¿   
		nt_setTask( citygo[j][5],10) --ÉèÖÃĞÅÊ¹ÈÎÎñµÄ²½Öè
		local name = GetName()
		Talk(1,"","Ng­¬i ®· nhËn ®­îc nhiÖm vô Tİn Sø giao th­ tõ <color=yellow>"..citygo[j][3].."<color> ®Õn <color=yellow>"..citygo[j][4].."<color>. H·y ®Õn gÆp Xa Phu ®Ó khëi hµnh!")		
		return 10
	end
end


---------------------------------------------------Éı¼¶ĞÅÊ¹³ÆºÅ----------------------------------------------------------------------
function messenger_getlevel()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local messenger_reallevelname = ""
	if ( Uworld1206 == 1 ) then
		messenger_reallevelname = "Méc bµi tİn sö"
	elseif ( Uworld1206 == 2 ) then
		messenger_reallevelname = "§ång bµi tİn sö"
	elseif ( Uworld1206 == 3 ) then
		messenger_reallevelname = "Ng©n bµi tİn sö"
	elseif ( Uworld1206 == 4 ) then
		messenger_reallevelname = "Kim bµi tİn sö"
	elseif ( Uworld1206 == 5 ) then
		messenger_reallevelname = "Ngù tø kim bµi tİn sö"
	else	
		messenger_reallevelname = "Kh«ng cã bÊt k× tİn sø nµo"
	end 
	Describe(DescLink_YiGuan.."Ngµi tr­íc m¾t lµ "..messenger_reallevelname.." , ngµi tİch lòy ®iÓm tİn sø v× "..Uworld1205.." ®iÓm, ngµi muèn th¨ng cÊp lµm lo¹i nµo tİn sø khiÕn cho ®©y",6,
		"Méc bµi tİn sö[50µã]/messenger_levelmu",
		"§ång bµi tİn sö[150µã]/messenger_leveltong",
		"Ng©n bµi tİn sö[450µã]/messenger_levelyin",
		"Kim bµi tİn sö[800µã]/messenger_leveljin",
		"Ngù tø kim bµi tİn sö[1500µã]/messenger_levelyuci",
		"Ta ch¼ng qua lµ tïy tiÖn xem mét chót/no")
end

function messenger_levelmu()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 50 ) then
		if ( Uworld1206 < 1 ) then
			nt_setTask(1206,1)
			nt_setTask(1205,Uworld1205-50)
			Describe(DescLink_YiGuan..": Chóc mõng"..name.."§¹i nh©n trë thµnh Tİn sø Méc!",1,"KÕt thóc ®èi tho¹i/no")
		elseif ( Uworld1206 == 1 ) then
			Describe(DescLink_YiGuan..":"..name.."! B¹n ®· lµ Tİn sø - Méc, kh«ng cÇn t¨ng cÊp, xin h·y cè g¾ng!",1,"KÕt thóc ®èi tho¹i/no")		
		else
			Describe(DescLink_YiGuan..":"..name.."! §¼ng cÊp cña b¹n v­ît qu¸ Tİn sø - Méc, xin h·y chän Tİn sø kh¸c.",2,"Quay l¹i/messenger_getlevel","KÕt thóc ®èi tho¹i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin lçi!  B¹n kh«ng phï hîp víi ®iÒu kiÖn t¨ng cÊp cña Tİn sø - Méc, xin h·y nç lùc, c¸m ¬n!",2,"Quay l¹i/messenger_getlevel","KÕt thóc ®èi tho¹i/no")
	end
end

function messenger_leveltong()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 150 )  then
		if ( Uworld1206 < 2 ) then
			nt_setTask(1206,2)
			nt_setTask(1205,Uworld1205-150)
			Describe(DescLink_YiGuan..": Chóc mõng "..name.." ®¹i nh©n ®· lµ tİn sø - ®ång !!",1,"KÕt thóc ®èi tho¹i/no")
		elseif ( Uworld1206 == 2 ) then
			Describe(DescLink_YiGuan..":"..name.."! Ng­¬i ®· lµ tİn sø - ®ång, kh«ng cÇn th¨ng cÊp, xin tiÕp tôc cè g¾ng !",1,"KÕt thóc ®èi tho¹i/no")				
		else
			Describe(DescLink_YiGuan..":"..name.."! CÊp bËc cña ng­¬i v­ît qua tİn sø - ®ång, xin mêi lùa chän nh÷ng lo¹i tİn sø kh¸c.",2,"Trë vÒ/messenger_getlevel","KÕt thóc ®èi tho¹i/no")				
		end
	else
		Describe(DescLink_YiGuan..":ThËt xin lçi ! Ng­¬i kh«ng ®ñ  ®iÒu kiÖn phï hîp th¨ng cÊp tİn sø - ®ång, xin tiÕp tôc cè g¾ng, c¸m ¬n!",2,"Trë vÒ/messenger_getlevel","KÕt thóc ®èi tho¹i/no")
	end
end

function messenger_levelyin()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 450 ) then
		if ( Uworld1206 < 3 ) then
			nt_setTask(1206,3)
			nt_setTask(1205,Uworld1205-450)
			Describe(DescLink_YiGuan..": Chóc mõng"..name.."§¹i nh©n th¨ng thµnh Tİn sø - B¹c!",1,"KÕt thóc ®èi tho¹i/no")
		elseif ( Uworld1206 == 3 ) then
			Describe(DescLink_YiGuan..":"..name.."! B¹n ®· lµ Tİn sø - B¹c, kh«ng cÇn th¨ng cÊp, h·y tiÕp tôc cè g¾ng!",1,"KÕt thóc ®èi tho¹i/no")				
		else
			Describe(DescLink_YiGuan..":"..name.."! §¼ng cÊp cña b¹n ®· v­ît qua Tİn Sø - B¹c, xin h·y chän Tİn sø kh¸c!",2,"Quay l¹i/messenger_getlevel","KÕt thóc ®èi tho¹i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin lçi!  B¹n kh«ng phï hîp víi ®iÒu kiÖn th¨ng cÊp cña Tİn sø - B¹c, xin b¹n h·y tiÕp tôc cè g¾ng, c¸m ¬n!",2,"Quay l¹i/messenger_getlevel","KÕt thóc ®èi tho¹i/no")
	end
end

function messenger_leveljin()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 800 ) then
		if ( Uworld1206 < 4 ) then
			nt_setTask(1206,4)
			nt_setTask(1205,Uworld1205-800)
			Describe(DescLink_YiGuan..": Chóc mõng"..name.."§¹i nh©n th¨ng thµnh Tİn sø - Vµng!",1,"KÕt thóc ®èi tho¹i/no")
		elseif ( Uworld1206 == 4 ) then
			Describe(DescLink_YiGuan..":"..name.."! B¹n ®· lµ Tİn sø - Vµng, kh«ng cÇn t¨ng cÊp n÷a, h·y tiÕp tôc cè g¾ng!",1,"KÕt thóc ®èi tho¹i/no")		
		else
			Describe(DescLink_YiGuan..":"..name.."! §¼ng cÊp cña b¹n ®· v­ît qu¸ Tİn sø - Vµng, xin chän Tİn sø kh¸c!",2,"Quay l¹i/messenger_getlevel","KÕt thóc ®èi tho¹i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin lçi!  B¹n kh«ng phï hîp víi ®iÒu kiÖn th¨ng cÊp cña Tİn sø - Vµng, h·y tiÕp tôc cè g¾ng, c¸m ¬n!",2,"Quay l¹i/messenger_getlevel","KÕt thóc ®èi tho¹i/no")
	end
end

function messenger_levelyuci()
	local Uworld1205 = nt_getTask(1205)
	local Uworld1206 = nt_getTask(1206)
	local name = GetName()
	if ( Uworld1205 >= 1500 ) then
		if ( Uworld1206 < 5 ) then
			nt_setTask(1206,5)
			nt_setTask(1205,Uworld1205-1500)
			Describe(DescLink_YiGuan..": Chóc mõng"..name.."§¹i nh©n th¨ng thµnh Ngù Tø Tİn sø yªu bµi!",1,"KÕt thóc ®èi tho¹i/no")
		elseif ( Uworld1206 == 5 ) then
			Describe(DescLink_YiGuan..":"..name.."B¹n ®· lµ Ngù Tø Tİn sø - Vµng, kh«ng cÇn t¨ng cÊp n÷a, xin h·y tiÕp tôc cè g¾ng!",1,"KÕt thóc ®èi tho¹i/no")				
		end
	else
		Describe(DescLink_YiGuan..":Xin lçi! B¹n kh«ng phï hîp ®iÒu kiÖn víi ®iÒu kiÖn t¨ng cÊp cña Ngù Tø Tİn sø - Vµng, xin h·y tiÕp tôc cè g¾ng, c¸m ¬n!",2,"Quay l¹i/messenger_getlevel","KÕt thóc ®èi tho¹i/no")
	end
end

--------------------------------------------½»ĞÅÊ¹ÈÎÎñ------------------------------------------------------
function messenger_finishtask()
	local Uworld1201= nt_getTask(1201)	--ËÍĞÅÈÎÎñ·çÖ®ÆïÈÎÎñ±äÁ¿
	local Uworld1202= nt_getTask(1202)	--ËÍĞÅÈÎÎñÉ½ÉñÃíÈÎÎñ±äÁ¿
	local Uworld1203= nt_getTask(1203)	--ËÍĞÅÈÎÎñÇ§±¦¿âÈÎÎñ±äÁ¿
	local Uworld1204= nt_getTask(1204)	--ËÍĞÅÈÎÎñËùµ½µØµãÈÎÎñ±äÁ¿
	local Uworld1205= nt_getTask(1205)	--ĞÅÊ¹»ı·Ö
	local Uworld1206= nt_getTask(1206)	--ĞÅÊ¹³ÆºÅ
	local Uworld1208= nt_getTask(1208)	--·çÖ®ÆïÉ±¹Ö¼ÇÊıÆ÷
	local Uworld1209= nt_getTask(1209)	--É½ÉñÃíÉ±¹Ö¼ÇÊıÆ÷
	local Uworld1210= nt_getTask(1210)	--Ç§±¦¿âÉ±¹Ö¼ÇÊıÆ÷
	local Uworld1218= nt_getTask(1218)  --ĞÅÊ¹ÈÎÎñÍê³É´ÎÊı¼ÇÊıÆ÷

	if ( Uworld1201 == 30 ) then
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan.."ThËt xin lçi, ng­¬i kh«ng cã ë hoµn thµnh tİn s­ tíi nhËn lÊy phÇn th­ëng, nhiÖm vô nµy xem thÊt b¹i !",1,"KÕt thóc ®èi tho¹i/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan.."Chóc mõng ngµi ®· hoµn thµnh nhiÖm vô hiÖn t¹i !",1,"NhËn lÊy phÇn th­ëng/messenger_flyprize")
		end
	elseif ( Uworld1202 == 30 ) then
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan.."ThËt xin lçi, ng­¬i kh«ng cã ë hoµn thµnh tİn s­ tíi nhËn lÊy phÇn th­ëng, nhiÖm vô nµy xem thÊt b¹i ",1,"KÕt thóc ®èi tho¹i/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan.."Chóc mõng ngµi ®· hoµn thµnh nhiÖm vô hiÖn t¹i",1,"NhËn lÊy phÇn th­ëng/messenger_templeprize")
		end
	elseif ( Uworld1203 == 30 or Uworld1203 == 25 ) then
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan..":Xin lçi!  B¹n ch­a hoµn thµnh nhiÖm vô mµ h«m tr­íc ®Õn l·nh th­ëng, nhiÖm vô nµy coi nh­ ®· thÊt b¹i råi!",1,"KÕt thóc ®èi tho¹i/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan..":  Chóc mõng b¹n ®· hoµn thµnh nhiÖm vô!",1,"NhËn l·nh phÇn th­ëng/messenger_treasureprize")
		end
	elseif ( Uworld1201 == 25 ) or ( Uworld1202 == 25 ) or ( Uworld1203 == 25 ) then   --Íê³ÉÁË¼òµ¥ĞÅÊ¹ÈÎÎñ
		if ( messenger_gettime() == 10 ) then
			Describe(DescLink_YiGuan.."ThËt xin lçi, ng­¬i kh«ng cã ë hoµn thµnh tİn s­ tíi nhËn lÊy phÇn th­ëng, nhiÖm vô nµy xem thÊt b¹i",1,"KÕt thóc ®èi tho¹i/no")
		else
			nt_setTask(1218,Uworld1218+1)
			Describe(DescLink_YiGuan.." Chóc mõng ngµi ®· hoµn thµnh nhiÖm vô hiÖn t¹i",1,"NhËn lÊy phÇn th­ëng/messenger_simpleprize")	
		end
	elseif ( Uworld1201 ~= 0 or Uworld1202 ~= 0 or Uworld1203 ~= 0 ) then
		Describe(DescLink_YiGuan..": NhiÖm vô tİn sø cña ngµi ch­a hoµn thµnh, xin h·y tiÕp tôc cè g¾ng",1,"KÕt thóc ®èi tho¹i/no")
	elseif Uworld1203 ~= 0 then
		Describe(DescLink_YiGuan..": Xin h·y l­îng thø, ng­¬i vÉn ch­a hoµn thµnh nhiÖm vô hiÖn t¹i. L·o Xa Phu bªn c¹nh ta cã thÓ ®­a ng­¬i ®Õn b¶n ®å nhiÖm vô !",1,"KÕt thóc ®èi tho¹i/no")
	else
		Describe(DescLink_YiGuan..": Ch­a tiÕp nhËn nhiÖm vô nµo ng­¬i cßn l¹i tr¶ nhiÖm vô! Ng­êi ®©u? B»m c¸i tªn nµy lµm nh©n b¸nh bao cho ta!",1,"KÕt thóc ®èi tho¹i/no")
	end
end

function messenger_flyprize()
	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);
	local Uworld1207 = nt_getTask(1207)
	local i = random(1,5)
	AddRepute(i)
	Msg2Player("Chóc mõng ng­¬i thu ®­îc "..i.." ®iÓm danh väng. ")
	if ( nt_getTask(1224) ~= 1 ) then
		if ( GetLevel()>=60 and GetLevel()<=89 ) then
			if ( nt_getTask(1223) >= 150 ) then
				messenger_giveplayerexp(1500000)
			end
		elseif ( GetLevel()>=90 and GetLevel()<=119 ) then
			if ( nt_getTask(1223) >= 200 ) then
				messenger_giveplayerexp(2000000)
			end			
		elseif ( GetLevel()>=120 and GetLevel()<=129 ) then
			if ( nt_getTask(1223) >= 300 ) then
				messenger_giveplayerexp(3000000)
			end		
		elseif ( GetLevel()>=130 ) then
			if ( nt_getTask(1223) >= 600 ) then
				messenger_giveplayerexp(6000000)
			end		
		end
	end
	
	nt_setTask(1201,0)	--ËÍĞÅÈÎÎñ·çÖ®ÆïÈÎÎñ±äÁ¿
	nt_setTask(1204,0)	--ËÍĞÅÈÎÎñËùµ½µØµãÈÎÎñ±äÁ¿
	nt_setTask(1207,0)	--ËÍĞÅÈÎÎñµ±Ç°É±¹Ö¼ÇÊı
	nt_setTask(1211,0)
end

function messenger_templeprize()
 	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);
	local Uworld1207 = nt_getTask(1207)
	local i = random(1,5)
	AddRepute(i)
	Msg2Player("Chóc mõng ng­¬i thu ®­îc "..i.." ®iÓm danh väng. ")
	if ( nt_getTask(1224) ~= 1 ) then
		if ( GetLevel()>=60 and GetLevel()<=89 ) then
			if ( nt_getTask(1223) >= 150 ) then
				messenger_giveplayerexp(1500000)
			end
		elseif ( GetLevel()>=90 and GetLevel()<=119 ) then
			if ( nt_getTask(1223) >= 200 ) then
				messenger_giveplayerexp(2000000)
			end			
		elseif ( GetLevel()>=120 and GetLevel()<=129 ) then
			if ( nt_getTask(1223) >= 300 ) then
				messenger_giveplayerexp(3000000)
			end		
		elseif ( GetLevel()>=130 ) then
			if ( nt_getTask(1223) >= 600 ) then
				messenger_giveplayerexp(6000000)
			end		
		end
	end
	
	nt_setTask(1202,0)	--ËÍĞÅÈÎÎñÉ½ÉñÃíÈÎÎñ±äÁ¿
	nt_setTask(1204,0)	--ËÍĞÅÈÎÎñËùµ½µØµãÈÎÎñ±äÁ¿
	nt_setTask(1207,0)	--ËÍĞÅÈÎÎñµ±Ç°É±¹Ö¼ÇÊı
	nt_setTask(1211,0)
end

function messenger_treasureprize()
  local nTaskFlag = check_daily_task_count()--¼ì²é»¹ÓĞÃ»ÓĞÈÎÎñ»ú»á
  if nTaskFlag == 0 then
  	Describe(DescLink_YiGuan..": Xin h·y l­îng thø, h«m nay ng­¬i ®· qu¸ mÖt råi. Hay lµ ngµy mai l¹i ®Õn ®æi nhiÖm vô nhĞ.",1,"KÕt thóc ®èi tho¹i/no")
  	return
  elseif nTaskFlag == -1 then
  	Describe(DescLink_YiGuan..": Cã ph¶i ng­¬i ®· lÊy <color=yellow> Thiªn Khè B¶o LÖnh <color> lµm mÊt råi h¶? T×m LÖnh Bµi vÒ ®©y ta míi th­ëng cho ng­¬i.",1,"KÕt thóc ®èi tho¹i/no")
  	return
  end
  
  --¼ì²é±³°ü¿Õ¼ä
  local nTodayTaskCount = %get_task_daily(12051234)
  local nBagCellNeed = 1
  if nTodayTaskCount == 0 then
  	nBagCellNeed = 2
  end
  if (CalcFreeItemCellCount() < nBagCellNeed) then
		Talk(1, "", format("<#>Hµnh trang cña ng­¬i kh«ng ®ñ chç trèng, h·y s¾p xÕp l¹i hµnh trang cßn trèng %d « råi h·y ®Õn nhËn th­ëng nhĞ.",nBagCellNeed))
		return
	end
	local n_level = GetLevel();
	G_ACTIVITY:OnMessage("FinishMail", 1, n_level);	
	--¿Û³ıÇ§±¦¿âÁî
	if nTaskFlag == 2 then
	--Fix bug ²»ÄÜÔÚ°ï»áÏä×ÓÄÚ¿Û³ıÇ§±¦¿âÁî- Modifiec by DinhHQ - 20110502
	    	if ConsumeEquiproomItem(1, 6, 1, 2813, -1) == 1 then--¿Û³ıÇ§±¦¿âÁî
	    		Msg2Player("Ng­¬i ®· giao 1 Thiªn B¶o Khè LÖnh")
	    	else
	    		Talk(1, "", "Thiªn B¶o Khè LÖnh cña ng­¬i ®©u sao ta kh«ng thÊy?")
	    		return
	    	end
    end
    
   	%add_task_daily(12051234, 1)
	nt_setTask(1201,0)	--
	nt_setTask(1202,0)
	nt_setTask(1203,0)
	nt_setTask(1204,0)
	
	nTodayTaskCount = %get_task_daily(12051234)--»ñÈ¡½»ÈÎÎñºóµÄ¼ÆÊıÖµ
	WriteLog(format("Account:%s[Name:%s] nhËn phÇn th­ëng nhiÖm vô Tİn Sø, h«m nay ®· hoµn thµnh [%d] lÇn.",
			GetAccount(),
			GetName(),
			nTodayTaskCount
			)
		);
		
	--Ã¿ÌìµÚÒ»´ÎÍê³ÉÈÎÎñ½±Àø3¸öĞĞÏÀÁî
	if nTodayTaskCount == 1 then
		for i = 1, 3 do
			--Fix bug sai level ĞĞÏÀÁî- Modified by DinhHQ - 20110921
			AddItem(6,1,2566,1,0,0)--»ñÈ¡µÄĞĞÏÀÁîÎª²»°ó¶¨×´Ì¬
		end;
		Msg2Player("Ng­¬i nhËn ®­îc 3 Hµnh HiÖp LÖnh")
	end
	
	--Ã¿´Î½»ÈÎÎñ½±Àø2¸öĞÅÊ¹±¦Ïä
	for i = 1, 2 do
		AddItem(6,1,2812,0,0,0)
	end;
	Msg2Player("Ng­¬i nhËn ®­îc 2 Tİn Sø B¶o R­¬ng")
end

function messenger_simpleprize()

	Ladder_NewLadder(10187, GetName(),nt_getTask(1205),1);
	local i = random(1,5)
	AddRepute(i)
	Msg2Player("Chóc mõng ng­¬i thu ®­îc "..i.." ®iÓm danh väng.")
	nt_setTask(1201,0)	
	nt_setTask(1202,0)	
	nt_setTask(1203,0)	
	nt_setTask(1204,0)
	nt_setTask(1207,0)
	nt_setTask(1211,0)
		
end

--------------------------------------------»ı·Ö»»½±Àø-----------------------------------------------------
function messenger_duihuanprize()
	Describe(DescLink_YiGuan..": PhÇn th­ëng gåm cã: Tİn sø yªu bµi vµ Trang bŞ Hoµng Kim. Yªu bµi cã thÓ t¨ng kh¸ng tİnh cña nh©n vËt, trang bŞ Hoµng Kim cã thÓ t¨ng kinh nghiÖm. B¹n muèn chän lo¹i nµo?",3,
		"Tİn sö yªu bµi /messenger_prize_yaopai",
		"Hoµng kim trang bŞ/messenger_prize_huangjin",
		"Hç Trî §ång Hµnh/messenger_prize_partner",
		"Nh÷ng vËt phÈm kh¸c/messenger_prize_other",
		"§Ó ta suy nghÜ l¹i!/no")
end

function messenger_prize_partner()
	Describe(DescLink_YiGuan..": Thñ lÜnh Long ngò võa míi mang vÒ mét sè <color=red>MÆt n¹ §ång hµnh kú bİ<color>, ng­êi cã muèn dïng thö kh«ng?",5,
		"Kü n¨ng §ång hµnh/no",
		"MÆt n¹ §ång hµnh/messenger_prize_mianju",
		--"VËt phÈm §ång hµnh/no",
		"Quay l¹i/messenger_duihuanprize",
		"Sau nµy h·y nãi!/no")
end

function messenger_prize_mianju()
	Describe(DescLink_YiGuan..": MÆt n¹ ®ång hµnh chia thµnh 2 lo¹i: 1 lÇn sö dung vµ 10 lÇn sö dông.  Muèn ®æi c¸i nµo?",4,
	"§æi MÆt n¹ 1 lÇn/prize_mianju_dan",
	"§æi MÆt n¹ 10 lÇn/prize_mianju_shi",
	"Quay l¹i/messenger_prize_partner",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_mianju_shi()
	Describe(DescLink_YiGuan..": B¹n muèn ®æi MÆt n¹ (10 lÇn) ThiÕu Niªn Vâ sÜ L«i KiÕm hay lµ Thanh Niªn Vâ sÜ L«i KiÕm?  Xem râ ch­a ch­a?",4,
	"§æi MÆt n¹ ThiÕu Niªn Vâ SÜ /prize_mianju_shi_shaonian",
	"§æi MÆt n¹ Thanh Niªn Vâ SÜ /prize_mianju_shi_qingnian",
	"Quay l¹i/messenger_prize_mianju",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_mianju_shi_shaonian()
	Describe(DescLink_YiGuan..": B¾t ®Çu ®æi ®©y!",7,
	"MÆt n¹ (10 lÇn) - ThiÕu Niªn L«i KiÕm [40000 phót]/prize_mianju_shi_shaolin_leijian",
	"MÆt n¹ (10 lÇn) - ThiÕu Niªn TiÕu S­¬ng [40000 phót]/prize_mianju_shi_shaolin_xiaoshuang",
	"MÆt n¹ (10 lÇn) - ThiÕu Niªn Háa NhËn [40000 phót]/prize_mianju_shi_shaolin_huoren",
	"MÆt n¹ (10 lÇn) - ThiÕu Niªn H¶i §­êng [40000 phót]/prize_mianju_shi_shaolin_haitang",
	"MÆt n¹ (10 lÇn) - ThiÕu Niªn Kim Phong [40000 phót]/prize_mianju_shi_shaolin_jinfeng",
	"Quay l¹i/prize_mianju_shi",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_mianju_shi_qingnian()
	Describe(DescLink_YiGuan..": B¾t ®Çu ®æi ®©y!",7,
	"MÆt n¹ (10 lÇn) - Thanh Niªn L«i KiÕm [40000 phót]/prize_mianju_shi_qinglin_leijian",
	"MÆt n¹ (10 lÇn) - Thanh Niªn TiÕu S­¬ng [40000 phót]/prize_mianju_shi_qinglin_xiaoshuang",
	"MÆt n¹ (10 lÇn) - Thanh Niªn Háa NhËn [40000 phót]/prize_mianju_shi_qinglin_huoren",
	"MÆt n¹ (10 lÇn) - Thanh Niªn H¶i §­êng [40000 phót]/prize_mianju_shi_qinglin_haitang",
	"MÆt n¹ (10 lÇn) - Thanh Niªn Kim Phong [40000 phót]/prize_mianju_shi_qinglin_jinfeng",
	"Quay l¹i/prize_mianju_shi",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_mianju_shi_qinglin_leijian()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,112,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_qinglin_xiaoshuang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,113,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_qinglin_huoren()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,114,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_qinglin_haitang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,115,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_qinglin_jinfeng()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,116,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_shaolin_leijian()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,102,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_shaolin_xiaoshuang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,103,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_shaolin_huoren()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,104,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_shaolin_haitang()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,105,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_shi_shaolin_jinfeng()
	if ( nt_getTask(1205) >= 40000 ) then
		AddItem(0,11,106,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 40000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan()
	Describe(DescLink_YiGuan..": B¹n muèn ®æi MÆt n¹ (1 lÇn) ThiÕu Niªn Vâ sÜ L«i KiÕm hay lµ Thanh Niªn Vâ sÜ L«i KiÕm?  Xem râ ch­a ch­a?",4,
	"§æi MÆt n¹ ThiÕu Niªn Vâ SÜ /prize_mianju_dan_shaonian",
	"§æi MÆt n¹ Thanh Niªn Vâ SÜ /prize_mianju_dan_qingnian",
	"Quay l¹i/messenger_prize_mianju",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_mianju_dan_qingnian()
	Describe(DescLink_YiGuan..": B¾t ®Çu ®æi ®©y.",7,
	"MÆt n¹ (1 lÇn) - Thanh Niªn L«i KiÕm [10000 phót]/prize_mianju_dan_qinglin_leijian",
	"MÆt n¹ (1 lÇn) - Thanh Niªn TiÕu S­¬ng [10000 phót]/prize_mianju_dan_qinglin_xiaoshuang",
	"MÆt n¹ (1 lÇn) - Thanh Niªn Háa NhËn [10000 phót]/prize_mianju_dan_qinglin_huoren",
	"MÆt n¹ (1 lÇn) - Thanh Niªn H¶i §­êng [10000 phót]/prize_mianju_dan_qinglin_haitang",
	"MÆt n¹ (1 lÇn) - Thanh Niªn Kim Phong [10000 phót]/prize_mianju_dan_qinglin_jinfeng",
	"Quay l¹i/prize_mianju_dan",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_mianju_dan_shaonian()
	Describe(DescLink_YiGuan..": B¾t ®Çu ®æi ®©y.",7,
	"MÆt n¹ (1 lÇn) - ThiÕu Niªn L«i KiÕm [10000 phót]/prize_mianju_dan_shaolin_leijian",
	"MÆt n¹ (1 lÇn) - ThiÕu Niªn TiÕu S­¬ng [10000 phót]/prize_mianju_dan_shaolin_xiaoshuang",
	"MÆt n¹ (1 lÇn) - ThiÕu Niªn Háa NhËn [10000 phót]/prize_mianju_dan_shaolin_huoren",
	"MÆt n¹ (1 lÇn) - ThiÕu Niªn H¶i §­êng [10000 phót]/prize_mianju_dan_shaolin_haitang",
	"MÆt n¹ (1 lÇn) - ThiÕu Niªn Kim Phong [10000 phót]/prize_mianju_dan_shaolin_jinfeng",
	"Quay l¹i/prize_mianju_dan",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_mianju_dan_shaolin_leijian()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,97,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_shaolin_xiaoshuang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,98,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_shaolin_huoren()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,99,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_shaolin_haitang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,100,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_shaolin_jinfeng()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,101,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_qinglin_leijian()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,107,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_qinglin_xiaoshuang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,108,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_qinglin_huoren()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,109,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_qinglin_haitang()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,110,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_mianju_dan_qinglin_jinfeng()
	if ( nt_getTask(1205) >= 10000 ) then
		AddItem(0,11,111,0,0,0,0)
		local Uworld1205 = nt_getTask(1205) - 10000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 MÆt n¹ ®ång hµnh")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end


function messenger_prize_yaopai()
	Describe(DescLink_YiGuan..": Tİn sø yªu bµi cïng ng­¬i ®¹t tíi tİn sø cho danh hiÖu t­¬ng ®èi øng. Tû nh­ ng­¬i lµ kim tİn sø, ®em cã thÓ ®æi bÊt kú tİn sø, nÕu nh­ ng­¬i lµ méc tİn sø, th× kh«ng thÓ ®æi kim tİn sø. HiÓu kh«ng ? b¾t ®Çu ®æi ®i . .",7, 
       	"Tİn sø lÖnh - Méc [50 ®iÓm ]/prize_yaopai_mu", 
    	"Tİn sø lÖnh - §ång [150 ®iÓm ]/prize_yaopai_tong", 
     	"Tİn sø lÖnh - B¹c [450 ®iÓm ]/prize_yaopai_yin", 
	"§æi Tİn sø Kim bµi [800 ®iÓm]/prize_yaopai_jin",
	"Ngù Tø lÖnh bµi - vµng [1500 ®iÓm]/prize_yaopai_yuci",
	"Quay l¹i/messenger_duihuanprize",
	"T¹m thêi kh«ng ®æi ®­îc!/no")
end

function prize_yaopai_mu()
	if ( nt_getTask(1205) >= 50 ) then
		AddItem(6,1,885,1,0,0)
		local Uworld1205 = nt_getTask(1205) - 50
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc tÊm Tİn sø lÖnh - Méc.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_yaopai_tong()
	if ( nt_getTask(1205) >= 150 ) then
		AddItem(6,1,886,2,0,0)
		local Uworld1205 = nt_getTask(1205) - 150
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc tÊm Tİn sø lÖnh - §ång.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_yaopai_yin()
	if ( nt_getTask(1205) >= 450 ) then
		AddItem(6,1,887,3,0,0)
		local Uworld1205 = nt_getTask(1205) - 450
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc Tİn sø lÖnh - B¹c.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end
end

function prize_yaopai_jin()
	if ( nt_getTask(1205) >= 800 ) then
		AddItem(6,1,888,4,0,0)
		local Uworld1205 = nt_getTask(1205) - 800
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 tÊm Tİn sø lÖnh - Vµng.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_yaopai_yuci()
	if ( nt_getTask(1205) >= 1500 ) then
		AddItem(6,1,889,5,0,0)
		local Uworld1205 = nt_getTask(1205) - 1500
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 tÊm Ngù Tø Tİn Sø yªu bµi")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function messenger_prize_huangjin()
	Describe(DescLink_YiGuan..": TriÒu ®×nh muèn th­ëng cho b¹n nªn ®· chuÈn bŞ 1 bé Trang bŞ Hoµng Kim khi giÕt ®Şch sÏ ®­îc nh©n ®«i kinh nghiÖm. B¹n muèn ®æi c¸i nµo?",6,
		"Hång ¶nh trÇm viªn v·n tóy [100000 ®iÓm]/prize_huangjin_shenyuan",
		"Hång ¶nh qua kiÕm t©y ph­¬ng [70000 ®iÓm]/prize_huangjin_guajian",
		"Hång ¶nh môc tóc t­¬ng vong [70000 ®iÓm]/prize_huangjin_muxu",
		"Hång ¶nh hång tô chiªu [50000 ®iÓm]/prize_huangjin_hongxiu",
		"Quay l¹i/messenger_duihuanprize",
		"T¹m thêi kh«ng ®æi/no")
end

function messenger_prize_other()
	Describe(DescLink_YiGuan..": TriÒu ®×nh cã nhiÒu phÇn th­ëng, hiÖn b¹n vËt phÈm b¹n cã thÓ ®æi:",3,
		"ThÇn bİ §¹i Hång Bao [2000 phót]/prize_other_hongbao",
		"Quay l¹i/messenger_duihuanprize",
		"T¹m thêi kh«ng ®æi/no")
end

function prize_other_hongbao()
	if ( nt_getTask(1205) >= 2000 ) then
		local Uworld1205 = nt_getTask(1205) - 2000 
		nt_setTask(1205,Uworld1205)
		AddItem(6,1,402,0,0,0)
		Msg2Player("B¹n nhËn ®­îc 1 ThÇn bİ §¹i Hång Bao.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_huangjin_shenyuan()
	if ( nt_getTask(1205) >= 100000 ) then
		AddGoldItem(0,204)
		local Uworld1205 = nt_getTask(1205) - 100000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 bé trang bŞ Hoµng Kim Hång ¶nh.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end


function prize_huangjin_guajian()
	if ( nt_getTask(1205) >= 70000 ) then
		AddGoldItem(0,205)
		local Uworld1205 = nt_getTask(1205) - 70000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 bé trang bŞ Hoµng Kim Hång ¶nh.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_huangjin_muxu()
	if ( nt_getTask(1205) >= 70000 ) then
		AddGoldItem(0,206)
		local Uworld1205 = nt_getTask(1205) - 70000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 bé trang bŞ Hoµng Kim Hång ¶nh.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end

function prize_huangjin_hongxiu()
	if ( nt_getTask(1205) >= 50000 ) then
		AddGoldItem(0,207)
		local Uworld1205 = nt_getTask(1205) - 50000
		nt_setTask(1205,Uworld1205)
		Msg2Player("B¹n nhËn ®­îc 1 bé trang bŞ Hoµng Kim Hång ¶nh.")
	else
		Describe(DescLink_YiGuan..": Xin lçi! §iÓm tİch lòy cña b¹n kh«ng ®ñ.",1,"KÕt thóc! /no")
	end 
end
-------------------------------------------È¡ÏûĞÅÊ¹ÈÎÎñ----------------------------------------------------
function messenger_losemytask()
	if ( GetTask(1204) == 0 ) then
		Describe(DescLink_YiGuan..": B¹n ch­a tiÕp nhËn nhiÖm vô Tİn sø, kh«ng thÓ xãa bá!",1,"KÕt thóc ®èi tho¹i/no")
	else
		Describe(DescLink_YiGuan..": B¹n x¸c ®Şnh muèn xãa bá?",2,"§óng vËy!/messenger_lostall","§Ó ta suy nghÜ l¹i!/no")
	end
end
--------------------------------------------½âÊÍÊ²Ã´ÊÇĞÅÊ¹ÈÎÎñ----------------------------------------------
function messenger_what()
	Describe(DescLink_YiGuan..": NhiÖm vô Tİn Sø lµ nhiÖm vô gióp TriÒu §×nh ®­a th­ cho c¸c DŞch Quan ë c¸c Thµnh ThŞ, v× gÇn ®©y trong TriÒu §×nh xuÊt hiÖn néi gi¸n, cho nªn trong lóc ®­a th­ ng­¬i gÆp kh«ng İt nguy hiÓm. Kh«ng cã nh÷ng ng­êi dòng c¶m trİ tuÖ siªu phµm vµ tinh thÇn hîp t¸c ®oµn kÕt th× sÏ rÊt khã hoµn thµnh nhiÖm vô. ChØ cã ®¹t ®Õn <color=red> cÊp 120 trë lªn <color> míi cã thÓ tham gia. Ta chØ cã ®«i lêi nh­ vËy chóc ng­¬i thµnh c«ng, cè lªn chiÕn h÷u!",7, 
       "Giíi thiÖu cÊp bËc b¶n ®å /messenger_levelmap", 
       "Giíi thiÖu phong chi kş quan/messenger_flyhorse", 
       "Giíi thiÖu S¬n thÇn miÕu quan t¹p /messenger_mountaindeity", 
    	"Giíi thiÖu Thiªn B¶o khè /messenger_storehouse",
       "Giíi thiÖu tİn sö yªu bµi/messenger_orderlevel", 
       "Giíi thiÖu nhiÖm vô h¹n lóc/messenger_limittotask", 
       "KÕt thóc ®èi tho¹i /no")
end

function messenger_levelmap()
	--Describe(DescLink_YiGuan.."£º°´ÕÕÍæ¼ÒµÄ²»Í¬µÈ¼¶£¬ÎÒÃÇ»®·ÖÁËÈıÖÖ²»Í¬Ç¿¶ÈµÄµØÍ¼¸øÄú¡£¼¶±ğÇø·ÖÊÇ<color=red>60-89¼¶£¬90-119¼¶£¬120<color>ÒÔÉÏÈıÖÖ¡£",2,"»ØÉÏÒ»²ã/messenger_what","½áÊø¶Ô»°/no")
	Describe(DescLink_YiGuan..": Tr­íc m¾t chØ cã <color=red> cÊp 120 trë lªn <color> míi cã thÓ nhËn nhiÖm vô",2," Quay l¹i/messenger_what"," KÕt thóc ®èi tho¹i/no")
end

function messenger_flyhorse()
	Describe(DescLink_YiGuan..": Phong kú quan bªn trong, ng­¬i cã thÓ kÕ tiÕp ®Õn xuÊt khÈu, nh­ vËy coi nh­ lµ hoµn thµnh nhiÖm vô, nh­ng lµ, chØ t­ëng th­ëng danh väng trŞ gi¸. ? quan bªn trong, chóng ta cã mét İt ®¬n gi¶n nhiÖm vô : däc theo ®­êng ®i, ng­¬i ®em thÊy rÊt nhiÒu qu©n ta l­u l¹i kı hiÖu, ®ång thêi cã rÊt nhiÒu kim quèc gi¸n ®iÖp. Ng­¬i chØ cÇn tiÕp xóc 5 c¸ täa ®é liÒn cã thÓ ®Õn xuÊt khÈu t×m b¹ch dùc t­íng qu©n v­ît qua kiÓm tra. Nh­ng lµ biÓu hiÖn cña ng­¬i ®Òu t¹i ta cöa ph¸i ®i ®İch ®iÒu tra viªn trong m¾t. §èi víi ng­¬i ®İch yªu bµi th¨ng cÊp rÊt cã lîi . .",2,"Trë vÒ /messenger_what","KÕt thóc ®èi tho¹i /no")
end

function messenger_mountaindeity()
	Describe(DescLink_YiGuan..": MiÕu s¬n thÇn quan bªn trong, ng­¬i cã thÓ kÕ tiÕp trùc tiÕp ®Õn ®¹i m«n, nh­ vËy coi xong thµnh nhiÖm vô, nh­ng lµ, chØ t­ëng th­ëng danh väng trŞ gi¸. ? quan bªn trong, chóng ta cã mét İt ®¬n gi¶n nhiÖm vô : ë trong nói xuÊt hiÖn thÇn ®ao doanh kinh s­ ph¶n ®å bän hä ë trong nói ng¨n trë tin/th¬ khiÕn cho. Bän hä ®Çu lÜnh gäi lµ ®ao yªu . ng­¬i chØ cÇn ®¸nh b¹i 2 c¸ ®ao yªu lµ cã thÓ ®Õn lín cöa t×m kia lang khuynh thµnh v­ît qua kiÓm tra. NÕu nh­ hoµn thµnh nhiÖm vô, ®èi víi ng­¬i th¨ng cÊp rÊt cã trî gióp.",2,"Trë vÒ/messenger_what","KÕt thóc ®èi tho¹i /no")
end

function messenger_storehouse()
	Describe(DescLink_YiGuan..": Ng­¬i hoÆc ®éi tr­ëng cña ng­¬i khi tiÕp nhËn nhiÖm vô v­ît ¶i Thiªn B¶o Khè, hÖ thèng sÏ ph©n phèi ngÉu nhiªn cho ng­¬i 5 ch÷ sè, ng­¬i dùa vµo 5 sè ®ã më <color=red> B¶o R­¬ng <color> ra theo thø tù th× míi cã thÓ qua ¶i. §­¬ng nhiªn, ®Ó më B¶o R­¬ng ng­¬i ph¶i ®¸nh b¹i <color=red> B¶o Khè Thñ Hé Gi¶ <color> bªn c¹nh B¶o R­¬ng. <color=red> Ngò Hµnh Phï <color> cã b¸n trong Kú Tr©n C¸c më ra cã thÓ nhËn ®­îc TriÖt Kim Phï, TriÖt Méc Phï, TriÖt Thuû Phï, TriÖt Ho¶ Phï, TriÖt Thæ Phï, sau khi sö dông cã thÓ gióp ng­¬i dÔ dµng ®¸nh b¹i B¶o Khè Thñ Hé Gi¶.",2,"Trë vÒ /messenger_what","KÕt thóc ®èi tho¹i /no")
end

function messenger_orderlevel()
	Describe(DescLink_YiGuan..": C¨n cø ng­¬i ë ®©y quan bªn trong ®İch biÓu hiÖn, Ta ®em phong cho ng­¬i mét İt quan hµm, ng­¬i sÏ ®­îc rÊt nhiÒu phÇn th­ëng. Tr­íc m¾t , yªu bµi gåm cã Méc bµi tİn sø, §ång bµi tİn sø, Ng©n bµi tİn sø, Kim bµi tİn sø cïng víi Ngù tø kim bµi tİn sø . §ång thêi, ng­¬i theo dâi nhiÖm vô nhÊn­ <color=red>F12<color>, nh×n b¶ng bªn trong <color=red> tİch lòy <color> ®iÓm tİn sø. Ng­¬i cã thÓ dïng ®iÓm tİn sö ®Ó ®æi danh hiÖu. Sau ®ã, cã thÓ dïng tİn sø lÖnh cho tİch ®iÓm ®æi lÊy lÖnh bµi. Nh÷ng thø nµy yªu bµi ®em gia t¨ng n¨ng lùc <color=red> kh«i phôc <color> ng­¬i, t¸c dông cña nã v× <color=red>1 giê <color>, sø  dông sè lÇn v× <color=red> 5 lÇn <color>.",2,"Trë vÒ /messenger_what","KÕt thóc ®èi tho¹i /no")
end

function messenger_limittotask()
	Describe(DescLink_YiGuan..": NhËn nhiÖm vô Tİn sø, ng­¬i cã <color=red>2 giê <color> ®Ó hoµn thµnh. Mçi ngµy lµm nhiÖm vô thêi gian lµ <color=red>2 giê <color>. Chó ı, khi ë quan bªn trong lóc, ng­¬i bŞ giÕt hoÆc lµ tang cöa coi nh­ lµ <color=red> nhiÖm vô thÊt b¹i <color>!",2,"Trë vÒ /messenger_what","KÕt thóc ®èi tho¹i /no")
end

function messenger_giveplayerexp(playerexp)

	local j =random(1,3)

	if ( j == 1 ) then
		tl_addPlayerExp(playerexp-500000)
	elseif ( j == 2 ) then
		tl_addPlayerExp(playerexp)
	elseif ( j == 3 ) then
		tl_addPlayerExp(playerexp+500000)
	end
	Msg2Player("Do b¹n lµm nhiÖm vô Tİn sø cã biÓu hiÖn tèt, DŞch tr¹m cho b¹n 1 phÇn th­ëng kinh nghiÖm!")
	nt_setTask(1224,1)  --ÉèÖÃµ±Ìì½±Àø¿ª¹ØÎª¿ª  
	nt_setTask(1223,0)
end

function messenger_lostall()
	nt_setTask(1201,0)
	nt_setTask(1202,0)
	nt_setTask(1203,0)
	nt_setTask(1204,0)
	nt_setTask(1207,0)
	nt_setTask(1212,0)
	nt_setTask(1213,0)
	nt_setTask(1214,0)
	nt_setTask(1215,0)
	Msg2Player("Ng­¬i ®· hñy bá thµnh c«ng nhiÖm vô Tİn Sø.")
	WriteLog(format("Account:%s[Name:%s] hñy bá nhiÖm vô Tİn Sø",
			GetAccount(),
			GetName()
			)
		);
end

function no()
end

function check_daily_task_count()
	local nNormalTaskLimit = 2--Ò»Ìì×î¶µÖ»ÔÊĞíÁ½´ÎÆÕÍ¨ÈÎÎñ
	local nIBTaskLimit = 1--Ò»Ìì×î¶µÖ»ÔÊĞí1´ÎIBÈÎÎñ
	local nTodayCnt = %get_task_daily(12051234)
	if nTodayCnt < nNormalTaskLimit then
		return 1--»¹ÓĞÆÕÍ¨ÈÎÎñ»ú»á
	elseif  nTodayCnt < (nNormalTaskLimit + nIBTaskLimit) then
		local nCountIb = CalcItemCount(-1, 6, 1, 2813, -1)
		if nCountIb >= 1 then
			return 2--¿ÉÒÔÊ¹ÓÃµÀ¾ß±¨Ãû
		else
			return -1--¿ÉÒÔÊ¹ÓÃµÀ¾ßµ«ÊÇÉíÉÏÃ»ÓĞ
		end
	end
	return 0--Ã»ÓĞÈÎÎñ»ú»áÁË
end
