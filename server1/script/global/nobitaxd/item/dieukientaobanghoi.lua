----------BANG HOI--------------
Include("\\script\\global\\repute_head.lua")
Include("\\script\\misc\\league_cityinfo.lua")
function DieuKienTaoBangHoi()
local strTongName = GetTongName()
if (strTongName == nil or strTongName == "") then
local szTitle = "Xin chµo Admin <color=yellow>"..GetName().."<color>. Nh÷ng chøc n¨ng bªn d­íi cã thÓ gióp b¹n kiÓm tra Server hoÆc hç trî ng­êi ch¬i."
local tbOpt =
	{
		{"NhËn §iÒu KiÖn T¹o Bang Héi",dmcreatetong},		
		{"T¹o Bang Héi",dmcreateit},
		{"Trë L¹i",main},
		{"Tho¸t"},
	}
	CreateNewSayEx(szTitle, tbOpt)
	else
	Say("C¸c h¹ ®· lµ thµnh viªn trong <color=green>Bang Héi<color> tªn lµ: <color=yellow>"..strTongName.."<color> råi!", 0)
end
end
function dmcreatetong()	
	local nReceived = GetTask(5999)
    if nReceived == 1 then       
        Msg2Player("<color=red>Nhµ ng­¬i ®· cã Nh¹c V­¬ng KiÕm råi mµ!<color>")
        return
    end
		SetCamp(4)
		SetCurCamp(4)
		AddRepute(1000);
		FuYuan_Start();
		FuYuan_Add(1000);
		AddLeadExp(2000000000)
		AddEventItem(195)
		Earn(1000000)
		if GetLevel() <= 100 then
			for i=1,100 do
				AddOwnExp(100000000)
			end
		end
SetTask(5999, 1)
Msg2Player("<color=yellow>Ng­¬i ®· héi ®ñ tÊt c¶ ®iªu kiÖn ®Ó t¹o Bang Héi!<color>")
end
function dmjointong()
if  GetCamp() ~= 4 then
		if GetLevel() <= 100 then
			for i=1,100 do
				AddOwnExp(100000000)
			end
		end
		SetCamp(4)
		SetCurCamp(4)
Msg2Player("<color=yellow>Gia nhËp Bang héi thµnh c«ng!<color>")
else
end
end
function dmcreateit()
	Tong_name,oper = GetTong()
	if (oper == 0) and (GetTask(99) == 1) then
		Say("Kiªm hiÖp ch­ëng m«n nh©n:Khai s¸ng bang héi, më réng b¸ nghiÖp." ,2,"B¾t ®Çu dùng bang/Direct_CreateTong","§îi ta mét chót/wait_a_moment")
	elseif (oper == 0) and (GetCamp() == 4) and (GetLevel() >= 50) and (GetReputeLevel(GetRepute()) >= 6) and (GetLeadLevel() >= 30) and (HaveItem(195) == 1) then
		Talk(6,"create_pay", "Ng­êi ch¬i: Kiªm hiÖp ch­ëng m«n nh©n, xin hái ta ph¶i lµm nh­ thÕ nµo míi ca thÓ khai t«ng lËp ph¸i trë thµnh Bang chñ ®©y?", "Kiªm hiÖp ch­ëng m«n nh©n: §Çu tiªn ng­¬i ph¶i cã ®ñ n¨ng lùc l·nh ®¹o, cã 16 ng­êi cïng chÝ h­íng cïng ng­¬i lËp bang, tr¶i qua 3 ngµy Kh¶o NghiÖm Kú ", "Ch­ëng m«n nh©n:  NÕu trong 3 ngµy cã ng­êi rêi bang th× néi trong 3 ngµy ®ã ng­¬i ph¶i t×m ng­êi kh¸c thay thÕ.", "Ch­ëng m«n nh©n:  Ng­¬i ph¶i cã ®ñ tµi l·nh ®¹o vµ tÝn vËt ®ã lµ Nh¹c V­¬ng KiÕm", "Ng­êi ch¬i: Nh¹c V­¬ng Kiªm ? Ng­êi nãi lµ thanh kiªm nµy µ ? ", "Kiªm hiÖp ch­ëng m«n nh©n : Th× ra lµ ng­¬i ®· cã nã... Kh«ng tÖ, qu¶ nhiªn tuæi trÎ tµi cao!!! ")
	else	
		i = random(0,1)
		if (i == 0) then
			Talk(1,"", "Kiªm hiÖp ch­ëng m«n nh©n: Nªu nh­ muèn thµnh lËp bang héi, ng­¬i cã thÓ v× nã bá ra 1 l­îng lín thêi gian, søc lùc cïng t©m huyÕt, kh«ng thÓ n÷a ®­êng hñy bá." )
		else
			Talk(6,"", "Kiªm hiÖp ch­ëng m«n nh©n:  Ng­¬i muèn hái ®iÒu kiÖn lËp bang µ? §Ó ta nãi cho ng­¬i râ.", "Kiªm hiÖp ch­ëng m«n nh©n: ®Çu tiªn ph¶i xuÊt x­,  tiªp theo ng­¬i kh«ng thÓ ë bÊt kú bang héi nµo kh¸c, ng­¬i nhÊt ®inh ph¶i cã danh väng giang hå, cuèi cïng lµ tµi l·nh ®¹o ph¶i h¬n 30 cÊp.", "Kiªm hiÖp ch­ëng m«n nh©n: Sau ®ã ®i chiÕn tr­êng t×m mét thanh Nh¹c V­¬ng Kiªm lµm bang chñ tÝn vËt lµ ®­îc råi.")
		end
	end
end

function create_pay()
	Say("Kiªm hiÖp ch­ëng m«n nh©n: Ng­¬i cÇn lÖ phi lµ 100 v¹n l­îng b¹c." ,2,"Kh«ng thµnh vÊn ®ª, ta cã ®em 100v l­îng ®©y! /create_pay_yes","Ta kh«ng ®em ®ñ tiªn råi. /create_pay_no")
end
function create_pay_yes()
	if (GetCash() >= 1000000) then
		Pay(1000000)		
		DelItem(195)		
		SetTask(99,1)				
		Direct_CreateTong()		
	else
		Talk(1,"", "Kiªm hiÖp ch­ëng m«n nh©n: ViÖc duy tr× bang héi rÊt tèn kÐm, ng­êi ph¶i cè g¾ng cïng mäi ng­êi tÝch gãp ®Ó Bang Héi ®­îc giµu m¹nh. ")	end
end

function Direct_CreateTong()
	CreateTong(1)				
end