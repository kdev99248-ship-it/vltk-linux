--ID Item 
--Include("\\script\\task\\system\\task_string.lua");
Include("\\script\\dailogsys\\dailogsay.lua") --§Ó dïng CreateNewSayEx
Include("\\script\\task\\newtask\\newtask_head.lua"); --CÇn ®Ó nt_getTask
function main_nvhk()
--dofile("script/global/nobitaxd/item/hoangkimbachkhoa.lua")
	local szTitle = "Xin chµo <color=yellow>"..GetName().."<color> , Tõ cÊp 20 trë lªn, gia nhËp m«n ph¸i. Ng­¬i cã thÓ tíi Long Ngò ë c¸c T©n Thñ Th«n ®Ó nhËn nhiÖm vô Hoµng Kim...!!!"
	local tbOpt = {}
	if GetLevel() < 20 then
		tinsert(tbOpt, {"TiÕp tôc tu luyÖn tíi cÊp 20 råi nhËn nhiÖm vô"});
		CreateNewSayEx(szTitle, tbOpt)
		return 1
	end
	if GetLastFactionNumber() == -1 then
		tinsert(tbOpt, {"H·y gia nhËp m«n ph¸i råi míi cã thÓ nhËn nhiÖm vô"});
		CreateNewSayEx(szTitle, tbOpt)
		return 1
	end
	tinsert(tbOpt, {"ChÝnh TuyÕn.", GQ,{1}});
	tinsert(tbOpt, {"Phô TuyÕn.", GQ,{2}});
	--tinsert(tbOpt, {"Test.", GQ_Test});
	tinsert(tbOpt, {"Rs Chuçi NVHK. Lµm l¹i tõ ®Çu.", GQ_RS});
	if ((nt_getTask(1060) == 40 or nt_getTask(1060) == 80) and nt_getTask(1013) == 10) or (nt_getTask(1011) == 10 and (nt_getTask(1052) == 20 or nt_getTask(1052) == 60))  or (nt_getTask(1012) == 10 and (nt_getTask(1056) == 20 or nt_getTask(1056) == 40)) then
		tinsert(tbOpt, {"Hoµn thµnh nhiÖm vô chiÕn th¾ng l«i ®µi Phô TuyÕn.", GQ_LoiDai});
	end
	if (nt_getTask(1061) == 20 and nt_getTask(1013) == 10) or (nt_getTask(1053) == 20 and nt_getTask(1011) == 10) or (nt_getTask(1057) == 20 and nt_getTask(1012) == 10) then
		tinsert(tbOpt, {"Hoµn thµnh nhiÖm vô Tèng Kim phô tuyÕn.", GQ_TongKim});
	end
	if (nt_getTask(1061) == 50) or (nt_getTask(1053) == 30) or (nt_getTask(1053) == 27) or (nt_getTask(1057) == 40 or nt_getTask(1057) == 50) then
		tinsert(tbOpt, {"Hoµn thµnh nhiÖm vô Hái §¸p Tèng Kim phô tuyÕn.", GQ_HoiDapTongKim});
	end
	tinsert(tbOpt, {"Tho¸t"});
	CreateNewSayEx(szTitle, tbOpt)
return 1
end
function GQ(ID)
	local MissType = ID --Lo¹i nv chÝnh hay phô tuyªn. ChÝnh lµ 1 phô lµ 2
	local szTitle = "Xin chµo <color=yellow>"..GetName().."<color> , Chän phe ph¸i nhiÖm vô mµ ng­¬i cÇn hç trî...!!!"
	local tbOpt = {}
	tinsert(tbOpt, {"ChÝnh ph¸i - BÝ MËt TÇm Long Héi.", GQ_Step1,{MissType,1}});
	tinsert(tbOpt, {"Trung LËp - C©u ChuyÖn L©m Uyªn Nhai.", GQ_Step1,{MissType,2}});
	tinsert(tbOpt, {"Tµ Ph¸i - Long KhÝ Chi Ho¹.", GQ_Step1,{MissType,3}});
	tinsert(tbOpt, {"Quay l¹i",main});
	tinsert(tbOpt, {"Tho¸t"});
	CreateNewSayEx(szTitle, tbOpt)
end

function GQ_Step1(ID1,ID2)
	local MissType = ID1 --Lo¹i NV chÝnh hay phô
	local PheType = ID2 --NhiÖm vô chÝnh - trung - tµ
	Uworld1001 = nt_getTask(1001) --ChÝnh
	Uworld183 = nt_getTask(183) --ChÝnh
	Uworld1002 = nt_getTask(1002) --Trung
	Uworld186 = nt_getTask(186) --Trung
	Uworld1003 = nt_getTask(1003) --Tµ
	Uworld189 = nt_getTask(189) --Tµ
	if Uworld1001 < 10 or Uworld1002 < 10 or Uworld1003 < 10 then
		Talk(1,"","§Õn Long Ngò nhËn th­ giíi thiÖu. Më th­ ra ®äc råi míi biÕt cÇn hç trî c¸i g× chø.")
		return
	end
	local Title = " "
	local tbOpt = {}
	for i=1,getn(tb_HelpGoldQuest[MissType][PheType]) do
		local TaskCheck = tb_HelpGoldQuest[MissType][PheType][i].nTaskCheck
		--local Task = tb_HelpGoldQuest[MissType][PheType][i].nTask
		local LevelMin = tb_HelpGoldQuest[MissType][PheType][i].nLevelMin
		local LevelMax = tb_HelpGoldQuest[MissType][PheType][i].nLevelMax
		if GetLevel() >= LevelMin and GetLevel() < LevelMax then
			local KiemTraDieuKienTask = 0
			for k=1,getn(TaskCheck) do
				local TaskID = TaskCheck[k][1]
				--Cã nhiÖm vô chØ cÇn check 1 task, cã nv cÇn check nhiÒu task
				--NhiÖm vô nµo cÇn check nhiÒu task th× yªu cÇu c¸c task ®c check ®Òu ph¶i true
				for v=1,getn(TaskCheck[k][2]) do
				--1 Task l¹i cã thÓ check mét hoÆc nhiÒu gi¸ trÞ cïng lóc
				--Task nµo cÇn check cã nhiÒu gi¸ trÞ th× chØ cÇn 1 trong sè chóng true
				--ThÕ nªn trong lóc lÆp for ®Ó check nÕu cã 1 c¸i true th× break lu«n
					local TaskValue = TaskCheck[k][2][v]
					if nt_getTask(TaskID) == TaskValue then
						KiemTraDieuKienTask = KiemTraDieuKienTask + 1
						break
					end
				end
			end
			if KiemTraDieuKienTask == getn(TaskCheck) then
			--Sau khi kiÓm tra c¸c task ®· true hÕt th× check ®Õn Item. Bëi cã 1 sè nhiÖm vô yªu cÇu check item
				if getn(tb_HelpGoldQuest[MissType][PheType][i].nItemCheck) ~= 0 then
				--NÕu nhiÖm vô ko yªu cÇu check item th× gi¸ trÞ nItemCheck sÏ ®Ó trèng. Tøc lµ sè phÇn tö lµ 0
				--NÕu kiÓm tra sè phÇn tö kh¸c 0 th× lµ nhiÖm vô cÇn check item
					local ItemCheck = tb_HelpGoldQuest[MissType][PheType][i].nItemCheck
					--Gi¶i thÝch th«ng sè nItemCheck
					--VÝ dô nItemCheck = {{0,{504,5}}}
					--		0 : Check False tøc lµ sè l­îng item ID 504 < 5
					--		1 : Check True lµ check item ID 504 >= 5
					local KiemTraSoLuongItem = 0
					for m=1,getn(ItemCheck) do
						if ItemCheck[m][1] == 0 then --Check sè l­îng false
							--Msg2Player(GetItemCount(ItemCheck[m][2]))
							if GetItemCount(ItemCheck[m][2]) < ItemCheck[m][3] then
								KiemTraSoLuongItem = KiemTraSoLuongItem + 1
							end
						elseif ItemCheck[m][1] == 1 then --Sè l­îng item >=
							--Msg2Player(GetItemCount(ItemCheck[m][2]))
							if GetItemCount(ItemCheck[m][2]) >= ItemCheck[m][3] then
								KiemTraSoLuongItem = KiemTraSoLuongItem + 1
								--Msg2Player(GetItemCount(ItemCheck[m][2]))
							end
						end
					end
					--Msg2Player(KiemTraSoLuongItem)
					if KiemTraSoLuongItem == getn(ItemCheck) then
						Title = tb_HelpGoldQuest[MissType][PheType][i].nName..": "..tb_HelpGoldQuest[MissType][PheType][i].nTitle
						Select = tb_HelpGoldQuest[MissType][PheType][i].nTitle
						FightState = tb_HelpGoldQuest[MissType][PheType][i].nFightState
						Map = tb_HelpGoldQuest[MissType][PheType][i].nW
						ToaDoX = tb_HelpGoldQuest[MissType][PheType][i].nX
						ToaDoY = tb_HelpGoldQuest[MissType][PheType][i].nY
						tinsert(tbOpt, {Select, GQ_Step2,{Title,FightState,Map,ToaDoX,ToaDoY}});
						break
					end
				else
					Title = tb_HelpGoldQuest[MissType][PheType][i].nName..": "..tb_HelpGoldQuest[MissType][PheType][i].nTitle
					Select = tb_HelpGoldQuest[MissType][PheType][i].nTitle
					FightState = tb_HelpGoldQuest[MissType][PheType][i].nFightState
					Map = tb_HelpGoldQuest[MissType][PheType][i].nW
					ToaDoX = tb_HelpGoldQuest[MissType][PheType][i].nX
					ToaDoY = tb_HelpGoldQuest[MissType][PheType][i].nY
					tinsert(tbOpt, {Select, GQ_Step2,{Title,FightState,Map,ToaDoX,ToaDoY}});
					break
				end
			else
				Title = "Kh«ng thÊy th«ng tin b­íc tiÕp theo!!!"
			end
			--Sau khi lÆp 2 for ®Ó check nÕu KiemTraDieuKienTask = Sè l­îng task cÇn check th× OK
		end
	end
	tinsert(tbOpt, {"Quay l¹i",GQ,{MissType}});
	tinsert(tbOpt, {"Tho¸t"});
	CreateNewSayEx(Title, tbOpt)
end
function GQ_Step2(MsgSystem,FightState,Map,ToaDoX,ToaDoY)
	Msg2Player("<color=green>"..MsgSystem.."<color>")
	NewWorld(Map,ToaDoX,ToaDoY)
	SetFightState(FightState)
end
tb_HelpGoldQuest = {
--Khi nh©n vËt lªn ®ñ level yªu cÇu th× 1 sè task tù ®éng ®­îc thay ®æi
--VÝ dô khi kÕt thóc nhiÖm vô 2x task 1001 lµ 70. Nh­ng khi nh©n vËt lªn cÊp 30 c¸i lµ task nµy tù nhÈy sang 80
	[1] = { --Chinh Tuyen MissType
		[1] = { --Chinh Phai PheType task\newtask\master\zhengpai\zhengpaitasknpc.lua
			{nTitle = "Long Ngò b¶o ng­¬i tíi §¹i Lý t×m gÆp Lý M¹c SÇu",nName = "ChÝnh Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1001,{10,20}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			{nTitle = "Lý M¹c SÇu b¶o ng­¬i ra bÕn ®ß ngoµi thµnh gÆp mÆt", nName = "ChÝnh Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1001,{30}}}, nItemCheck = {}, nFightState = 1, nW = 162, nX = 1636, nY = 2984},
			{nTitle = "Sau khi bÞ ®¸nh b¹i. M¹c SÇu b¶o b¹n vÒ thµnh nãi chuyÖn", nName = "ChÝnh Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1001,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			--Sau khi vÒ thµnh nãi chuyÖn task ®c set thµnh 60
			--Sau khi lªn level 30 task ®c set thµnh 80
			--NÕu lªn lv30 tr­íc khi lµm xong nv 20 th× task chØ ®c set thµnh 70. ph¶i tiÕp tôc nãi chuyÖn vs m¹c sÇu th× task míi thµnh 80
			{nTitle = "VÒ §¹i Lý gÆp Lý M¹c SÇu", nName = "ChÝnh Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1001,{70}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			{nTitle = "M¹c SÇu b¶o b¹n ®i Thµnh §« TÝn T­íng Tù t×m C«ng Tö TiÕu ®iÒu tra tung tÝch cña Hoµng Kim L©n.", nName = "ChÝnh Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1001,{80,90}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3223, nY = 5118},
			{nTitle = "C«ng Tö TiÕu b¶o b¹n ®i tÇng 1 D­îc V­¬ng ®éng t×m thuéc h¹ Giíi L­u Phong.", nName = "ChÝnh Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1001,{100}}}, nItemCheck = {}, nFightState = 1, nW = 141, nX = 1544, nY = 3323},
			{nTitle = "§· cã Hoµng Kim L©n. B¹n cã thÓ vÒ §¹i Lý gÆp M¹c SÇu", nName = "ChÝnh Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1001,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			--Sau khi nãi chuyÖn víi m¹c sÇu nhËn mò hoµng kim xong th× task ®c set thµnh 130
			--Lªn 40 task ®c set thµnh 150
			--NÕu lªn 40 trc khi lµm xong Q30 th× task 140. ph¶i vÒ gÆp m¹c sÇu nãi chuyÖn míi lªn 150
			{nTitle = "VÒ §¹i Lý gÆp Lý M¹c SÇu", nName = "ChÝnh Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1001,{140}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			{nTitle = "M¹c SÇu b¶o b¹n ®Õn D­¬ng Ch©u t×m H¹ V« Th­", nName = "ChÝnh Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1001,{150,160}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1705, nY = 3119},
			{nTitle = "H¹ V« Th­ b¶o b¹n ®Õn tÇng 3 §iÓm Th­¬ng §éng t×m Tö §ao HiÖp. BiÕt ®©u sÏ cã chót manh mèi", nName = "ChÝnh Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1001,{170}}}, nItemCheck = {}, nFightState = 1, nW = 173, nX = 1557, nY = 3049},
			{nTitle = "Mang Cöu HiÖn Chi ChØ vÒ §¹i Lý t×m M¹c SÇu", nName = "ChÝnh Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1001,{180,190}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			--Sau khi nãi chuyÖn víi m¹c sÇu vµ nhËn phÇn th­ëng xong th× task set vÒ 200
			--NÕu lªn lv tr­íc khi xong Q th× task lªn 210
			{nTitle = "VÒ §¹i Lý t×m gÆp M¹c SÇu. M¹c X¶o Nhi nãi M¹c SÇu ®· bÞ b¾t ®i råi.", nName = "ChÝnh Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1001,{210}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			{nTitle = "§Õn L©m An t×m gÆp M¹nh Phµm hái tin tøc.", nName = "ChÝnh Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1001,{220,230}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1626, nY = 2990},
			{nTitle = "LÊy thñ cÊp cña O¸n §éc t¹i H­íng Thuû §éng.", nName = "ChÝnh Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1001,{240}}}, nItemCheck = {}, nFightState = 1, nW = 24, nX = 2095, nY = 3314},
			{nTitle = "Quay trë vÒ Lam An gÆp M¹nh Phµm", nName = "ChÝnh Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1001,{250,260}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1626, nY = 2990},
			{nTitle = "Cã chót th«ng tin míi xuÊt hiÖn. Quay trë vÒ Lam An gÆp M¹nh Phµm", nName = "ChÝnh Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1001,{280}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1626, nY = 2990},
			{nTitle = "§Õn MËt §¹o T­¬ng D­¬ng tiªu diÖt ThÇn BÝ Nam Nh©n", nName = "ChÝnh Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1001,{290}}}, nItemCheck = {}, nFightState = 1, nW = 79, nX = 1681, nY = 3142},
			{nTitle = "Ng­êi thÇn bÝ sau khi bÞ ®¸nh b¹i. B¶o b¸n ®Õn chç M¹c SÇu gÆp h¾n. H¾n cã chuyÖn cÇn nãi", nName = "ChÝnh Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1001,{300,310}}}, nItemCheck = {}, nFightState = 0, nW = 162, nX = 1470, nY = 3170},
			{nTitle = "Quay vÒ gÆp Long Ngò nhËn phÇn th­ëng", nName = "ChÝnh Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1001,{320}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
			{nTitle = "§· hoµn thµnh chuçi nhiÖm vô hoµng kim ChÝnh Ph¸i. H·y tiÕp tôc rÌn luyÖn!!!",nName = "ChÝnh Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1001,{1000}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
			--Sau b­íc nµy task ®c set thµnh 1000. KÕt thóc chÝnh tuyÕn chÝnh ph¸i
		},
		[2] = { --Trung Lap PheType task\newtask\master\zhongli\zhonglitasknpc.lua
			{nTitle = "Long Ngò b¶o ng­¬i tíi BiÖn Kinh gÆp Phã Nam B¨ng", nName = "Trung LËp CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1002,{10,20}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "Phã Nam B¨ng b¶o b¹n lªn La Tiªu S¬n ®¸nh b¹i Ninh T­íng Qu©n", nName = "Trung LËp CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1002,{30}}}, nItemCheck = {}, nFightState = 1, nW = 179, nX = 2033, nY = 2755},
			{nTitle = "Sau khi ®¸nh b¹i Ninh T­íng Qu©n, quay vÒ BiÖn Kinh t×m gÆp Phã Nam B¨ng", nName = "Trung LËp CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1002,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			--Lªn cÊp 30 task tù set lªn 80
			{nTitle = "Quay vÒ gÆp Phã Nam B¨ng nhËn nhiÖm vô",nName = "Trung LËp CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1002,{70}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "Phã Nam B¨ng b¶o b¹n ®i Kho¸i Ho¹t L©m thö søc víi L­ Thiªn T­îng",nName = "Trung LËp CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1002,{80}}}, nItemCheck = {}, nFightState = 1, nW = 136, nX = 1602, nY = 3197},
			{nTitle = "Quay vÒ BiÖn Kinh t×m gÆp Phã Nam B¨ng",nName = "Trung LËp CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1002,{90,100}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "T×m gÆp Phã Nam B¨ng",nName = "Trung LËp CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1002,{120}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "§Õn Thuý Yªn M«n, t×m gÆp LÖ Thu Thuû",nName = "Trung LËp CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1002,{130,140}}}, nItemCheck = {}, nFightState = 0, nW = 154, nX = 343, nY = 1346},
			{nTitle = "LÖ Thu Thuû b¶o b¹n ®Õn Kinh Hoµng §éng giÕt Tõ Tù Lùc.",nName = "Trung LËp CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1002,{150}}}, nItemCheck = {}, nFightState = 1, nW = 5, nX = 1476, nY = 3433},
			{nTitle = "Quay l¹i gÆp LÖ Thu Thuû.",nName = "Trung LËp CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1002,{160}}}, nItemCheck = {}, nFightState = 0, nW = 154, nX = 343, nY = 1346},
			{nTitle = "VÒ t×m LÖ Thu Thuû hái tin tøc.",nName = "Trung LËp CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1002,{170}}}, nItemCheck = {}, nFightState = 0, nW = 154, nX = 343, nY = 1346},
			{nTitle = "§· ®Õn lóc trë vÒ t×m Phã Nam B¨ng.",nName = "Trung LËp CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1002,{180,190}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "§Õn Thiªn V­¬ng t×m Hµn Giang §éc §iÕu TÈu.",nName = "Trung LËp CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1002,{200,210}}}, nItemCheck = {}, nFightState = 0, nW = 59, nX = 1642, nY = 3188},
			{nTitle = "§¸nh b¹i §éc §iÓu TÈu.",nName = "Trung LËp CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1002,{215}}}, nItemCheck = {}, nFightState = 1, nW = 66, nX = 1596, nY = 3307},
			{nTitle = "Quay l¹i b¸o tin cho Phã Nam B¨ng.",nName = "Trung LËp CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1002,{220,230}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "Trë vÒ t×m Phã Nam B¨ng Hái chuyÖn.",nName = "Trung LËp CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1002,{250}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "Lªn ThiÕu L©m Tù, t×m Kh«ng TÞch.",nName = "Trung LËp CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1002,{260,270}}}, nItemCheck = {}, nFightState = 0, nW = 103, nX = 1776, nY = 2843},
			{nTitle = "§¸nh b¹i Kh«ng Tich.",nName = "Trung LËp CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1002,{280}}}, nItemCheck = {}, nFightState = 1, nW = 103, nX = 1744, nY = 2662},
			{nTitle = "Quay vÒ b¸o tin cho Phã Nam B¨ng.",nName = "Trung LËp CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1002,{290,300}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1699, nY = 3161},
			{nTitle = "Cã thÓ ®Õn t×m Long Ngò nhËn phÇn th­ëng.",nName = "Trung LËp CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1002,{310}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
			{nTitle = "§· hoµn thµnh chuçi nhiÖm vô hoµng kim Trung LËp. H·y tiÕp tôc rÌn luyÖn!!!",nName = "Trung LËp CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1002,{1000}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
		},
		[3] = { --Ta Phai PheType task\newtask\master\xiepai\maintask.lua
			{nTitle = "Long Ngò b¶o ng­¬i tíi Chu Tiªn TrÊn gÆp V©n Nhi", nName = "Tµ Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1003,{10}}}, nItemCheck = {}, nFightState = 0, nW = 100, nX = 1729, nY = 3173},
			{nTitle = "§Õn gÆp Th¸i C«ng C«ng ë L©m An lÊy Thiªn H­¬ng Ngäc Chi Cao", nName = "Tµ Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1003,{20}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1625, nY = 3203},
			{nTitle = "§Õn Phôc Ng­u s¬n ®¸nh b¹i TiÓu Kú Nhi. LÊy t­îng phËt vÒ cho Th¸i C«ng C«ng", nName = "Tµ Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1003,{30}}}, nItemCheck = {}, nFightState = 1, nW = 90, nX = 1798, nY = 3284},
			{nTitle = "Mang t­îng phËt vÒ cho Th¸i C«ng C«ng", nName = "Tµ Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1003,{40}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1625, nY = 3203},
			{nTitle = "Mang Thiªn H­¬ng Ngäc Chi Cao cho V©n Nhi", nName = "Tµ Ph¸i CÊp 20",nLevelMin = 20, nLevelMax=200, nTaskCheck = {{1003,{50}}}, nItemCheck = {}, nFightState = 0, nW = 100, nX = 1729, nY = 3173},
			--Sau khi nhËn th­ëng xong tõ V©n Nhi task bÞ set thµnh 100
			--Lªn cÊp 30 task nµy vÉn lµ 100
			{nTitle = "§Õn D­¬ng Ch©u t×m gÆp Tiªu S­", nName = "Tµ Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1003,{100}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1597, nY = 3117},
			{nTitle = "Cuèi cïng còng biÕt ai ®ang gi÷ TrÊn Minh Chi Liªn. B¹n lËp tøc ®i Thµnh §«, ®Õn Thanh Thµnh S¬n t×m H¹ HÇu Phôc", nName = "Tµ Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1003,{110}}}, nItemCheck = {}, nFightState = 1, nW = 21, nX = 2720, nY = 3956},
			{nTitle = "B¹n mang trong lßng mèi nghi vÊn. Quay l¹i t×m V©n Nhi hái chuyÖn", nName = "Tµ Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1003,{120}}}, nItemCheck = {}, nFightState = 0, nW = 100, nX = 1729, nY = 3173},
			{nTitle = "ThÕ giíi nµy thËt sù cã ng­êi c¸i g× còng biÕt ­? Dï kh«ng tin nh­ng b¹n còng ®Õn Long TuyÒn Th«n t×m Phã L«i Th­", nName = "Tµ Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1003,{140}}}, nItemCheck = {}, nFightState = 0, nW = 174, nX = 1595, nY = 3255},
			{nTitle = "Kh«ng mÊt ®ång nµo vÉn moi ®­îc tin tøc tõ Phã L«i Th­. B¹n lËp tøc ®Õn Ngò §éc Gi¸o t×m MÆc Thï H­¬ng Chñ hái th¨m tin tøc.", nName = "Tµ Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1003,{150}}}, nItemCheck = {}, nFightState = 0, nW = 186, nX = 1600, nY = 3196},
			{nTitle = "H­¬ng chñ ®· qu¸ giµ yÕu kh«ng muèn nãi chuyÖn víi b¹n. B¹n quay vÒ gÆp Phã L«i Th­ hái tung tÝch con g¸i cña Tang Chu.", nName = "Tµ Ph¸i CÊp 30",nLevelMin = 30, nLevelMax=200, nTaskCheck = {{1003,{160}}}, nItemCheck = {}, nFightState = 0, nW = 174, nX = 1595, nY = 3255},
			{nTitle = "§Õn Vâ §ang t×m §µo Th¹ch M«n dß la tin tøc.", nName = "Tµ Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1003,{170}}}, nItemCheck = {}, nFightState = 0, nW = 86, nX = 1606, nY = 3190},
			{nTitle = "ChØ v× TrÊn Minh Chi Liªn mµ thiªn h¹ ®¹i lo¹n. B¹n quyÕt ®Þnh ®Õn Thôc C­¬ng S¬n diÖt Tiªu V« Th­êng", nName = "Tµ Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1003,{210}}}, nItemCheck = {}, nFightState = 1, nW = 92, nX = 1948, nY = 3233},
			{nTitle = "Quay trë l¹i gÆp §µo Th¹ch M«n", nName = "Tµ Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1003,{220}}}, nItemCheck = {}, nFightState = 0, nW = 86, nX = 1606, nY = 3190},
			{nTitle = "VÒ Long TuyÒn Th«n t×m Phã L«i Th­", nName = "Tµ Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1003,{230}}}, nItemCheck = {}, nFightState = 0, nW = 174, nX = 1595, nY = 3255},
			{nTitle = "§Õn BiÖn Kinh t×m Nh­ Ngäc", nName = "Tµ Ph¸i CÊp 40",nLevelMin = 40, nLevelMax=200, nTaskCheck = {{1003,{300}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1681, nY = 3139},
			{nTitle = "Nh­ Ngäc giíi thiÖu b¹n víi TrÇn Tam B¶o. Ng­êi nµy n¾m ®­îc nhiÒu bÝ mËt cña Kim triÒu", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{310}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1756, nY = 2995},
			{nTitle = "Quay vÒ gÆp TrÇn Tam B¶o.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{328,329}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1756, nY = 2995},
			{nTitle = "§Õn Nh¹n §·ng S¬n tiªu diÖt Lôc Phi.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{330}}}, nItemCheck = {}, nFightState = 1, nW = 195, nX = 599, nY = 3068},
			{nTitle = "Quay vÒ gÆp TrÇn Tam B¶o.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{340}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1756, nY = 2995},
			{nTitle = "§¸nh t­íng Kim §å Lan ë TÇng 3 ThiÕt Th¸p.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{350}}}, nItemCheck = {}, nFightState = 1, nW = 40, nX = 1699, nY = 3044},
			{nTitle = "GÆp §oµn Méc DuÖ.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{360}}}, nItemCheck = {}, nFightState = 0, nW = 49, nX = 1801, nY = 3183},
			{nTitle = "GÆp §oµn Méc Thanh.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{400}}}, nItemCheck = {}, nFightState = 0, nW = 121, nX = 2013, nY = 4490},
			{nTitle = "Quay vÒ gÆp §oµn Méc Thanh.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{409}}}, nItemCheck = {}, nFightState = 0, nW = 121, nX = 2013, nY = 4490},
			{nTitle = "Tiªu diÖt anh hïng kh¸ng Kim, Liªu §Þnh.", nName = "Tµ Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{410}}}, nItemCheck = {}, nFightState = 1, nW = 94, nX = 1565, nY = 3141},
			{nTitle = "Quay vÒ gÆp §oµn Méc Thanh.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{420}}}, nItemCheck = {}, nFightState = 0, nW = 121, nX = 2013, nY = 4490},
			{nTitle = "Cã thÓ ®Õn t×m Long Ngò nhËn phÇn th­ëng.",nName = "Tµ Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{430}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
			{nTitle = "§· hoµn thµnh chuçi nhiÖm vô hoµng kim Tµ Ph¸i. H·y tiÕp tôc rÌn luyÖn!!!",nName = "Tµ Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{1000}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
		},
	},
	[2] = { --Phô tuyÕn MissType
		[1] = { --ChÝnh ph¸i PheType
			----------------------------------------------------------CÊp 20-29
			{nTitle = "§Õn Ph­îng T­êng gÆp Ng¹o V©n T«ng",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Ng¹o V©n T«ng b¶o b¹n ®Õn Thiªn Long tù ë §¹i Lý t×m Si T¨ng hái th¨m tin tøc.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{20,30}}}, nItemCheck = {}, nFightState = 0, nW = 332, nX = 167*8, nY = 176*16},
			{nTitle = "Si T¨ng nãi b¹n ra ngoµi ®¸nh Tµng B¶o Kh¸ch lÊy 5 cuèn Cê Phæ mang vÒ cho «ng ta",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{40}}}, nItemCheck = {{0,504,5}}, nFightState = 1, nW = 332, nX = 1252, nY = 3011},
			{nTitle = "§· lÊy ®ñ 5 cuèn Cê Phæ. Quay l¹i gÆp Si T¨ng",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{40}}}, nItemCheck = {{1,504,5}}, nFightState = 0, nW = 332, nX = 1345, nY = 2828},
			{nTitle = "Th× ra ng­êi nµy lµ Si T¨ng gi¶ d¹ng! B¹n h·y trë vÒ t×m Ng¹o V©n T«ng.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Lµ TiÔn §Çu b¹n cña ta. Ng­¬i ®i Hoa S¬n ph¸i t×m «ng ta ®i, «ng ta Èn c­ ë ®ã ®· 10 n¨m råi, n¨m x­a y tõng nh¾c ®Õn Thiªn Hoµng Long KhÝ",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{80,90}}}, nItemCheck = {}, nFightState = 0, nW = 333, nX = 1246, nY = 3267},
			{nTitle = "TiÔn §Çu b¶o b¹n ®Õn Ph­îng T­êng t×m SÇm Hïng hái th¨m tin tøc.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{100,110}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 192*8, nY = 201*16},
			{nTitle = "§¸nh b¹i Phan Nh­ Long ®ang ë ngoµi thµnh Ph­îng T­êng.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{120}}}, nItemCheck = {}, nFightState = 1, nW = 1, nX = 220*8, nY = 190*16},
			{nTitle = "Phan Nh­ Long lóc s¾p chÕt nãi, h¾n ta kh«ng ph¶i lµ ng­êi hµnh thÝch Nh¹c Phi! Hoµn thµnh nhiÖm vô.B¹n cã thÓ vÒ gÆp Ng¹o V©n T«ng.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{130}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Hoµn thµnh nhiÖm vô. Cã thÓ gÆp Ng¹o V©n T«ng nhËn th­ëng <<M¶nh B¶nh §å>> vµ <<D©y ChuyÒn Kim Phong>>",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1050,{1000}},{196,{0}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			----------------------------------------------------------CÊp 30-39
			{nTitle = "§Õn Ph­îng T­êng gÆp Ng¹o V©n T«ng",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "§i t×m gÆp H¹ Lan Chi",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{20,30}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3085, nY = 5191},
			{nTitle = "H¹ Lan Chi cho biÕt B¶o Th¹ch ®· bÞ bá ë quª nhµ. B¹n cã thÓ ®i t×m Ng« L·o Th¸i ®Ó nhËn mét gi¸p thÇn kú",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 20, nX = 3465, nY = 6195},
			{nTitle = "Ng« l·o Th¸i bÞ bÖnh l¹. Ng­¬i quyÕt ®Þnh ®i t×m Ng¹o V©n T«ng th­¬ng l­îng b­íc tiÕp theo",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Ng¹o V©n T«ng cho b¹n biÕt mét bÝ mËt, «ng nghi ngê Ng« L·o Th¸i bÞ kÎ thï h¹ ®éc. ¤ng ta b¶o b¹n lªn Phôc Ng­u S¬n ®¸nh 50 con Sãi xanh lÊy x­¬ng vÒ bµo chÕ thuèc.",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{80}},{1011,{10}}}, nItemCheck = {}, nFightState = 1, nW = 90, nX = 1639, nY = 3511},
			{nTitle = "§· lÊy ®­îc x­¬ng Sãi xanh, cã thÓ quay vÒ gÆp Ng¹o V©n T«ng.",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{80,90}},{1011,{20}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Tiªu diÖt sãi råi? Tèt! H·y ®em x­¬ng sãi ®Õn T­¬ng D­¬ng t×m Cung A Ng­u, h¾n lµ thî s¨n næi tiÕng ë Phôc Ng­u S¬n, lÊy x­¬ng sãi bµo chÕ d­îc töu sÏ trÞ ®­îc bÖnh cña Ng« L·o th¸i.",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{100,110}}}, nItemCheck = {}, nFightState = 0, nW = 78, nX = 1551, nY = 3191},
			{nTitle = "ViÖc nµy ®¬n gi¶n, Ta cã thÓ gióp huynh tiªu diÖt ¸c lang.<enter>Cung A Ng­u: ThËt tèt qu¸!Míi xem qua phong th¸i cña ng­¬i, ta biÕt ng­¬i kh«ng ph¶i lµ ng­êi th­êng. Chê ng­¬i tiªu diÖt ¸c lang ta sÏ bµo chÕ thuèc.",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{120}}}, nItemCheck = {}, nFightState = 1, nW = 90, nX = 1789, nY = 3140},
			{nTitle = "§· giÕt ®c ¸c Lang. Cã thÓ quay vÒ gÆp Cung A Ng­u",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{130,140}}}, nItemCheck = {}, nFightState = 0, nW = 78, nX = 1551, nY = 3191},
			{nTitle = "Cung A Ng­u ®­a cho b¹n d­îc töu bµo chÕ tõ x­¬ng sãi, b¹n mang ®Õn chç Ng« L·o th¸i",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{150,160}}}, nItemCheck = {}, nFightState = 0, nW = 20, nX = 3465, nY = 6195},
			{nTitle = "B¹n nhËn ®­îc mét viªn b¶o th¹ch thuéc tÝnh Èn. B¹n cã thÓ quay vÒ gÆp Ng¹o V©n T«ng.",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{170,180}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Hoµn thµnh nhiÖm vô. Cã thÓ gÆp Ng¹o V©n T«ng nhËn th­ëng <<M¶nh B¶nh §å>> vµ <<Kim Phong C«ng CÈm Th¸n>>",nName = "ChÝnh Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1051,{1000}},{196,{0,1}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			----------------------------------------------------------CÊp 40-49
			{nTitle = "§Õn Ph­îng T­êng gÆp Ng¹o V©n T«ng",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "GÆp C«ng B×nh Tö ®¸nh l«i ®µi lÇn 1",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{20}},{1011,{10}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3165, nY = 5194},
			{nTitle = "§· cã thÓ quay l¹i gÆp Ng¹o V©n T«ng",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{20,30}},{1011,{20}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "§Õn D­¬ng Ch©u t×m gÆp Hçn Hçn",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1846, nY = 3046},
			{nTitle = "GÆp C«ng B×nh Tö ®¸nh l«i ®µi lÇn 2",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{60}},{1011,{10}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3165, nY = 5194},
			{nTitle = "Hoµn thµnh nhiÖm vô l«i ®µi. Cã thÓ quay vÒ gÆp Hçn Hçn",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{60,70}},{1011,{20}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1846, nY = 3046},
			{nTitle = "Quay vÒ gÆp Ng¹o V©n T«ng",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{80,90}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "§¸nh b¹i Du S­¬ng T©n",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{100}}}, nItemCheck = {}, nFightState = 1, nW = 11, nX = 3371, nY = 4889},
			{nTitle = "Quay vÒ b¸o tin cho Ng¹o V©n T«ng",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Hoµn thµnh nhiÖm vô. Cã thÓ gÆp Ng¹o V©n T«ng nhËn th­ëng <<M¶nh B¶nh §å>> vµ <<Kim Phong Lan §×nh Ngäc>>",nName = "ChÝnh Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1052,{1000}},{196,{0,1,2,3,4,5}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			----------------------------------------------------------CÊp 50-59
			{nTitle = "§i t×m Hçn Hçn",nName = "ChÝnh Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1053,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1846, nY = 3046},
			{nTitle = "§· hoµn thµnh nhiÖm vô tÝch luü tèng kim. Cã thÓ quay vÒ gÆp Hçn Hçn",nName = "ChÝnh Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1053,{20,25}},{1011,{20}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1846, nY = 3046},
			{nTitle = "T×m gÆp Hçn Hçn tr¶ lêi c¸c c©u hái cña «ng ta vÒ Tèng Kim",nName = "ChÝnh Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1053,{27,30}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1846, nY = 3046},
			{nTitle = "§· hoµn thµnh hái ®¸p víi Hçn Hçn. Cã thÓ tiÕp tôc nãi chuyÖn víi «ng ta hái tin tøc",nName = "ChÝnh Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1053,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1846, nY = 3046},
			{nTitle = "Hçn Hçn cuèi cïng ®· tiÕt lé, cÇm ®Çu thÝch s¸t Nh¹c Nguyªn So¸i n¨m x­a chÝnh lµ TÒ Tøc Phong. H¾n ®ang ë bªn ngoµi thµnh L©m An",nName = "ChÝnh Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1053,{60}}}, nItemCheck = {}, nFightState = 1, nW = 176, nX = 1680, nY = 2575},
			{nTitle = "Quay vÒ hái chuyÖn Ng¹o V©n T«ng.",nName = "ChÝnh Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1053,{70,80}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Hoµn thµnh nhiÖm vô. Cã thÓ gÆp Ng¹o V©n T«ng nhËn th­ëng <<M¶nh B¶nh §å>> vµ <<Kim Phong §ång T­íc Xu©n Th©m>>.",nName = "ChÝnh Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1053,{1000}},{196,{1,2,3,4,5,6}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
		},
		[2] = { --Trung lËp PheType
			----------------------------------------------------------CÊp 20-29
			{nTitle = "§Õn L©m An t×m gÆp LiÔu Nam V©n",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "TÇn L¨ng, n¬i ®ã ®ang bÞ n¹n giÆc NhÝm ph¸ ph¸ch, tr­íc tiªn h·y ®Õn TÇn L¨ng ®¸nh 50 con NhÝm.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{20}},{1012,{10}}}, nItemCheck = {}, nFightState = 1, nW = 7, nX = 2277, nY = 2824},
			{nTitle = "B¹n ®· giÕt ®­îc NhÝm, cã thÓ ®i D­¬ng Ch©u t×m Giang NhÊt Tiªu.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{20,30}},{1012,{20}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 204*8, nY = 192*16},
			{nTitle = "Ta cã quen L¹c Thanh Thu th­ sinh, y tõng lµ nhµ b×nh kiÕm næi tiÕng. ChØ v× mét lÇn ngoµi ý muèn ®· phÕ c¸nh tay, ng­¬i h·y ®Õn t×m «ng.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1694, nY = 3129},
			{nTitle = "GÆp con b¹c ë gÇn sßng b¹c. Gióp L¹c Thanh Thu gi¶i quyÕt kho¶n nî",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1744, nY = 3151},
			{nTitle = "§­îc! Ra ngoµi thµnh lÊy m¹ng Lé Tr­êng Thiªn, mãn nî cña hä L¹c kh«ng ph¶i tr¶.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{80}}}, nItemCheck = {}, nFightState = 1, nW = 80, nX = 1999, nY = 2882},
			{nTitle = "Lé Tr­êng Thiªn ®· bÞ b¹n khuÊt phôc, nhiÖm vô hoµn thµnh, b¹n cã thÓ vÒ t×m con b¹c.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{90,100}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1744, nY = 3151},
			{nTitle = "Mãn nî cña L¹c Thanh Thu ®· ®­îc xo¸. H·y quay vÒ gÆp L¹c Thanh Thu",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1694, nY = 3129},
			{nTitle = "H·y ra ngoµi thµnh ®o¹t lÊy b¶o kiÕm cña (Nh©n vËt Vâ l©m)",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{130}}}, nItemCheck = {}, nFightState = 1, nW = 80, nX = 1396, nY = 3397},
			{nTitle = "B¹n ®· lÊy ®­îc B¶o kiÕm, cã thÓ quay vÒ giao cho L¹c Thanh Thu.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{140}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1694, nY = 3129},
			{nTitle = "Quay l¹i gÆp LiÔu Nam V©n nhËn phÇn th­ëng.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1054,{1000}},{197,{0}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			----------------------------------------------------------CÊp 30-39
			{nTitle = "§Õn L©m An t×m gÆp LiÔu Nam V©n",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "GÇn ®©y T©y B¾c x¶y ra ¸n lín, LiÔu Nam V©n b¶o b¹n ®Õn Ph­îng T­êng t×m Chñ nh©n Song ¦ng tiªu côc hái râ.",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{20,30}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1543, nY = 3191},
			{nTitle = "B¹n ®i t×m A Ng­u.",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1567, nY = 3253},
			{nTitle = "GÆp H¹ L·o B¶n (Chñ tiªu côc).",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3011, nY = 5057},
			{nTitle = "§i Thôc C­¬ng S¬n ®¸nh 50 con KhØ x¸m.",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{80}},{1012,{10}}}, nItemCheck = {}, nFightState = 1, nW = 92, nX = 1977, nY = 3116},
			{nTitle = "Quay l¹i gÆp H¹ L·o B¶n (Chñ tiªu côc).",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{80,90}},{1012,{20}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3011, nY = 5057},
			{nTitle = "§¸nh b¹i 3 chÞ em BÝch Ngäc, Nh­ Yªn, T¨ng Méng.",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{100}},{1012,{0,10,20}}}, nItemCheck = {}, nFightState = 1, nW = 131, nX = 1872, nY = 3392},
			{nTitle = "§· ®¸nh b¹i Hµ Hoa §¹o. Quay vÒ b¸o tin cho H¹ L·o B¶n.",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3011, nY = 5057},
			{nTitle = "GÆp LiÔu Nam V©n.",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1055,{130,140}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "Quay l¹i gÆp LiÔu Nam V©n nhËn phÇn th­ëng <<M¶nh B¶n §å>> vµ <<Kim Phong C«ng CÈm Th¸n>>.",nName = "Trung LËp CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1054,{1000}},{197,{0,1}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			----------------------------------------------------------CÊp 40-49
			{nTitle = "§Õn L©m An t×m gÆp LiÔu Nam V©n",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "GÆp C«ng B×nh Tö ®¸nh l«i ®µi lÇn 1",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{20}},{1012,{10}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3165, nY = 5194},
			{nTitle = "§· hoµn thµnh nhiÖm vô l«i ®µi. Cã thÓ trë vÒ t×m gÆp LiÔu Nam V©n",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{20,25}},{1012,{20}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "GÆp C«ng B×nh Tö ®¸nh l«i ®µi lÇn 2",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{40}},{1012,{10}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3165, nY = 5194},
			{nTitle = "ChiÕn th¾ng l«i ®µi lÇn 2. L¹i quay vÒ b¸o cho LiÔu Nam V©n",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{40,50}},{1012,{20}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "§¸nh b¹i Du S­¬ng T©n",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{60}}}, nItemCheck = {}, nFightState = 1, nW = 11, nX = 3371, nY = 4889},
			{nTitle = "Quay l¹i b¸o tin cho LiÔu Nam V©n",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{70,80}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "Quay l¹i gÆp LiÔu Nam V©n nhËn phÇn th­ëng <<M¶nh B¶n §å>>",nName = "Trung LËp CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1056,{1000}},{197,{1,2,3,4,5}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			----------------------------------------------------------CÊp 50-59
			{nTitle = "§Õn L©m An t×m gÆp LiÔu Nam V©n",nName = "Trung LËp CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1057,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "Hoµn thµnh nhiÖm vô tÝch luü tèng kim. Cã thÓ quay vÒ gÆp LiÔu Nam V©n",nName = "Trung LËp CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1057,{20,30}},{1012,{20}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "TiÕp tôc nãi chuyÖn víi LiÔu Nam V©n vµ tr¶ lêi c¸c c©u hái cña «ng ta vÒ Tèng Kim",nName = "Trung LËp CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1057,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "§· hoµn thµnh hái ®¸p víi LiÔu Nam V©n. TiÕp tôc nãi chuyÖn víi «ng ta ®Ó dß la tin tøc.",nName = "Trung LËp CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1057,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "LiÔu Nam V©n b¶o b¹n ®i tiªu diÖt Long Truy Vò.",nName = "Trung LËp CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1057,{80}}}, nItemCheck = {}, nFightState = 1, nW = 162, nX = 1723, nY = 2987},
			{nTitle = "Tiªu diÖt ®­îc Long Truy Vò. Quay vÒ b¸o tin cho LiÔu Nam V©n",nName = "Trung LËp CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1057,{90,100}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "Quay l¹i gÆp LiÔu Nam V©n nhËn phÇn th­ëng [[M¶nh B¶n §å]]",nName = "Trung LËp CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1057,{1000}},{197,{1,2,3,4,5,6}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
		},
		[3] = { --Tµ Ph¸i PheType
			----------------------------------------------------------CÊp 20-29
			{nTitle = "GÆp Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Th¸c B¹t Hoµi Xuyªn b¶o b¹n ®i §­êng M«n Thµnh §« ®¸nh 50 con H¾c DiÖp HÇu.",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{20}},{1013,{10}}}, nItemCheck = {}, nFightState = 1, nW = 25, nX = 3952, nY = 5284},
			{nTitle = "§· ®¸nh b¹i 50 con H¾c DiÖp HÇu. Quay vÒ b¸o cho Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{20}},{1013,{20}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Th¸c B¹t Hoµi Xuyªn b¶o b¹n ®Õn Thµnh §« t×m gÆp Tr©u Tr­êng Cöu",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3139, nY = 5086},
			{nTitle = "NÕu cã thÓ tho¸t th©n ®­îc, cÇm nh÷ng quyÓn mËt tÞch nµy ®i D­¬ng Ch©u t×m ThÈm Phong. Nh×n thÊy vËt nµy, h¾n tù nhiªn sÏ hiÓu.",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1684, nY = 3078},
			{nTitle = "§¸nh b¹i Vâ SÜ gi¶ d¹ng ThÈm Phong",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{80}}}, nItemCheck = {}, nFightState = 1, nW = 80, nX = 1787, nY = 3378},
			{nTitle = "B¹n ®· h¹ gôc tªn Vâ sÜ gi¶ d¹ng ThÈm Phong. NhiÖm vô hoµn thµnh. Cã thÓ trë vÒ t×m Th¸c B¹t Hoµi Xuyªn!",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{90,100}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Cã thÓ gÆp Th¸c B¹t Hoµi Xuyªn nhËn phÇn th­ëng",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax=29, nTaskCheck = {{1058,{1000}},{198,{0}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			----------------------------------------------------------CÊp 30-39
			{nTitle = "GÆp Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "§¸nh 50 con Sãi vµng",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{20}},{1013,{10}}}, nItemCheck = {}, nFightState = 1, nW = 193, nX = 1560, nY = 3188},
			{nTitle = "§· ®¸nh b¹i ®­îc Sãi vµng. Cã thÓ vÒ BiÖn Kinh gÆp Th¸c B¹t Hoµi Xuyªn.",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{20,30}},{1013,{20}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "§Õn T­¬ng D­¬ng gÆp L­u UÈn C«.",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 78, nX = 1611, nY = 3185},
			{nTitle = "L­u ¦u C« cho biÕt Thi Nghi Sinh thùc sù cã biÓu hiÖn ph¶n quèc. B¹n lËp tøc quay l¹i b¸o cho Th¸c B¹t Hoµi Xuyªn.",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Hoµi Xuyªn b¶o b¹n ®Õn L©m An t×m gÆp tªn mËt th¸m Èn nÊp ®· l©u, ng­êi nµy th­êng gi¶ d¹ng say xØn bªn c¹nh töu lÇu.",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{80,90}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1691, nY = 3033},
			{nTitle = "§¸nh b¹i Thi Nghi Sinh.",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{100}}}, nItemCheck = {}, nFightState = 1, nW = 176, nX = 1701, nY = 3388},
			{nTitle = "Thi Nghi Sinh ®· bÞ ®¸nh b¹i. Quay vÒ b¸o tin cho Hoµi Xuyªn.",nName = "Tµ Ph¸i CÊp 30-39",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Cã thÓ gÆp Th¸c B¹t Hoµi Xuyªn nhËn phÇn th­ëng <<M¶nh B¶n §å>> vµ <<Kim Phong C«ng CÈm Th¸n>>.",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 30, nLevelMax = 39, nTaskCheck = {{1059,{1000}},{198,{0,1}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			----------------------------------------------------------CÊp 40-49
			{nTitle = "GÆp Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "GÆp L­u UÈn C« ®iÒu tra t×nh h×nh Tèng triÒu diÔn vâ ®­êng.",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{20,30}}}, nItemCheck = {}, nFightState = 0, nW = 78, nX = 1611, nY = 3185},
			{nTitle = "GÆp C«ng B×nh Tö ®¸nh l«i ®µi lÇn 1",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{40}},{1013,{10}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3165, nY = 5194},
			{nTitle = "Cã thÓ vÒ gÆp L­u UÈn C«",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{40,50}},{1013,{20}}}, nItemCheck = {}, nFightState = 0, nW = 78, nX = 1611, nY = 3185},
			{nTitle = "Quay vÒ gÆp Th¸c B¹t Hoµi Xuyªn b¸o c¸o t×nh h×nh thi ®Êu",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{70,60}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "GÆp C«ng B×nh Tö ®¸nh l«i ®µi lÇn 2",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{80}},{1013,{10}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3165, nY = 5194},
			{nTitle = "Quay vÒ gÆp Th¸c B¹t Hoµi Xuyªn b¸o c¸o t×nh h×nh thi ®Êu",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{80,90}},{1013,{20}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "§i T­¬ng D­¬ng ¸m s¸t ®¹i phó hé NguyÔn Minh ViÔn",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{100}}}, nItemCheck = {}, nFightState = 1, nW = 78, nX = 1788, nY = 3189},
			{nTitle = "Trë vÒ phôc mÖnh víi Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Cã thÓ gÆp Th¸c B¹t Hoµi Xuyªn nhËn phÇn th­ëng <<M¶nh B¶n §å>> vµ <<Kim Phong Lan §×nh Ngäc>>.",nName = "Tµ Ph¸i CÊp 40-49",nLevelMin = 40, nLevelMax = 49, nTaskCheck = {{1060,{1000}},{198,{0,1,2}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			----------------------------------------------------------CÊp 50-59
			{nTitle = "GÆp Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1061,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "NhiÖm vô Tèng Kim tÝch luü ®· hoµn thµnh. Cã thÓ quay vÒ gÆp Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1061,{20,30}},{1013,{20}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Trë vÒ t×m Th¸c B¹t. Tr¶ lêi c¸c c©u hái cña «ng ta vÒ Tèng Kim",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1061,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Cã thÓ t×m gÆp Th¸c B¹t nãi chuyÖn",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1061,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "TiÕp tôc nãi chuyÖn víi Th¸c B¹t nhËn uû th¸c cña «ng ta",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1061,{80,90}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Qu©n ®¹i Kim Nam H¹ t¹i T­¬ng D­¬ng ®ang l©m nguy. B¹n phông mÖnh ®i giÕt Sö ThÞnh Do·n",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1061,{100}}}, nItemCheck = {}, nFightState = 1, nW = 78, nX = 1372, nY = 3500},
			{nTitle = "GÆp Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1061,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Cã thÓ gÆp Th¸c B¹t Hoµi Xuyªn nhËn phÇn th­ëng <<M¶nh B¶n §å>> vµ <<Kim Phong §æng T­íc Xu©n Th©m>>.",nName = "Tµ Ph¸i CÊp 50-59",nLevelMin = 50, nLevelMax = 59, nTaskCheck = {{1060,{1000}},{198,{0,1,2,3,4,5,6}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
		}
	}
}
function GQ_Test()
	--Msg2Player(tb_HelpGoldQuest[1].nTitle)
	--Msg2Player(tb_HelpGoldQuest[1][1][1].nTitle)
	--Msg2Player(getn(tb_HelpGoldQuest[1][1]))
	--Msg2Player("============Phô - ChÝnh===========")
	--Msg2Player("Task1050 "..nt_getTask(1050))
	--Msg2Player("Task1051 "..nt_getTask(1051))
	--Msg2Player("Task1052 "..nt_getTask(1052))
	--Msg2Player("Task1053 "..nt_getTask(1053))
	--Msg2Player("Task196 "..nt_getTask(196))
	--Msg2Player("Task1011 "..nt_getTask(1011))
	--Msg2Player("============Phô - Trung===========")
	--Msg2Player("Task1054 "..nt_getTask(1054))
	--Msg2Player("Task1055 "..nt_getTask(1055))
	--Msg2Player("Task1056 "..nt_getTask(1056))
	--Msg2Player("Task1057 "..nt_getTask(1057))
	--Msg2Player("Task197 "..nt_getTask(197))
	--Msg2Player("Task1012 "..nt_getTask(1012))
	--Msg2Player("============Phô - Tµ==============")
	--Msg2Player("Task1058 "..nt_getTask(1058))
	--Msg2Player("Task1059 "..nt_getTask(1059))
	--Msg2Player("Task1060 "..nt_getTask(1060))
	--Msg2Player("Task1061 "..nt_getTask(1061))
	--Msg2Player("Task198 "..nt_getTask(198))
	--Msg2Player("Task1013 "..nt_getTask(1013))
	--Msg2Player("===========================")
	--Msg2Player("Task1001 "..nt_getTask(1001))
	--Msg2Player("Task1002 "..nt_getTask(1002))
	--Msg2Player("Task1003 "..nt_getTask(1003))
	--Msg2Player("Task183 "..nt_getTask(183))
	--Msg2Player("Task186 "..nt_getTask(186))
	--Msg2Player("Task189 "..nt_getTask(189))
end
------------------------------------------------------------------------------------------------------------
----------------------------------------Phô TuyÕn-----------------------------------------------------------
------------------------------------------------------------------------------------------------------------
function GQ_RS()
	nt_setTask(1001,0)
	nt_setTask(1002,0)
	nt_setTask(1003,0)
	nt_setTask(1050,0)
	nt_setTask(1051,0)
	nt_setTask(1052,0)
	nt_setTask(1053,0)
	nt_setTask(1054,0)
	nt_setTask(1055,0)
	nt_setTask(1056,0)
	nt_setTask(1057,0)
	nt_setTask(1058,0)
	nt_setTask(1059,0)
	nt_setTask(1060,0)
	nt_setTask(1061,0)
	nt_setTask(192,0)
	nt_setTask(193,0)
	nt_setTask(194,0)
	nt_setTask(195,0)
	nt_setTask(1011,0)
	nt_setTask(1012,0)
	nt_setTask(1013,0)
	Msg2Player("§· RS NVHK. Cã thÓ lµm l¹i tõ ®Çu. H·y vÒ Long Ngò nhËn th­")
end
function GQ_LoiDai()
	if (nt_getTask(1060) == 40 or nt_getTask(1060) == 80) and nt_getTask(1013) == 10 then
		nt_setTask(1013, 20)
		Msg2Player("§· hoµn thµnh nhiÖm vô l«i ®µi phô tuyÕn Tµ Ph¸i 40-49.")
	elseif (nt_getTask(1011) == 10 and (nt_getTask(1052) == 20 or nt_getTask(1052) == 60)) then
		nt_setTask(1011, 20)
		Msg2Player("§· hoµn thµnh nhiÖm vô l«i ®µi phô tuyÕn ChÝnh Ph¸i 40-49.")
	elseif (nt_getTask(1012) == 10 and (nt_getTask(1056) == 20 or nt_getTask(1056) == 40)) then
		nt_setTask(1012, 20)
		Msg2Player("§· hoµn thµnh nhiÖm vô l«i ®µi phô tuyÕn Trung LËp 40-49.")
	end
end
function GQ_TongKim()
	if (nt_getTask(1061) == 20 and nt_getTask(1013) == 10) then --tµ ph¸i 50-59 yªu cÇu ®¸nh tèng kim
		nt_setTask(1013, 20)
		Msg2Player("§· hoµn thµnh nhiÖm vô Tèng Kim phô tuyÕn Tµ Ph¸i 50-59.")
	elseif (nt_getTask(1053) == 20 and nt_getTask(1011) == 10) then
		nt_setTask(1011, 20)
		Msg2Player("§· hoµn thµnh nhiÖm vô Tèng Kim phô tuyÕn ChÝnh Ph¸i 50-59.")
	elseif (nt_getTask(1057) == 20 and nt_getTask(1012) == 10) then
		nt_setTask(1012, 20)
		Msg2Player("§· hoµn thµnh nhiÖm vô Tèng Kim phô tuyÕn Trung LËp 50-59.")
	end
end
function GQ_HoiDapTongKim()
	if (nt_getTask(1061) == 50) then --tµ ph¸i 50-59 hái ®¸p tèng kim
		nt_setTask(1061, 60)
		Msg2Player("§· hoµn thµnh nhiÖm vô Hái §¸p Tèng Kim phô tuyÕn Tµ Ph¸i 50-59. Cã thÓ nãi chuyÖn víi Th¸c B¹t.")
	elseif (nt_getTask(1053) == 30) then
		nt_setTask(1053, 40)
		Msg2Player("§· hoµn thµnh nhiÖm vô Hái §¸p Tèng Kim phô tuyÕn ChÝnh Ph¸i 50-59. Cã thÓ nãi chuyÖn víi Hçn Hçn.")
	elseif (nt_getTask(1057) == 40 or nt_getTask(1057) == 50) then
		nt_setTask(1057, 60)
		Msg2Player("§· hoµn thµnh nhiÖm vô Hái §¸p Tèng Kim phô tuyÕn Trung LËp 50-59. Cã thÓ nãi chuyÖn víi LiÔu Nam V©n.")
	end
end