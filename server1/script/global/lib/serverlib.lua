
-------------------------------------------------
IncludeLib("ITEM")
IncludeLib("NPCINFO")
IncludeLib("RELAYLADDER");	--≈≈––∞Ò
IncludeLib("FILESYS") --: de dung dc ham doc file
IncludeLib("TASKSYS")---:  DE DUNG TASK SYS FILE
IncludeLib("SETTING")--- : Dung lien wan den ham ST_
IncludeLib("TIMER") --li™n quan Æ’n hµm timer (g‰i id from tasklist.ini)
IncludeLib("BATTLE");
IncludeLib("TITLE");


Include("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\dailogsys\\g_dialog.lua")
Include("\\script\\lib\\progressbar.lua"); 
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\string.lua");
Include("\\script\\vng_lib\\files_lib.lua")
Include("\\script\\task\\task_addplayerexp.lua");
Include("\\script\\lib\\player.lua")
Include("\\script\\activitysys\\npcfunlib.lua")
Include("\\script\\global\\login_head.lua")
Include("\\script\\global\\logout_head.lua")

local LOG_PATH = 
{
	["exp"] = "dark_dulieu/record_exp/",
	["award"] = "dark_dulieu/record_award/",
	["log"] = "dark_dulieu/record_log/",

}

---------------------[LIEN QUAN DEN SOURCE VINA]----------------------------------------
---D u ng∑ ~ tËng kim
SOURCE_PLAYER_TOTALPOINT	= 1;
SOURCE_PLAYER_KILLER		= 2;
SOURCE_PLAYER_KILLNPC		= 3;
SOURCE_PLAYER_BEKILL		= 4;
SOURCE_PLAYER_SNAPFLAG	= 5;
SOURCE_PLAYER_GOLD		= 17;
SOURCE_PLAYER_MAXLIENTRAM	= 13;
SOURCE_PLAYER_CURLIENTRAM	= 14;
SOURCE_PLAYER_PARAM1 		= 22	-- ”√”⁄º«¬º∂·∆Ïµƒ◊¯±ÍX
SOURCE_PLAYER_PARAM2 		= 23

SOURCE_PLAYER_BATTLEID		= 41;
SOURCE_PLAYER_RULEID		= 42;
SOURCE_PLAYER_BATTLECAMP	= 43;
SOURCE_PLAYER_BATTLESERIES	= 44;
SOURCE_PLAYER_KEYNUMBER	= 45;
SOURCE_PLAYER_LASTDEATHTIME	= 46;
SOURCE_PLAYER_BATTLEPOINT	= 47;
SOURCE_PLAYER_ROUND		= 46;



SOURCE_GAME_KEY	= 1;
SOURCE_GAME_BATTLEID	= 2;
SOURCE_GAME_RULEID	= 3;
SOURCE_GAME_MAPID	= 4;
SOURCE_GAME_CAMP1	= 5;
SOURCE_GAME_CAMP2	= 6;
SOURCE_GAME_MAPIDCONID	= 7;
SOURCE_GAME_RESTTIME		= 8;
SOURCE_GAME_LEVEL		= 9;
SOURCE_GAME_MODE		= 10;
SOURCE_GAME_CAMP1AREA	= 11;
SOURCE_GAME_CAMP2AREA	= 12;
SOURCE_GAME_BATTLESERIES	= 13;
SOURCE_GAME_ROUND		= 14;

---end d u ng∑ ~ tËng kim

--task hi”n thﬁ f12 s∏t thÒ
SOURCE_UI_SATTHU		= 1082;



-----------------------[[TASK SERVER]]----------------------
TASKBASE = 3200;


--Task M∆c Æﬁnh sv
VINHDU_TSKID			= 2501;

--Task S∏t ThÒ
SATTHU_TSKID_DOTASK		= 1;
SATTHU_TSKID_DATETASK 		= 2;
SATTHU_TSKID_MAXBOSS		= 3;

--Task dﬁch quan
DICHQUAN_TSKID_LETTER 		= 4;

--Task Hoa Dang 
HOADANG_TSKID_WIN 		= 5;
HOADANG_TSKID_DATE 		= 6;

--Task V≠Ót Aÿ
VA_TSKID_LIMIT_JOIN		= 7;
VA_TSKID_DATETASK 		= 8;

--task n®ng ÆÈng
ACTIVE_TSKID			= 9;

--Task h‰c k¸ n®ng m´n ph∏i
MP_TSKID_LEARNSKILL9X		= 10;
MP_TSKID_LEARNSKILL12X		= 11;

--Task h‰c skill khinh c´ng.
VS_TSKID_LEARNFLYSKILL		= 12;
VS_TSKID_BEAT_WOOD		= 13;
VS_TSKID_BEAT_SANDBAG		= 14;
VS_TSKID_BEAT_DOLL		= 15;

--Task Nhi÷m vÙ danh v‰ng ba l®ng.
BALANG_TSKID_APHUONG		= 16;
BALANG_TSKID_COLAOTHAI		= 17;
BALANG_TSKID_TIEUNGU		= 18;


SHXT_TSKID			= 19;

---Task TËng Kim
TK_TSKID_CAMP			= 20;
TK_TSKID_ROUND			= 21;
TK_TSKID_KILL			= 22;
TK_TSKID_BEKILL			= 23;
TK_TSKID_SNAPFLAG		= 24;
TK_TSKID_LIENTRAM		= 25;
TK_TSKID_CURLIENTRAM		= 26;
TK_TSKID_BATTLE_LEVEL		= 27;
TK_TSKID_BATTLE_POINT		= 28;
TK_TSKID_PLAYER_RANK		= 29;
TK_TSKID_PLAYER_DEATHTIME	= 30;
TK_TSKID_MAKE_PAY		= 31;
TK_TSKID_KILLNPC	= 32;

--Task U˚ Th∏c
UT_TSKID_BCHSKILL9X		= 32; --giÍ luy÷n skill 9x
UT_TSKID_BCHSKILL12X	 	= 33;--giÍ luy÷n skill 12x
UT_TSKID_BCHNORMALEXP		= 34; --giÍ t®ng exp b◊nh th≠Íng (1.5)
UT_TSKID_BCHSPECIALEXP		= 35; --giÍ t®ng exp g p 3 l«n cÒa 1.5
UT_TSKID_SKILL9XID		= 36; --skill 9x id
UT_TSKID_SKILL12XID		= 37; --skill 12x id
UT_TSKID_ACNORMALEXP	= 39; --thÍi gian nh©n vÀt bæt Æ«u u˚ th∏c t›nh exp normal bch.
UT_TSKID_ACSPECIALEXP_TIMESTART	= 40; --thÍi gian nh©n vÀt bæt Æ«u u˚ th∏c t›nh exp special bch.
UT_TSKID_SKILL9X_TIMESTART	= 40; --thÍi gian nh©n vÀt bæt Æ«u u˚ th∏c t›nh up skill 9x
UT_TSKID_SKILL12X_TIMESTART	= 41; --thÍi gian nh©n vÀt bæt Æ«u u˚ th∏c t›nh up skill 12x
UT_TSKID_TYPEOPT = 42; --dÔng Æ” ph©n bi÷t loπi u˚ th∏c cÒa bch(1),skill(2)

--Task t›n s¯.




--task l´i Æµi
LDAI_TSKID_ENEMY		= 60;
LDAI_TSKID_ROOMKEY		= 61;
LDAI_TSKID_CAMP			= 62;
LDAI_TSKID_MAPID		= 63;

--task l≠u gi˜ vÀt ph»m
BOX_TSKID_START		= 70;
BOX_TSKID_END			= 370;
BOX_TSKID_OPENBOX		= 371;

---task li™n Æ u.
LDAU_TSKID_FLAG							= 372;
LDAU_TSKID_MEM							= 373;
LDAU_TSKID_WIN							= 374;
LDAU_TSKID_LOSE							= 375;
LDAU_TSKID_EQ								= 376;
LDAU_TSKID_TOTALMATCH			= 377;
LDAU_TSKID_PARTNER					= 378; 
LDAU_TSKID_POINT						= 379;

--Task Ladder 
LADDER_TSKID_LIENDAUDON		= 380;
LADDER_TSKID_DATAU					= 381;
LADDER_TSKID_TOPSERVER			= 382;
LADDER_TSKID_TOPWEEKEND		= 383;
LADDER_TSKID_END						= 500;


--Task Su Do
SDO_TSKID_MEM							= 501;
SDO_TSKID_DATAKEY					= 502;
SDO_TSKID_LEVELPM					= 503;

--Task T›n S¯
--Phong K˙
PKY_TSKID_TIMELIMIT					= 511;
PKY_TSKID_MEMTASK					= 512;
PKY_TSKID_NPCPOS14					= 513;
PKY_TSKID_NPCPOS58					= 514;
PKY_TSKID_FINISH							= 515;
PKY_TSKID_DATE							= 516;
PKY_TSKID_LIMITDOTASK				= 517;

--Task D∑ T»u
DTAU_TSKID_TASKTYPE				= 521;
DTAU_TSKID_MAPID					= 522;
DTAU_TSKID_MAINPOINT			= 523;
DTAU_TSKID_TOTALFINISH		= 524;
DTAU_TSKID_TOTALDOTASK		= 525;
DTAU_TSKID_CANCELTASK		= 526;
DTAU_TSKID_POINT250				= 527;
DTAU_TSKID_CURPOINT250		= 528 
DTAU_TSKID_DOTASK				= 529;
DTAU_TSKID_LIMITCANCEL		= 530;
DTAU_TSKID_DATETASK				= 531;


--task b∏n hµng 
SALER_TSKID_MEMBERSHIP		= 532;
SALER_TSKID_ENDCONTRACT	= 533;
SALER_TSKID_SIGNUPTIME		= 534;
---Task Nhi÷m vÙ 12x
TASK12X_TSKID_MAXPOWER		= 535;
TASK12X_TSKID_STEP				= 536;
--Task support award by level
NEWPLAYERAWARD_TSKID_LEVEL	= 537;

--Task Ti™n Th∂o lÈ mi‘n ph›
TTLO_TSKID_FREEUSE	= 538;

--Auto script
AUTOSCRIPT_TSKID_POTION_1 = 539;
AUTOSCRIPT_TSKID_POTION_2 = 540;
AUTOSCRIPT_TSKID_POTION_3 = 541;
AUTOSCRIPT_TSKID_POTION_4 = 542;
AUTOSCRIPT_TSKID_POTION_5 = 543;
AUTOSCRIPT_TSKID_X2EXP_1H = 544;
AUTOSCRIPT_TSKID_X2EXP_8H = 545;

--Task knb quang cao
ADDS_TSKID_MEMBER	= 546;

--Task limit sˆ dÙng b∏nh event t©n thÒ
EVENTCAKE_TSKID_LIMITEAT = 547
EVENTCAKE_TSKID_PAY2EXTENDLIMIT = 548;

--Task ßua Top
TOP10_TSKID_MEM	= 549;
TOP10_TSKID_DOTOP = 550;


DTAU_TSKID_AWARDLEVEL = 551;


--Task tµi kho∂n
ACTIVATEACCOUNT_TSKID_PASTDUE = 552

--Task –p trang bﬁ xanh
ITEMBLUE_TSKID_COUNT = 553;

TUIMAU_TSKID_TOTAL = 555;


--Task nhÀn nhi÷m vÙ ti™u di÷t h∂i t®c Æ«u l‹nh
PLDBOSS_TSKID_MEM = 556;
--Task Nπp thŒ
NAPTHE_TSKID_MEM = 557;
--Task ph«n th≠Îng d∑ t»u 
DTAU_TSKID_AWARDLEVEL_1 = 558;
--c»m nang hoµng kim 
CAMNANGHK_TSKID_MEM = 559;

--Task uy danh
UYDANH_TSKID_COUNT = 560;
--Task c p bÀc exp.
TTL_TSKID_LEVEL = 561;

--Nhi÷m  th´ng th≠¨ng.
THONGTHUONG_TSKID_MEM = 562;
THONGTHUONG_TSKID_DATE = 563;



--nhi÷m vÙ thi™n b∂o khË.
TBKHO_TSKID_MEM = 564;
TBKHO_TSKID_DATE = 565;
TBKHO_TSKID_F3POS = 566;
TBKHO_TSKID_S3POS = 567;
TBKHO_TSKID_TEAM= 568;
TBKHO_TSKID_GETS3POS = 569;


-----add more task for tËng kim 
TK_TSKID_TIMECOUNT_INTKIM = 575;

--add more task v≠Ót ∂i
VA_TSKID_COUNTKILLNPC = 576;

--task boss thu˚ t∆c
PLDPIRATE_TSKID_STEPS = 577;

--task loπn chi’n
LC_TSKID_TOTALJOINMISSION = 578;
LC_TSKID_USEDLENHBAI = 579;

--SkillFree
SKILL_TSKID_FREE = 580;


--task reset bug top
TOP10_TSKID_BUG = 581;

--task save exp 
EXP_TSKID_SAVE = 582;

--task ti™n th∂o lÈ hÁ trÓ
TTL_TSKID_HTRO = 583;


--task gamble
GAMBLE_TSKID_MONEY = 584;


--Task ngµy th∏ng Chung
PUBLIC_TASKID_DATE  = 585;

--Task Limit exp mÎ r≠¨ng b∂o khË.
TBK_TSKID_LIMITEXPAWARD = 586;

--Nhi÷m  th´ng th≠¨ng.
THONGTHUONG_TSKID_MEM1 = 587;
THONGTHUONG_TSKID_NPCID = 588;
THONGTHUONG_TSKID_MAPID = 589;


--Nhi÷m vÙ vi™m Æ’.
VIEMDE_TSKID_MEM = 590;
VIEMDE_TSKID_DATE = 591;

--Nhi÷m vÙ Æπo t∆c
DAOTAC_TSKID_MEM = 598;
DAOTAC_TSKID_DATE = 599;

--nhi÷m vÙ hoµng kim 
TASKHK_TSKID_MEM1 = 600;
TASKHK_TSKID_MEM2 = 601;
TASKHK_TSKID_MEM3 = 603;

--task Bonus Online top 10 
BNUSTOP_TSKID_ONLINE_TIME = 607;
BNUSTOP_TSKID_START_SERVERONLINE = 608;
BNUSTOP_TSKID_DAILY = 609;
BNUSTOP_TSKID_LIMITUSE = 610;

--task daily chung cho t t c∂ nv
DAILY_TSKID_DATE = 611;

--task mÀt ÆÂ th«n b›
MDTB_TSKID_POINT = 612;

--task l´i Æµi
LOIDAI_TSKID_PASSWORD = 613;
LOIDAI_TSKID_MAPID = 614;


--Task x∏c nhÀn lµm c∏c nhi÷m vÙ
ACTIVE_TSKID_1 = 620;--1: v≠Ót ∂i, 2 tËng kim, 3: s∏t thÒ, 4: phong l®ng ÆÈ.
ACTIVE_TSKID_2 = 621; 
ACTIVE_TSKID_3 = 622;
ACTIVE_TSKID_4 = 623;
ACTIVE_TSKID_5 = 624;

--Task x∏c nhÀn mi‘n ph›
FREE_TSKID_1 = 625;


--task month li™n Æ u
LDAU_TSKID_MONTH = 625;

-------------------------------------------------
----------------CONSTANT VALUE-------------------
-------------------------------------------------
CONST_TIMEIN7DAYS		= 585412;
CONST_DATETOPEND = 20160321;

/* function task c∏c hoπt ÆÈng */
function AddTaskActive(nType,nPos,nValue)
	local BaseTask = 619 + nType;
	if BaseTask > ACTIVE_TSKID_5 then 
		Msg2Player("Task Active Errorr!!! Li™n h÷ vÌi Admin.");
		return 
	end
	
	local nCount = GTaskValue(BaseTask,nPos);
	return STaskValue(BaseTask,nPos,nCount + nValue);
end

function GetTaskActive(nType,nPos)
	local BaseTask = 619 + nType;
	return GTaskValue(BaseTask,nPos);
end


function GetMyTeam()
	local orgplayer = PlayerIndex;
	local nTeamSize = GetTeamSize();
	local tbTeam = {};
	if nTeamSize < 2 then 
		return nil,nil;
	end
	
	for k=1,nTeamSize do 
		local memindex = GetTeamMember(k);
		tinsert(tbTeam,memindex);
	end
	
	if getn(tbTeam) == 0 then 
		return nil,nil
	else
		return 1,tbTeam;
	end
end

function IsAccountNapThe()
	local szNoteNapThe = GetNotePlayer("NoteNapThe",GetAccount(),1);
	if szNoteNapThe and szNoteNapThe ~= "" then 
		local tbInfoCard =  split(szNoteNapThe,",");
		if tbInfoCard[3] == "" or tbInfoCard[3] == "Mi‘n ph› 7 ngµy ch¨i" then 
			return 0;
		else	
			return 1;
		end
	end
	return 0;
end

--quy Æﬁnh trang bﬁ Æ∆t vµo.
function CheckItemInUi(tbIndex,nItemCount,tbItem)
	for k=1,nItemCount do 
		local itemidx = GetGiveItemUnit(k);
		local nGenre, nDetailType, nParticular, nLevel, nSeries,nLuck = GetItemProp(itemidx);
		local nVerItem =  ITEM_GetItemVersion(itemidx);
		local nRandSeedItem = ITEM_GetItemRandSeed(itemidx);
		local nQuality = GetItemQuality(itemidx);
		local item_time = GetItemGenTime(itemidx);
		local item_lock = GetItemBindState(itemidx);
		local szItemName = GetItemName(itemidx);
		
		--tbItem = {nQuality,nItemTime,nItemLock,szItemName}
		if tbItem[1] and nGenre == tbItem[1] then --quality
			if nQuality ~= tbItem[1] then 
				Say("Ng≠¨i chÿ Æ≠Óc ph–p b· vµo "..tbItem[4].."",0);
				return nil,nil
			end
			
			if tbItem[2] then --ktra time
				if item_time > 0 then 
					Say("Ng≠¨i kh´ng Æ≠Óc ph–p b· trang bﬁ c„ thÍi gian vµo.",0)
					return nil,nil
				end
			end
			
			if tbItem[3] then --ktra item lock
				Say("Kh´ng Æ≠Óc ph–p b· trang bﬁ Î trπng th∏i kho∏ b∂o hi”m ho∆c kho∏ v‹nh vi‘n.",0);
				return nil,nil
			end
			tinsert(tbIndex,itemidx);
			return 1,tbIndex,{nVerItem,nRandSeedItem,nQuality,nGenre, nDetailType, nParticular, nLevel, nSeries,nLuck,szItemName};
		end
	end
	Say("C«n ph∂i c„ 1 "..tbItem[4].." ",0)
	return nil,nil,nil
end
--no stack
function CheckItemQuestInUi(tbIndex,nItemCount,tbItem)
	local temp = {};
	for k=1,nItemCount do 
		local itemidx = GetGiveItemUnit(k);
		local nCountStack =GetItemStackCount(itemidx) or 1;
		local nGenre, nDetailType, nParticular, nLevel, nSeries = GetItemProp(itemidx);
		local szItemName = GetItemName(itemidx);
		--tbItem = {nGenre,nID,nLevel,nSeries,nAmountReq,szItemName};
		local nID = 0;
		if tbItem[1] == 6 then 
			nID = nParticular;
		elseif tbItem[1] == 4 then 
			nID = nDetailType;
		end
		
		if nGenre == tbItem[1] then
			if nID == tbItem[2] then
				if tbItem[3] and tbItem[4] then --level va series
					tinsert(temp,itemidx)
				elseif tbItem[3] and not tbItem[4] then --level
					tinsert(temp,itemidx)
				elseif not tbItem[3] and tbItem[4] then --series
					tinsert(temp,itemidx)
				elseif not tbItem[3] and not tbItem[4] then --check id only
					tinsert(temp,itemidx)
				end
			end
		end
	end

	local count_temp = getn(temp);
	if count_temp < tbItem[5] then 
		Say("Ng≠¨i kh´ng b· ÆÒ sË l≠Óng vµo. SË l≠Óng c«n lµ: <color=yellow>"..tbItem[5].." "..tbItem[6].." ",0);
		return nil,nil;
	elseif count_temp > tbItem[5] then
		Say("Ng≠¨i b· qu∏ nhi“u. SË l≠Óng c«n chÿ lµ: <color=yellow>"..tbItem[5].." "..tbItem[6].." ",0);
		return nil,nil;
	end
	
	for k=1,count_temp do 
		tinsert(tbIndex,temp[k]);
	end
	return 1,tbIndex;
end

function GetTabIndexRandom(tbItem)
	local rtotal = 10000000
	local rcur=random(1,rtotal);
	local rstep=0;
	for i=1,getn(tbItem) do
		rstep=rstep+floor(tbItem[i].nRate*rtotal/100);
		if(rcur <= rstep) then
			local tb = {};
			for k=1,getn(tbItem) do 
				if tbItem[i].nRate == tbItem[k].nRate then 
					tinsert(tb,k);
				end	
			end
			if getn(tb) >= 2 then 
				local t = RandValueTabStartEnd(1,getn(tb));
				return t[random(1,getn(tb))];
			end
			return i;
		end
	end
	return GetTabIndexRandom(tbItem)
end

function GetIndexTabAward(tbItem)
	local tabindex = GetTabIndexRandom(tbItem);
	return tabindex;
end

function GiveItemAward(tbItem,szMsgLog,IndexTab)
	local tabindex = GetTabIndexRandom(tbItem);
	if IndexTab then 
		tabindex = IndexTab;
	end
	
	local item = tbItem[tabindex];
	if item then 
		if getn(item.tbProp) == 2 and item.tbProp[1] == 0 then --trang bﬁ hoµng kim 
			local ItemIdx = AddGoldItem(unpack(item.tbProp))
			--giÌi hπn thÍi gian
			if item.nLimitTime then 
				LockItemStatus(ItemIdx,item.nLimitTime*24);
			end
			--lock v‹nh vi‘n.
			if item.nLockForever then 
				LockItemStatus(ItemIdx,nil,1);
			end
			Msg2Player("Bπn Æ∑ nhÀn Æ≠Óc 1 trang bﬁ: <color=yellow>"..(item.szName).."<color>")
			_Write2File(format("GetAward_%s",GetLocalDate("%m%d%Y")),{format("Ngµy: %s - Account: [%s] - [Nh©n vÀt: %s] Æ∑ nhÀn Æ≠Óc 1 trang bﬁ [%s] tı ph«n th≠Îng [%s]",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),item.szName,szMsgLog)});
			return 1;
		elseif getn(item.tbProp) == 2 and item.tbProp[1] == 4 or item.tbProp[1] == 6 then --vÀt ph»m questkey,-vÀt ph»m magic
			local ItemIdx = AddItemID(unpack(item.tbProp));
			--giÌi hπn thÍi gian
			if item.nLimitTime then 
				LockItemStatus(ItemIdx,item.nLimitTime*24);
			end
			--lock v‹nh vi‘n.
			if item.nLockForever then 
				LockItemStatus(ItemIdx,nil,1);
			end
			Msg2Player("Bπn Æ∑ nhÀn Æ≠Óc 1 vÀt ph»m: <color=yellow>"..(item.szName).."<color>");
			_Write2File(format("GetAward_%s",GetLocalDate("%m%d%Y")),{format("Ngµy: %s - Account: [%s] - [Nh©n vÀt: %s] Æ∑ nhÀn Æ≠Óc 1 vÀt ph»m [%s] tı ph«n th≠Îng [%s]",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),item.szName,szMsgLog)});
			return 1;
		elseif getn(item.tbProp) == 6 then --add item
			local ItemIdx = AddItem(unpack(item.tbProp));
			
			--giÌi hπn thÍi gian
			if item.nLimitTime then 
				LockItemStatus(ItemIdx,item.nLimitTime*24);
			end
			--lock v‹nh vi‘n.
			if item.nLockForever then 
				LockItemStatus(ItemIdx,nil,1);
			end
			
			Msg2Player("Bπn Æ∑ nhÀn Æ≠Óc 1 vÀt ph»m: <color=yellow>"..(item.szName).."<color>");
			_Write2File(format("GetAward_%s",GetLocalDate("%m%d%Y")),{format("Ngµy: %s - Account: [%s] - [Nh©n vÀt: %s] Æ∑ nhÀn Æ≠Óc 1 vÀt ph»m [%s] tı ph«n th≠Îng [%s]",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),item.szName,szMsgLog)});
			return 1;
		elseif getn(item.tbProp) == 2 and item.tbProp[1] == 5 then --kinh nghi÷m.
			if item.nTaskLimitExp and item.nMaxExpUse then 
				local resetdate = PublicTaskDate();
				if resetdate then 
					sTask(item.nTaskLimitExp,0);
				end
				
				if gTask(item.nTaskLimitExp) >= item.nMaxExpUse then
					Msg2Player("H´m nay Æ∑ nhÀn ÆÒ <color=yellow>"..(item.nMaxExpUse).." kinh nghi÷m<color>, kh´ng th” ti’p tÙc nhÀn th™m");
					return 
				end
				local nTotalExpUse = gTask(item.nTaskLimitExp);
				sTask(item.nTaskLimitExp,nTotalExpUse + item.tbProp[2]);
			end
			
			if item.nTypeExp == 1 then --cÈng dÂn
				AddPlayerExp(item.tbProp[2]);
				Msg2Player("Bπn Æ∑ nhÀn Æ≠Óc <color=yellow>"..(item.tbProp[2]).." kinh nghi÷m<color> cÈng dÂn.");
			elseif item.nTypeExp == 2 then --ko cÈng dÂn
				AddOwnExp(item.tbProp[2]);
				Msg2Player("Bπn Æ∑ nhÀn Æ≠Óc <color=yellow>"..(item.tbProp[2]).." kinh nghi÷m<color> kh´ng th” cÈng dÂn.");
			end
			
			_Write2File(format("GetAward_%s",GetLocalDate("%m%d%Y")),{format("Ngµy: %s - Account: [%s] - [Nh©n vÀt: %s] Æ∑ nhÀn Æ≠Óc kinh nghi÷m [%d] tı ph«n th≠Îng [%s]",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),item.tbProp[2],szMsgLog)});
			return 1;
		elseif getn(item.tbProp) == 2 and item.tbProp[1] == 7 then --ti“n vπn
			Earn(item.tbProp[2])
			Msg2Player("Bπn Æ∑ nhÀn Æ≠Óc <color=yellow>"..(item.tbProp[2]/10000).." vπn<color>.");
			_Write2File(format("GetAward_%s",GetLocalDate("%m%d%Y")),{format("Ngµy: %s - Account: [%s] - [Nh©n vÀt: %s] Æ∑ nhÀn Æ≠Óc [%d] vπn tı ph«n th≠Îng [%s]",GetLocalDate("%m/%d/%Y_%H:%M:%S"),GetAccount(),GetName(),item.tbProp[2]/10000,szMsgLog)});
			return 1;
		end
	end
end

function PublicTaskDate()
	local curday = tonumber(GetLocalDate("%d"));
	local curmonth = tonumber(GetLocalDate("%m"));
	local curyear = tonumber(GetLocalDate("%y"))
	local oldday = GTaskValue(PUBLIC_TASKID_DATE,1);
	local oldmonth = GTaskValue(PUBLIC_TASKID_DATE,2);
	local oldyear = GTaskValue(PUBLIC_TASKID_DATE,3);
	local stroldday = format("%d%d%d",oldmonth,oldday,oldyear);
	local strcurday = format("%d%d%d",curmonth,curday,curyear);
	if stroldday ~= strcurday then 
		STaskValue(PUBLIC_TASKID_DATE,1,curday);
		STaskValue(PUBLIC_TASKID_DATE,2,curmonth);
		STaskValue(PUBLIC_TASKID_DATE,3,curyear);
		return 1;
	end
end


function GetLuckyPlayer()
	local tbFixItem = GetAllEquipment();
	local nQueHT = GetSkillState(450);
	local nTSBL = GetSkillState(441);
	local luckplayer = 1;
	if nQueHT ==  20  then 
		luckplayer = 10;
	end
	
	if nTSBL == 1 then 
		luckplayer = luckplayer + 5;
	end	
	
	for k=1,getn(tbFixItem) do 
		local pG,pD,pP = GetItemProp(tbFixItem[k]);
		if pD == 2 or pD == 3 or pD == 4 or pD == 5 or pD == 6 or pD == 7 or pD == 8 or pD == 9 then --N’u lµ vÚ kh› cÀn chi’n, vÚ kh› t«m xa, ao, gi«y, Æai l≠ng, mÚ, bao tay.
			for i=1,6 do 
				magictype, p1, p2, p3 = GetItemMagicAttrib(tbFixItem[k], i)
				if magictype == 135 then --may man
					--range 1 - 10;
					luckplayer = luckplayer + (p1*2);
				end
			end			
		end
	end
	return luckplayer
end

function LockChucNangByTop(szMsg)
	if gTask(TOP10_TSKID_DOTOP) > 0 then 
		Msg2Player(szMsg);
		return 
	end
	return 1;
end

function PlayerIP(ntype)
	local _,_,num_1,num_2,num_3,num_4 = strfind(GetIP(),"(%d+).(%d+).(%d+).(%d+)")
	local str = format("%d%d%d%d",num_1,num_2,num_3,num_4);
	if ntype == 1 then 
		return tonumber(str);
	else
		return str;
	end
end


function CONSTNewPlayer_ClearStatusPlayer()
	AddSkillState(472, 5, 1,0)
	AddSkillState(546, 50,1,0)
	ForbidChangePK(0);
	SetPKFlag(0);
	ForbidEnmity(0);
end

function SetLockTrapOut(nStartDate,nEndDate,nTimeActivate,nStateStatus,tbMoveIn,szMsg)
	local nStateFight = GetFightState();
	if nStateFight == nStateStatus then 
		local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
		if nCurDate >= nStartDate and nCurDate <= nEndDate then 
			local nTime = tonumber(GetLocalDate("%H%M"));
			if nTime < nTimeActivate then
				if tbMoveIn then 
					SetPos(tbMoveIn[1],tbMoveIn[2]);
				end
				
				Msg2Player(szMsg);
				return nil
			end
		end
	end
	return 1;
end

function SetStateSafePK(nStartDate,nEndDate,nTimeStop,szMsg)
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
	if nCurDate >= nStartDate and nCurDate < nEndDate then
		ForbidChangePK(1);
		SetPKFlag(0);
		ForbidEnmity(1);
		Msg2Player(szMsg)
	elseif nCurDate == nEndDate then 
		local nTime = tonumber(GetLocalDate("%H%M"));
		if nTimeStop and nTime >= nTimeStop then 
			ForbidChangePK(0);
			SetPKFlag(0);
			ForbidEnmity(0);
			return 
		end
	else
		ForbidChangePK(0);
		SetPKFlag(0);
		ForbidEnmity(0);
	end
end


function CloseActivity(nType,nStartDate,nEndDate,nTimeOpen,szMsg)
	if nType == 1 then --Æ„ng
		local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
		local nTime = tonumber(GetLocalDate("%H%M"));
		--check ngµy
		if nStartDate and nEndDate then 
			if nCurDate >= nStartDate and nCurDate < nEndDate then --ngµy Æ„ng
				if szMsg and szMsg ~= "" then 
					Msg2Player(szMsg)
				end
				return 
			elseif nCurDate == nEndDate then --ngµy mÎ
				--thÍi gian mÎ activity;
				if nTimeOpen then 
					if nTime >= nTimeOpen then 
						return 1;
					else
						if szMsg and szMsg ~= "" then 
							Msg2Player(szMsg)
						end
						return
					end
				end
			end
		else
			return 1;
		end
	end
	
	return 1
end

function LockItemStatus(nItemIdx,nTime,nState)
	if not nItemIdx then 
		return 
	end
	--chÿnh thÍi gian.
	if nTime then 
		ITEM_SetExpiredTime(nItemIdx,nTime*60);
	end
	--lock v‹nh vi‘n
	if nState then 
		SetItemBindState(nItemIdx,-2);
	end
	SyncItem(nItemIdx);
end

function GetMSPlayerTab(nMissionID)
	local index = 0;
	local player = 0;
	local players = {}
	local i = 1
	while (1) do
		index, player = GetNextPlayer(MISSION_MATCH, index, 0);
		if (player > 0) then
			players[i] = player
			i = i + 1
		end
		if (index == 0) then
			break;
		end	
	end
	return players;
end

function GetDateByLogin(nPlayerIndex)
	PlayerIndex = nPlayerIndex;
	local mylogintime = GetLoginTime();
	local tbDate = Time2Tm(mylogintime);
	local nYear = tbDate[1];
	local nMonth = tbDate[2];
	local nDay = tbDate[3];
	return nDay,nMonth,nYear;
end

function GetTimeByGameTime(nTime)
	local totalmin = nTime/3600;
	local _hour = floor(totalmin/60);
	local _min = floor(totalmin - (_hour*60));
	return _hour,_min;
end


function AddPhucDuyen(nPoint)
	local totalpd = GetTask(151)
	SetTask(151,totalpd + nPoint);
end

function GetPhucDuyen()
	return GetTask(151);
end

function AddDanhVong(nPoint)
	return AddRepute(nPoint);
end

function GetDanhVong()
	return GetRepute();
end	


function AddItemID(nPar,nID,nLevel)
	local itemidx = 0;
	if not nLevel then 
		nLevel = 1;
	end
	
	if nPar == 4 then 
		itemidx = AddItem(nPar,nID,nLevel,1,0,0);
	elseif nPar == 6 then 
		if nID <= 11 then
			itemidx = AddItem(nPar,0,nID,nLevel,1,0,0);
		else
			itemidx = AddItem(nPar,1,nID,nLevel,1,0,0);
		end
	end
	
	return itemidx;
end


function DelItemID(nPar,nID,nNum)
	if nPar == 4 then 
		idxdel = ConsumeEquiproomItem(nNum,nPar,nID,1,-1);
	elseif nPar == 6 then 
		idxdel = ConsumeEquiproomItem(nNum,nPar,1,nID,-1);
	end
	
	return idxdel;
end

function GetCountItemID(nPar,nID,nLevel)
	local count = 0;
	if not nLevel then 
		nLevel = 1;
	end
	
	if nPar == 4 then 
		count = CalcEquiproomItemCount(4,nID,nLevel,-1)
	elseif nPar == 6 then
		count = CalcEquiproomItemCount(6,1,nID,nLevel)
	end
	
	return count;
end

function GetRoomHanhTrang(nType,nWide,nLength)
	if nType == 0 then --check tıng ´ trong hµnh trang.
		if nWide and CalcFreeItemCellCount() < nWide then 
			Say("Hµnh trang kh´ng ÆÒ "..nWide.." ´ trËng",0);
			return
		end
		return 1;
	elseif nType == 1 then --check theo khung dµi rÈng
		if nWide and nLength and CountFreeRoomByWH(nWide,nLength,1) < 1 then 
			Say("Hµnh trang kh´ng c„ ÆÒ kho∂ng trËng "..nWide.." x "..nLength.." ",0);
			return 
		end
		return 1;
	end
	
	return 1;
end


function tbSayEx(tbOpt)
	local nNpcIndex = GetLastDiagNpc();
	local szNpcName = GetNpcName(nNpcIndex);
	
	if NpcName2Replace then 
		szNpcName = NpcName2Replace(szNpcName);
	end
	
	local tb = DailogClass:new(szNpcName);
	if not tbOpt or type(tbOpt) ~= "table" or getn(tbOpt) == 0 then 
		Say("Xin chµo: Æ∑ tham gia v‚ l©m private online.",0);
		return
	end
	
	tb.szTitleMsg = tbOpt[1];
	local count = getn(tbOpt);
	--tbOpt = {"",{"",funct,{param}},{"",funct,{parama}}}
	for k=2,count do 
		local tbtemp = tbOpt[k]
		if not tbtemp[3] then 
			tb:AddOptEntry(tbtemp[1],tbtemp[2]);
		else
			local t = {};
			t[1] = tbtemp[3][1];
			local ncount_ = getn(tbtemp[3][2]);
			for d=1,ncount_ do 
				tinsert(t,tbtemp[3][2][d]);
			end
			tb:AddOptEntry(tbtemp[1],tbtemp[2],t);
		end
	end
	tb:Show();
end




function LockStatus(nType,nLock)
	if nType == 1 then --lock pk only
		if not nLock then --unlock nLock == nil
			ForbidChangePK(0);
			SetPKFlag(0);
		else
			--c m change pk 
			ForbidChangePK(nType);
			SetPKFlag(nLock);
		end
	elseif nType == 2 then --c m giao bu´n b∏n
		if nLock == 1 then --c m	
			DisabledStall(1)
		else
			DisabledStall(0);
		end
	elseif nType == 3 then --c m move vÀt ph»m trong hµnh trang
		if nLock == 1 then --c m
			ForbitTrade(1)
		else
			ForbitTrade(0)
		end
	elseif nType == 4 then --lock h’t.
		if not nLock then --unlock
			ForbidChangePK(0);
			ForbitTrade(0);
			DisabledUseTownP(0)
			SetPKFlag(0);
			DisabledStall(0);
		else
			ForbidChangePK(1);
			DisabledStall(1);
			ForbitTrade(1);
			DisabledUseTownP(1)
			SetPKFlag(nLock);
		end
	elseif nType == 5 then --lock thÊ Æﬁa phÔ
		if nLock == 1 then --c m
			DisabledUseTownP(1);
		else
			DisabledUseTownP(0)
		end
	end
end

function StartDamage(nPlayerIndex)
	CallPlayerFunction(nPlayerIndex, ST_StartDamageCounter)
end

function StopDamage(nPlayerIndex)
	CallPlayerFunction(nPlayerIndex, ST_StopDamageCounter)
end

function GetDamage(nPlayerIndex)
	local Damage = CallPlayerFunction(nPlayerIndex, ST_GetDamageCounter);
	StopDamage(nPlayerIndex);
	StartDamage(nPlayerIndex);
	return Damage;
end

function UiString(szFunctName,Length,szMsg)
	AskClientForString(szFunctName, "", 1, Length,szMsg);
end

function UiNumber(szFunctName,Length,szMsg)
	AskClientForNumber(szFunctName, 0,Length,szMsg);
end



/* Ui c„ th” g‰i tı function table*/
tbDarkUi = {};
--pFunData = {"Function name",tbParam}

function GiveUiNumber(szTitle,szClassName,pFunData,nLength)
	tbDarkUi[PlayerIndex] = {szClassName,pFunData};
	AskClientForNumber("GiveBackUiNumber",0,nLength,szTitle);
end

function GiveBackUiNumber(nCount)
	local pData = tbDarkUi[PlayerIndex];
	tbDarkUi[PlayerIndex] = nil;
	if pData and pData[1] then 
		local szClassName = pData[1];
		local tbFunData = pData[2];
		local szFunctName = tbFunData[1];
		local tbParam = tbFunData[2];
		local pFunClassName = dostring(format("return %s",szClassName))
		local pFunCall = dostring(format("return %s.%s",szClassName,szFunctName));
		if not tbParam then 
			return pFunCall(pFunClassName,nCount);
		else
			local tbFinalParam = {};
			tinsert(tbFinalParam,nCount);
			for k=1,getn(tbParam) 
				do tinsert(tbFinalParam,tbParam[k]); 
			end
			return pFunCall(pFunClassName,unpack(tbFinalParam))
		end
	end
end

function GiveUiString(szTitle,szClassName,pFunData,nLength)
	tbDarkUi[PlayerIndex] = {szClassName,pFunData};
	AskClientForString("GiveBackUiString","", 1,nLength,szTitle);
end

function GiveBackUiString(nCount)
	local pData = tbDarkUi[PlayerIndex];
	tbDarkUi[PlayerIndex] = nil;
	if pData and pData[1] then 
		local szClassName = pData[1];
		local tbFunData = pData[2];
		local szFunctName = tbFunData[1];
		local tbParam = tbFunData[2];
		local pFunClassName = dostring(format("return %s",szClassName))
		local pFunCall = dostring(format("return %s.%s",szClassName,szFunctName));
		if not tbParam then 
			return pFunCall(pFunClassName,nCount);
		else
			local tbFinalParam = {};
			tinsert(tbFinalParam,nCount);
			for k=1,getn(tbParam) 
				do tinsert(tbFinalParam,tbParam[k]); 
			end
			return pFunCall(pFunClassName,unpack(tbFinalParam))
		end
	end
end

function GiveUi(szTitle,szContent,szClassName,pFunData)
	tbDarkUi[PlayerIndex] = {szClassName,pFunData}
	GiveItemUI(szTitle, szContent,"GiveBackUi","GiveUiCancel",1)
end

function GiveBackUi(nCount)
	local pData = tbDarkUi[PlayerIndex];
	tbDarkUi[PlayerIndex] = nil;
	if pData and pData[1] then 
		local szClassName = pData[1];
		local tbFunData = pData[2]
		local szFunctName = tbFunData[1];
		local tbParam = tbFunData[2];
		local pFunClassName = dostring(format("return %s",szClassName))
		local pFunCall = dostring(format("return %s.%s",szClassName,szFunctName));
		if not tbParam then 
			return pFunCall(pFunClassName,nCount);
		else
			local tbFinalParam = {};
			tinsert(tbFinalParam,nCount);
			for k=1,getn(tbParam) 
				do tinsert(tbFinalParam,tbParam[k]); 
			end
			return pFunCall(pFunClassName,unpack(tbFinalParam))
		end
	end
end

function GiveUiCancel()
end

/* End Ui c„ th” g‰i tı function table*/


function SetTaskSource()
	BT_SetType2Task(1, 751)
	for i = 2, 50 do 
		BT_SetType2Task(i, 700 + i);
	end
end

function MyID(nTaskID)
	return (TASKBASE + nTaskID);
end

function SetTaskSystem(nTaskID, nTaskValue)
	SetTask(nTaskID, nTaskValue);
	SyncTaskValue(nTaskID);
end

function GetTaskSystem(nTaskID)
	return GetTask(nTaskID);
end

function sTask(nTaskID,nTaskValue,nKindTask)
	if nKindTask then 
		SetTask(nTaskID,nTaskValue);
		SyncTaskValue(nTaskID);
		return 
	end
	
	local myTaskID = nTaskID + %TASKBASE;
	SetTask(myTaskID,nTaskValue);
	SyncTaskValue(myTaskID);
end

function gTask(nTaskID,nKindTask)
	if nKindTask then 
		return GetTask(nTaskID);
	end
	
	local myTaskID = nTaskID + %TASKBASE;
	return GetTask(myTaskID);
end

--4 position only, max value 250;
function STaskValue(nTaskID,nPosition,nValue)
	local nByteValue = SetByte(%gTask(nTaskID),nPosition,nValue);
	%sTask(nTaskID,nByteValue);
end

function GTaskValue(nTaskID,nPosition)
	local nTask = %gTask(nTaskID);
	local nByteValue = GetByte(nTask,nPosition);
	return nByteValue;
end


JXG4VN_tbTaskReset = {};
JXG4VN_tbTaskReset[1] = {}; --ko ph∂i byte task 
JXG4VN_tbTaskReset[2] = {};--byte task 

--tbCondTask = {nTaskDoTask,nPosDoTask,ResetValue}
function AddTaskReset(nTaskBase,nPosTask,nValueReset,tbCondTask,szNameTask)
	if nPosTask then --byte
		tinsert(JXG4VN_tbTaskReset[2],{nTaskBase,nPosTask,nValueReset,tbCondTask,szNameTask});
	else --no byte
		tinsert(JXG4VN_tbTaskReset[1],{nTaskBase,nPosTask,nValueReset,tbCondTask,szNameTask});
	end
end

function ResetDailyTaskLogin()
	local count_tbregtask = getn(JXG4VN_tbTaskReset[1])
	local count_tbvaluetask = getn(JXG4VN_tbTaskReset[2])
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"))
	local nTaskDate = gTask(DAILY_TSKID_DATE);
	if nCurDate == nTaskDate then 
		return 
	end
	
	sTask(DAILY_TSKID_DATE,nCurDate);
	--reset no byte task 
	if count_tbregtask > 0 then 
		for k=1,count_tbregtask do 
			local temp = JXG4VN_tbTaskReset[1][k];
			if not temp[4] then --ko c„ Æi“u ki÷n.
				-- print("RESET TASK",temp[1]);
				sTask(temp[1],temp[3]);
			else
				if gTask(temp[4][1]) > 0 then --check n’u lµ mem cÒa 1 task nµo Æ„ mµ ch≠a hoµn thµnh reset task Æ∑ giÌi hπn v“ resetvalue m∆c Æﬁnh.
					-- print("RESET TASK COND",temp[1])
					sTask(temp[1],temp[4][3]);
				end
			end
		end
	end
	
	--reset byte task 
	if count_tbvaluetask > 0 then 
		for k=1,count_tbvaluetask do 
			local temp = JXG4VN_tbTaskReset[2][k];
			if not temp[4] then --ko c„ Æi“u ki÷n.
				-- print("RESET TASK VALUE ",temp[1]);
				STaskValue(temp[1],temp[2],temp[3]);
			else
				if GTaskValue(temp[4][1],temp[4][2]) > 0 then --check n’u lµ mem cÒa 1 task nµo Æ„ mµ ch≠a hoµn thµnh reset task Æ∑ giÌi hπn v“ resetvalue m∆c Æﬁnh.
					-- print("RESET TASK VALUE COND",temp[1]);
					STaskValue(temp[1],temp[2],temp[4][3]);
				end
			end
		end
	end
end

function SetTaskDaily(nTask,nTime,nTypeValueTask,nPosTask)
	local nCurDate = tonumber(GetLocalDate("%Y%m%d"))
	local nTaskDate = gTask(DAILY_TSKID_DATE);
	if nCurDate ~= nTaskDate then 
		sTask(DAILY_TSKID_DATE,nCurDate);
	end
	
	if not nTypeValueTask then --task b◊nh th≠Íng ko dÔng byte.
		local nTaskDaily = gTask(nTask);
		return sTask(nTask,nTaskDaily + nTime);
	else
		local nTaskDaily = GTaskValue(nTask,nPosTask);
		return STaskValue(nTask,nPosTask,nTaskDaily + nTime);
	end
end

function CheckTaskDaily(nTask,nTimeCheck,szMsg,nTypeTaskValue,nPosTask)
	if not nTypeTaskValue then --ko ph∂i byte.
		nTaskDaily = gTask(nTask)
	else
		nTaskDaily = GTaskValue(nTask,nPosTask);
	end
	
	if nTaskDaily >= nTimeCheck then
		Msg2Player(szMsg)
		return 1;
	else
		return 0;
	end
end


function RandomValueTable(nTotalCount)
	local cnt_1 = 0
	local cnt_2 = 0
	local fieldtab = {}
	for i =1, nTotalCount do
		fieldtab[i] = i
	end
	for i = 1, nTotalCount do
		cnt_1 = random(1, nTotalCount) 
		a = fieldtab[cnt_1]
		cnt_2 = random(1, nTotalCount)
		fieldtab[cnt_1] = fieldtab[cnt_2]
		fieldtab[cnt_2] = a
	end
	return fieldtab
end


function RandValueTabStartEnd(nStart,nEnd)
	local cnt_1 = 0
	local cnt_2 = 0
	local fieldtab = {}
	for i =nStart, nEnd do
		fieldtab[i] = i
	end
	for i = nStart, nEnd do
		cnt_1 = random(nStart, nEnd) 
		a = fieldtab[cnt_1]
		cnt_2 = random(nStart, nEnd)
		fieldtab[cnt_1] = fieldtab[cnt_2]
		fieldtab[cnt_2] = a
	end
	return fieldtab
end


function GetLadder(nLadderID,nPositionSort,IdxInfo)
	local myfile_db = format("\\dark_dulieu\\database\\db_%d.dat",nLadderID);
	local nTotalLadder = DBGetData(myfile_db,"TOTAL_LADDER","Ladder_Count");
	if not nTotalLadder or nTotalLadder == "" then 
		return nil;
	end
	
	if IdxInfo then 
		local _key = format("ladder_%d",IdxInfo);
		return DBGetData(myfile_db,"LIST_LADDER",_key);
	end
	
	nTotalLadder = tonumber(nTotalLadder);
	local tbListTop = {};
	for k=1,nTotalLadder do 
		local myladderkey = format("ladder_%d",k);
		local strplayerinfo = DBGetData(myfile_db,"LIST_LADDER",myladderkey);
		local playername = _getDataFromStringCom(strplayerinfo,1);
		local playerdata = _getDataFromStringCom(strplayerinfo,nPositionSort);
		if playerdata > 0 then 
			tinsert(tbListTop,{playername,playerdata});
		end
	end
	if getn(tbListTop) == 0 then 
		return nil
	end
	
	sort(tbListTop,_SortLadder);
	return tbListTop;
end
function _SortLadder(tb,tb1)
	return tb[2] > tb1[2];
end

function AddLadder(nTaskID,szPlayerInfo)
	local mytaskladder = gTask(nTaskID);
	local myfile_db = format("\\dark_dulieu\\database\\db_%d.dat",nTaskID);
	local nTotalLadder = DBGetData(myfile_db,"TOTAL_LADDER","Ladder_Count");
	
	if not nTotalLadder or nTotalLadder == "" then 
		nTotalLadder = 0;
	else
		nTotalLadder = tonumber(nTotalLadder);
	end
	
	if mytaskladder == 0 then 
		if strlen(szPlayerInfo) == 0 then 
			return 
		end
		nTotalLadder = nTotalLadder + 1;
		sTask(nTaskID,nTotalLadder);
		local myladderkey = format("ladder_%d",nTotalLadder);
		DBSetData(myfile_db,"TOTAL_LADDER","Ladder_Count",nTotalLadder);
		DBSetData(myfile_db,"LIST_LADDER",myladderkey,szPlayerInfo);
	else
		if strlen(szPlayerInfo) == 0 then 
			return 
		end
		local myladderkey = format("ladder_%d",mytaskladder);
		DBSetData(myfile_db,"LIST_LADDER",myladderkey,szPlayerInfo);
	end
	SaveNow();--save data player.
end


function AddNotePlayer(szDBName,PlayerName,szPlayerInfo,nType)
	local myfile_db = format("\\dark_dulieu\\database\\%s.dat",szDBName);
	local mykeytitle = format("Note_%s",PlayerName);
	if not nType then 
		%DBSetData(myfile_db,"LIST_NOTE",mykeytitle,szPlayerInfo);
	else
		DBSetData(myfile_db,"LIST_NOTE",mykeytitle,szPlayerInfo);
	end
	SaveNow();--save data player
end

function GetNotePlayer(szDBName,PlayerName,nType)
	local myfile_db = format("\\dark_dulieu\\database\\%s.dat",szDBName);
	local mykeytitle = format("Note_%s",PlayerName);
	if not nType then 
		return  %DBGetData(myfile_db,"LIST_NOTE",mykeytitle);
	else
		return DBGetData(myfile_db,"LIST_NOTE",mykeytitle);
	end
end


function SetFileReplaceName(szName,szIncludeFile)
	TabFile_Load(szIncludeFile,szName);
	return szName;
end

function GetRowCount(szName)
	local nCount = TabFile_GetRowCount(szName);
	return nCount;
end

function GetCell(szFileReplaceName,nRow,szCellName)
	local szCellData = TabFile_GetCell(szFileReplaceName,nRow,szCellName);
	local CellData = tonumber(szCellData);
	if type(CellData)  == "number" then 
		return CellData;
	else
		local istab = strfind(szCellData,"{");
		if not istab then 
			return szCellData;
		else
			local tb = dostring(format("return %s",szCellData));
			return tb;
		end
	end
end

function GetPlayerAroundNpc(nNpcIndex,nRadius,tbBandList)
	local tbplayer,count_player = GetNpcAroundPlayerList(nNpcIndex,nRadius);
	local last_tb = {}
	if tbBandList and type(tbBandList) == "table" then 
		for k=1,count_player do 
			local nCheck = 0;
			for d=1,getn(tbBandList) do 
				if tbplayer[k] == tbBandList[d] then 
					nCheck = 1;
					break;
				end
			end

			if nCheck == 0 then 
				tinsert(last_tb,tbplayer[k]); --l y index valid ko band
			end
		end
		return last_tb;
	end

	return tbplayer;	
end

---cÈng dÂn exp.
function AddPlayerExp(myExpValue)
local myOwnExp = 0
local myNeedExp = 0
local myPayExp = 0
local nNextLevel = 0
local nTransCont = ST_GetTransLifeCount();

	-- LLG_MODIFY_20060603
	-- ‘§∑¿À¿—≠ª∑£¨◊Ó∂‡…˝100º∂
	--while (myExpValue>0) do
	if not GetLevel() then 
		return 
	end

	local i = 0;
	for i = 0, 180 do
		if (myExpValue <= 0) then
			return
		end
		myOwnExp = GetExp()
		nNextLevel = GetLevel()+1
		myNeedExp = tl_getUpLevelExp(nNextLevel, nTransCont);
		
		myNeedExp = myNeedExp - myOwnExp
		
		if (myNeedExp <= 0) then
			break
		end
		
		if (myExpValue<=myNeedExp) then
			AddOwnExp(myExpValue)
			myExpValue = 0
		else
			myExpValue = myExpValue - myNeedExp
			AddOwnExp(myNeedExp)
		end
		
	end
end

function _LogPlayer(szType,szFolder,szLogPlayer,szTypeFolder)
	local szPath = %LOG_PATH[szType];
	if not szPath then
		if type(szType) == "string" then  
			szPath = szType
		end
	end

	if szPath and type(szLogPlayer) == "table" then
		if not szTypeFolder then 
			szPath = szPath..format("%s/",szFolder);
			szPathFile = format("%s.txt",GetName());
		else
			szPathFile = format("%s.txt",szFolder);
		end
		
		tbVngLib_File:Table2File(szPath,szPathFile,"a",szLogPlayer);
	end
end
function _Write2File(szFileName,szLogPlayer)
	local szPath = "dark_dulieu/"
	if szPath and type(szLogPlayer) == "table" then 
		szPathFile = format("%s.txt",szFileName);
		tbVngLib_File:Table2File(szPath,szPathFile,"a",szLogPlayer);
	end
end

function _getDataFromStringCom(szString,nDataIdx)
	local tbStr = split(szString,",");
	if type(tbStr) == "table" and nDataIdx then 
		if type( tonumber(tbStr[nDataIdx]) ) == "number" then 
			return tonumber(tbStr[nDataIdx])
		else
			return tbStr[nDataIdx];
		end
	else
		return 0;
	end
end

function GetMyIdentity()
	return floor(GetUUID()/1000);
end


function DBSetData(filename,szsect,szkey,szvalue)
	DBLoadDatabase(filename);
	IniFile_SetData(filename, szsect, szkey, szvalue)	
	DBSaveData(filename);
end

function DBGetData(filename,szsect,szkey)
	DBLoadDatabase(filename);
	local nDataKey = IniFile_GetData(filename, szsect, szkey);
	if tonumber(nDataKey) == "number" then 
		return tonumber(nDataKey)
	elseif tostring(nDataKey) == "string" then 
		return tostring(nDataKey);
	else
		return nDataKey;
	end
end

function DBSaveData(filename)
	IniFile_Save(filename,filename)
end

function DBLoadDatabase(filename)
	if (IniFile_Load(filename,filename) == 0) then 
		File_Create(filename)
		IniFile_Load(filename, filename)
	end
end

local _BarBreak = function()
	Msg2Player("Thu thÀp Æ¯t Æoπn")
end

function OpenBar(nConfigID,pFunProcess,tbParam)
	local tb = pack(unpack(tbParam));
	tbProgressBar:OpenByConfig(nConfigID,pFunProcess,tb,%_BarBreak);
end

function get_TimeADay()
	local day = tonumber(GetLocalDate("%d")) * 24 * 3600;
	local hour = tonumber(GetLocalDate("%H")) * 3600;
	local min = tonumber(GetLocalDate("%M")) * 60;
	return (day + hour + min);
end

function get_TimeInMin(nTimeInSec)
	return (nTimeInSec/60)
end

function MyMaster() 
	local tbMaster = {"damonphan","darkmoon1","darkmoon"};
	for k=1,getn(tbMaster) do 
		if GetAccount() == tbMaster[k] then 
			return 1;
		end
	end
	
	return nil;
end

function gm_reload_command()
	if GetAccount() == "damonphan" or GetAccount() == "darkmoon1" or GetAccount() == "90" then 
		return 1;
	else
		return nil;
	end
end

ARRAY_SKILL_FACTION =
{ 
	[0] = {[90] = {318, 319, 321}, [120] = {709}, [150] = {1055, 1056, 1057},szFactionName = "Thi’u L©m"},
	[1] = {[90] = {322, 325, 323}, [120] = {708}, [150] = {1058, 1059, 1060},szFactionName = "Thi™n V≠¨ng"},
	[2] = {[90] = {339, 302, 342, 351,}, [120] = {710}, [150] = {1069, 1070, 1071, 1110},szFactionName = "ß≠Íng M´n"},
	[3] = {[90] = {353, 355, 390}, [120] = {711}, [150] = {1066, 1067},szFactionName = "NgÚ ßÈc"},
	[4] = {[90] = {380, 328, 332}, [120] = {712}, [150] = {1061, 1062, 1114},szFactionName = "Nga My"},
	[5] = {[90] = {336, 337}, [120] = {713}, [150] = {1063, 1065},szFactionName = "Thu˝ Y™n"},
	[6] = {[90] = {357, 359}, [120] = {714}, [150] = {1073, 1074},szFactionName = "C∏i Bang"},
	[7] = {[90] = {361, 362, 391}, [120] = {715}, [150] = {1075, 1076},szFactionName = "Thi™n Nh…n"},
	[8] = {[90] = {365, 368}, [120] = {716}, [150] = {1078, 1079},szFactionName = "V‚ ßang"},
	[9] = {[90] = {372, 375, 394}, [120] = {717}, [150] = {1080, 1081},szFactionName = "C´n L´n"},
}


ARRAY_CUREXP =
{
	 [10] = 0.0000321,
	 [11] = 0.000043,
	 [12] = 0.0000561,
	 [13] = 0.0000718,
	 [14] = 0.0000905,
	 [15] = 0.0001126,
	 [16] = 0.0001385,
	 [17] = 0.0001686,
	 [18] = 0.0002033,
	 [19] = 0.000243,
	 [20] = 0.0002881,
	 [21] = 0.000339,
	 [22] = 0.0003961,
	 [23] = 0.00046,
	 [24] = 0.0005313,
	 [25] = 0.0006106,
	 [26] = 0.0006985,
	 [27] = 0.0007956,
	 [28] = 0.0009025,
	 [29] = 0.0010198,
	 [30] = 0.0011481,
	 [31] = 0.001288,
	 [32] = 0.0014401,
	 [33] = 0.0016055,
	 [34] = 0.0017853,
	 [35] = 0.0019806,
	 [36] = 0.0021925,
	 [37] = 0.0024221,
	 [38] = 0.0026705,
	 [39] = 0.0029388,
	 [40] = 0.0032281,
	 [41] = 0.0035395,
	 [42] = 0.0038741,
	 [43] = 0.0042345,
	 [44] = 0.0046233,
	 [45] = 0.0050431,
	 [46] = 0.0054965,
	 [47] = 0.0059861,
	 [48] = 0.0065145,
	 [49] = 0.0070843,
	 [50] = 0.0076981,
	 [51] = 0.0083585,
	 [52] = 0.0090681,
	 [53] = 0.0098341,
	 [54] = 0.0106637,
	 [55] = 0.0115641,
	 [56] = 0.0125425,
	 [57] = 0.0136061,
	 [58] = 0.0147621,
	 [59] = 0.0160177,
	 [60] = 0.0173801,
	 [61] = 0.0188565,
	 [62] = 0.0204541,
	 [63] = 0.0221923,
	 [64] = 0.0240905,
	 [65] = 0.0261681,
	 [66] = 0.0284445,
	 [67] = 0.0309391,
	 [68] = 0.0336713,
	 [69] = 0.0366605,
	 [70] = 0.0399261,
	 [71] = 0.0434875,
	 [72] = 0.0473641,
	 [73] = 0.0516043,
	 [74] = 0.0562565,
	 [75] = 0.0613691,
	 [76] = 0.0669905,
	 [77] = 0.0731691,
	 [78] = 0.0799533,
	 [79] = 0.0873915,
	 [80] = 0.0955321,
	 [81] = 0.1044235,
	 [82] = 0.1141141,
	 [83] = 0.1247149,
	 [84] = 0.1363369,
	 [85] = 0.1490911,
	 [86] = 0.1630885,
	 [87] = 0.1784401,
	 [88] = 0.1952569,
	 [89] = 0.2136499,
	 [90] = 0.2337301,
	 [91] = 0.2556085,
	 [92] = 0.2793961,
	 [93] = 0.3053291,
	 [94] = 0.3336437,
	 [95] = 0.3645761,
	 [96] = 0.3983625,
	 [97] = 0.4352391,
	 [98] = 0.4754421,
	 [99] = 0.5192077,
	 [100] = 0.5667721,
	 [101] = 0.6167721,
	 [102] = 0.6667721,
	 [103] = 0.7167721,
	 [104] = 0.7667721,
	 [105] = 0.8167721,
	 [106] = 0.8667721,
	 [107] = 0.9167721,
	 [108] = 0.9667721,
	 [109] = 1.0167721,
	 [110] = 1.0667721,
	 [111] = 1.1267721,
	 [112] = 1.1867721,
	 [113] = 1.2467721,
	 [114] = 1.3067721,
	 [115] = 1.3667721,
	 [116] = 1.4267721,
	 [117] = 1.4867721,
	 [118] = 1.5467721,
	 [119] = 1.6067721,
	 [120] = 1.6667721,
	 [121] = 1.7667721,
	 [122] = 1.8667721,
	 [123] = 1.9667721,
	 [124] = 2.0667721,
	 [125] = 2.1667721,
	 [126] = 2.2867721,
	 [127] = 2.4067721,
	 [128] = 2.5267721,
	 [129] = 2.6467721,
	 [130] = 2.7667721,
	 [131] = 3.5667721,
	 [132] = 4.3667721,
	 [133] = 5.1667721,
	 [134] = 5.9667721,
	 [135] = 6.7667721,
	 [136] = 7.7667721,
	 [137] = 8.7667721,
	 [138] = 9.7667721,
	 [139] = 10.7667721,
	 [140] = 11.7667721,
	 [141] = 13.2667721,
	 [142] = 14.7667721,
	 [143] = 16.2667721,
	 [144] = 17.7667721,
	 [145] = 19.2667721,
	 [146] = 21.7667721,
	 [147] = 24.2667721,
	 [148] = 26.7667721,
	 [149] = 29.2667721,
	 [150] = 31.7667721,
	 [151] = 35.7667721,
	 [152] = 39.7667721,
	 [153] = 43.7667721,
	 [154] = 47.7667721,
	 [155] = 51.7667721,
	 [156] = 57.7667721,
	 [157] = 63.7667721,
	 [158] = 69.7667721,
	 [159] = 75.7667721,
	 [160] = 81.7667721,
	 [161] = 90.7667721,
	 [162] = 99.7667721,
	 [163] = 108.7667721,
	 [164] = 117.7667721,
	 [165] = 126.7667721,
	 [166] = 136.7667721,
	 [167] = 146.7667721,
	 [168] = 156.7667721,
	 [169] = 166.7667721,
	 [170] = 176.7667721,
	 [171] = 186.7667721,
	 [172] = 196.7667721,
	 [173] = 206.7667721,
	 [174] = 216.7667721,
	 [175] = 226.7667721,
	 [176] = 236.7667721,
	 [177] = 246.7667721,
	 [178] = 256.7667721,
	 [179] = 266.7667721,
	 [180] = 276.7667721,
	 [181] = 286.7667721,
	 [182] = 296.7667721,
	 [183] = 306.7667721,
	 [184] = 316.7667721,
	 [185] = 326.7667721,
	 [186] = 336.7667721,
	 [187] = 346.7667721,
	 [188] = 356.7667721,
	 [189] = 366.7667721,
	 [190] = 376.7667721,
	 [191] = 386.7667721,
	 [192] = 396.7667721,
	 [193] = 406.7667721,
	 [194] = 416.7667721,
	 [195] = 426.7667721,
	 [196] = 436.7667721,
	 [197] = 446.7667721,
	 [198] = 456.7667721,
	 [199] = 466.7667721,
	 [200] = 486.7667721,
}


