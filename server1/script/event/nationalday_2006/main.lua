
-- ====================== ÎÄ¼şĞÅÏ¢ ======================

-- ½£ÏÀÇéÔµonline 2006 Äê¹úÇì½Ú»î¶¯Npc¶Ô»°ÎÄ¼ş
-- Edited by peres
-- 2006/09/26 PM 14:52

-- ¾ÍÈçÍ¬ËıµÄĞ¦´ÓÀ´¶¼²»ÊÇ´ú±í¿ìÀÖ£¬
-- ËıµÄ¿ŞÆüÒ²Ã»ÓĞÈÎºÎÒâÎ¶¡£
-- ËıËµ£¬ºÃÁË¡£
-- ÎÒÃÇËµ»á¶ù»°°É¡£
-- ÄÃÁËÈ¹×ÓºÍÄÚÒÂ£¬·Ç³£³Á¾²µØÒ»¼şÒ»¼ş´©ÉÏ¡£
-- Ì¬¶ÈÓĞÃ÷ÏÔµÄÉúÊè£¬·Â·ğÏëÍË»Øµ½ËıµÄÊÀ½çÀïÈ¥¡£

-- ======================================================

-- ¶ÁÈë¹úÇì½Ú»î¶¯Í·ÎÄ¼ş
Include("\\script\\event\\nationalday_2006\\head.lua");

-- ¶ÁÈë¶Ô»°×Ö·û´¦ÀíÎÄ¼ş
Include("\\script\\task\\system\\task_string.lua");

-- 2006 Äê¹úÇì½Ú¶Ô»°Èë¿Ú
function nationalday_2006_main()

	local aryTalk = {
			"<dec><npc>µ±½ñÎäÁÖ£¬ÈË½Ü±²³ö£¬¸÷´óÃÅÅÉíÂ¾«Í¼Ç¿¡£µ±´ËÂÒÊÀ£¬¸÷Î»ÈÔÎªÎäÁÖÃË¾¡ĞÄ½ßÁ¦¡£Ç¡·ê¼Ñ½Ú£¬¶À¹ÂÃËÖ÷ÌØÎª¸÷Î»ÏÀÊ¿ÏÀÅ®ËÍÉÏ½ÚÈÕºØÀñ£¬´ó¼Ò¿ÉÒÔÔÚ<color=yellow>01 th¸ng 10 ®Õn ngµy 03 th¸ng 10<color>ÁìÈ¡£¬×îºó×£ºÏ¼Ò°²¿µ£¬ÍòÊÂÈçÒâ£¡",
			"NhËn phÇn th­ëng kinh nghiÖm hµng ngµy/getMoreExp_Confirm",
			"T×m hiÓu vÒ viÖc t¨ng tû lÖ kİch ho¹t nhiÖm vô ngÉu nhiªn/getRandomTaskInfo",
			"Tin tøc vÒ hiÖu qu¶ gÊp ®«i c¸c lo¹i thuèc/getBaijuInfo",
			"KÕt thóc ®èi tho¹i/OnExit",
		};
	
	CreateTaskSay(aryTalk);
	
	return 1;

end;

function getDoubleExp()

-- È¡µÃÈÕÆÚ
local nDate  = tonumber(GetLocalDate("%y%m%d"));
	
	-- Èç¹ûÈÕÆÚ²»¶Ô£¬Ö±½Ó·µ»Ø
	if isNationalDay()==0 then
		Say("ÏÖÔÚÒÑ¾­²»ÊÇ¹úÇì½ÚµÄÇ°ÈıÌìÁËÅ¶£¡", 0);
		return
	end;

	-- Èç¹ûµÈ¼¶Î´´ïµ½ 80 ¼¶
	if GetLevel()<80 then
		Say("Ö»ÓĞ 80 ¼¶ÒÔÉÏµÄÈË²ÅÄÜÁìÈ¡Ë«±¶¾­ÑéÅ¶£¡", 0);
		return
	end;

	if nDate~= GetTask(ID_GETDOUBLEEXP_DATE) then
	
		SetTask(ID_GETDOUBLEEXP_DATE, nDate);
		SetTask(ID_GETDOUBLEEXP_NUM, 1);	
		
	elseif GetTask(ID_GETDOUBLEEXP_NUM)>=1 then
	
		Say("Äã½ñÌìÒÑ¾­ÁìÈ¡¹ıÁËË«±¶¾­ÑéÁËÅ¶£¡", 0);
		return
		
	else
	
		SetTask(ID_GETDOUBLEEXP_DATE, nDate);
		SetTask(ID_GETDOUBLEEXP_NUM, 1);
			
	end;
	
	-- 80 ¼¶ÒÔÉÏµÄÈËÃ¿Ìì¿ÉÒÔÁìÈ¡Ò»´Î 8 Ğ¡Ê±¾­ÑéË«±¶
	if GetLevel()>=80 then
	
		AddSkillState(531,10,1,8*60*60*18);
		AddSkillState(461,1, 1,8*60*60*18);
		
		Msg2Player("ÄúµÃµ½ÁË<color=green> 8 Ğ¡Ê±µÄË«±¶¾­Ñé£¡<color>");
		WriteTaskLog("µÃµ½ÁË 8 Ğ¡Ê±µÄË«±¶¾­Ñé£¡");
		
	else
		Say("Ö»ÓĞ 80 ¼¶ÒÔÉÏµÄÈË²ÅÄÜÁìÈ¡Ë«±¶¾­ÑéÅ¶£¡", 0);
	end;

end;


function getTaskBook()

local nRandomTaskID, nRandomItemIndex = 0, 0;

-- È¡µÃÈÕÆÚ
local nDate  = tonumber(GetLocalDate("%y%m%d"));
	
	-- Èç¹ûÈÕÆÚ²»¶Ô£¬Ö±½Ó·µ»Ø
	if isNationalDay()==0 then
		Say("ÏÖÔÚÒÑ¾­²»ÊÇ¹úÇì½ÚµÄÇ°ÈıÌìÁËÅ¶£¡", 0);
		return
	end;
	
	-- Èç¹ûÊÇ·Ç³å¿¨ÓÃ»§
	if IsCharged()==0 then
		Say("±¾´Î¹úÇì½Ú»î¶¯Ö»ÓĞ³å¿¨ÓÃ»§²ÅÄÜ²ÎÓëÅ¶£¡", 0);
		return
	end;
	
	-- Èç¹ûµÈ¼¶Î´´ïµ½ 80 ¼¶
	if GetLevel()<80 then
		Say("Ö»ÓĞ 80 ¼¶ÒÔÉÏµÄÈË²ÅÄÜÁìÈ¡Õâ¸öÈÎÎñ¾íÖáÅ¶£¡", 0);
		return
	end;
	
	if nDate~= GetTask(ID_GETTASKBOOK_DATE) then
	
		SetTask(ID_GETTASKBOOK_DATE, nDate);
		SetTask(ID_GETTASKBOOK_NUM, 1);	
		
	elseif GetTask(ID_GETTASKBOOK_NUM)>=1 then
	
		Say("Äã½ñÌìÒÑ¾­ÁìÈ¡¹ıÁËÒ»¸öÈÎÎñ¾íÖáÅ¶£¡", 0);
		return
		
	else
	
		SetTask(ID_GETTASKBOOK_DATE, nDate);
		SetTask(ID_GETTASKBOOK_NUM, 1);	
		
	end;
	
	-- Ñ¡ÔñÒ»¸öµÚ¶ş²ãµÄËæ»úÈÎÎñ
	nRandomTaskID = TaskNo(selectNextTask());
		
	-- Éú³ÉÒ»¸öÈÎÎñ¾íÖá
	nRandomItemIndex = AddItem(6, 2, 2, 0, 1, 0, 0);
	SetItemMagicLevel(nRandomItemIndex, 1, nRandomTaskID);
	
	-- Í¬²½ÎïÆ·Ä§·¨ÊôĞÔ
	SyncItem(nRandomItemIndex);

	Msg2Player("ÄúµÃµ½ÁË<color=green>ÈÎÎñ¾íÖáÒ»¸ö£¡<color>");
	
	WriteTaskLog("µÃµ½ÁËÒ»¸öÈÎÎñ¾íÖá£¬±àºÅÎª£º"..nRandomTaskID);
	
end;


-- Ñ¯ÎÊÍæ¼ÒÊÇ·ñÁìÈ¡¾­Ñé
function getMoreExp_Confirm()
	Say("ÄúÔÚ<color=yellow>2006Äê10ÔÂ01ÈÕÖÁ2006Äê10ÔÂ03ÈÕ<color>ÆÚ¼ä£¬Ã¿ÈÕÉÏÏß¶¼»á»ñµÃ¶À¹ÂÃËÖ÷ÔùËÍµÄ´óÅú¾­Ñé¡£<color=yellow>ÕâÈıÌìÖ®ÄÚÃ¿ÌìÄÜÁìÒ»´Î<color>£¬µ«Á½´ÎÁìÈ¡¾­ÑéÖ®¼äÏà¸ôĞèÒª<color=yellow>ÔÚÏß³¬¹ı1Ğ¡Ê±<color>¡£ÄãÒªÏÖÔÚÁìÈ¡Âğ£¿",2,
		"ºÃ°¡£¬ÎÒÒªÁìÈ¡/getMoreExpMain",
		"»¹ÊÇÔÙµÈÒ»ÏÂ°É/OnExit");
	return
end;


-- ÁìÈ¡Ã¿ÈÕµÄ¾­Ñé
function getMoreExpMain()

local nExp = countMoreExpNum();

-- È¡µÃÈÕÆÚ
local nDate  = tonumber(GetLocalDate("%y%m%d"));
	
	-- Èç¹ûÈÕÆÚ²»¶Ô£¬Ö±½Ó·µ»Ø
	if isNationalDay()==0 then
		Say("ÏÖÔÚÒÑ¾­²»ÊÇ¹úÇì½ÚµÄÇ°ÈıÌìÁËÅ¶£¡", 0);
		return
	end;
	
	-- Èç¹ûÊÇ·Ç³å¿¨ÓÃ»§
	if IsCharged()==0 then
		Say("±¾´Î¹úÇì½Ú»î¶¯Ö»ÓĞ³å¿¨ÓÃ»§²ÅÄÜ²ÎÓëÅ¶£¡", 0);
		return
	end;
	
	if canGetMoreExp()==1 then
		if GetLevel()<50 then
			addPlayerExpForLimit(nExp, 5); -- ÏŞÖÆÖ»ÄÜÉı 5 ¼¶
		else
			addPlayerExpForLimit(nExp, 0); -- ²»ÏŞÖÆ
		end;
		
		Msg2Player("ÄúµÃµ½ÁËÔªµ©»î¶¯µÄ¾­Ñé½±Àø£º<color=yellow>"..nExp.."<color> µã¾­Ñé£¡");
		
		writeMoreExpData();  -- ¼ÇÂ¼ÁìÈ¡¾­ÑéµÄÏà¹ØÊı¾İ
	
		WriteTaskLog("µÃµ½Ã¿ÈÕµÄ½±Àø¾­Ñé£º"..nExp);
		
	else
		Say("ÄãÏÖÔÚµÄÌõ¼ş²»ÄÜ¹»ÁìÈ¡Ã¿ÈÕµÄ¾­Ñé£¬ÔÚ10ÔÂ01ÈÕÖÁ10ÔÂ03ÈÕÆÚ¼ä£¬Ã¿ÈÕÉÏÏß¶¼»á»ñµÃ¶À¹ÂÃËÖ÷ÔùËÍµÄ´óÅú¾­Ñé¡£<color=yellow>ÕâÈıÌìÖ®ÄÚÃ¿ÌìÄÜÁìÒ»´Î<color>£¬µ«Á½´ÎÁìÈ¡¾­ÑéÖ®¼äÏà¸ôĞèÒª<color=yellow>ÔÚÏß³¬¹ı1Ğ¡Ê±<color>Å¶£¡", 0);
		return
	end;


end;


function getRandomTaskInfo()

	Say("ÄúÔÚ <color=yellow>2006Äê10ÔÂ01ÈÕÖÁ2006Äê10ÔÂ03ÈÕ<color> »ñµÃÁËËæ»úÈÎÎñ´¥·¢¸ÅÂÊ·­±¶µÄºØÀñ£¡", 0);
	return

end;


function getBaijuInfo()

	Say("ÄúÔÚ <color=yellow>2006Äê10ÔÂ01ÈÕÖÁ2006Äê10ÔÂ03ÈÕ<color>£¬Ê¹ÓÃ°×¾ÔÍè¹Ò»ú»ñµÃµÄ¾­Ñé¡¢¼¼ÄÜ°×¾ÔÍè¹Ò»ú»ñµÃÊìÁ·¶È½«·­ 1.5 ±¶¡£µ«ÊÇ<color=yellow>Ãâ·ÑÍĞ¹ÜµÄ¾­Ñé²»ÔÚ´ËÁĞ<color>¡£", 0);
	return

end;