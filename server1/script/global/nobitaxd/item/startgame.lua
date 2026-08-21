Include("\\script\\battles\\marshal\\mission.lua")
Include("\\script\\battles\\marshal\\head.lua")
Include("\\script\\battles\\marshal\\smalltimer.lua")
Include("\\script\\battles\\battlemain.lua")
Include("\\script\\missions\\fengling_ferry\\fldmap_boat1.lua")
Include("\\script\\missions\\fengling_ferry\\mission.lua")
Include("\\script\\missions\\fengling_ferry\\fld_smalltimer.lua")
Include("\\script\\missions\\fengling_ferry\\fld_head.lua")

----------------------------------------------------Khëi §éng Ho¹t §éng Game ---------------------------------------------

function goihoatdongmaychu()
	dofile("script/global/nobitaxd/item/statgame.lua")
	tbTitle = "Khëi ®éng hÖ thèng Missions Thñ C«ng"
	tbSay = {}
	tinsert(tbSay,"Më Boss §¹i/#StartMissions(3)")
	tinsert(tbSay,"Më Boss TiÓu/#StartMissions(4)")
	tinsert(tbSay,"Më Tèng Kim [Cao CÊp]/#StartMissions(8)")
	tinsert(tbSay,"Më ThÊt Thµnh §¹i ChiÕn/ThatThanhDaiChien")	
	--tinsert(tbSay,"Më V­ît ¶i/#StartMissions(1)")	
	--tinsert(tbSay,"Më Phong L¨ng §é/#StartMissions(5)")
	tinsert(tbSay,"Më Phong L¨ng §é/menu_phonglangdo")	
	tinsert(tbSay,"Më NhÝm BÐo Ph×/#StartMissions(18)")
	tinsert(tbSay,"Më Qu¶ Huy Hoµng-Qu¶ Hoµng Kim/#StartMissions(7)")
	tinsert(tbSay,"Më Hoa §¨ng/#StartMissions(9)")
	tinsert(tbSay,"Më Liªn §Êu §¬n Tù Do/#StartMissions(22)")
	tinsert(tbSay,"Më Lo¹n ChiÕn Cöu Ch©u Cãc/#StartMissions(6)")
	tinsert(tbSay,"Më §Êu Ng­u/#StartMissions(15)")	
	tinsert(tbSay,"Tho¸t/OnCancel")
	Say(tbTitle, getn(tbSay), tbSay)
end

function ThatThanhDaiChien()

	tbTitle = "Ho¹t §éng ThÊt Thµnh §¹i ChiÕn"
	tbSay = {}	
	tinsert(tbSay,"B¸o Danh ThÊt Thµnh §¹i ChiÕn/#StartMissions(10)")
	--tinsert(tbSay,"Më CTC KÕt Thóc B¸o Danh /#StartMissions(11)")
	--tinsert(tbSay,"Më CTC ChuÈn BÞ/#StartMissions(12)")
	tinsert(tbSay,"B¾t §Çu ThÊt Thµnh §¹i ChiÕn/#StartMissions(13)")
	tinsert(tbSay,"KÕt Thóc ThÊt Thµnh §¹i ChiÕn /#StartMissions(14)")
	tinsert(tbSay,"Reset D÷ LiÖu ThÊt Thµnh §¹i ChiÕn /#StartMissions(23)")
	tinsert(tbSay,"Trang tr­íc/goihoatdongmaychu")
	tinsert(tbSay,"Tho¸t/OnCancel")
	Say(tbTitle, getn(tbSay), tbSay)
end

function StartMissions(MsID)
	if (MsID == 1) then
		RemoteExc("\\script\\startmissions.lua", "VuotAi")
	elseif (MsID == 2) then
		RemoteExc("\\script\\startmissions.lua", "ViemDe")
	elseif (MsID == 3) then
		RemoteExc("\\script\\startmissions.lua", "Call_BigBoss")
	elseif (MsID == 4) then
		RemoteExc("\\script\\startmissions.lua", "Call_SmallBoss")
	elseif (MsID == 5) then
		RemoteExc("\\script\\startmissions.lua", "PhongLangDo")
	elseif (MsID == 6) then
		RemoteExc("\\script\\startmissions.lua", "loanchiencuuchau")
	elseif (MsID == 7) then
		RemoteExc("\\script\\startmissions.lua", "QuaHuyHoang")
	elseif (MsID == 8) then
		RemoteExc("\\script\\startmissions.lua", "StartTongKim_3")
	elseif (MsID == 9) then
		RemoteExc("\\script\\startmissions.lua", "GoiHoaDang")
	elseif (MsID == 10) then
		RemoteExc("\\script\\startmissions.lua", "CTC_BaoDanh")
	elseif (MsID == 11) then
		RemoteExc("\\script\\startmissions.lua", "CTC_KetThucBaoDanh")
	elseif (MsID == 12) then
		RemoteExc("\\script\\startmissions.lua", "CTC_ChuanBi")
	elseif (MsID == 13) then
		RemoteExc("\\script\\startmissions.lua", "CTC_BatDau")
	elseif (MsID == 14) then
		RemoteExc("\\script\\startmissions.lua", "CTC_KetThuc")
	elseif (MsID == 15) then
		RemoteExc("\\script\\startmissions.lua", "HoatDongDauNguu")
	elseif (MsID == 16) then
		RemoteExc("\\script\\startmissions.lua", "nguyetcadao")
	elseif (MsID == 17) then
		RemoteExc("\\script\\startmissions.lua", "tanthuyhoang")
		--tbAdd_Boss_TuLinh()
		--elseif (MsID == 18) then
		--RemoteExc("\\script\\startmissions.lua", "StartDuaNgua")
	elseif (MsID == 18) then
		RemoteExc("\\script\\startmissions.lua", "goinhimbeophi")
	elseif (MsID == 19) then
		findgoldboss(1,20)
	elseif (MsID == 20) then
		tbAloneShipped:BeginMission()
	elseif (MsID == 21) then
		RemoteExc("\\script\\startmissions.lua", "PhongLangDoThuyTac")	
	elseif (MsID == 22) then
		RemoteExc("\\script\\startmissions.lua", "StartLienDauNhanh")
	elseif (MsID == 23) then
		RemoteExc("\\script\\startmissions.lua", "CTC_XoaDuLieu")	
	end		
end

function menu_phonglangdo()
	tbTitle = "Chän lo¹i Phong L¨ng §é muèn më"
	tbSay = {}
	tinsert(tbSay,"Phong L¨ng §é Th­êng/#StartMissions(5)")
	tinsert(tbSay,"Phong L¨ng §é §Æc BiÖt(Thñy TÆc)/#StartMissions(21)")
	tinsert(tbSay,"Quay l¹i/goihoatdongmaychu")
	tinsert(tbSay,"Tho¸t/OnCancel")
	Say(tbTitle, getn(tbSay), tbSay)
end

