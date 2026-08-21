-- Ç®×¯¹¦ÄÜ (Ô½ÄÏ°æ±¾) Banks function (Vietnamese version) 
-- by£ºDan_Deng(2003-09-16)
-- Update: Dan_Deng(2004-01-06) ´ÓÍ³Ò»¹¦ÄÜÒÆ¶¯´¦ÀíÒøÆ±µ½´Ë¶ÀÓĞ
-- Update: Fanghao_Wu(2004-9-04) Ôö¼ÓÔª±¦¶Ò»»Í­Ç®¹¦ÄÜ

-- Update: paul zhang(2005-09-06) ÎªÔ½ÄÏ°æ×÷ĞŞ¸Ä£¬Ö»Ê¹ÓÃÒøÔª±¦£¬Ã»ÓĞ½ğÔª±¦£¬ÒøÔª±¦¿É³ä³É°üÖÜ(7Ìì)»òÕß25Ğ¡Ê±£¬
--			Í­Ç®ÔİÊ±²»¿ª·Å£¬Í¬Ê±Ôö¼ÓÒ»¸öÍ·ÎÄ¼şÓÃÓÚ¿ØÖÆ¹¦ÄÜµÄ¿ª·ÅÓë¹Ø±Õ
-- Update: paul zhang(2005-12-28) ÎªÔ½ÄÏ°æ×÷ĞŞ¸Ä£¬ÓÉÓÚÔ½ÄÏ·½µÄÔ­Òò£¬ĞŞ¸Ä³ÉÖ»Ê¹ÓÃ½ğÔª±¦£¬Ã»ÓĞÒøÔª±¦£¬µ«ÊÇ½ğÔª±¦µÄ×÷ÓÃĞŞ¸ÄÎª¿É³ä³É°üÖÜ(7Ìì)»òÕß25Ğ¡Ê±£¬

-- Edited by peres
-- 2005/12/29 ¿ª·ÅÒ»¸öÔª±¦»» 15 ¸öÍ­Ç®µÄ¹¦ÄÜ
-- Last edited by Giangleloi WwW.ClbGamesVN.COM
-- end;

Include("\\script\\global\\systemconfig.lua") -- ÏµÍ³ÅäÖÃ
--Include("\\script\\global\\yuanbao_head.lua")
Include("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\task\\newtask\\education\\jiaoyutasknpc.lua") 
Include("\\script\\misc\\maskfree\\event.lua")		--Ãâ·ÑÃæ¾ßÁìÈ¡
Include("\\script\\event\\vnchristmas2006\\event.lua")	--Ê¥µ®³ä¿¨ËÍÃæ¾ß
Include("\\script\\global\\vn\\extpointfunc_proc.lua") --by Giangleloi

--Msg2Player("gamebank_proc-- vn")

function gamebank_proc()
	local msg = {
		"Ta muèn rót TiÒn ®ång/get_ingot", 
		"Ta muèn ®æi TiÒn ®ång lÊy ngµy ch¬i/pay_ingot",
		"KiÓm tra ta cßn göi bao nhiªu TiÒn ®ång/show_ingot", 
		"Ta muèn ®æi kim nguyªn b¶o thµnh tiÒn ®ång/change_ingot_to_coin", 
		"Nh©n tiÖn ghĞ qua th«i/no" 
	};
	local talk = "";  
	if (GetSex() == 0) then
		talk = "§óng råi, thiÕu hiÖp cÇn g×?";
	else
		talk = "§óng råi, n÷ hiÖp cÇn g×?"; -- 
	end
	local nDate = tonumber(GetLocalDate("%Y%m%d"));
	if (nDate >= 20061223 and nDate <= 20270114) then
		tinsert(msg, 1, "NhËn mÆt n¹ miÔn phİ khi n¹p thÎ/takeMaskFree"); 
	end;
	Say(talk, getn(msg), msg)
end
------------- ²éÑ¯Ôª±¦ --------------------
function show_ingot()
	local nMoney = GetExtPoint(1)
	if (nMoney >= 32768) then
		nMoney = 0
		Msg2Player("T¹m thêi kh«ng thÓ rót TiÒn ®ång! Xin liªn hÖ víi nhµ s¶n xuÊt ®Ó gi¶i quyÕt!") 
		return
	end
	if (nMoney <= 0) then
		Say("Chñ tiÒn trang: Kh¸ch quan ch­a hÒ göi kú tr©n b¶o vËt g× ë ®©y",1,"BiÕt råi/no") 
		return
	else
		local nCurVar = nMoney *20
		Say("<#> Kh¸ch quan ®ang göi ë ®©y <color=green>"..nCurVar.."<color> TiÒn ®ång.",1,"BiÕt råi/no") 
	end
end

------------- È¡Ôª±¦ -----------------------
function get_ingot()
	if (SYSCFG_GAMEBANK_GOLDSILVER_OPEN ~= 1) then
		Talk(1,"","ThËt xin lçi! TiÒn trang ®ang söa ch÷a, 2 ngµy sau h·y ®Õn.")  
		return
	end
	local nMoney = GetExtPoint(1)	
	if (nMoney >= 32768) then
		nMoney = 0
		Msg2Player("Chøc n¨ng bŞ lçi!")
		return
	end
	if CalcFreeItemCellCount() < 5 then
			Talk(1, "", "CÇn İt nhÊt 5 « trèng trong hµnh trang."); 
			return 1
	end
	if (nMoney <= 0) then					-- Ã»ÓĞÀ©Õ¹µãÊı
		Talk(1,"","Xin lçi! Kh¸ch quan kh«ng cã göi TiÒn ®ång t¹i bæn trang!") 
		return
	else
		local nCurVar = nMoney *20
		Say("<#> Kh¸ch quan ®ang göi ë ®©y tæng céng <color=green>"..nCurVar.."<color> TiÒn ®ång, muèn rót chø?", 2, "Ta muèn rót "..G_COIN.." TiÒn ®ång/get_ingot10", "Kh«ng rót/no") 
	end
end

function get_ingot10()
	if (SYSCFG_GAMEBANK_SILVER_GET == nil) then -- ³ö´íÁË~~
		print("get_silver have close, but something is wrong...");
		Msg2Player("Chøc n¨ng bŞ lçi!"); 
		return
	end
	
	if (GetExtPoint(1) < 1) then
		Talk(1,"","T¹m thêi kh«ng thÓ rót TiÒn ®ång! Xin liªn hÖ víi nhµ s¶n xuÊt ®Ó gi¶i quyÕt!") 
		return
	end
	Say("Kh¸ch quan cã ch¾c muèn rót TiÒn ®ång chø? (NÕu ®ång ı, xin ®õng tho¸t khái trß ch¬i!) ", 2, "Ta ®ång ı/get_ingot10ok", "Kh«ng rót/no"); 
end

function get_ingot10ok()
	PayExtPoint(1,1)
	Msg2Player("§ang rót TiÒn ®ång! Xin cÈn träng vµ ®õng tho¸t khái trß ch¬i!") 
end;

------------- ¶ÒÏÖÔª±¦ ---------------------
function pay_ingot()
	if (SYSCFG_GAMEBANK_SILVER_PAY ~= 1) then
		Talk(1,"","ThËt xin lçi! TiÒn trang ®ang söa ch÷a, 2 ngµy sau h·y ®Õn.") 
		return
	end
	-- Ô½ÄÏµÄÒøÔª±¦ÎïÆ·IDÓë´óÂ½°æ±¾µÄ½ğÔª±¦ÎïÆ·IDÒ»ÖÂ
	local nCurTD = CalcEquiproomItemCount(4,417,1,1)
	if (nCurTD >= 20) then
		Say("Chñ tiÒn trang: Kh¸ch quan muèn ®æi <color=green>TiÒn ®ång<color> thµnh d¹ng g×?", 3,"Ta muèn dïng 20 tiÒn ®ång ®æi lÊy 7 ngµy ch¬i/pay_ingot_10a","Ta muèn dïng 20 tiÒn ®ång ®æi lÊy 25 giê ch¬i/pay_ticket_10b","Kh«ng ®æi/no")
	else
		Say("Kh¸ch quan kh«ng ®em theo TiÒn ®ång",1,"§óng råi, ta quªn mang theo/no")
	end
end

function pay_ingot_10a()
	if (SYSCFG_GAMEBANK_SILVER_PAY == nil) then -- ³ö´íÁË~~
		print("pay_silver10 have close, but something is wrong...");
		Msg2Player("Chøc n¨ng bŞ lçi!"); 
		return
	end
	local nCurTD = CalcEquiproomItemCount(4,417,1,1)
	if (nCurTD >= 20) then
		if (ConsumeEquiproomItem(20,4,417,1,1)~= 1) then
			Msg2Player("Quy ®æi thÊt b¹i!") 
			WriteLog(date("%Y%m%d %H%M%S").."\t".." Tµi kho¶n "..GetAccount().."\t"..GetName().."\t".." quy ®æi 20 TiÒn ®ång thµnh 7 ngµy ch¬i thÊt b¹i!")
			return
		end
		UseSilver(1,1,1)
		SaveNow(); -- Á¢¼´´æÅÌ - immediately save 
		WriteLog(date("%Y%m%d %H%M%S").."\t".." Tµi kho¶n "..GetAccount().."\t"..GetName().."\t".." quy ®æi 20 TiÒn ®ång thµnh 7 ngµy ch¬i thµnh c«ng!")
		WriteGoldLog( GetAccount().."("..GetName()..") USE a 343 SILVER for 7 DAY CHARGE", 0, -1, 0 );
		Say("Chñ tiÒn trang: Kh¸ch quan ®· sö dông <color=green>20 TiÒn ®ång<color> ®æi lÊy <color=red>7 ngµy ch¬i<color> thµnh c«ng! Xin kiÓm tra l¹i!", 0)
	end
end

function pay_ticket_10b()
	if (SYSCFG_GAMEBANK_SILVER_PAY == nil) then -- ³ö´íÁË~~
		print("pay_silver10 have close, but something is wrong...");
		Msg2Player("Chøc n¨ng bŞ lçi!"); 
		return
	end
	local nCurTD = CalcEquiproomItemCount(4,417,1,1)
		if (nCurTD >= 20) then
			if (ConsumeEquiproomItem(20,4,417,1,1)~= 1) then
				Msg2Player("Quy ®æi thÊt b¹i!")
				WriteLog(date("%Y%m%d %H%M%S").."\t".." Tµi kho¶n "..GetAccount().."\t"..GetName().."\t".." quy ®æi 20 TiÒn ®ång thµnh 25 giê ch¬i thÊt b¹i!")
				return
			end
			UseSilver(1,0,1)
			SaveNow(); -- Á¢¼´´æÅÌ
			WriteLog(date("%Y%m%d %H%M%S").."\t".." Tµi kho¶n "..GetAccount().."\t"..GetName().."\t".." quy ®æi 20 TiÒn ®ång thµnh 25 giê ch¬i thµnh c«ng!")
			WriteGoldLog( GetAccount().."("..GetName()..") USE a 343 SILVER for 25 HOURS CHARGE", 0, -1, 0 );
			Say("Chñ tiÒn trang: Kh¸ch quan ®· sö dông <color=green>20 TiÒn ®ång<color> ®æi lÊy <color=green>25 giê ch¬i<color> thµnh c«ng! Xin kiÓm tra l¹i!", 0)
		end
end

------------- ¶Ò»»Í­Ç®---------------------
function change_ingot_to_coin()	
--do return end
	local nSilverCount = GetItemCountEx(343);		-- Ôª±¦¸öÊı
	if (SYSCFG_GAMEBANK_SILVER_COIN ~= 1) then
		Talk(1,"","ThËt xin lçi! TiÒn trang ®ang söa ch÷a, 2 ngµy sau h·y ®Õn.")
		return
	end
	if (nSilverCount <= 0) then					-- Ã»ÓĞÔª±¦
		Say("Kh¸ch quan kh«ng mang theo kim nguyªn b¶o?", 1, "§óng råi, ta quªn mang theo/no");
		return
	end
	if CalcFreeItemCellCount() < 5 then
			Talk(1, "", "Kh«ng ®ñ 5 « trèng trong hµnh trang.");
			return 1
	end
	Say("Chñ TiÒn Trang: Kh¸ch quan ®ång ı ®æi Kim Nguyªn b¶o lÊy ®ång tiÒn sao?", 2, "§æi Kim nguyªn b¶o thµnh "..COIN_CHANGE_COUNT_OF_SILVER.."<#> tiÒn ®ång/change_silver_to_coin", "Kh«ng ®æi/no");
end

function change_silver_to_coin()
	if (SYSCFG_GAMEBANK_SILVER_COIN == nil) then -- ³ö´íÁË~~
		print("coin_silver have close, but something is wrong...");
		Msg2Player("Chøc n¨ng bŞ lçi!"); 
		return
	end
	if (GetItemCountEx(343) > 0) then		
		DelItemEx(343);		
		AddStackItem(COIN_CHANGE_COUNT_OF_SILVER, 4, 417, 1, 1, 0, 0, 0 );
		UseSilver(1, 2, 1); -- ÒøÆ±¶Ò»»ÎªÍ­Ç®µÄÏûºÄÍ³¼Æ
		SaveNow(); -- Á¢¼´´æÅÌ
		WriteGoldLog( GetAccount().."("..GetName()..") CHANGE a SILVER into "..COIN_CHANGE_COUNT_OF_SILVER.." COINS", 0, -1, COIN_CHANGE_COUNT_OF_SILVER );
		--local nSilverCount = GetItemCountEx( 343 );		-- Ôª±¦¸öÊı
		--if( nSilverCount > 0 ) then
		--	Say( "Ç®×¯ÀÏ°å£ºÄúµÄÔª±¦ÒÑ³É¹¦¶Ò»»³É"..COIN_CHANGE_COUNT_OF_SILVER.."<#>¸öÍ­Ç®£¬Çë¿ÍÙÄºË²é¡£", 2, "ÖªµÀÁË/no", "ÔÙ¶Ò»»Ò»Ğ©Í­Ç®/change_coin" );
		-- Say ("banks Boss: Your ingot has been successfully converted into" .. COIN_CHANGE_COUNT_OF_SILVER .. "<#> months coins, treat groom verification.", 2, "know / no", "and then exchange some coins / change_coin "); 
		--else
		Say("Kh¸ch quan ®· ®æi thµnh c«ng Kim Nguyªn B¶o lÊy "..COIN_CHANGE_COUNT_OF_SILVER.."<#> tiÒn ®ång! Xin kiÓm tra l¹i!",0);
		-- Say ("banks Boss: Keguan change ingot out" .. COIN_CHANGE_COUNT_OF_SILVER .., 0 "<#> coins Keguan please check again!"); 
		--end
	end
end

------------ ¹ØÓÚÍ­Ç® ------------------
function onAboutCoin()
	Talk( 2,"","Ç®×¯ÀÏ°å£º¿ÉÒÔ´øÔª±¦µ½±¾µê»»³ÉÍ­Ç®, 1 <color=yellow>Ôª±¦<color>»»µÃ<color=yellow>"..COIN_CHANGE_COUNT_OF_SILVER.."<color> Í­Ç®¡£Ôª±¦»»³ÉÍ­Ç®ºó£¬¾Í²»ÄÜ»»»ØÀ´ÁË","Í­Ç®¿ÉÒÔµ½¸÷³ÇÊĞµÄÉÌ··´¦ÂòÆæÕäÒì±¦.","µã»÷Êó±ê×ó¼üµ½Ò»¸öÍ­Ç®ÉÏ£¬À­³öÁíÒ»¸öÍ­Ç®µşÔÚÉÏÃæ£¬×î¶àÎª<color=yellow>100¸ö<color>. °´¼üÅÌ<color=yellow>Shift<color> ÒÔ¼°°´Êó±ê×ó¼üµ½Ò»¸öÍ­Ç®ÉÏ£¬ÊäÈëÏë»»µÄÇ®Êı£¬°´È·¶¨À´Íê³É¡£!");
-- Talk (2, "", "banks boss: can be replaced with gold coins to shop, 1 <color=yellow> ingot <color> exchange <color=yellow>" .. COIN_CHANGE_COUNT_OF_SILVER .. "<color> gold coins After the switch to coins, you can not change back, "and" coins to traders can buy at various cities treasures. "," click on the left mouse button to a coins, pull coins stacked on top of another, up to . <color=yellow> 100 ? <color> <color=yellow> Shift <color> the keyboard and press the left mouse button to count the money on one coins, enter want to change, and press OK to finish. ")!; 
end
----------------------------------------
function no()
end