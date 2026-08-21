IncludeLib("ITEM")
Include("\\script\\lib\\log.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\objbuffer_head.lua")
Include("\\script\\lib\\composeex.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\lib\\progressbar.lua")
Include("\\script\\dailogsys\\dailogsay.lua");
Include("\\script\\lib\\common.lua")
Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\hoanbinhvukhi\\head.lua")

----------------------------------------------------Hoang Kim----------------------------------------------------
function hoangkim()
	local szTitle = "Xin chµo <color=red>"..GetName().."<color> ! ” §¹i HiÖp Muèn Chän Trang BÞ G×"
	local tbOpt=
	{

	"NhËn SÐt HKMP/SetTrangBiHoangKim",
	"NhËn An Bang/anbang",
	"NhËn §Þnh Quèc/dinhquoc",
	"NhËn HiÖp Cèt/hiOpcot",
	"NhËn Nhu T×nh/nhutinh",
	"NhËn SÐt Hoµn Mü Vinh DiÖu/vinhdieu",
	"NhËn NhÉn Kinh NghiÖm/nhankn",
	"NhËn MÆt N¹/matnavip",
	"N©ng CÊp §å B¹ch Kim/bachkim_main",
	"Trë L¹i/main",
	"Tho¸t./no",
	}
	Say(szTitle, getn(tbOpt), tbOpt)
	
end
-------------------------------------------------------------------------------------



TAB_SET = {
	[0] = "Hoµng kim m«n ph¸i", 
	[1] = "Hoµng kim m«n ph¸i Èn",
	};

TAB_GOLD_SET = {
[0] = {
["ThiÕu L©m QuyÒn"]    ={[0]={1, 5},    [1]={647, 651}},
["ThiÕu L©m Bæng"]      ={[0]={6, 10},  [1]={652, 656}},
["ThiÕu L©m §ao"]        ={[0]={11, 15},[1]={542,546}},
},
[1] = {
["Thiªn V­¬ng Chïy"]    ={[0]={16, 20}, [1]={552, 556}},
["Thiªn V­¬ng Th­¬ng"]  ={[0]={21, 25}, [1]={547, 551}},
["Thiªn V­¬ng §ao"]      ={[0]={26, 30}, [1]={557, 561}},
},
[4] = {
["Nga My KiÕm"]         ={[0]={31, 35},  [1]={562, 566}},
["Nga My Ch­ëng"]       ={[0]={36, 40}, [1]={567, 571}},
["Nga My Buff"]           ={[0]={41, 45}},
},
[5] = {
["Thóy Yªn §ao"]          ={[0]={46, 50}, [1]={572, 576}},
["Thóy Yªn Song §ao"] ={[0]={51, 55}, [1]={577,581}},
},
[3] = {
["Ngò §éc Ch­ëng"] 	 ={[0]={56, 60}, [1]={582, 586}},
["Ngò §éc §ao"]            ={[0]={61, 65}, [1]={587,591}},
["Ngò §éc Bïa"]            ={[0]={66, 70}},
},
[2] = {
["§­êng M«n Phi §ao"]   ={[0]={71, 75}, [1]={592, 596}},
["§­êng M«n Tô TiÔn"]    ={[0]={76, 80}, [1]={597, 601}},
["§­êng M«n Phi Tiªu"]   ={[0]={81, 85},  [1]={602,606}},
["§­êng M«n BÉy"]          ={[0]={86, 90}},
},
[6] = {
["C¸i Bang Ch­ëng"] 	= {[0]={91, 95},   [1]={607, 611}},
["C¸i Bang C«n"]          = {[0]={96, 100}, [1]={612, 616}},
},
[7] = {
["Thiªn NhÉn KÝch"] 	= {[0]={101, 105}, [1]={617, 621}},
["Thiªn NhÉn §ao"]       ={[0]={106, 110}, [1]={622, 626}},
["Thiªn NhÉn Bïa"]        ={[0]={111, 115}},
},
[8] = {
["Vâ §ang QuyÒn"]        ={[0]={116, 120}, [1]={627, 631}},
["Vâ §ang KiÕm"]           ={[0]={121, 125}, [1]={632,636}},
},
[9] = {
["C«n L«n §ao"]            ={[0]={126, 130}, [1]={637, 641}},
["C«n L«n KiÕm"]           ={[0]={131, 135}, [1]={642, 646}},
["C«n L«n Bïa"]             ={[0]={136, 140}}
},
};


TAB_FACTION = {
	[0] = "ThiÕu L©m",
	[1] = "Thiªn V­¬ng",
	[2] = "§­êng M«n",
	[3] = "Ngò §éc",
	[4] = "Nga My",
	[5] = "Thóy Yªn",
	[6] = "C¸i Bang",
	[7] = "Thiªn NhÉn",
	[8] = "Vâ §ang",
	[9] = "C«n L«n",

};

function SetTrangBiHoangKim()
	local szTitle = "Ng­¬i muèn nhËn trang bÞ ph¸i nµo?";
	local tbOption = {}
	local num_faction = 10
	for i_faction = 0, (num_faction - 1) do
		tinsert(tbOption, format("Trang bÞ ph¸i %s /#AddGold_Faction(%d)", TAB_FACTION[i_faction], i_faction))
	end	
	tinsert(tbOption, "Trë l¹i/main")
	tinsert(tbOption, "KÕt thóc ®èi tho¹i./no")
	Say(szTitle, getn(tbOption), tbOption)	
	--CreateNewSayEx(szTitle, tbOption)
end

function AddGold_Faction(i_faction)
	local tb_Equip = TAB_GOLD_SET[i_faction];
	local tbOption = {};
	local szTitle = "Mêi chän ®­êng tÊn c«ng c¬ b¶n?";
	for x, y in tb_Equip do
		tinsert(tbOption, x.."/#AddGold_Skill("..i_faction..",\""..x.."\")") -- \" ®Ó viÕt dÊu nh¸y, nÕu kh«ng chØ pass kÝ tù.
		--tinsert(tbOption, format(%s/#AddGold_Skill(%d, %a), x, i_faction, x))
	end
	tinsert(tbOption, "Trë l¹i./SetTrangBiHoangKim")
	tinsert(tbOption, "KÕt thóc ®èi tho¹i./no")
	Say(szTitle, getn(tbOption), tbOption)	
	--CreateNewSayEx(szTitle, tbOption)
end

function AddGold_Skill(i_faction, skill_style)
	local tb_Equip = TAB_GOLD_SET[i_faction][skill_style]
	local tbOption = {};
	local szTitle = "Mêi b¹n chän set hoµng kim?";
	--for nSet = 12, 13 do
	--for nSet, value in tb_Equip do
	--	tinsert(tbOption, TAB_SET[nSet].."/#AddGold_Set("..value[1]..","..value[2]..")") --tb_Equip[nSet]
	--end
	for nSet = 0, 1 do
		if tb_Equip[nSet] then
			tinsert(tbOption, TAB_SET[nSet].."/#AddGold_Set("..tb_Equip[nSet][1]..","..tb_Equip[nSet][2]..")")
		end
	end
	tinsert(tbOption, "Trë l¹i./SetTrangBiHoangKim")
	tinsert(tbOption, "KÕt thóc ®èi tho¹i./no")
	Say(szTitle, getn(tbOption), tbOption)	
	--CreateNewSayEx(szTitle, tbOption)	
end

function AddGold_Set(num1, num2)
	if (num2-num1) <= 10 then
		for nID = num1, num2 do
			AddGoldItem(0, nID)
		end
	else
		Talk(1,"","Kh«ng thÓ nhËn qu¸ nhiÒu trang bÞ 1 lóc.")
	end
end
----------NhËn An Bang - §Þnh Quèc-----------
function anbang()
for i=424,427  do
AddGoldItem(0, i)
end
end
function dinhquoc()
for i=403,407  do
AddGoldItem(0, i)
end
end
function hiepcot()
for i=412,415  do
AddGoldItem(0, i)
end
end
function nhutinh()
for i=416,419  do
AddGoldItem(0, i)
end
end
function vinhdieu()
for i=512,513  do
AddGoldItem(0, i)
end
end
function nhankn()
for i=378,379  do
AddGoldItem(0, i)
end
end
function matnavip()
for i=5658,5669  do
AddGoldItem(0, i)
end
end
----------------------------------------------------Bach Kim----------------------------------------------------
function bachkim_main()
	local szTitle = " Xin chµo <color=red>"..GetName().."<color> ! §¹i hiÖp muèn sö dông chøc n¨ng g×?"
	local tbOpt={}
	tinsert(tbOpt, "N©ng cÊp ®å Hoµng kim lªn B¹ch kim cÊp 10/make_bachkim_max")
	tinsert(tbOpt, "Quay l¹i/main")
	tinsert(tbOpt, "Th«i./no")
	Say(szTitle, getn(tbOpt), tbOpt)
end

tbBlockPlatinaIds = {
	[5]=1, [7]=1, [12]=1, [32]=1, [37]=1, [70]=1, [79]=1,
	[90]=1, [91]=1, [110]=1, [117]=1, [124]=1, [127]=1,
}

function make_bachkim_max()
	GiveItemUI("T¹o trang bÞ B¹ch Kim", "N©ng cÊp trang bÞ B¹ch kim Max (+10)", "do_upgoldeq_max", "no", 1)
end

function do_upgoldeq_max(nCount)
	if nCount ~= 1 then
		Talk(1, "", "ChØ bá 1 mãn trang bÞ")
		return
	end
	local nItemIndex = GetGiveItemUnit(1)
	local goldIdx = GetGlodEqIndex(nItemIndex)
	
	if goldIdx < 1 or goldIdx > 140 then
		Talk(1, "", "Trang bÞ nµy kh«ng hç trî n©ng cÊp B¹ch Kim")
		return
	end
	
	if tbBlockPlatinaIds[goldIdx] then
		Talk(1, "", "Server hiÖn t¹i t¹m thêi kh«ng thÓ n©ng B¹ch Kim trang bÞ nµy.")
		return
	end
	
	UpgradePlatinaFromGoldItem(nItemIndex)
	for i = 1, 10 do
		UpgradePlatinaItem(nItemIndex)
	end
	Msg2Player("<color=yellow>§· n©ng cÊp B¹ch Kim +10 thµnh c«ng!<color>")
end

-------------------------------------------§æi M¶nh HK----------------------------------------
function XoayManhHKMP()
	--dofile("script/global/sang/tinhnang/thorenthanbi.lua")
	szDescription = format("ChØ CÇn Bá M¶nh HKMP Vµo Trong Lµ §­îc\n=> Hªn Xui Nµo!!.")
	GiveItemUI("Nguyªn LiÖu CÇn Cã", szDescription, "Run_XoayManhHKMP", "no", 1)
		--GiveItemUI("Gia H¹n Phï", "Xin h·y bá 1 mãn trang søc cã h¹n sö dông vµo « bªn d­íi", "tbVnGiaHanPhuGiveUIConfirm", "onCancel")

end

function Run_XoayManhHKMP(nCount)
if nCount == 0 or nCount >1 then
		Say("Ng­¬i d¸m g¹t ta µ! ThËt to gan.")
		return 1;
	end
	
	for i = 1, nCount do
		local nItemIndex = GetGiveItemUnit(i)
		local nG, nD, nP, nL, nS ,kk = GetItemProp(nItemIndex)
		local xu = CalcEquiproomItemCount(4,417,1,-1)
		
		if nG==6 and nP >= 239 and nP <= 378 and xu >=1 then
			ConsumeEquiproomItem(1, 6,1, nP,-1)
			ConsumeEquiproomItem(1, 4,417, 1,-1)
			local Index	= AddItem(6,1,random(239,378),0,0,0,0) 
			Msg2SubWorld("<color=cyan>Chóc mõng ®¹i hiÖp <color=green>"..GetName().."<color=yellow> Xoay Thµnh C«ng <color=green>M¶nh HKMP!")
			else Say("Kh«ng cã m¶nh HKMP hoÆc kh«ng ®ñ 1 Xu")
		end
	end
end
function GhepManhHKMP()
Say("§Ó Hîp Thµnh §å HKMP CÇn Cã §ñ 100 M¶nh HKMP",7,"Nga Mi/hkmpnm1","Thóy Yªn/hkmpty1","§­êng M«n/hkmpdm1","Ngò §éc/hkmpnd1","Thiªn V­¬ng/hkmptv1","Trang Sau/GhepManhHKMP2","KÕt thóc ®èi tho¹i/no") 
end
function GhepManhHKMP2() 
Say("Xin mêi chän trang bÞ",7,"ThiÕu L©m/hkmptl1","Vâ §ang/hkmpvd1","C«n L«n/hkmpcl1","Thiªn NhÉn/hkmptn1","C¸i Bang/hkmpcb1","Trang Tr­íc/GhepManhHKMP","KÕt thóc ®èi tho¹i/no") 
end
function addhkmp(idgold,idmagic)
local nCount_manhhkmp = CalcEquiproomItemCount(6,1,idmagic,1)
	if nCount_manhhkmp >=100 then
		ConsumeEquiproomItem(100, 6,1, idmagic,-1) 
		Msg2SubWorld("<color=green> Xin Chóc Mõng <color=red>"..GetName().."<color=green> §· Ðp Thµnh C«ng 100 M¶nh Thµnh §å HKMP")
		local Index = AddGoldItem(0,idgold) ITEM_SetExpiredTime(Index,30*24*60) SyncItem(Index)
	else
		Say("Ng­¬i Kh«ng §ñ Nguyªn LiÖu T×m Ta Lµm G×") return 1;
		end
end

----------------------------------------------------------


--------------------------------------------------------
function lochkmpmain() 
Say("Xin mêi chän trang bÞ",7,"Nga Mi/locoknm","Thóy Yªn/locokty","§­êng M«n/locokdm","Ngò §éc/locoknd","Thiªn V­¬ng/locoktv","Trang Sau/lochkmpmain1","KÕt thóc ®èi tho¹i/no") 
end

function lochkmpmain1() 
Say("Xin mêi chän trang bÞ",7,"ThiÕu L©m/locoktl","Vâ §ang/locokvd","C«n L«n/locokcl","Thiªn NhÉn/locoktn","C¸i Bang/locokcb","Trang Tr­íc/lochkmpmain","KÕt thóc ®èi tho¹i/no") 
end

function locoknm() 
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end
        local tbOpt= 
               { 
                {"V« Ma TÈy N­gäc KhÊu", hknmc}, 
                {"V« Giang û Thiªn KiÕm", hknmk}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 

function hknmc()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,39},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,39},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 2,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end

function hknmk() 
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,31},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,31},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end


function locokty()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end
        local tbOpt= 
               { 
                {"Tª Hoµng Phông Nghi §ao", tehoangdao}, 
                {"BÝch H¶i Uyªn ¦¬ng Hoµng §ao", yenuongdao}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 

function tehoangdao()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,46},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,46},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end


function yenuongdao()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,51},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,51},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 



function locokdm()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end 
        local tbOpt= 
               { 
                {"Thiªn Quang M¹n Vò M·n Thiªn", thienquangmanthien},
                {"S©m Hoµng Phi Tinh §o¹t Hån", samhoangdao},  
                {"B¨ng Hµn §¬n ChØ Phi §ao", banghandao}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 

function thienquangmanthien()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,76},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,76},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function samhoangdao()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,81},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,81},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function banghandao()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,71},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,71},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function locoknd()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end
        local tbOpt= 
               { 
                {"U Lung Kim Xµ Ph¸t ®¸i", unlungkimxa}, 
                {"Minh ¶o Tµ S¸t §éc NhËn", minhaodoc}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 


function unlungkimxa()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,56},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,56},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function minhaodoc()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,61},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,61},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function locoktv()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end
local tbOpt= 
               { 
                {"KÕ NghiÖp B«n L«i Toµn Long th­¬ng", kenghiepthuong}, 
                {"H¸m Thiªn Kim Hoµn §¹i Nh·n ThÇn Chïy", hamthienchuy}, 
                {"Ngù Long L­îng Ng©n B¶o ®ao", ngulongdao}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 


function kenghiepthuong()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,21},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,21},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function hamthienchuy()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,16},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,16},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function ngulongdao()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,26},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,26},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function locoktl()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end 
local tbOpt= 
               {
                {"Tø Kh«ng Gi¸ng Ma Giíi ®ao", tukhonggiangdao}, 
                {"Phôc Ma Tö Kim C«n", phucmakimcon}, 
                {"Méng Long Kim Ti ChÝnh Hång Cµ Sa", monglongcasa}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 


function tukhonggiangdao()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,11},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,11},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function phucmakimcon()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,6},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,6},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function monglongcasa()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,2},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,2},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function locokvd()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end 
local tbOpt= 
               {
                {"L¨ng Nh¹c Th¸i Cùc KiÕm", langnhackiem}, 
                {"CËp Phong Ch©n Vò KiÕm", capphongkiem}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 

function langnhackiem()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,116},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,116},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function capphongkiem()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,121},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,121},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function locokcl()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end 
local tbOpt= 
               {
                {"S­¬ng Tinh Thiªn Niªn Hµn ThiÕt", suongtinhhanthiet}, 
                {"L«i Khung Hµn Tung B¨ng B¹ch quan", loikhungbachquan}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 

function suongtinhhanthiet()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,126},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,126},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function loikhungbachquan()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,131},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,131},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function locoktn()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end 
local tbOpt= 
               {
                {"Ma S¸t Quû Cèc U Minh Th­¬ng", masatuminh},
                {"Ma ThÞ To¹i Tinh §ao", mathidao},  
                {"Ma ThÞ s¬n H¶i Phi Hång Lý", mathihongly}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 


function masatuminh()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,101},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,101},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function mathidao()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,540},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,540},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function mathihongly()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,115},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,115},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


function locokcb()
if CalcFreeItemCellCount() < 6 then
		Talk(1, "", "Hµnh trang §¹i hiÖp kh«ng ®ñ 6 « trèng!")
		return
	end
local tbOpt= 
               { 
                {"§ång Cõu Kh¸ng Long Hé UyÓn", dongcuuhouyen}, 
                {"§Þch Kh¸i Lôc Ngäc Tr­îng", dinhkhaitruong}, 
                {"Tho¸t"}, 
               } 
                CreateNewSayEx("<npc>Ngò hµnh kú th¹ch lÊy ë sßng bµi - Tèng kim tÝch lòy bao trong shop tèng kim ®em ®ñ 2 mãn cho ta ta sÏ gióp ng­êi läc option ?", tbOpt)
        return 1 
end 

function dongcuuhouyen()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,94},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,94},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 

function dinhkhaitruong()
local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("<color=green>§¹i hiÖp <color=yellow>%s<color=cyan> ®· läc l¹i thuéc tÝnh thµnh c«ng trang bÞ <color=gold><%s><color=green><enter><color=yellow>< T¹i Thî §óc Trang BÞ ><color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end
local tbFormula = 
	{
			tbMaterial = 
			{
				{szName="HK CÇn Läc",tbProp={0,96},nQuality = 1,nCount = 1},
				{szName="TK TÝch Lòy Bao",tbProp={6,1,4415,1},nCount=1},
				{szName="Ngò Hµnh Kú Th¹ch",tbProp={6,1,2125,1},nCount=1},
	
			},
		tbProduct = {szName="Thµnh PhÈm",tbProp={0,96},nQuality = 1,nCount = 1,CallBack= _Message},
		nWidth = 1,
		nHeight = 3,
		nFreeItemCellLimit = 1,	
	}
	local p = tbActivityCompose:new(tbFormula, "xingxialin1huitian", INVENTORY_ROOM.room_giveitem)
	p:ComposeDailog()
end 


-----------------------------------------------------


function LocOptionHKOK()
	local title = "Läc Trang bÞ HKMP"
	g_GiveItemUI(title, "CÇn 100 tiÒn ®ång l­u ý 100 tiÒn ®ång ph¶i ®Ó ngoµi hµnh trang  ", {GiveUIOK4}, nil, nil)   --- 100 tiÒn ®ång l­u ý 100 tiÒn ®ång ph¶i ®Ó ngoµi hµnh trang
end


--------------®Þnh nghÜa b¶ng trang bÞ HKMP tbHKMP : thªm vµo nhiÒu dßng tõ id thÊp tíi cao

tbHKMP = {

		[1]={	
			{"Méng Long ChÝnh Hång T¨ng M·o",1}, 
			{"Méng Long Kim Ti ChÝnh Hång Cµ Sa",2},
			{"Méng Long HuyÒn Ti Ph¸t ®¸i",3},
			{"Méng Long PhËt Ph¸p HuyÒn Béi",4},
			{"Méng Long §¹t Ma T¨ng hµi",5},
			{"Phôc Ma Tö Kim C«n",6},
			{"Phôc Ma HuyÒn Hoµng Cµ Sa",7},
			{"Phôc Ma ¤ Kim NhuyÔn §iÒu",8},
			{"Phôc Ma PhËt T©m NhuyÔn KhÊu",9},
			{"Phôc Ma Phæ §é T¨ng hµi",10},
{"Tø Kh«ng Gi¸ng Ma Giíi ®ao",11},
{"Tø Kh«ng Tö Kim Cµ Sa",12},
{"Tø Kh«ng Hé ph¸p Yªu ®¸i",13},
{"Tø Kh«ng NhuyÔn B× Hé UyÓn",14},
{"Tø Kh«ng Giíi LuËt Ph¸p giíi",15},
{"H¸m Thiªn Kim Hoµn §¹i Nh·n ThÇn Chïy",16},
{"H¸m Thiªn Vò ThÇn T­¬ng Kim Gi¸p",17},
{"H¸m Thiªn Uy Vò Thóc yªu ®¸i",18},
{"H¸m Thiªn Hæ ®Çu KhÈn Thóc UyÓn",19},
{"H¸m Thiªn Thõa Long ChiÕn Ngoa",20},
{"KÕ NghiÖp B«n L«i Toµn Long th­¬ng",21},
{"KÕ NghiÖp HuyÒn Vò Hoµng Kim Kh¶i",22},
{"KÕ NghiÖp B¹ch Hæ V« Song khÊu",23},
{"KÕ NghiÖp HáaV©n Kú L©n Thñ ",24},
{"KÕ NghiÖp Chu T­íc L¨ng V©n Ngoa",25},
{"Ngù Long L­îng Ng©n B¶o ®ao",26},
{"Ngù Long ChiÕn ThÇn Phi Qu¶i gi¸p",27},
{"Ngù Long Thiªn M«n Thóc Yªu hoµn",28},
{"Ngù Long TÊn Phong Hé yÓn",29},
{"Ngù Long TuyÖt MÖnh ChØ hoµn",30},
{"V« Gian û Thiªn KiÕm",31},
{"V« Gian Thanh Phong Truy Y",32},
{"V« Gian PhÊt V©n Ti ®¸i",33},
{"V« Gian CÇm VËn Hé UyÓn",34},
{"V« Gian B¹ch Ngäc Bµn ChØ ",35},
{"V« Ma Ma Ni qu¸n",36},
{"V« Ma Tö Kh©m Cµ Sa",37},
{"V« Ma B¨ng Tinh ChØ Hoµn",38},
{"V« Ma TÈy T­îng Ngäc KhÊu ",39},
{"V« Ma Hång Truy NhuyÔn Th¸p hµi",40},
{"V« TrÇn Ngäc N÷ Tè T©m qu¸n",41},
{"V« TrÇn Thanh T©m H­íng ThiÖn Ch©u",42},
{"V« TrÇn Tõ Bi Ngäc Ban ChØ ",43},
{"V« TrÇn PhËt T©m Tõ H÷u Yªu Phèi",44},
{"V« TrÇn PhËt Quang ChØ Hoµn",45},
{"Tª Hoµng Phông Nghi ®ao",46},
{"Tª Hoµng TuÖ T©m Khinh Sa Y",47},
{"Tª Hoµng Phong TuyÕt B¹ch V©n Thóc §¸i",48},
{"Tª Hoµng B¨ng Tung CÈm uyÓn",49},
{"Tª Hoµng Thóy Ngäc ChØ Hoµn",50},
{"BÝch H¶i Uyªn ¦¬ng Liªn Hoµn ®ao",51},
{"BÝch H¶i Hoµn Ch©u Vò Liªn",52},
{"BÝch H¶i Hång Linh Kim Ti ®¸i",53},
{"BÝch H¶i Hång L¨ng Ba",54},
{"BÝch H¶i Khiªn TÕ ChØ hoµn",55},
{"U Lung Kim Xµ Ph¸t ®¸i",56},
{"U Lung XÝch YÕt MËt trang",57},
{"U Lung Thanh Ng« TriÒn yªu",58},
{"U Lung Ng©n ThÒm Hé UyÓn",59},
{"U Lung MÆc Thï NhuyÔn Lý ",60},
{"Minh ¶o Tµ S¸t §éc NhËn",61},
{"Minh ¶o U §éc ¸m Y",62},
{"Minh ¶o §éc YÕt ChØ Hoµn",63},
{"Minh ¶o Hñ Cèt Hé uyÓn",64},
{"Minh ¶o Song Hoµn Xµ Hµi",65},
{"Chó Ph­îc Ph¸ gi¸p ®Çu hoµn",66},
{"Chó Ph­îc DiÖt L«i C¶nh Phï ",67},
{"Chó Ph­îc U ¶o ChØ Hoµn",68},
{"Chó Ph­îc Xuyªn T©m §éc UyÓn",69},
{"Chó Ph­îc B¨ng Háa Thùc Cèt Ngoa",70},
{"B¨ng Hµn §¬n ChØ Phi §ao",71},
{"B¨ng Hµn HuyÒn Y Thóc Gi¸p",72},
{"B¨ng Hµn T©m TiÔn Yªu KhÊu",73},
{"B¨ng Hµn HuyÒn Thiªn B¨ng Háa Béi",74},
{"B¨ng Hµn NguyÖt ¶nh Ngoa",75},
{"Thiªn Quang Hoa Vò M¹n Thiªn",76},
{"Thiªn Quang §Þnh T©m Ng­ng ThÇn Phï ",77},
{"Thiªn Quang S©m La Thóc §¸i",78},
{"Thiªn Quang Song B¹o Hµn ThiÕt Tr¹c",79},
{"Thiªn Quang Thóc Thiªn Ph­îc §Þa Hoµn",80},
{"S©m Hoang Phi Tinh §o¹t Hån",81},
{"S©m Hoang KimTiÒn Liªn Hoµn Gi¸p",82},
{"S©m Hoang Hån Gi¶o Yªu Thóc",83},
{"S©m Hoang HuyÒn ThiÕt T­¬ng Ngäc Béi",84},
{"S©m Hoang Tinh VÉn Phi Lý ",85},
{"§Þa Ph¸ch Ngò hµnh Liªn Hoµn Qu¸n",86},
{"§Þa Ph¸ch H¾c DiÖm Xung Thiªn Liªn",87},
{"§Þa Ph¸ch TÝch LÞch L«i Háa Giíi",88},
{"§Þa Ph¸ch KhÊu T©m tr¹c",89},
{"§Þa Ph¸ch §Þa Hµnh Thiªn Lý Ngoa",90},
{"§ång Cõu Phi Long §Çu hoµn",91},
{"§ång Cõu Gi¸ng Long C¸i Y",92},
{"§ång Cõu TiÒm Long Yªu §¸i",93},
{"§ång Cõu Kh¸ng Long Hé UyÓn",94},
{"§ång Cõu KiÕn Long Ban ChØ ",95},
{"§Þch Kh¸i Lôc Ngäc Tr­îng",96},
{"§Þch Kh¸i Cöu §¹i C¸i Y",97},
{"§Þch Kh¸i TriÒn M·ng yªu ®¸i",98},
{"§Þch Kh¸i CÈu TÝch B× Hé uyÓn",99},
{"§Þch Kh¸i Th¶o Gian Th¹ch giíi",100},
{"Ma S¸t Quû Cèc U Minh Th­¬ng",101},
{"Ma S¸t Tµn D­¬ng ¶nh HuyÕt Gi¸p",102},
{"Ma S¸t XÝch Ký Táa Yªu KhÊu",103},
{"Ma S¸t Cö Háa Liªu Thiªn uyÓn",104},
{"Ma S¸t V©n Long Thæ Ch©u giíi",105},
{"Ma Hoµng Kim Gi¸p Kh«i",106},
{"Ma Hoµng ¸n XuÊt Hæ H¹ng Khuyªn",107},
{"Ma Hoµng Khª Cèc Thóc yªu ®¸i",108},
{"Ma Hoµng HuyÕt Y Thó Tr¹c",109},
{"Ma Hoµng §¨ng §¹p Ngoa",110},
{"Ma ThÞ LiÖt DiÖm Qu¸n MiÖn",111},
{"Ma ThÞ LÖ Ma PhÖ T©m Liªn",112},
{"Ma ThÞ NghiÖp Háa U Minh Giíi",113},
{"Ma ThÞ HuyÕt Ngäc ThÊt S¸t Béi",114},
{"Ma ThÞ s¬n  H¶i Phi Hång Lý ",115},
{"L¨ng Nh¹c Th¸i Cùc KiÕm",116},
{"L¨ng Nh¹c V« Ng· ®¹o bµo",117},
{"L¨ng Nh¹c Né L«i Giíi",118},
{"L¨ng Nh¹c V« Cùc HuyÒn Ngäc Béi",119},
{"L¨ng Nh¹c Thiªn §Þa HuyÒn Hoµng giíi",120},
{"CËp Phong Ch©n Vò KiÕm",121},
{"CËp Phong Tam Thanh Phï ",122},
{"CËp Phong HuyÒn Ti Tam §o¹n cÈm",123},
{"CËp Phong Thóy Ngäc HuyÒn Hoµng Béi",124},
{"CËp Phong Thanh Tïng Ph¸p giíi",125},
{"S­¬ng Tinh Thiªn Niªn Hµn ThiÕt",126},
{"S­¬ng Tinh Ng¹o S­¬ng ®¹o bµo",127},
{"S­¬ng Tinh Thanh Phong Lò ®¸i",128},
{"S­¬ng Tinh Thiªn Tinh B¨ng Tinh thñ ",129},
{"S­¬ng Tinh Phong B¹o chØ hoµn",130},
{"L«i Khung Hµn Tung B¨ng B¹ch quan",131},
{"L«i Khung Thiªn §Þa Hé phï ",132},
{"L«i Khung Phong L«i Thanh CÈm ®¸i",133},
{"L«i Khung Linh Ngäc UÈn L«i",134},
{"L«i Khung Cöu Thiªn DÉn L«i giíi",135},
{"Vô ¶o B¾c Minh §¹o qu¸n",136},
{"Vô ¶o Ki B¸n phï chó ",137},
{"Vô ¶o Thóc T©m chØ hoµn",138},
{"Vô ¶o Thanh ¶nh HuyÒn Ngäc Béi",139},
{"Vô ¶o Tung Phong TuyÕt ¶nh ngoa",140},


},
}

function GiveUIOK4(putCount) --ep phi phong 9
	if (putCount == 0) then 
		Talk(1,"", "Xin vui lßng ®Æt vµo trang bÞ HKMP")
		return
	end
	local itemIndex = GetGiveItemUnit(1)
	local bindState = GetItemBindState(itemIndex)
	if (bindState ~=0) then
		Talk(1,"", "Trang bi ®ang  trong tr¹ng th¸i khãa, kh«ng thÓ n©ng cÊp")
		return
	end	
	local ts1 = ITEM_GetExpiredTime(itemIndex) -- timestamp: thoi gian tin = s tu 1/1/1970
	local ts2 = GetLocalTime()
	local t = 1--ts1 - ts2
	  local ntime = t/60 
	--print(ts1,ntime)
	if (t >0) then
		
		
		local goldEquipIndex = GetGlodEqIndex(itemIndex)
		local hkmpTable = tbHKMP[1]
		local minId = hkmpTable[1][2]
		local maxId = hkmpTable[3][2]   --- d·y cuèi cïng cña bant tbHKMP ®Þnh nghÜa ë trªn
				
		if (goldEquipIndex < 1) or (goldEquipIndex > 140) then 
			Talk(1,"", "Xin vui lßng ®Ët vµo 1 trang bÞ HKMP")
			return
		end
	local nSilverCount = CalcEquiproomItemCount(4,417,1,1) ;
	if(nSilverCount < 100) then
		Talk(1, "no", "CÇn cã 100 <color=red>TiÒn §ång<color> míi cã thÓ läc.")
		return
		end
	
	
		if (RemoveItemByIndex(itemIndex) == 1) then
                                                                                   tenhk = tbHKMP[1][goldEquipIndex][1] 
			local requireIngradent = CalcEquiproomItemCount(4, 417, 1, -1)
			local ndxit = AddGoldItem(0, goldEquipIndex )
			local rate = CalcEquiproomItemCount(4, 417, 1, -1); 
			if (rate >= 100) then
			ConsumeEquiproomItem(100, 4, 417, 1, -1)
				ITEM_SetExpiredTime(ndxit,ntime)
				SyncItem(ndxit);
--Msg2SubWorld("Chóc mõng ®¹i hiÖp <color=green>"..GetName().."<color> läc l¹i option trang bÞ <color=gold>"..tenhk.."<color> T¹i NPC.")
				else
		Talk(1, "", "CÇn cã 100 <color=red>TiÒn §ång<color> míi cã thÓ läc trang bÞ xin h·y kiÔm tra l¹i.")
		return
		end
	else
		Talk(1,"", "Trang bÞ kh«ng cã trong danh s¸ch hoÆc ®· hÕt h¹n sö dông hoÆc nguyªn liÖu kh«ng ®óng")
		return
	end
end
end


----------------------------------------------------Ho¸n §æi Trang BÞ----------------------------------------------------
function hoandoitrangbi()
	--dofile("script/global/sang/tinhnang/hoanbinhvukhi/main.lua")
		local tbOpt = {
		{"Ta muèn Ho¸n §æi Binh KhÝ.",weaponswap},
		{"TÈy LuyÖn Thuéc TÝnh ",reroll,{1}},
		{"KÕt Thóc",No},
	}
	CreateNewSayEx("<color=green>Chøc N¨ng Ho¸n §æi Vò KhÝ Vµ Thay §æi Thuéc TÝnh !!!<color>", tbOpt)
	  return 1;
end

function WriteLogAll(szPath, szFile, szMsg)
	local logDir = "log/"
	local check = io.open(logDir.."test.tmp", "w")
	if not check then
		os.execute("mkdir " .. logDir)
	else
		check:close()
		os.remove(logDir.."test.tmp")
	end

	local filePath = logDir.."hoanbinhvukhi_"..date("%d_%m_%Y")..".txt"
	local file = io.open(filePath, "a+")
	if file then
		file:write(string.format("[%s] %s\n", date("%Y-%m-%d %H:%M:%S"), szMsg))
		file:close()
	else
		Msg2Player("<color=red>Kh«ng thÓ ghi log! H·y kiÓm tra quyÒn th­ môc /log/<color>")
	end
end

function weaponswap()
	local tbMaterial = tbMaterial_List;
	local szTitle = format("Ho¸n Binh Vò KhÝ")
	local szContent = "§Æt vò khÝ cÇn ®æi vµo :";
	szContent = szContent.."<enter>------------------";
	szContent = szContent.."<enter>Nguyªn liÖu cÇn :";
	szContent = format("%s<enter>%-20s  %s", szContent, "VËt phÈm", "Sè l­îng")	
	for i = 1, getn(tbMaterial_List) do
		szContent = format("%s<enter>%-20s  %s", szContent, tbMaterial_List[i].szName, tbMaterial_List[i].nCount)
	end
	if nPractice_Fees > 0 then 
		szContent = format("%s<enter>%-20s  %s", szContent, "V¹n l­îng", floor(nPractice_Fees/10000))
		g_GiveItemUI(szTitle, szContent, {weaponswap_action})
	end
	
end

function weaponswap_action(nCount)
	if nCount ~= 1 then
		Talk(1, "", "ChØ ®­îc bá 1 mãn vò khÝ cÇn ho¸n ®æi")
		return
	end
	nItemIndex = GetGiveItemUnit(1)
	local nEquipVer = ITEM_GetItemVersion(nItemIndex)
	local nQuality = GetItemQuality(nItemIndex)
	local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
	local nEquipRandSeed = ITEM_GetItemRandSeed(nItemIndex)
	local arynMagLvl = GetItemAllParams(nItemIndex)	
	local nOldItemIndex = GetItemName(nItemIndex)
	if (nQuality ~= 0) then 
		Talk (1,"","Trang bÞ ®Æt vµo kh«ng ph¶i <color=blue>Trang BÞ Xanh") 
		return 
	end
	if nGenre ~= 0 or nDetailType >= 2 then 
		Talk(1,"","Trang bÞ ng­¬i bá vµo kh«ng ph¶i lµ <color=red>Vò KhÝ<color>!!!") 
		return 
	end

	if (GetCash() < nPractice_Fees) then
		Say(format("RÊt tiÕc! B¹n kh«ng cã ®ñ <color=yellow>%s l­îng<color>!",nPractice_Fees));
		return
	end;
	for i = 1, getn(tbMaterial_List) do
		local nCheck = CalcEquiproomItemCount(tbMaterial_List[i].tbProp[1],tbMaterial_List[i].tbProp[2],tbMaterial_List[i].tbProp[3],tbMaterial_List[i].tbProp[4])
		if (nCheck < tbMaterial_List[i].nCount) then
			Say(""..myplayersex().." mang thiÕu <color=red>"..(tbMaterial_List[i].nCount-nCheck).."<color> <color=yellow>"..tbMaterial_List[i].szName.."<color>!")
			return
		end;
	end;
	
	
	for i = 1, getn(tbMaterial_List) do
		ConsumeEquiproomItem(tbMaterial_List[i].nCount,tbMaterial_List[i].tbProp[1],tbMaterial_List[i].tbProp[2],tbMaterial_List[i].tbProp[3],tbMaterial_List[i].tbProp[4]);
	end;
	RemoveItemByIndex(nItemIndex)
	if nPractice_Fees > 0 then
		Pay(nPractice_Fees);
	end
	local nrate = random(1,EQUIPBLUE_LIST[1]);
	local nsum = 0
	for nkey,nitem in EQUIPBLUE_LIST[2] do
		nsum = nsum + (nitem["nrate"] * 1000)
		if (nsum > nrate) then
			local g = nitem["G"];
			local d = nitem["D"];
			local p = nitem["P"];
			local nNewItemIndex = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,g,d,p,nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
			local msg = format("<color=yellow>Chóc mõng "..myplayersex().." ®· Ho¸n Binh thµnh c«ng tõ <color=blue><%s><color> Thµnh <color=blue><%s><color>.", nOldItemIndex, GetItemName(nNewItemIndex) )
			Msg2Player(msg)
			return 0
		end
	end
end


function mainreroll()
	--dofile("script/global/sang/tinhnang/hoanbinhvukhi/hoanbinh.lua")
		local tbOpt = {
		{"Ho¸n §æi Vò KhÝ",reroll,{2}},
		{"TÈy LuyÖn Thuéc TÝnh ",reroll,{1}},
		{"KÕt Thóc",No},
	}
	CreateNewSayEx("<color=green>Chøc N¨ng Ho¸n §æi Vò KhÝ Vµ Thay §æi Thuéc TÝnh !!!<color>", tbOpt)
	  return 1;
end



NGUYENLIEU = {
	[1] = {nXu = 100, nDa = 1, nTienVan = 200000 * 5},
	[2] = { nXu = 100, nDa = 1, nTienVan = 1000000* 1},
}

IdVatPham1 = 417
TenVatPham1 = "TiÒn §ång"
IdVatPham2 = 5286
TenVatPham2 = "Th¹ch ChuyÓn Ho¸"

function reroll(nValue)
	SetTaskTemp(101,nValue)
	local nTienVan = NGUYENLIEU[nValue].nTienVan;
	local nXu = NGUYENLIEU[nValue].nXu;
	local nDa = NGUYENLIEU[nValue].nDa;
	GiveItemUI("Xin bá trang bÞ vµo «", "\n<+> "..TenVatPham1..": "..nXu.."\n<+> "..TenVatPham2..": "..nDa.."\n<+> TiÒn V¹n: "..nTienVan.."", "confirm","cancel",1);
end

function confirm(nCount)
	nValue = GetTaskTemp(101)
	local nTienVan = NGUYENLIEU[nValue].nTienVan;
	local nXu = NGUYENLIEU[nValue].nXu;
	local nDa = NGUYENLIEU[nValue].nDa;
	local nTienDong = CalcEquiproomItemCount(4,IdVatPham1,1,1)
	local nXKC = CalcItemCount(3,6,1,IdVatPham2,-1) ;
	if  (nTienDong < nXu) then Say(""..myplayersex().." mang thiÕu <color=red>"..nXu.."<color> "..TenVatPham1.."!") return end 
	if  (nXKC < nDa) then Say(""..myplayersex().." mang thiÕu <color=red>"..nDa.."<color> "..TenVatPham2.."!") return end 
	if  (GetCash() < nTienVan) then Say(""..myplayersex().." mang thiÕu <color=red>"..nTienVan.."<color> l­îng!") return end
	for i = 1, nCount do				
		local nItemIndex = GetGiveItemUnit(i)
		local nQuality = GetItemQuality(nItemIndex)
		local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
		local arynMagLvl = GetItemAllParams(nItemIndex)
		for j = 1, 6 do	
		local nOpt = GetItemMagicAttrib(nItemIndex, j)
	if (nCount ~= 1)  then Talk(1, "", ""..myplayersex().." chØ cÇn bá <color=red>"..GetItemName(nItemIndex).."<color> vµo lµ ®­îc!\nnh÷ng thø kh¸c ta sÏ trõ trong hµnh trang...!"); return end
	--if (nLevel < 10) then Talk (1,"","ChØ cã thÓ thùc hiÖn trªn trang bÞ xanh cÊp <color=red>10") return end
	--if (nQuality ~= 0) then Talk (1,"","ChØ cã thÓ thùc hiÖn trªn <color=blue>Trang BÞ Xanh") return end
	--if (nOpt < 6) then Talk(1,"","ChØ cã thÓ thùc hiÖn trªn <color=blue>Trang BÞ Xanh - 6 Dßng") return end
		end
	if nValue == 1 then
	tbProgressBar.tbConfig[1].nTime = 2
	tbProgressBar.tbConfig[1].szTitle = "§ang Xö Lý..."
	tbProgressBar:OpenByConfig(1, _confirm, {nCount}, OnBreak)
	else
	if nDetailType >= 2 then Talk(1,"","Trang bÞ ng­¬i bá vµo kh«ng ph¶i lµ <color=red>Vò KhÝ<color>!!!") return end
	tbProgressBar.tbConfig[1].nTime = 2
	tbProgressBar.tbConfig[1].szTitle = "§ang Xö Lý..."
	tbProgressBar:OpenByConfig(1, _confirm, {nCount}, OnBreak)
	end
	end
end


function _confirm(nCount)
	nValue = GetTaskTemp(101)
	local nTienVan = NGUYENLIEU[nValue].nTienVan;
	local nXu = NGUYENLIEU[nValue].nXu;
	local nDa = NGUYENLIEU[nValue].nDa;
		for i = 1, nCount do				
			local nItemIndex = GetGiveItemUnit(i)
			local nEquipVer = ITEM_GetItemVersion(nItemIndex)
			local nQuality = GetItemQuality(nItemIndex)
			local nEquipRandSeed = ITEM_GetItemRandSeed(nItemIndex)
			local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
			local arynMagLvl = GetItemAllParams(nItemIndex)			
				-----------------------------------Xoa Vat Pham--------------------------------
				if nItemIndex <= 0 or not GetItemName(nItemIndex) then
				Msg2Player("Kh«ng thÓ x¸c ®Þnh trang bÞ, thao t¸c bÞ hñy!")
				return
				end
				RemoveItemByIndex(nItemIndex)
				ConsumeEquiproomItem(nXu,4,IdVatPham1,1,1) ; 
				ConsumeEquiproomItem(nDa,6,1,IdVatPham2,-1);
				Pay(nTienVan);
				---------------------Them Vat Pham Moi--------------------------------
				if nValue == 1 then
						local ItemIndex = AddItemEx(nEquipVer,0,nQuality,nGenre,nDetailType,nParticular,nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
						local msg = format("<color=yellow>Chóc mõng "..myplayersex().." <color=green>%s<color> ®· tÈy luyÖn thuéc tÝnh trang bÞ <color=blue><%s><color> thµnh c«ng. <pic=7>" ,GetName(), GetItemName(ItemIndex) )
						Msg2SubWorld(msg) 
				else
					i = random (1,100)
					if i < 31 then
					local ItemName = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,0,random(0,6),nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
					local msg = format("<color=yellow>Chóc mõng "..myplayersex().." <color=green>%s<color> ®· ®æi vò khÝ thµnh c«ng <color=blue><%s><color>." ,GetName(), GetItemName(ItemName) )
					Msg2SubWorld(msg)
					elseif i < 61 then
					local ItemName = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,1,random(0,2),nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
					local msg = format("<color=yellow>Chóc mõng "..myplayersex().." <color=green>%s<color> ®· ®æi vò khÝ thµnh c«ng <color=blue><%s><color>." ,GetName(), GetItemName(ItemName) )
					Msg2SubWorld(msg)
					else
					AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,nDetailType,nParticular,nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
					Msg2Player("Ho¸n binh thÊt b¹i - Trang bÞ ®­îc gi÷ nguyªn.")
					end
				end
			end	
end


function OnBreak()
	Msg2Player("Thao T¸c BÞ Hñy, Xin Thö L¹i!")
end
-----------------------------------------------------------------------------------------------

----------------------------------------------------T¨ng Gi¶m CÊp Trang BÞ----------------------------------------------------
function TangGiamTrangBi()
	local tbSay = {"<dec>Mêi §¹i HiÖp Chän Chøc N¨ng"};
		tinsert(tbSay, "T¨ng CÊp Trang BÞ/UpgradeDo")
		tinsert(tbSay, "H¹ CÊp Trang BÞ/DowngradeDo")
		tinsert(tbSay, "§ãng./no");
	CreateTaskSay(tbSay);
end
--------------------------------
function UpgradeDo()
GiveItemUI("T¨ng cÊp Trang bÞ ", "§¹i hiÖp ®Æt vËt phÈm vµo!", "UpItemConfirm", "onCancel", 1);
end

function UpItemConfirm(nCount)
for i=1, nCount do
local nItemIndex = GetGiveItemUnit(i)
local strItem = GetItemName(nItemIndex)
local nEquipVer = ITEM_GetItemVersion(nItemIndex)
local nEquipRandSeed = ITEM_GetItemRandSeed(nItemIndex)
local nQuality = GetItemQuality(nItemIndex)
local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
local arynMagLvl = GetItemAllParams(nItemIndex)
-- CHAN: chi cho phep do xanh (Trang Bi)
        if nQuality ~= 0 and nQuality ~= 2 then
			Talk(1, "", "Kh«ng thÓ t¨ng cÊp ®å HKMP/B¹ch Kim.")
			return
		end
        
        -- CHAN: chi cho phep trang bi (Genre 0)
        if nGenre ~= 0 then
            Talk(1, "", "VËt phÈm nµy kh«ng ph¶i trang bÞ.")
            return
        end
if nLevel>0 and nLevel<10 then
RemoveItemByIndex(nItemIndex)
newitem_index = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,nDetailType,nParticular,nLevel+1,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
local strItem_new = GetItemName(newitem_index)
Msg2Player("<enter> §¹i hiÖp<color=green> T¨ng cÊp<color> VËt phÈm <color><color=gold>thµnh c«ng!")
Talk(1, "", "§¹i hiÖp T¨ng cÊp thµnh c«ng <color=yellow>"..strItem.."<color> thµnh <color=yellow>"..strItem_new);
else
Talk(1, "", "Kh«ng thÓ <color=green>T¨ng cÊp <color><color=yellow>"..strItem)
end
end
end
--------------------------------
function DowngradeDo()
GiveItemUI("H¹ cÊp Trang bÞ ", "§¹i hiÖp ®Æt vËt phÈm vµo!", "DownItemConfirm", "onCancel", 1);
end
function DownItemConfirm(nCount)
for i=1, nCount do
local nItemIndex = GetGiveItemUnit(i)
local strItem = GetItemName(nItemIndex)
local nEquipVer = ITEM_GetItemVersion(nItemIndex)
local nEquipRandSeed = ITEM_GetItemRandSeed(nItemIndex)
local nQuality = GetItemQuality(nItemIndex)
local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
local arynMagLvl = GetItemAllParams(nItemIndex)
-- CHAN: chi cho phep do xanh (Trang Bi)
        if nQuality ~= 0 and nQuality ~= 2 then
			Talk(1, "", "Kh«ng thÓ h¹ cÊp ®å HKMP/B¹ch Kim.")
			return
		end
        
        -- CHAN: chi cho phep trang bi (Genre 0)
        if nGenre ~= 0 then
            Talk(1, "", "VËt phÈm nµy kh«ng ph¶i trang bÞ.")
            return
        end
if nLevel>1 then
RemoveItemByIndex(nItemIndex)
newitem_index = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,nGenre,nDetailType,nParticular,nLevel-1,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
local strItem_new = GetItemName(newitem_index)
Msg2Player("<enter> §¹i hiÖp<color=green> H¹ cÊp<color> VËt phÈm <color><color=gold>thµnh c«ng!")
Talk(1, "", "§¹i hiÖp<color=green> H¹ cÊp<color> thµnh c«ng <color=yellow>"..strItem.."<color> thµnh <color=yellow>"..strItem_new);
else
Talk(1, "", "Kh«ng thÓ<color=green> H¹ cÊp<color> <color=yellow>"..strItem)
end
end
end

--------------------------------------------------------------------------------
tbDoTim = {}
tbDoTim.tbTrangBi = {
    [1] = {
        szName = "Vò KhÝ",
        tbEquip = { --
        {"KiÕm", 0, 0, 0}, --
        {"§ao", 0, 0, 1}, --
        {"Chïy", 0, 0, 4}, --        
        {"Th­¬ng - KÝch", 0, 0, 3}, --        
        {"C«n - Bæng", 0, 0, 2}, --
        {"Song §ao", 0, 0, 5}, --
        {"Phi Tiªu", 0, 1, 0}, --
        {"Phi §ao", 0, 1, 1}, --
        {"Tô TiÔn", 0, 1, 2}}
    },
    [2] = {
        szName = "Mò",
        tbEquip = { --
        {"Tú L« M·o", 0, 7, 0}, --
        {"Ngò L·o Qu¸n", 0, 7, 1}, --
        {"Tu La Ph¸t KÕt", 0, 7, 2}, --
        {"Th«ng Thiªn Ph¸t Qu¸n", 0, 7, 3}, --
        {"YÓm NhËt Kh«i", 0, 7, 4}, --
        {"TrÝch Tinh Hoµn", 0, 7, 5}, --
        {"¤ Tµm M·o", 0, 7, 6}, --
        {"Quan ¢m Ph¸t Qu¸n", 0, 7, 7}, --
        {"¢m D­¬ng V« Cùc qu¸n", 0, 7, 8}, --
        {"HuyÒn Tª DiÖn Tr¸o", 0, 7, 9}, --
        {"Long HuyÕt §Çu hoµn", 0, 7, 10}, --
        {"Long L©n Kh«i", 0, 7, 11}, --
        {"Thanh Tinh Thoa", 0, 7, 12}, --
        {"Kim Phông TriÓn SÝ ", 0, 7, 13}}
    },
    [3] = {
        szName = "Trang phôc",
        tbEquip = { --
        {"ThÊt B¶o Cµ Sa", 0, 2, 0}, --
        {"Ch©n Vò Th¸nh Y", 0, 2, 1}, --        
        {"Thiªn NhÉn MËt Trang", 0, 2, 2}, --
        {"Gi¸ng Sa Bµo", 0, 2, 3}, --
        {"§­êng Nghª Gi¸p", 0, 2, 4}, --
        {"V¹n L­u Quy T«ng Y", 0, 2, 5}, --
        {"TuyÒn Long Bµo", 0, 2, 6}, --
        {"Long Tiªu §¹o Y", 0, 2, 8}, --
        {"Cöu VÜ B¹ch Hå Trang", 0, 2, 9}, --
        {"TrÇm H­¬ng Sam", 0, 2, 10}, --
        {"TÝch LÞch Kim Phông gi¸p", 0, 2, 11}, --
        {"V¹n Chóng TÒ T©m Y", 0, 2, 12}, --
        {"L­u Tiªn QuÇn", 0, 2, 13}}
    },
    [4] = {
        szName = "D©y ChuyÒn",
        tbEquip = { --
        {"Toµn Th¹ch H¹ng Liªn", 0, 4, 0}, --
        {"Lôc PhØ Thóy Hé Th©n Phï ", 0, 4, 1}}
    },
    [5] = {
        szName = "Th¾t L­ng",
        tbEquip = { --
        {"Thiªn Tµm Yªu §¸i", 0, 6, 0}, --
        {"B¹ch Kim Yªu §¸i", 0, 6, 1}}
    },
    [6] = {
        szName = "NhÉn",
        tbEquip = {{"Giíi ChØ", 0, 3, 0}}
    },
    [7] = {
        szName = "Bao Tay",
        tbEquip = { --
        {"Ngäc Tr¹c (N÷)", 0, 8, 0}, --
        {"Hé UyÓn (Nam)", 0, 8, 1}}
    },
    [8] = {
        szName = "Ngäc Béi",
        tbEquip = { --
        {"Long Tiªn H­¬ng Nang", 0, 9, 0}, --
        {"D­¬ng Chi B¹ch Ngäc", 0, 9, 1}}
    },
    [9] = {
        szName = "Giµy",
        tbEquip = { --
        {"Cöu TiÕt X­¬ng VÜ Ngoa", 0, 5, 0}, --
        {"Thiªn Tµm Ngoa", 0, 5, 1}, --
        {"Kim Lò Hµi", 0, 5, 2}, --
        {"Phi Phông Ngoa", 0, 5, 3}}
    }
}

tbDoTim.tbMagic_VuKhi = {
    [0] = { -- Kim
    {"STVL ngo¹i c«ng (®iÓm)", 220},
    {"STVL néi c«ng (®iÓm)", 440}, --
    {"Kh¸ng §éc", 290} -- 
   -- {"T¨ng ®¼ng cÊp kü n¨ng hÖ Kim", 390}
    },
    [1] = { -- Méc
    {"§éc s¸t ngo¹i c«ng", 230}, --
    {"§éc s¸t néi c«ng", 480}, --
    {"Kh¸ng L«i", 320}, --
    {"Thêi gian phôc håi", 90} --
    --{"T¨ng ®¼ng cÊp kü n¨ng hÖ Méc", 410}
    },
    [2] = { -- Thuû
    {"B¨ng s¸t ngo¹i c«ng", 240}, --
    {"B¨ng s¸t néi c«ng", 450}, --
    {"Kh¸ng Ho¶", 310}, --
    {"Thêi gian cho¸ng", 340} -- 
    --{"T¨ng ®¼ng cÊp kü n¨ng hÖ Thuû", 400}
    },
    [3] = { -- Ho¶
    {"Ho¶ s¸t ngo¹i c«ng", 250}, --
    {"Ho¶ s¸t néi c«ng", 460}, --
    {"Thêi gian lµm chËm", 360} -- 
    --{"T¨ng ®¼ng cÊp kü n¨ng hÖ Ho¶", 420}
    },
    [4] = { -- Thæ
    {"L«i s¸t ngo¹i c«ng", 260}, --
    {"L«i s¸t néi c«ng", 470}, --
    {"Kh¸ng B¨ng", 300}, --
    {"Thêi gian tróng §éc", 380} --
    --{"T¨ng ®¼ng cÊp kü n¨ng hÖ Thæ", 430}
    }
}

tbDoTim.tbMagic_TrangPhuc = {
    [0] = { -- Kim
    {"Kh¸ng §éc", 290}},
    [1] = { -- Méc
    {"Kh¸ng L«i", 320}, --
    {"Thêi gian phôc håi", 90}},
    [2] = { -- Thuû
    {"Kh¸ng Ho¶", 310}, --
    {"Thêi gian cho¸ng", 340}},
    [3] = { -- Ho¶		
    {"Phßng thñ VËt lý", 280}, --
    {"Thêi gian lµm chËm", 360}},
    [4] = { -- Thæ
    {"Kh¸ng B¨ng", 300}, --
    {"Thêi gian tróng §éc", 380}}
}

tbDoTim.tbMagic_All = {
    [1] = { -- Vò KhÝ
    {"Sinh lùc", 150}, --
   -- {"Néi lùc", 160}, --
    {"Kü n¨ng vèn cã", 110}, --
    {"Hót sinh lùc", 130}, --
    {"Hót néi lùc", 140}, --
    {"STVL ngo¹i c«ng (%)", 10}, --
    {"STVL ngo¹i c«ng (®iÓm)", 220}, --
    {"Tèc ®é ®¸nh ngo¹i c«ng", 30}, --
    {"TØ lÖ c«ng kÝch chÝnh x¸c", 20}, --
    --{"T¨ng ph¹m vi s¸t th­¬ng", 100}, --
    {"Bá qua nÐ tr¸nh", 40}, --
	--{"Tèc ®é ®¸nh néi c«ng", 490}, --
   -- {"Kh«ng thÓ ph¸ huû", 50}
    },
    [2] = { -- Trang bÞ
    {"Sinh lùc", 150}, --
    {"Néi lùc", 160}, --
    --{"Kü n¨ng vèn cã", 110}, --
    {"ChuyÓn ho¸ s¸t th­¬ng thµnh néi lùc", 270}, --
    {"Phôc håi sinh lùc mçi nöa gi©y", 180}, --
    {"May m¾n", 350}, --
    {"Sinh khÝ", 330}, --
    {"Søc m¹nh", 210}, --
    {"Th©n ph¸p", 370}, --
   -- {"NÐ tr¸nh", 60}, -- 
	--{"Tèc ®é ®¸nh néi c«ng", 490}, --
    --{"Kh«ng thÓ ph¸ huû", 50}
    }
}

tbDoTim.tbSeries = {
    [0] = {"Kim", "yellow"},
    [1] = {"Méc", "green"},
    [2] = {"Thuû", "blue"},
    [3] = {"Ho¶", "red"},
    [4] = {"Thæ", "orange"}
}
szSerires = function(num)
    return format("<color=%s>%s<color>", tbDoTim.tbSeries[num][2], tbDoTim.tbSeries[num][1])
end

function tbDoTim:Define()
    self.tbWeaponMagic = self.tbMagic_VuKhi
    self.tbEquipMagic = self.tbMagic_TrangPhuc
    for i = 0, getn(self.tbSeries) do
        for _, tbOptVK in self.tbMagic_All[1] do
            tinsert(self.tbWeaponMagic[i], tbOptVK)
        end
        for _, tbOptTB in self.tbMagic_All[2] do
            tinsert(self.tbEquipMagic[i], tbOptTB)
        end
    end
end
tbDoTim:Define()

tbCheTao = {
    nItemId = 0,
    szName = "",
    nLevel = 0,
    nGenre = 0,
    nDetail = 0,
    nPart = 0,
    nSeries = 0,
    tbOptions = {}
}

function Chetaodotimvip()
--function main()
    dofile("script/global/sang/npc/npc_dotim.lua")
    MAIN_TITLE = "<npc>Mêi <sex><bclr=red>" .. GetName() .. "<bclr> lùa chän <pic=46>\n"
    local szTitle = "<npc><sex><bclr=red>" .. GetName() .. "<bclr> muèn chÕ t¹o <bclr=pink>§å TÝm<bclr> ch¨ng <pic=44><color>"
    local tbOpt = {}
    for id, tbEquip in tbDoTim.tbTrangBi do
        tinsert(tbOpt, {id .. ". " .. tbEquip.szName, PurpleItem_diaglog, {id}})
    end
    tinsert(tbOpt, {"KÕt thóc ®èi tho¹i"})

    CreateNewSayEx(szTitle, tbOpt)
end

function PurpleItem_diaglog(nItemId)
    if (CountFreeRoomByWH(2, 3) < 1) then
        Talk(1, "", "Hµnh trang kh«ng ®ñ « trèng! Xin h·y s¾p xÕp råi quay l¹i nhÐ.");
        return
    end
    MAIN_TITLE = MAIN_TITLE ..
                     strfill_center(" ChÕ t¹o <bclr=pink>" .. tbDoTim.tbTrangBi[nItemId].szName .. "<bclr> ", 70, ".")
    local tbOpt = {}
    for id, tbEquip in tbDoTim.tbTrangBi[nItemId].tbEquip do
        local nEqIdx, nGenre, nDetail, nPart = id, tbEquip[2], tbEquip[3], tbEquip[4]
        tinsert(tbOpt, {tbEquip[1], getItemLevel, {nItemId, nEqIdx, nGenre, nDetail, nPart}})
    end
    tinsert(tbOpt, {"Trë l¹i", main})
    tinsert(tbOpt, {"KÕt thóc ®èi tho¹i"})
    CreateNewSayEx(MAIN_TITLE, tbOpt)
end

function getItemLevel(nItemId, nEqIdx, nGenre, nDetail, nPart)
    tbCheTao.nItemId = nItemId
    tbCheTao.szName = tbDoTim.tbTrangBi[nItemId].tbEquip[nEqIdx][1]
    tbCheTao.nGenre = nGenre
    tbCheTao.nDetail = nDetail
    tbCheTao.nPart = nPart
    g_AskClientNumberEx(1, 10, "Item level", {getItemSeries})
end

function getItemSeries(nItemLevel)
    tbCheTao.nLevel = nItemLevel
    MAIN_TITLE = MAIN_TITLE .. format("\n<pic=137> Trang bÞ: <bclr=blue>%s<bclr> cÊp: %d", tbCheTao.szName, nItemLevel)
    local szTitle = MAIN_TITLE .. "\n<pic=136><color>Chän ngò hµnh:"
    local tbOpt = {}
    for nSeries, tbHe in tbDoTim.tbSeries do
        tinsert(tbOpt, {"HÖ " .. tbHe[1], getLine, {1, nSeries}})
    end
    tinsert(tbOpt, {"KÕt thóc ®èi tho¹i"})
    CreateNewSayEx(szTitle, tbOpt)
end

function getLine(nLine, nSeries, tbLineOpt)
    tbCheTao.nSeries = nSeries
    local tbOpt = {}
    local szTitle
    if nLine == 1 then -- dßng 1
        MAIN_TITLE = MAIN_TITLE .. "\n<pic=136><color> Ngò hµnh hÖ: " .. szSerires(nSeries)
    else -- dßng #1
        tinsert(tbCheTao.tbOptions, tbLineOpt)
        local nPreLine = nLine - 1
        local szColor = mod(nPreLine, 2) == 0 and "violet" or "pink"
        MAIN_TITLE = MAIN_TITLE ..
                         format("\n  - Dßng %d: <color=%s>%s<color>", nPreLine, szColor,
                tbCheTao.tbOptions[nPreLine][1])
        Msg2Player("Dßng " .. nPreLine .. ": <color=green>" .. tbCheTao.tbOptions[nPreLine][1])
    end
    if nLine <= 6 then
        szTitle = MAIN_TITLE .. "\n<pic=135><color> Chän dßng " .. nLine .. ":"
        insertTable(tbOpt, nLine + 1)
    else
        szTitle = MAIN_TITLE
        tinsert(tbOpt, {"§ång ý chÕ t¹o", CheTaoDoTim})
        tinsert(tbOpt, {"Tho¸t", no})
    end
    CreateNewSayEx(szTitle, tbOpt)
end

function insertTable(tbOpt, nLine)
    if tbCheTao.nItemId == 1 then -- check id nÕu lµ vò khÝ
        for _, optVK in tbDoTim.tbWeaponMagic[tbCheTao.nSeries] do
            if type(optVK) == "table" then
                tinsert(tbOpt, {optVK[1], getLine, {nLine, tbCheTao.nSeries, optVK}})
            end
        end
    else
        if tbCheTao.nItemId == 9 then -- nÕu lµ giµy th× thªm dßng TDDC
            tinsert(tbOpt, {"Tèc ®é di chuyÓn", getLine, {nLine, tbCheTao.nSeries, {"Tèc ®é di chuyÓn", 70}}})
        end
        if tbCheTao.nItemId == 4 then -- nÕu lµ d©y chuyÒn th× thªm dßng Kh¸ng tÊt c¶
            tinsert(tbOpt, {"Kh¸ng tÊt c¶", getLine, {nLine, tbCheTao.nSeries, {"Kh¸ng tÊt c¶", 120}}})
        end
        if tbCheTao.nItemId == 3 and tbCheTao.nSeries == 0 then -- nÕu lµ ¸o hÖ Kim th× thªm dßng Ph¶n ®ßn cËn chiÕn
            tinsert(tbOpt,
                {"Ph¶n ®ßn cËn chiÕn", getLine, {nLine, tbCheTao.nSeries, {"Ph¶n ®ßn cËn chiÕn", 80}}})
        end
        for _, optTB in tbDoTim.tbEquipMagic[tbCheTao.nSeries] do
            if type(optTB) == "table" then
                tinsert(tbOpt, {optTB[1], getLine, {nLine, tbCheTao.nSeries, optTB}})
            end
        end
    end
    tinsert(tbOpt, {"Tho¸t", no})
end

function CheTaoDoTim()
    local nItemIdx = AddQualityItem(2, tbCheTao.nGenre, tbCheTao.nDetail, tbCheTao.nPart, tbCheTao.nLevel,
        tbCheTao.nSeries, 500, tbCheTao.tbOptions[1][2], tbCheTao.tbOptions[2][2], tbCheTao.tbOptions[3][2],
        tbCheTao.tbOptions[4][2], tbCheTao.tbOptions[5][2], tbCheTao.tbOptions[6][2])
    Msg2Player("NhËn ®­îc <color=pink>" .. GetItemName(nItemIdx)) -- tbCheTao.szName
    tbCheTao.tbOptions = {}
end

--------------------------------------------------------------------------------------

function mainhoandoi()
	--dofile("script/global/sang/tinhnang/hoanbinhvukhi/main.lua")
		local tbOpt = {
			{"Ta muèn Ho¸n §æi Binh KhÝ.",weaponswap},
			{"KÕt thóc dèi tho¹i",No},
		}
	CreateNewSayEx("<npc><color=green>ta ®©y cã nhiÒu sù lùa chän cho "..myplayersex().." , ng­¬i muèn lµm g× ?<color>", tbOpt)
end

--function WriteLogAll(szPath, szFile, szMsg)
	--local filePath = "log/hoanbinhvukhi_"..date("%d_%m_%Y")..".txt"
	--local file = io.open(filePath, "a+")
	--if file then
		--file:write(string.format("[%s] %s\n", date("%Y-%m-%d %H:%M:%S"), szMsg))
		--file:close()
	--else
		--Msg2Player("<color=red>Kh«ng thÓ ghi log! H·y kiÓm tra quyÒn th­ môc /log/<color>")
	--end
--end

function WriteLogAll(szPath, szFile, szMsg)
	local logDir = "log/"
	local check = io.open(logDir.."test.tmp", "w")
	if not check then
		os.execute("mkdir " .. logDir)
	else
		check:close()
		os.remove(logDir.."test.tmp")
	end

	local filePath = logDir.."hoanbinhvukhi_"..date("%d_%m_%Y")..".txt"
	local file = io.open(filePath, "a+")
	if file then
		file:write(string.format("[%s] %s\n", date("%Y-%m-%d %H:%M:%S"), szMsg))
		file:close()
	else
		Msg2Player("<color=red>Kh«ng thÓ ghi log! H·y kiÓm tra quyÒn th­ môc /log/<color>")
	end
end

function weaponswap()
	local tbMaterial = tbMaterial_List;
	local szTitle = format("Ho¸n Binh Vò KhÝ")
	local szContent = "§Æt vò khÝ cÇn ®æi vµo :";
	szContent = szContent.."<enter>------------------";
	szContent = szContent.."<enter>Nguyªn liÖu cÇn :";
	szContent = format("%s<enter>%-20s  %s", szContent, "VËt phÈm", "Sè l­îng")	
	for i = 1, getn(tbMaterial_List) do
		szContent = format("%s<enter>%-20s  %s", szContent, tbMaterial_List[i].szName, tbMaterial_List[i].nCount)
	end
	if nPractice_Fees > 0 then 
		szContent = format("%s<enter>%-20s  %s", szContent, "V¹n l­îng", floor(nPractice_Fees/10000))
		g_GiveItemUI(szTitle, szContent, {weaponswap_action})
	end
	
end

function weaponswap_action(nCount)
	if nCount ~= 1 then
		Talk(1, "", "ChØ ®­îc bá 1 mãn vò khÝ cÇn ho¸n ®æi")
		return
	end
	nItemIndex = GetGiveItemUnit(1)
	local nEquipVer = ITEM_GetItemVersion(nItemIndex)
	local nQuality = GetItemQuality(nItemIndex)
	local nGenre, nDetailType, nParticular, nLevel, nSeries, nLuck = GetItemProp(nItemIndex)
	local nEquipRandSeed = ITEM_GetItemRandSeed(nItemIndex)
	local arynMagLvl = GetItemAllParams(nItemIndex)	
	local nOldItemIndex = GetItemName(nItemIndex)
	if (nQuality ~= 0) then 
		Talk (1,"","Trang bÞ ®Æt vµo kh«ng ph¶i <color=blue>Trang BÞ Xanh") 
		return 
	end
	if nGenre ~= 0 or nDetailType >= 2 then 
		Talk(1,"","Trang bÞ ng­¬i bá vµo kh«ng ph¶i lµ <color=red>Vò KhÝ<color>!!!") 
		return 
	end

	if (GetCash() < nPractice_Fees) then
		Say(format("RÊt tiÕc! B¹n kh«ng cã ®ñ <color=yellow>%s l­îng<color>!",nPractice_Fees));
		return
	end;
	for i = 1, getn(tbMaterial_List) do
		local nCheck = CalcEquiproomItemCount(tbMaterial_List[i].tbProp[1],tbMaterial_List[i].tbProp[2],tbMaterial_List[i].tbProp[3],tbMaterial_List[i].tbProp[4])
		if (nCheck < tbMaterial_List[i].nCount) then
			Say(""..myplayersex().." mang thiÕu <color=red>"..(tbMaterial_List[i].nCount-nCheck).."<color> <color=yellow>"..tbMaterial_List[i].szName.."<color>!")
			return
		end;
	end;
	
	
	for i = 1, getn(tbMaterial_List) do
		ConsumeEquiproomItem(tbMaterial_List[i].nCount,tbMaterial_List[i].tbProp[1],tbMaterial_List[i].tbProp[2],tbMaterial_List[i].tbProp[3],tbMaterial_List[i].tbProp[4]);
	end;
	RemoveItemByIndex(nItemIndex)
	if nPractice_Fees > 0 then
		Pay(nPractice_Fees);
	end
	local nrate = random(1,EQUIPBLUE_LIST[1]);
	local nsum = 0
	for nkey,nitem in EQUIPBLUE_LIST[2] do
		nsum = nsum + (nitem["nrate"] * 1000)
		if (nsum > nrate) then
			local g = nitem["G"];
			local d = nitem["D"];
			local p = nitem["P"];
			local nNewItemIndex = AddItemEx(nEquipVer,nEquipRandSeed,nQuality,g,d,p,nLevel,nSeries,nLuck,arynMagLvl[1],arynMagLvl[2],arynMagLvl[3],arynMagLvl[4],arynMagLvl[5],arynMagLvl[6])
			local msg = format("<color=yellow>Chóc mõng "..myplayersex().." ®· Ho¸n Binh thµnh c«ng tõ <color=blue><%s><color> Thµnh <color=blue><%s><color>.", nOldItemIndex, GetItemName(nNewItemIndex) )
			Msg2Player(msg)
			return 0
		end
	end
end

----------------------------------------------------------------------------------------------------
tb_TrangBiHKMP =
{	[1]={"Méng Long ChÝnh Hång T¨ng M·o",1,239},
	[2]={"Méng Long Kim Ti ChÝnh Hång Cµ Sa",2,240},
	[3]={"Méng Long HuyÒn Ti Ph¸t ®¸i",3,241},
	[4]={"Méng Long PhËt Ph¸p HuyÒn Béi",4,242},
	[5]={"Méng Long §¹t Ma T¨ng hµi",5,243},
	[6]={"Phôc Ma Tö Kim C«n",6,244},
	[7]={"Phôc Ma HuyÒn Hoµng Cµ Sa",7,245},
	[8]={"Phôc Ma ¤ Kim NhuyÔn §iÒu",8,246},
	[9]={"Phôc Ma PhËt T©m NhuyÔn KhÊu",9,247},
	[10]={"Phôc Ma Phæ §é T¨ng hµi",10,248},
	[11]={"Tø Kh«ng Gi¸ng Ma Giíi ®ao",11,249},
	[12]={"Tø Kh«ng Tö Kim Cµ Sa",12,250},
	[13]={"Tø Kh«ng Hé ph¸p Yªu ®¸i",13,251},
	[14]={"Tø Kh«ng NhuyÔn B× Hé UyÓn",14,252},
	[15]={"Tø Kh«ng Giíi LuËt Ph¸p giíi",15,253},
	[16]={"H¸m Thiªn Kim Hoµn §¹i Nh·n ThÇn Chïy",16,254},
	[17]={"H¸m Thiªn Vò ThÇn T­¬ng Kim Gi¸p",17,255},
	[18]={"H¸m Thiªn Uy Vò Thóc yªu ®¸i",18,256},
	[19]={"H¸m Thiªn Hæ ®Çu KhÈn Thóc UyÓn",19,257},
	[20]={"H¸m Thiªn Thõa Long ChiÕn Ngoa",20,258},
	[21]={"KÕ NghiÖp B«n L«i Toµn Long th­¬ng",21,259},
	[22]={"KÕ NghiÖp HuyÒn Vò Hoµng Kim Kh¶i",22,260},
	[23]={"KÕ NghiÖp B¹ch Hæ V« Song khÊu",23,261},
	[24]={"KÕ NghiÖp HáaV©n Kú L©n Thñ ",24,262},
	[25]={"KÕ NghiÖp Chu T­íc L¨ng V©n Ngoa",25,263},
	[26]={"Ngù Long L­îng Ng©n B¶o ®ao",26,264},
	[27]={"Ngù Long ChiÕn ThÇn Phi Qu¶i gi¸p",27,265},
	[28]={"Ngù Long Thiªn M«n Thóc Yªu hoµn",28,266},
	[29]={"Ngù Long TÊn Phong Hé yÓn",29,267},
	[30]={"Ngù Long TuyÖt MÖnh ChØ hoµn",30,268},
	[31]={"V« Gian û Thiªn KiÕm",31,269},
	[32]={"V« Gian Thanh Phong Truy Y",32,270},
	[33]={"V« Gian PhÊt V©n Ti ®¸i",33,271},
	[34]={"V« Gian CÇm VËn Hé UyÓn",34,272},
	[35]={"V« Gian B¹ch Ngäc Bµn ChØ ",35,273},
	[36]={"V« Ma Ma Ni qu¸n",36,274},
	[37]={"V« Ma Tö Kh©m Cµ Sa",37,275},
	[38]={"V« Ma B¨ng Tinh ChØ Hoµn",38,276},
	[39]={"V« Ma TÈy T­îng Ngäc KhÊu ",39,277},
	[40]={"V« Ma Hång Truy NhuyÔn Th¸p hµi",40,278},
	[41]={"V« TrÇn Ngäc N÷ Tè T©m qu¸n",41,279},
	[42]={"V« TrÇn Thanh T©m H­íng ThiÖn Ch©u",42,280},
	[43]={"V« TrÇn Tõ Bi Ngäc Ban ChØ ",43,281},
	[44]={"V« TrÇn PhËt T©m Tõ H÷u Yªu Phèi",44,282},
	[45]={"V« TrÇn PhËt Quang ChØ Hoµn",45,283},
	[46]={"Tª Hoµng Phông Nghi ®ao",46,284},
	[47]={"Tª Hoµng TuÖ T©m Khinh Sa Y",47,285},
	[48]={"Tª Hoµng Phong TuyÕt B¹ch V©n Thóc §¸i",48,286},
	[49]={"Tª Hoµng B¨ng Tung CÈm uyÓn",49,287},
	[50]={"Tª Hoµng Thóy Ngäc ChØ Hoµn",50,288},
	[51]={"BÝch H¶i Uyªn ¦¬ng Liªn Hoµn ®ao",51,289},
	[52]={"BÝch H¶i Hoµn Ch©u Vò Liªn",52,290},
	[53]={"BÝch H¶i Hång Linh Kim Ti ®¸i",53,291},
	[54]={"BÝch H¶i Hång L¨ng Ba",54,292},
	[55]={"BÝch H¶i Khiªn TÕ ChØ hoµn",55,293},
	[56]={"U Lung Kim Xµ Ph¸t ®¸i",56,294},
	[57]={"U Lung XÝch YÕt MËt trang",57,295},
	[58]={"U Lung Thanh Ng« TriÒn yªu",58,296},
	[59]={"U Lung Ng©n ThÒm Hé UyÓn",59,297},
	[60]={"U Lung MÆc Thï NhuyÔn Lý ",60,298},
	[61]={"Minh ¶o Tµ S¸t §éc NhËn",61,299},
	[62]={"Minh ¶o U §éc ¸m Y",62,300},
	[63]={"Minh ¶o §éc YÕt ChØ Hoµn",63,301},
	[64]={"Minh ¶o Hñ Cèt Hé uyÓn",64,302},
	[65]={"Minh ¶o Song Hoµn Xµ Hµi",65,303},
	[66]={"Chó Ph­îc Ph¸ gi¸p ®Çu hoµn",66,304},
	[67]={"Chó Ph­îc DiÖt L«i C¶nh Phï ",67,305},
	[68]={"Chó Ph­îc U ¶o ChØ Hoµn",68,306},
	[69]={"Chó Ph­îc Xuyªn T©m §éc UyÓn",69,307},
	[70]={"Chó Ph­îc B¨ng Háa Thùc Cèt Ngoa",70,308},
	[71]={"B¨ng Hµn §¬n ChØ Phi §ao",71,309},
	[72]={"B¨ng Hµn HuyÒn Y Thóc Gi¸p",72,310},
	[73]={"B¨ng Hµn T©m TiÔn Yªu KhÊu",73,311},
	[74]={"B¨ng Hµn HuyÒn Thiªn B¨ng Háa Béi",74,312},
	[75]={"B¨ng Hµn NguyÖt ¶nh Ngoa",75,313},
	[76]={"Thiªn Quang Hoa Vò M¹n Thiªn",76,314},
	[77]={"Thiªn Quang §Þnh T©m Ng­ng ThÇn Phï ",77,315},
	[78]={"Thiªn Quang S©m La Thóc §¸i",78,316},
	[79]={"Thiªn Quang Song B¹o Hµn ThiÕt Tr¹c",79,317},
	[80]={"Thiªn Quang Thóc Thiªn Ph­îc §Þa Hoµn",80,318},
	[81]={"S©m Hoang Phi Tinh §o¹t Hån",81,319},
	[82]={"S©m Hoang KimTiÒn Liªn Hoµn Gi¸p",82,320},
	[83]={"S©m Hoang Hån Gi¶o Yªu Thóc",83,321},
	[84]={"S©m Hoang HuyÒn ThiÕt T­¬ng Ngäc Béi",84,322},
	[85]={"S©m Hoang Tinh VÉn Phi Lý ",85,323},
	[86]={"§Þa Ph¸ch Ngò hµnh Liªn Hoµn Qu¸n",86,324},
	[87]={"§Þa Ph¸ch H¾c DiÖm Xung Thiªn Liªn",87,325},
	[88]={"§Þa Ph¸ch TÝch LÞch L«i Háa Giíi",88,326},
	[89]={"§Þa Ph¸ch KhÊu T©m tr¹c",89,327},
	[90]={"§Þa Ph¸ch §Þa Hµnh Thiªn Lý Ngoa",90,328},
	[91]={"§ång Cõu Phi Long §Çu hoµn",91,329},
	[92]={"§ång Cõu Gi¸ng Long C¸i Y",92,330},
	[93]={"§ång Cõu TiÒm Long Yªu §¸i",93,331},
	[94]={"§ång Cõu Kh¸ng Long Hé UyÓn",94,332},
	[95]={"§ång Cõu KiÕn Long Ban ChØ ",95,333},
	[96]={"§Þch Kh¸i Lôc Ngäc Tr­îng",96,334},
	[97]={"§Þch Kh¸i Cöu §¹i C¸i Y",97,335},
	[98]={"§Þch Kh¸i TriÒn M·ng yªu ®¸i",98,336},
	[99]={"§Þch Kh¸i CÈu TÝch B× Hé uyÓn",99,337},
	[100]={"§Þch Kh¸i Th¶o Gian Th¹ch giíi",100,338},
	[101]={"Ma S¸t Quû Cèc U Minh Th­¬ng",101,339},
	[102]={"Ma S¸t Tµn D­¬ng ¶nh HuyÕt Gi¸p",102,340},
	[103]={"Ma S¸t XÝch Ký Táa Yªu KhÊu",103,341},
	[104]={"Ma S¸t Cö Háa Liªu Thiªn uyÓn",104,342},
	[105]={"Ma S¸t V©n Long Thæ Ch©u giíi",105,343},
	[106]={"Ma Hoµng Kim Gi¸p Kh«i",106,344},
	[107]={"Ma Hoµng ¸n XuÊt Hæ H¹ng Khuyªn",107,345},
	[108]={"Ma Hoµng Khª Cèc Thóc yªu ®¸i",108,346},
	[109]={"Ma Hoµng HuyÕt Y Thó Tr¹c",109,347},
	[110]={"Ma Hoµng §¨ng §¹p Ngoa",110,348},
	[111]={"Ma ThÞ LiÖt DiÖm Qu¸n MiÖn",111,349},
	[112]={"Ma ThÞ LÖ Ma PhÖ T©m Liªn",112,350},
	[113]={"Ma ThÞ NghiÖp Háa U Minh Giíi",113,351},
	[114]={"Ma ThÞ HuyÕt Ngäc ThÊt S¸t Béi",114,352},
	[115]={"Ma ThÞ s¬n  H¶i Phi Hång Lý ",115,353},
	[116]={"L¨ng Nh¹c Th¸i Cùc KiÕm",116,354},
	[117]={"L¨ng Nh¹c V« Ng· ®¹o bµo",117,355},
	[118]={"L¨ng Nh¹c Né L«i Giíi",118,356},
	[119]={"L¨ng Nh¹c V« Cùc HuyÒn Ngäc Béi",119,357},
	[120]={"L¨ng Nh¹c Thiªn §Þa HuyÒn Hoµng giíi",120,358},
	[121]={"CËp Phong Ch©n Vò KiÕm",121,359},
	[122]={"CËp Phong Tam Thanh Phï ",122,360},
	[123]={"CËp Phong HuyÒn Ti Tam §o¹n cÈm",123,361},
	[124]={"CËp Phong Thóy Ngäc HuyÒn Hoµng Béi",124,362},
	[125]={"CËp Phong Thanh Tïng Ph¸p giíi",125,363},
	[126]={"S­¬ng Tinh Thiªn Niªn Hµn ThiÕt",126,364},
	[127]={"S­¬ng Tinh Ng¹o S­¬ng ®¹o bµo",127,365},
	[128]={"S­¬ng Tinh Thanh Phong Lò ®¸i",128,366},
	[129]={"S­¬ng Tinh Thiªn Tinh B¨ng Tinh thñ ",129,367},
	[130]={"S­¬ng Tinh Phong B¹o chØ hoµn",130,368},
	[131]={"L«i Khung Hµn Tung B¨ng B¹ch quan",131,369},
	[132]={"L«i Khung Thiªn §Þa Hé phï ",132,370},
	[133]={"L«i Khung Phong L«i Thanh CÈm ®¸i",133,371},
	[134]={"L«i Khung Linh Ngäc UÈn L«i",134,372},
	[135]={"L«i Khung Cöu Thiªn DÉn L«i giíi",135,373},
	[136]={"Vô ¶o B¾c Minh §¹o qu¸n",136,374},
	[137]={"Vô ¶o Ki B¸n phï chó ",137,375},
	[138]={"Vô ¶o Thóc T©m chØ hoµn",138,376},
	[139]={"Vô ¶o Thanh ¶nh HuyÒn Ngäc Béi",139,377},
	[140]={"Vô ¶o Tung Phong TuyÕt ¶nh ngoa",140,378},
}
function ghepmanhhkmp()
--function main()
	dofile("script/global/sang/tinhnang/ghepmanhhkmp.lua")
	local szTitle = format("<npc>Ng­¬i chÕ t¹o Trang BÞ cña m«n ph¸i nµo xin bá vµo m·nh trang bÞ t­¬ng øng vµ c¸c nguyªn liÖu theo yªu cÇu:")
	local tbOpt = {}
		tinsert(tbOpt, {"ChÕ T¹o Hoµng Kim M«n Ph¸i", CheTaoHKMP})
		tinsert(tbOpt, {"KÕt thóc ®èi tho¹i."})
		CreateNewSayEx(szTitle, tbOpt)
end

local _OnBreak = function()
	Msg2Player("§ang tiÕn hµnh chÕ t¹o ng­êi mang nguyªn liÖu ®i ®©u vËy ! ?")
end

function CheTaoHKMP()
	local strDesc = "Nguyªn liÖu cÇn:";
	strDesc = strDesc.."\n- 10 Tö Thñy Tinh"
	strDesc = strDesc.."\n- 10 Lôc Thñy Tinh"
	strDesc = strDesc.."\n- 10 Lam Thñy Tinh"
	strDesc = strDesc.."\n- 100 §å Phæ HKMP"
	strDesc = strDesc.."\n(*)TØ lÖ thµnh c«ng: 60%"
	strDesc = strDesc.."\nL­u ý: thuéc tÝnh trang bÞ sÏ ngÉu nhiªn"

	g_GiveItemUI("GhÐp HKMP",strDesc,{CheTao_HKMP_Compound,{nIDHKMP}},"cancel",1)
end

function CheTao_HKMP_Compound(nItemCount)
	tbProgressBar:OpenByConfig(1,OK_Che_HKMP, {nItemCount}, %_OnBreak)
end

function OK_Che_HKMP(nItemCount)
	nTuThuyTinh = 10;
	nLucThuyTinh = 10;
	nLamThuyTinh = 10;
	nDoPhoHKMP = 100;
	nNganLuong =	20000000
	nTyLeThatBai = 40
	Player = {};
	Player[PlayerIndex] = {tbTuThuyTinh = {},tbLucThuyTinh = {},tbLamThuyTinh = {},tbDoPhoHKMP = {}};
	local _tbcp = Player[PlayerIndex];
	local IsTuThuyTinh,IsLucThuyTinh,IsLamThuyTinh,IsDoPhoHKMP= 0,0,0,0;
	for k=1,nItemCount do
		local nItemIndex = GetGiveItemUnit(k);
		local nPar,nType,nID = GetItemProp(nItemIndex);
		local nCountStack = GetItemStackCount(nItemIndex) or 1;
		local myitemname = GetItemName(nItemIndex);
		
		if nPar == 6 then
			for i=1, getn(tb_TrangBiHKMP) do 
				if nID == tonumber(tb_TrangBiHKMP[i][3])  then
					nID_TBHK = tb_TrangBiHKMP[i][2]
					IsDoPhoHKMP = IsDoPhoHKMP + nCountStack;
					if IsDoPhoHKMP > nDoPhoHKMP then
						Talk(1, "", "B¹n ®· bá <color=green>§å Phæ HKMP<color> qu¸ sè l­îng yªu cÇu.");
						return
					else
						tinsert(_tbcp.tbDoPhoHKMP,{nItemIndex});
					end
	
				end
			end
		elseif  nPar == 4 then
			if nType == 238 then
				if IsLamThuyTinh >= nLamThuyTinh then
					Talk(1, "", "B¹n ®· bá <color=green>Lam Thñy Tinh<color> qu¸ sè l­îng yªu cÇu.");
					return
				else	
					IsLamThuyTinh = IsLamThuyTinh + nCountStack;
					tinsert(_tbcp.tbLamThuyTinh,{nItemIndex});
				end
			end
			if nType == 239 then
				if IsTuThuyTinh>= nTuThuyTinh then
					Talk(1, "", "B¹n ®· bá <color=green>Tö Thñy Tinh<color> qu¸ sè l­îng yªu cÇu.");
					return
				else	
					IsTuThuyTinh= IsTuThuyTinh + nCountStack;
					tinsert(_tbcp.tbTuThuyTinh,{nItemIndex});
				end
			end
			if nType == 240 then
				if IsLucThuyTinh >= nLucThuyTinh then
					Talk(1, "", "B¹n ®· bá <color=green>Lôc Thñy Tinh<color> qu¸ sè l­îng yªu cÇu.");
					return
				else	
					IsLucThuyTinh= IsLucThuyTinh+ nCountStack;
					tinsert(_tbcp.tbLucThuyTinh,{nItemIndex});
				end
			end
		end
	end

	if IsLamThuyTinh ~= nLamThuyTinh then
		Talk(1, "", "B¹n ch­a bá hoÆc bá <color=green>Lam Thñy Tinh<color> kh«ng ®óng yªu cÇu.");
		return
	end
	if IsTuThuyTinh ~= nTuThuyTinh then
		Talk(1, "", "B¹n ch­a bá hoÆc bá <color=green>Tö Thñy Tinh<color> kh«ng ®óng yªu cÇu.");
		return
	end
	if IsLucThuyTinh ~= nLucThuyTinh then
		Talk(1, "", "B¹n ch­a bá hoÆc bá <color=green>Lôc Thñy Tinh<color> kh«ng ®óng yªu cÇu.");
		return
	end
	if IsDoPhoHKMP ~= nDoPhoHKMP then
		Talk(1, "", "B¹n ch­a bá hoÆc bá <color=green>§å Phæ HKMP<color> kh«ng ®óng yªu cÇu.");
		return
	end
	if (GetCash() < nNganLuong) then
		Say("B¹n kh«ng mang ®ñ tiÒn",0);
		return 
	end
	Pay(nNganLuong)
	nRate = random(1,100)
	if nRate > nTyLeThatBai then
		for i=1,getn(_tbcp.tbLamThuyTinh) do		
			if (RemoveItemByIndex(_tbcp.tbLamThuyTinh[i][1]) ~= 1) then	return	end
		end
		for i=1,getn(_tbcp.tbTuThuyTinh) do		
			if (RemoveItemByIndex(_tbcp.tbTuThuyTinh[i][1]) ~= 1) then	return	end
		end
		for i=1,getn(_tbcp.tbLucThuyTinh) do		
			if (RemoveItemByIndex(_tbcp.tbLucThuyTinh[i][1]) ~= 1) then	return	end
		end
		for i=1,getn(_tbcp.tbDoPhoHKMP) do		
			if (RemoveItemByIndex(_tbcp.tbDoPhoHKMP[i][1]) ~= 1) then	return	end
		end

		tbAwardTemplet:GiveAwardByList({{szName=""..tb_TrangBiHKMP[nID_TBHK][1].."",tbProp={0,nID_TBHK},nCount=1,nQuality =1},}, "CheTaoHKMPThanhCong", 1);
		Msg2Player("<color=yellow>Chóc mõng b¹n ®· chÕ t¹o thµnh c«ng Trang bÞ HKMP<color>")
	else
		Msg2Player("<color=green>ChÕ t¹o thÊt b¹i xin vui lßng thö l¹i sau<color>")
	end
end 

