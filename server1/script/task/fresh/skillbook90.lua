-- Ho Tro nhiem vu mon phai By Vo Lam Cu Chuoi
Include("\\script\\global\\repute_head.lua")
Include("\\script\\global\\skills_table.lua")

function main(nItemIndex)
	dofile("script/task/fresh/skillbook90.lua");
	player_Faction = GetFaction()
	if (player_Faction == "shaolin") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"§¹t Ma §é Giang/Done_ThieuLam_1",
			"Hoµnh T¶o Thiªn Qu©n/Done_ThieuLam_2",
			"V« T­íng Tr¶m/Done_ThieuLam_3" );
	elseif (player_Faction == "tianwang") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"Ph¸ Thiªn Tr¶m/Done_ThienVuong_1",
			"Truy Tinh Trôc NguyÖt/Done_ThienVuong_2",
			"Truy Phong QuyÕt/Done_ThienVuong_3" );
	elseif (player_Faction == "tangmen") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"NhiÕp Hån NguyÖt ¶nh/Done_DuongMon_1",
			"B¹o Vò Lª Hoa/Done_DuongMon_2",
			"Cöu Cung Phi Tinh/Done_DuongMon_3",
			"Lo¹n Hoµn KÝch/Done_DuongMon_4" );
	elseif (player_Faction == "wudu") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"¢m Phong Thùc Cèt/Done_NguDoc_1",
			"HuyÒn ¢m Tr¶m/Done_NguDoc_2",
			"§o¹n C©n Hñ Cèt/Done_NguDoc_3" );
	elseif (player_Faction == "emei") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"Tam Nga TÒ TuyÕt/Done_NgaMy_1",
			"Phong S­¬ng To¸i ¶nh/Done_NgaMy_2",
			"Phæ §é Chóng Sinh/Done_NgaMy_3" );
	elseif (player_Faction == "cuiyan") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"B¨ng Tung V« ¶nh/Done_ThuyYen_1",
			"B¨ng T©m Tiªn Tö/Done_ThuyYen_2" );
	elseif (player_Faction == "gaibang") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"Phi Long T¹i Thiªn/Done_CaiBang_1",
			"Thiªn H¹ V« CÈu/Done_CaiBang_2" );
	elseif (player_Faction == "tianren") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"V©n Long KÝch/Done_ThienNhan_1",
			"Thiªn Ngo¹i L­u Tinh/Done_ThienNhan_2",
			"NhiÕp Hån Lo¹n T©m/Done_ThienNhan_3" );
	elseif (player_Faction == "wudang") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"Thiªn §Þa V« Cùc/Done_VoDang_1",
			"Nh©n KiÕm Hîp NhÊt/Done_VoDang_2" );
	elseif (player_Faction == "kunlun") then
		Say ("Chän kü n¨ng cÇn häc ! ! !", 4,
			"Ng¹o TuyÕt Tiªu Phong/Done_ConLon_1",
			"L«i ®éng Cöu Thiªn/Done_ConLon_2",
			"Tóy Tiªn T¸ Cèt/Done_ConLon_3" );
	else
		Talk(1, "", "H×nh nh­ quyÓn s¸ch nµy miªu t¶ vâ c«ng cao cÊp cña c¸c ®¹i m«n ph¸i, ng­¬i kh«ng thÓ hiÓu sù huyÒn c¬ cña nã.")
		return	1
	end
end

function Done_ConLon_1()
		if (HaveMagic(372) == -1) then		-- Ng¹o TuyÕt Tiªu Phong
			AddMagic(372,1)
		end
end
function Done_ConLon_2()
		if (HaveMagic(375) == -1) then		-- L«i ®éng Cöu Thiªn
			AddMagic(375,1)
		end
end
function Done_ConLon_3()
		if (HaveMagic(394) == -1) then		-- Tóy Tiªn T¸ Cèt
			AddMagic(394)
		end
end

function Done_VoDang_1()
		if (HaveMagic(365) == -1) then		-- Thiªn §Þa V« Cùc
			AddMagic(365,1)
		end
end
function Done_VoDang_2()
		if (HaveMagic(368) == -1) then		-- Nh©n KiÕm Hîp NhÊt
			AddMagic(368,1)
		end
end

function Done_ThienNhan_1()
		if (HaveMagic(361) == -1) then		-- V©n Long KÝch
     		 	AddMagic(361,1)
		end
end
function Done_ThienNhan_2()
		if (HaveMagic(362) == -1) then		-- Thiªn Ngo¹i L­u Tinh
   	  		 AddMagic(362,1)
		end
end
function Done_ThienNhan_3()
		if (HaveMagic(391) == -1) then		-- NhiÕp Hån Lo¹n T©m
			AddMagic(391)
		end
end

function Done_CaiBang_1()
		if (HaveMagic(357) == -1) then		-- Phi Long T¹i Thiªn
			AddMagic(357,1)
		end
end
function Done_CaiBang_2()
		if (HaveMagic(359) == -1) then		-- Thiªn H¹ V« CÈu
			AddMagic(359,1)
		end
end

function Done_ThuyYen_1()
		if (HaveMagic(336) == -1) then		-- B¨ng Tung V« ¶nh
			AddMagic(336,1)
		end
end
function Done_ThuyYen_2()
		if (HaveMagic(337) == -1) then		-- B¨ng T©m Tiªn Tö
			AddMagic(337,1)
		end
end

function Done_NgaMy_1()
		if (HaveMagic(328) == -1) then		-- Tam Nga TÒ TuyÕt
			AddMagic(328,1)
		end
end
function Done_NgaMy_2()
		if (HaveMagic(380) == -1) then		-- Phong S­¬ng To¸i ¶nh
			AddMagic(380,1)
		end
end
function Done_NgaMy_3()
		if (HaveMagic(332) == -1) then		-- Phæ §é Chóng Sinh
			AddMagic(332)
		end
end

function Done_NguDoc_1()
		if (HaveMagic(353) == -1) then		-- ¢m Phong Thùc Cèt
			AddMagic(353,1)
		end
end
function Done_NguDoc_2()
		if (HaveMagic(355) == -1) then		-- HuyÒn ¢m Tr¶m
			AddMagic(355,1)
		end
end
function Done_NguDoc_3()
		if (HaveMagic(390) == -1) then		-- §o¹n C©n Hñ Cèt
			AddMagic(390)
		end
end

function Done_DuongMon_1()
	if (HaveMagic(339) == -1) then		-- NhiÕp Hån NguyÖt ¶nh
		AddMagic(339,1)
	end
end
function Done_DuongMon_2()
	if (HaveMagic(302) == -1) then		-- B¹o Vò Lª Hoa
		AddMagic(302,1)
	end
end
function Done_DuongMon_3()
	if (HaveMagic(342) == -1) then		-- Cöu Cung Phi Tinh
		AddMagic(342,1)
	end
end
function Done_DuongMon_4()
	if (HaveMagic(351) == -1) then		-- Lo¹n Hoµn KÝch
		AddMagic(351)
	end
end

function Done_ThienVuong_1()
		if (HaveMagic(322) == -1) then		-- Ph¸ Thiªn Tr¶m
			AddMagic(322,1)
		end
end
function Done_ThienVuong_2()
		if (HaveMagic(323) == -1) then		-- Truy Tinh Trôc NguyÖt
			AddMagic(323,1)
		end
end
function Done_ThienVuong_3()
		if (HaveMagic(325) == -1) then		-- Truy Phong QuyÕt
			AddMagic(325,1)
   		end
end

function Done_ThieuLam_1()
		if (HaveMagic(318) == -1) then		-- §¹t Ma §é Giang
			AddMagic(318,1)
		end
end
function Done_ThieuLam_2()
		if (HaveMagic(319) == -1) then		-- Hoµnh T¶o Thiªn Qu©n
			AddMagic(319,1)
		end
end
function Done_ThieuLam_3()
		if (HaveMagic(321) == -1) then		-- V« T­íng Tr¶m
			AddMagic(321,1)
		end
end
