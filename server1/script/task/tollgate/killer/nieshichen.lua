--BossÉ±ÊÖÈÎÎñ½ÓÒýnpc½Å±¾
--By LiuKuo 2005.3.25
Include ("\\script\\class\\ktabfile.lua")
Include ("\\script\\task\\newtask\\newtask_head.lua")
Include("\\script\\missions\\challengeoftime\\npc\\dragonboat_main_caocap_dondau.lua")
Include("\\script\\missions\\challengeoftime\\npc\\dragonboat_main_caocap_todoi.lua")
Include("\\script\\missions\\challengeoftime\\npc\\dragonboat_main_socap_dondau.lua")
Include("\\script\\missions\\challengeoftime\\npc\\dragonboat_main_socap_todoi.lua")
Include("\\script\\event\\birthday_jieri\\200905\\chuangguan\\chuangguan.lua");
Include("\\script\\event\\birthday_jieri\\200905\\class.lua");
Include("\\script\\lib\\common.lua");
Include("\\script\\lib\\log.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")
-- ´³¹Ø»î¶¯Ã¿ÈÕÅÅÐÐ°ñ
Include("\\script\\missions\\challengeoftime\\rank_perday.lua");
---- DescribÍ¼Æ¬ÃèÊö
--DescLink_NieShiChen = "<#><link=image[147,167]:\\spr\\npcres\\enemy\\enemy154\\enemy154_pst.spr>Äôß±³¾£º<link>";
--TSKID_KILLTASKID = 1082;	-- ½ÓÊÜµÄÄÄ¸öÈÎÎñ
--TSKID_KILLERDATE	= 1192;	--½ÓÈÎÎñÊ±µÄÈÕÆÚ
--TSKID_KILLERMAXCOUNT	= 1193;	--Ã¿ÌìÉ±ÈË´ÎÊý
--KILLER_MAXCOUNT		= 8;	--Ã¿ÌìÉ±ÈËÉÏÏÞ8ÈË

--Thªm dßng kiÓm tra ®iÒu kiÖn tham gia khiªu chiÕn cña tæ ®éi - Modified by DinhHQ - 20110504
Include("\\script\\vng_feature\\challengeoftime\\npcNhiepThiTran.lua")

tab_ToaDoBossST = {
	--    Tªn boss ph¶i lÊy trong \script\task\tollgate\killbosshead.lua nã míi chuÈn. Vµ FindNpc nã míi cã thÓ t×m thÊy
	--    IDMap,ID(Sè dßng)trong killer.txt, tªn boss, tªn map, cÊp ®é boss s¸t thñ
		{73,1,"Tr¸c L·nh CÇm","Phôc L­u ®éng",20},
		{73,2,"Tiªu Thiªn Ng¹o","Phôc L­u ®éng",20},
		{73,3,"Môc Minh KiÖt","Phôc L­u ®éng",20},
		{73,4,"TÊt V­u Phãng","Phôc L­u ®éng",20},
		{43,5,"Lôc Cöu U","KiÕm C¸c Trung Nguyªn",20},
		{43,6,"Bé Hiªu TrÇn","KiÕm C¸c Trung Nguyªn",20},
		{43,7,"Cèc KiÕm Thu","KiÕm C¸c Trung Nguyªn",20},
		{43,8,"ThiÖu Hoa Dung","KiÕm C¸c Trung Nguyªn",20},
		{71,9,"Quan Tö M¹c","B¹ch Thñy ®éng",20},
		{71,10,"Bµnh ThÝch H¶i","B¹ch Thñy ®éng",20},
		{71,11,"BÝch Phï B×nh","B¹ch Thñy ®éng",20},
		{71,12,"Tr­îng L·nh s¬n ","B¹ch Thñy ®éng",20},
		{83,13,"Tiªu KiÕm TuyÕt","Háa Lang ®éng",20},
		{83,14,"Kha ThiÕu Gia","Háa Lang ®éng",20},
		{83,15,"Ch­ëng B¸t Ph­¬ng","Háa Lang ®éng",20},
		{83,16,"Méng Êt  Phi","Háa Lang ®éng",20},
		{14,17,"T­ §å TuyÖt Chñy","M·nh Hæ ®éng",20},
		{14,18,"Th­îng Quan L·ng","M·nh Hæ ®éng",20},
		{14,19,"D­¬ng Thanh Èn","M·nh Hæ ®éng",20},
		{14,20,"Ngôy Chiªm Th©n","M·nh Hæ ®éng",20},
		{4,21,"§µo §o¹t Thu","Kim Quang ®éng",30},
		{4,22,"Xµ B¸ §«ng","Kim Quang ®éng",30},
		{4,23,"L­¬ng T­ Nam ","Kim Quang ®éng",30},
		{4,24,"Tr¸c ThÊt Lang","Kim Quang ®éng",30},
		{22,25,"KiÒu §Ønh Thiªn","B¹ch V©n ®éng",30},
		{22,26,"Träng V« CÊp","B¹ch V©n ®éng",30},
		{22,27,"KhÝ CÇm SÜ","B¹ch V©n ®éng",30},
		{22,28,"§inh V¨n Dôc","B¹ch V©n ®éng",30},
		{77,29,"Phong Ngò Ên","YÕn Tö ®éng",30},
		{77,30,"Khang  BÊt Hèi","YÕn Tö ®éng",30},
		{77,31,"Ph­¬ng Dùc Viªm","YÕn Tö ®éng",30},
		{77,32,"Ninh T©m Cuång","YÕn Tö ®éng",30},
		{141,33,"H×nh Phô Sinh","D­îc V­¬ng §éng TÇng 1",30},
		{141,34,"Ho¾c TrÊn Phi","D­îc V­¬ng §éng TÇng 1",30},
		{141,35,"Qu¶n V« YÕm","D­îc V­¬ng §éng TÇng 1",30},
		{141,36,"DiÖp VÜnh ¢n","D­îc V­¬ng §éng TÇng 1",30},
		{193,37,"¢u chÝ Phong","Vò Di s¬n",30},
		{193,38,"§éc C« HiÖp","Vò Di s¬n",30},
		{193,39,"H¹ng Phï Nhai","Vò Di s¬n",30},
		{193,40,"Nghª §¹i Chu","Vò Di s¬n",30},
		{5,41,"Du Th¸n Giang","Kinh Hoµng ®éng",40},
		{5,42,"H¹ Hïng Phi","Kinh Hoµng ®éng",40},
		{5,43,"Tèng Vò Phong","Kinh Hoµng ®éng",40},
		{5,44,"Lé Th­îng Nh©n","Kinh Hoµng ®éng",40},
		{168,45,"NhËm T«ng Hoµnh","Phông Nh·n ®éng",40},
		{168,46,"Hµn Khanh Long","Phông Nh·n ®éng",40},
		{168,47,"Tr× PhÈm Chi","Phông Nh·n ®éng",40},
		{168,48,"Chung ThiÕt Thèi","Phông Nh·n ®éng",40},
		{23,49,"§iªu DÞch §ao","ThÇn Tiªn ®éng",40},
		{23,50,"§å Tµn Sinh","ThÇn Tiªn ®éng",40},
		{23,51,"Bµng V« TÜnh","ThÇn Tiªn ®éng",40},
		{23,52,"Lý Hoa §é","ThÇn Tiªn ®éng",40},
		{91,53,"ThÝch ¶nh Sa","Mª Cung Kª Qu¸n ®éng",40},
		{91,54,"Nguy Nh©n Tö ","Mª Cung Kª Qu¸n ®éng",40},
		{91,55,"Cè ViÔn Khª","Mª Cung Kª Qu¸n ®éng",40},
		{91,56,"Tang Ninh Cèc","Mª Cung Kª Qu¸n ®éng",40},
		{135,57,"Diªm Tù H÷u","KiÕn TÝnh Phong s¬n ®éng",40},
		{135,58,"§µm Thiªn Béc","KiÕn TÝnh Phong s¬n ®éng",40},
		{135,59,"Th¹ch Cè KiÒu","KiÕn TÝnh Phong s¬n ®éng",40},
		{135,60,"øng Th¸i HiÖp","KiÕn TÝnh Phong s¬n ®éng",40},
		{12,61,"M¹nh §¹p Hång","§Þa §¹o HËu ViÖn TÝn T­íng Tù",50},
		{12,62,"¢n  Tøc HËn","§Þa §¹o HËu ViÖn TÝn T­íng Tù",50},
		{12,63,"Ho¾c Thanh S­¬ng","§Þa §¹o HËu ViÖn TÝn T­íng Tù",50},
		{12,64,"Miªn T­ §¹o","§Þa §¹o HËu ViÖn TÝn T­íng Tù",50},
		{24,65,"TiÕu Väng Du","H­ëng Thñy ®éng",50},
		{24,66,"Cao N·i Kho¸t","H­ëng Thñy ®éng",50},
		{24,67,"M¹nh Tö  Vò ","H­ëng Thñy ®éng",50},
		{24,68,"§­êng NghÜa Chi","H­ëng Thñy ®éng",50},
		{42,69,"L©u Vi ThiÖn","Thiªn T©m ®éng",50},
		{42,70,"Lç Tranh Tranh","Thiªn T©m ®éng",50},
		{42,71,"Sö Tiªu s¬n","Thiªn T©m ®éng",50},
		{42,72,"T©y M«n V« Giíi","Thiªn T©m ®éng",50},
		{66,73,"Giíi T×nh ChØ","§¸y §éng §×nh Hå TÇng 1",50},
		{66,74,"L«i HuyÔn Kh¸ch","§¸y §éng §×nh Hå TÇng 1",50},
		{66,75,"DiÖp Ngò Long","§¸y §éng §×nh Hå TÇng 1",50},
		{66,76,"TiÕt TiÓu B¸ch","§¸y §éng §×nh Hå TÇng 1",50},
		{194,77,"MËu TuÊt Nhung","Ngäc Hoa ®éng",50},
		{194,78,"D­¬ng DiÔm Qu©n","Ngäc Hoa ®éng",50},
		{194,79,"Du Tiªu C­êng","Ngäc Hoa ®éng",50},
		{194,80,"C« Dù  TÈu","Ngäc Hoa ®éng",50},
		{164,81,"U«ng  ThÖ Thñy","Thiªn TÇm Th¸p TÇng 1",60},
		{164,82,"YÕn L­u  Sanh","Thiªn TÇm Th¸p TÇng 1",60},
		{164,83,"Tang Th­¬ng H¶i","Thiªn TÇm Th¸p TÇng 1",60},
		{164,84,"Bå ThËp Tam","Thiªn TÇm Th¸p TÇng 1",60},
		{117,85,"HËu  KhÊt KiÕm","T­êng V©n §éng TÇng 2",60},
		{117,86,"HËu YÕn T©n","T­êng V©n §éng TÇng 2",60},
		{117,87,"ThiÖu ThÊt S¸t","T­êng V©n §éng TÇng 2",60},
		{117,88,"Du V¹n Lý","T­êng V©n §éng TÇng 2",60},
		{56,89,"Cõu DuÉn Sam","Hoµnh s¬n ph¸i",60},
		{56,90,"Th­îng Quan ChÊt","Hoµnh s¬n ph¸i",60},
		{56,91,"T¸i ViÔn B¹c","Hoµnh s¬n ph¸i",60},
		{56,92,"T­ëng HuyÒn ViÔn","Hoµnh s¬n ph¸i",60},
		{148,93,"KhuÊt Léc Vinh","TuyÕt b¸o ®éng tÇng 4",60},
		{148,94,"L« Qu¸n B¾c","TuyÕt b¸o ®éng tÇng 4",60},
		{148,95,"Gi¶i Qui Nam","TuyÕt b¸o ®éng tÇng 4",60},
		{148,96,"Tïng V« ¶nh","TuyÕt b¸o ®éng tÇng 4",60},
		{196,97,"TiÔn Thª Thanh","D­¬ng Gi¸c ®éng",60},
		{196,98,"B¹ch Th­¬ng Nham","D­¬ng Gi¸c ®éng",60},
		{196,99,"BiÖn L­u ThiÖn","D­¬ng Gi¸c ®éng",60},
		{196,100,"Th¸i Tinh ThÇn","D­¬ng Gi¸c ®éng",60},
		{123,101,"H¹ng LÖnh Ti","L·o Hæ ®éng",70},
		{123,102,"Tµo Nh©n  Phñ","L·o Hæ ®éng",70},
		{123,103,"Tr×nh Phóc Tam","L·o Hæ ®éng",70},
		{123,104,"§Æng An Khuª","L·o Hæ ®éng",70},
		{94,105,"øng  Tiªu Phong","Linh Cèc ®éng",70},
		{94,106,"Th­¬ng TriÒu S­¬ng","Linh Cèc ®éng",70},
		{94,107,"Phïng Song Dùc","Linh Cèc ®éng",70},
		{94,108,"Phã Kh©u Tu","Linh Cèc ®éng",70},
		{319,109,"L¹c Long HiÒn","L©m du quan",70},
		{319,110,"Cæ Thanh D­¬ng","L©m du quan",70},
		{319,111,"Quan Thiªn VÊn","L©m du quan",70},
		{319,112,"H¹ ThiÕu Hïng","L©m du quan",70},
		{72,113,"T« Cæ Ng©m","§¹i Tï ®éng",70},
		{72,114,"Hå NhÊt Lang","§¹i Tï ®éng",70},
		{72,115,"Hoµng V¹n KiÕp","§¹i Tï ®éng",70},
		{72,116,"Giang TrÇm Nh¹n","§¹i Tï ®éng",70},
		{76,117,"C¶nh Dung Phôc","S¬n B¶o ®éng",70},
		{76,118,"Kh­¬ng Tù Dao","S¬n B¶o ®éng",70},
		{76,119,"Khæng Dong Nh©n","S¬n B¶o ®éng",70},
		{76,120,"L¨ng TËn Trung","S¬n B¶o ®éng",70},
		{201,121,"DiÖp øc Anh","B¨ng Hµ ®éng",80},
		{201,122,"L¹c NhÜ Kim","B¨ng Hµ ®éng",80},
		{201,123,"M¹c Nam Tróc","B¨ng Hµ ®éng",80},
		{201,124,"TÇn Tö Du","B¨ng Hµ ®éng",80},
		{10,125,"C« V« Th­êng","Nh¹n Th¹ch ®éng",80},
		{10,126,"LiÔu Tø Gia","Nh¹n Th¹ch ®éng",80},
		{10,127,"Thi §¹i ThiÕu","Nh¹n Th¹ch ®éng",80},
		{10,128,"T«n V¨n B­u","Nh¹n Th¹ch ®éng",80},
		{202,129,"§ång BÊt Phôc","Phï Dung ®éng",80},
		{202,130,"§­êng B¸c V¨n","Phï Dung ®éng",80},
		{202,131,"§µo §¶o Chñ ","Phï Dung ®éng",80},
		{202,132,"§iÒn V« §¹o","Phï Dung ®éng",80},
		{181,133,"Viªn NiÖm TÞch","L­ìng Thñy ®éng",80},
		{181,134,"TrÞnh Tr¸c QuÇn","L­ìng Thñy ®éng",80},
		{181,135,"Ch­¬ng Nguyªn Sïng","L­ìng Thñy ®éng",80},
		{181,136,"T¹ Träng HËu","L­ìng Thñy ®éng",80},
		{143,137,"Vu Cöu  §å","d­îc v­¬ng ®éng tÇng 3",80},
		{143,138,"Viªn Thiªn Thä","d­îc v­¬ng ®éng tÇng 3",80},
		{143,139,"Nh¹c Th­îng C«n","d­îc v­¬ng ®éng tÇng 3",80},
		{143,140,"Chiªm Phóc V©n","d­îc v­¬ng ®éng tÇng 3",80},
		{93,141,"Cæ Giíi Nh©n","TiÕn Cóc ®éng",90},
		{93,142,"TrÞnh Cöu NhËt","TiÕn Cóc ®éng",90},
		{93,143,"Chu Së B¸","TiÕn Cóc ®éng",90},
		{93,144,"Trang Minh Trung","TiÕn Cóc ®éng",90},
		{225,145,"Cam ChÝnh C«","Sa M¹c 1",90},
		{225,146,"Vò NhÊt ThÕ","Sa M¹c 1",90},
		{225,147,"D­¬ng Phong DËt","Sa M¹c 1",90},
		{225,148,"Hµ Sinh Vong","Sa M¹c 1",90},
		{75,149,"T»ng ChØ O¸n","Kho¶ Lang ®éng",90},
		{75,150,"VÖ Biªn Thµnh","Kho¶ Lang ®éng",90},
		{75,151,"Cè Thñ §»ng","Kho¶ Lang ®éng",90},
		{75,152,"Ch­ C¸t Kinh Hång","Kho¶ Lang ®éng",90},
		{321,153,"Phan Ng¹t Nhan","Tr­êng B¹ch S¬n Nam",90},
		{321,154,"Liªn Kinh Th¸i","Tr­êng B¹ch S¬n Nam",90},
		{321,155,"B¶o TriÖt S¬n","Tr­êng B¹ch S¬n Nam",90},
		{321,156,"V¹n Hå Tinh","Tr­êng B¹ch S¬n Nam",90},
		{340,157,"Trö Thiªn MÉn","M¹c Cao QuËt",90},
		{340,158,"§o¹n L¨ng NguyÖt","M¹c Cao QuËt",90},
		{340,159,"T¶ DËt Danh","M¹c Cao QuËt",90},
		{340,160,"Nh©m Th­¬ng Khung","M¹c Cao QuËt",90},
	} 
	
ContentList = {
	"<#> NÕu ai cã ®ñ 160 s¸t thñ gi¶n trong tay th× giÊc méng trë thµnh ®Ö nhÊt s¸t thñ xem nh­ hoµn thµnh. Mçi ngµy chØ cÇn hoµn thµnh <color=yellow>"..SoLuongBossSatThuTrongNgay.."<color> nhiÖm vô lµ ®­îc. <enter>H·y tiÕp nhËn nhiÖm vô “th¸ch thøc thêi gian” ®Ó tr¶i nghiÖm søc m¹nh ®ång ®éi vµ kh¶ n¨ng s¸t thñ cña m×nh.",
	"<#> NhiÖm vô s¸t thñ cÊp 20/killer20",
	"<#> NhiÖm vô s¸t thñ cÊp 30/killer30",
	"<#> NhiÖm vô s¸t thñ cÊp 40/killer40",
	"<#> NhiÖm vô s¸t thñ cÊp 50/killer50",	--5
	"<#> NhiÖm vô s¸t thñ cÊp 60/killer60",
	"<#> NhiÖm vô s¸t thñ cÊp 70/killer70",
	"<#> NhiÖm vô s¸t thñ cÊp 80/killer80",
	"<#> NhiÖm vô s¸t thñ cÊp 90/killer90",
	"<#> Ta ®¸nh kh«ng muèn giÕt ng­êi ®©u, hñy bá nhiÖm vô./cancel",	--10
	"<#> M¸u ch¶y ®Çu r¬i, tèt nhÊt lµ ta nªn tr¸nh xa/no",
	"<#> Ng­¬i ®· hñy bá nhiÖm vô. Lµm s¸t thñ tr­íc tiªn ph¶i cã thñ ph¸p siªu phµm, hai lµ h¹ thñ v« t×nh, xem ra ng­¬i kh«ng thÝch hîp, kh«ng ®i còng kh«ng sao.",
	"<#> Ng­êi lÇn tr­íc ta nãi ng­¬i ®i h¹ thñ vÉn cßn sèng, h·y chøng minh thùc lùc cña m×nh tr­íc ®i ®·.",
	"<#> §¼ng cÊp cña ng­¬i kh«ng phï hîp, ph¶i giao ®Êu cïng víi ng­êi cã ®¼ng cÊp t­¬ng øng míi ®­îc.",
	"<#> §ãng/no",	--15
	"<#> §¼ng cÊp nh­ thÕ cã 20 s¸t thñ, tay mçi ng­êi ®Òu nhuèm ®Çy m¸u, ng­¬i muèn ®¸nh víi ng­êi nµo?",
	"<#> Hîp thµnh s¸t thñ gi¶n/compose",
	"<#> S¸t thñ gi¶n b¹n ®Ó kh«ng ®óng, viÖc quan s¸t vµ cÆp m¾t tinh t­êng lµ rÊt quan träng.",
	"<#> S¸t thñ lÖnh b¹n ®Ó qu¸ nhiÒu, s¸t thñ còng ph¶i cã nghÖ thuËt cña nã, kh«ng thÓ nµo mµ ngay c¶ sinh mÖnh cña b¶n th©n m×nh còng kh«ng biÕt.",
	"<#> S¸t thñ lÖnh b¹n ®Ó qu¸ Ýt, s¸t thñ còng ph¶i cã nghÖ thuËt cña nã, kh«ng thÓ nµo mµ ngay c¶ sinh mÖnh cña b¶n th©n m×nh còng kh«ng biÕt.",	--20
	"<#> Hîp l¹i mét lÇn n÷a/compose",
	"<#> B¹n ®· hîp thµnh mét<color=",
	"<#> Thuéc tÝnh<color> s¸t thñ gi¶n, s¸t thñ gi¶n lµ mét s¸t thñ phi phµm. B¹n cã thÓ dïng mét s¸t thñ cïng cÊp ®Ó so tµi víi s¸t thñ gi¶n, quy t¾c th¾ng thua ®­îc ¸p dông theo quy t¾c t­¬ng kh¾c cña ngò hµnh. ",
	"<#> Thö luyÖn s¸t thñ /annealofkiller",
	"<#> Tham gia khiªu chiÕn/want_playboat",	--25
	"<#> S¸t thñ luyÖn thøc tr­íc tiªn ph¶i b¾t ®Çu tõ viÖc tham gia khiªu chiÕn, ng­¬i d¸m tiÕp nhËn nhiÖm vô chø?",
	"<#> Liªn quan ®Õn khiªu chiÕn/aboutchallenge",
	"<#> Cø mçi giê hÖ thèng sÏ th«ng b¸o 1 lÇn. Thêi gian b¸o danh lµ 5 phót, thùc hiÖn chØ trong 30 phót. Mçi ng­êi chØ tèi ®a 2 lÇn/ngµy. Ph¶i ®o ®éi tr­ëng ®Õn b¸o danh. <enter>”NhiÖm vô th¸ch thøc thêi gian” gåm 2 khu vùc tham gia. S¬ cÊp: ng­êi ch¬i tõ cÊp 50 ®Õn 89, do ®éi tr­ëng mang 2 s¸t thñ gi¶n d­íi cÊp 90 (ngò hµnh bÊt kú) ®i b¸o danh. Cao cÊp: ng­êi ch¬i tõ cÊp 90, do ®éi tr­ëng mang 2 s¸t thñ gi¶n cÊp 90 (ngò hµnh bÊt kú) ®i b¸o danh. <enter>Néi trong thêi gian quy ®Þnh, nÕu v­ît qua hÕt 28 ¶i sÏ hoµn thµnh. Mçi ¶i phÇn th­ëng kinh nghiÖm sÏ kh¸c nhau. NÕu hoµn thµnh nhiÖm vô tr­íc thêi gian h¹n ®Þnh, phÇn th­ëng kinh nghiÖm sÏ cµng cao <enter>NÕu tr­íc thêi h¹n ®· hoµn thµnh, cã thÓ sÏ xuÊt hiÖn thªm 1 ¶i, trong ®ã cã nhiÒu phÇn th­ëng bÊt ngê (vËt phÈm ngÉu nhiªn, trang bÞ Hoµng Kim…). ChØ nh÷ng ®éi ®· v­ît 28 ¶i ®óng thêi gian quy ®Þnh míi cã tªn trong b¶ng xÕp h¹ng.",
	--"<#> NhiÖm vô \"Qu¸ quan tÇm b¶o\"/guoguan_xunbao",
	"<#> Ta ®Õn nhËn th­ëng/rank_award", --29
    "<#> Ta ®Õn xem xÕp h¹ng 5 ®éi cao nhÊt cña h«m nay./get_top5team",	
	"<#> V­ît ¶i §¬n S¬ CÊp/want_playboat_socap_dondau",    
	"<#> V­ît ¶i §¬n - C¸ Nh©n/want_playboat_caocap_dondau",
    "<#> V­ît ¶i Tæ §éi S¬ CÊp/want_playboat_socap_todoi",
    "<#> V­ît ¶i Tæ §éi/want_playboat_caocap_todoi", --34    
		  
}


killertabfile = new(KTabFile,"/settings/task/tollgate/killer/killer.txt","KILLER")

function main()
	UWorld1082 = nt_getTask(1082);
	local tbDialog = {ContentList[24],ContentList[17],ContentList[2],ContentList[3],ContentList[4],ContentList[5],ContentList[6],ContentList[7],ContentList[8],ContentList[9],ContentList[10],ContentList[15]};
	if (tbBirthday0905:IsActDate() == 1) then
		tinsert(tbDialog, 12, ContentList[29]);
	end
	Describe(DescLink_NieShiChen..ContentList[1], getn(tbDialog), unpack(tbDialog));
end

function annealofkiller()
--Thªm dßng kiÓm tra ®iÒu kiÖn tham gia khiªu chiÕn cña tæ ®éi - Modified by DinhHQ - 20110504
	--Describe(DescLink_NieShiChen..ContentList[26], 3, ContentList[25],ContentList[27],ContentList[11]);
	Describe(DescLink_NieShiChen..ContentList[26],4,ContentList[32],ContentList[34],ContentList[27],ContentList[11]);
end
--"<#> KiÓm tra ®iÒu kiÖn tæ ®éi/#tbCOT_Party:CheckCondition()"
function aboutchallenge()
	Describe(DescLink_NieShiChen..ContentList[28],1, ContentList[15]);
end

function killer20()
	if ( killerCoundTakedTask(20, 29) == 0) then
		return 0;
	end;
	showboss( 0 );
end

function killer30()
	if ( killerCoundTakedTask(30, 39) == 0) then
		return 0;
	end;
	showboss( 20 );
end

function killer40()
	if ( killerCoundTakedTask(40, 49) == 0) then
		return 0;
	end;
	showboss( 40 );
end

function killer50()
	if ( killerCoundTakedTask(50, 59) == 0) then
		return 0;
	end;
	showboss( 60 );
end

function killer60()
	if ( killerCoundTakedTask(60, 69) == 0) then
		return 0;
	end;
	showboss( 80 );
end

function killer70()
	if ( killerCoundTakedTask(70, 79) == 0) then
		return 0;
	end;
	showboss( 100 );
end

function killer80()
	if ( killerCoundTakedTask(80, 89) == 0) then
		return 0;
	end;
	showboss( 120 );
end

function killer90()
	if ( killerCoundTakedTask(90, 350) == 0) then
		return 0;
	end;
	showboss( 140 );
	tbLog:PlayerActionLog("TinhNangKey","NhanNhiemVuBossSatThu")
end

function cancel()
	if (nt_getTask(1082) == 0) then
		Talk(1, "", "Ng­¬i ch­a nhËn nhiÖm vô, kh«ng thÓ hñy bá!")
	return end
	nt_setTask(1082, 0);
	Describe(DescLink_NieShiChen..ContentList[12], 1,ContentList[15]);
end

function havetask()
	if ( UWorld1082 ~= 0 ) then
		local tbSay = {}
		thongbao = DescLink_NieShiChen.." S¸t thñ "..tab_ToaDoBossST[UWorld1082][3].." vÉn cßn sèng, ng­¬i cßn ch­a tiªu diÖt ®­îc h¾n."
		if (tab_ToaDoBossST[UWorld1082][3] == "Cæ Giíi Nh©n") then
		tinsert(tbSay,"H·y §Õn DiÖt Cæ Giíi Nh©n/#TimNhanhBossST(1)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "TrÞnh Cöu NhËt") then
		tinsert(tbSay,"H·y §Õn DiÖt TrÞnh Cöu NhËt/#TimNhanhBossST(2)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Chu Së B¸") then
		tinsert(tbSay,"H·y §Õn DiÖt Chu Së B¸/#TimNhanhBossST(3)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Trang Minh Trung") then
		tinsert(tbSay,"H·y §Õn DiÖt Trang Minh Trung/#TimNhanhBossST(4)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Cam ChÝnh C«") then
		tinsert(tbSay,"H·y §Õn DiÖt Cam ChÝnh C«/#TimNhanhBossST(5)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Vò NhÊt ThÕ") then
		tinsert(tbSay,"H·y §Õn DiÖt Vò NhÊt ThÕ/#TimNhanhBossST(6)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "D­¬ng Phong DËt") then
		tinsert(tbSay,"H·y §Õn DiÖt D­¬ng Phong DËt/#TimNhanhBossST(7)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Hµ Sinh Vong") then
		tinsert(tbSay,"H·y §Õn DiÖt Hµ Sinh Vong/#TimNhanhBossST(8)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "T»ng ChØ O¸n") then
		tinsert(tbSay,"H·y §Õn DiÖt T»ng ChØ O¸n/#TimNhanhBossST(9)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "VÖ Biªn Thµnh") then
		tinsert(tbSay,"H·y §Õn DiÖt VÖ Biªn Thµnh/#TimNhanhBossST(10)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Cè Thñ §»ng") then
		tinsert(tbSay,"H·y §Õn DiÖt Cè Thñ §»ng/#TimNhanhBossST(11)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Ch­ C¸t Kinh Hång") then
		tinsert(tbSay,"H·y §Õn DiÖt Ch­ C¸t Kinh Hång/#TimNhanhBossST(12)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Phan Ng¹t Nhan") then
		tinsert(tbSay,"H·y §Õn DiÖt Phan Ng¹t Nhan/#TimNhanhBossST(13)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Liªn Kinh Th¸i") then
		tinsert(tbSay,"H·y §Õn DiÖt Liªn Kinh Th¸i/#TimNhanhBossST(14)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "B¶o TriÖt S¬n") then
		tinsert(tbSay,"H·y §Õn DiÖt B¶o TriÖt S¬n/#TimNhanhBossST(15)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "V¹n Hå Tinh") then
		tinsert(tbSay,"H·y §Õn DiÖt V¹n Hå Tinh/#TimNhanhBossST(16)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Trö Thiªn MÉn") then
		tinsert(tbSay,"H·y §Õn DiÖt Trö Thiªn MÉn/#TimNhanhBossST(17)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "§o¹n L¨ng NguyÖt") then
		tinsert(tbSay,"H·y §Õn DiÖt §o¹n L¨ng NguyÖt/#TimNhanhBossST(18)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "T¶ DËt Danh") then
		tinsert(tbSay,"H·y §Õn DiÖt T¶ DËt Danh/#TimNhanhBossST(19)")
		end
		if (tab_ToaDoBossST[UWorld1082][3] == "Nh©m Th­¬ng Khung") then
		tinsert(tbSay,"H·y §Õn DiÖt Nh©m Th­¬ng Khung/#TimNhanhBossST(20)")
		end					
		tinsert(tbSay,"Th«i ta kh«ng muèn ®i./no")
		Say(""..thongbao.."", getn(tbSay), tbSay)
		-- Describe(DescLink_NieShiChen..ContentList[13], 1,ContentList[15]);
		return 0
	end
	return 1
end

function TimNhanhBossST(TD)
	if (TD == 1) then
		NewWorld(93,1644,3279)
		SetFightState(1);
	elseif (TD == 2) then
		NewWorld(93,1646,3058)
		SetFightState(1);
	elseif (TD == 3) then
		NewWorld(93,1736,3213)
		SetFightState(1);
	elseif (TD == 4) then
		NewWorld(93,1610,3152)
		SetFightState(1);
	elseif (TD == 5) then
		NewWorld(225,1590,3325)
		SetFightState(1);
	elseif (TD == 6) then
		NewWorld(225,1261,3247)
		SetFightState(1);
	elseif (TD == 7) then
		NewWorld(225,1452,3377)
		SetFightState(1);
	elseif (TD == 8) then
		NewWorld(225,1425,3107)
		SetFightState(1);
	elseif (TD == 9) then
		NewWorld(75,1711,3187)
		SetFightState(1);
	elseif (TD == 10) then
		NewWorld(75,1752,3124)
		SetFightState(1);
	elseif (TD == 11) then
		NewWorld(75,1831,3190)
		SetFightState(1);
	elseif (TD == 12) then
		NewWorld(75,1639,3159)
		SetFightState(1);
	elseif (TD == 13) then
		NewWorld(321,1253,3002)
		SetFightState(1);
	elseif (TD == 14) then
		NewWorld(321,1483,2742)
		SetFightState(1);
	elseif (TD == 15) then
		NewWorld(321,1289,2613)
		SetFightState(1);
	elseif (TD == 16) then
		NewWorld(321,1113,2569)
		SetFightState(1);
	elseif (TD == 17) then
		NewWorld(340,1217,2740)
		SetFightState(1);
	elseif (TD == 18) then
		NewWorld(340,1723,2765)
		SetFightState(1);
	elseif (TD == 19) then
		NewWorld(340,1275,2749)
		SetFightState(1);
	elseif (TD == 20) then
		NewWorld(340,1932,2759)
		SetFightState(1);
	end
end 

function showboss(row)
	Describe(DescLink_NieShiChen..ContentList[16], 12, killertabfile:getCell("BossName",row+1).."/#givetask("..(row+1)..")", killertabfile:getCell("BossName",row+2).."/#givetask("..(row+2)..")", killertabfile:getCell("BossName",row+3).."/#givetask("..(row+3)..")", killertabfile:getCell("BossName",row+4).."/#givetask("..(row+4)..")", killertabfile:getCell("BossName",row+5).."/#givetask("..(row+5)..")", killertabfile:getCell("BossName",row+6).."/#givetask("..(row+6)..")", killertabfile:getCell("BossName",row+7).."/#givetask("..(row+7)..")", killertabfile:getCell("BossName",row+8).."/#givetask("..(row+8)..")", killertabfile:getCell("BossName",row+9).."/#givetask("..(row+9)..")", killertabfile:getCell("BossName",row+10).."/#givetask("..(row+10)..")", "Trang kÕ /#showbossnext("..row..")", ContentList[15]);
end

function showbossnext(row)
	Describe(DescLink_NieShiChen..ContentList[16], 12, killertabfile:getCell("BossName",row+11).."/#givetask("..(row+11)..")", killertabfile:getCell("BossName",row+12).."/#givetask("..(row+12)..")", killertabfile:getCell("BossName",row+13).."/#givetask("..(row+13)..")", killertabfile:getCell("BossName",row+14).."/#givetask("..(row+14)..")", killertabfile:getCell("BossName",row+15).."/#givetask("..(row+15)..")", killertabfile:getCell("BossName",row+16).."/#givetask("..(row+16)..")", killertabfile:getCell("BossName",row+17).."/#givetask("..(row+17)..")", killertabfile:getCell("BossName",row+18).."/#givetask("..(row+18)..")", killertabfile:getCell("BossName",row+19).."/#givetask("..(row+19)..")", killertabfile:getCell("BossName",row+20).."/#givetask("..(row+20)..")", "Trang tr­íc/#showboss("..row..")", ContentList[15]);
end

function givetask(taskid)
	nt_setTask(1082,taskid);
	if TuDichChuyen == 1 then
		Talk(1, "#Bil_Go2BossPos("..taskid..")", DescLink_NieShiChen.." <color=yellow>"..killertabfile:getCell("BossName",taskid).."<color> "..killertabfile:getCell("BossInfo",taskid))
	else
		Talk(1, "", DescLink_NieShiChen.." <color=yellow>"..killertabfile:getCell("BossName",taskid).."<color> "..killertabfile:getCell("BossInfo",taskid))
	end
end

function Bil_Go2BossPos(taskid)
	local Bil_PosW = tonumber(killertabfile:getCell("BilBossPosW",taskid))
	local Bil_PosX = tonumber(killertabfile:getCell("BilBossPosX",taskid))
	local Bil_PosY = tonumber(killertabfile:getCell("BilBossPosY",taskid))

	if not Bil_PosW or not Bil_PosX or not Bil_PosY then
		Msg2Player("Lçi: Kh«ng ®äc ®­îc d÷ liÖu trong file killer.txt!")
		return
	end	
	local BilProcessX = Bil_PosX * 8
	local BilProcessY = Bil_PosY * 16
	local Bil_ChNW = NewWorld(Bil_PosW, BilProcessX, BilProcessY)
	
	if Bil_ChNW == 0 or Bil_ChNW == nil then
		Msg2Player("Lçi Map:"..Bil_PosW.." X:"..BilProcessX.." Y:"..BilProcessY)
	else
		SetFightState(1)		
	end
end

function compose()
	GiveItemUI("Giao diÖn hîp thµnh s¸t thñ gi¶n","5 s¸t thñ lÖnh cïng ®¼ng cÊp sÏ hîp thµnh 1 s¸t thñ gi¶n cÊp t­¬ng øng, thuéc tÝnh cña s¸t thñ gi¶n ®­îc t¹o thµnh cã liªn quan ®Õn thuéc tÝnh cña 5 s¸t thñ lÖnh. B¹n cã thÓ dïng s¸t thñ gi¶n cña m×nh ®Ó so tµi víi s¸t thñ gi¶n ®ång cÊp cña ng­êi kh¸c, quy t¾c th¾ng thua ®­îc tÝnh theo quy t¾c t­¬ng kh¾c cña ngò hµnh.","exchange_token", "no")
end

function exchange_token(ncount)
	local scrollidx = {}
	local scrollattr = {}
	local y = 0
	local compare_level = 0
	for i=1, ncount do
		local nItemIdx = GetGiveItemUnit(i);
		itemgenre, detailtype, parttype, level, attribute = GetItemProp(nItemIdx)
		if (itemgenre == 6 and detailtype == 1 and parttype == 399  ) then	
			if( y > 0 ) then
				if( level ~= compare_level ) then
					Describe(DescLink_NieShiChen..ContentList[18], 2, ContentList[21], ContentList[15]);
					return
				end
			end
			y = y + 1;
			scrollidx[y] = nItemIdx;
			scrollattr[y] = attribute;
			compare_level = level;
		end
	end
	if( y ~= ncount) then
		Describe(DescLink_NieShiChen..ContentList[18], 2, ContentList[21], ContentList[15]);
		return
	end
	if( y > 5 ) then
		Describe(DescLink_NieShiChen..ContentList[19], 2, ContentList[21], ContentList[15]);
		return
	end
	if( y < 5 ) then
		Describe(DescLink_NieShiChen..ContentList[20], 2, ContentList[21], ContentList[15]);
		return
	end
	if( y == 5 ) then
		for i = 1, y do
			RemoveItemByIndex(scrollidx[i]);
		end
		givesword(scrollattr,compare_level);
	end
end

function givesword(attr,level)
	series = {"metal>Kim", "wood>Méc", "water>Thñy", "fire>Háa", "earth>Thæ "};
	i = random( 1, 5 );
	AddItem( 6, 1, 400, level, attr[i], 0);
	j = attr[i] + 1;
	Describe(DescLink_NieShiChen..ContentList[22]..series[j]..ContentList[23], 1, ContentList[15]);
end

function no()
end

--Ã¿Ìì½ÓÈÎÎñµÄÏÞÖÆ
function killerCoundTakedTask(nLowLevel, nHighLevel)
	if ( havetask() == 0) then
		return 0;
	end;
	local myLevel = GetLevel();
	if( myLevel < nLowLevel or myLevel >  nHighLevel) then
		Describe(DescLink_NieShiChen..ContentList[14], 1,ContentList[15]);
		return 0;
	end;
	local nDate = tonumber(GetLocalDate("%y%m%d"));
	local myDate = nt_getTask(TSKID_KILLERDATE);
	if (myDate == nDate and nt_getTask(TSKID_KILLERMAXCOUNT) >= SoLuongBossSatThuTrongNgay) then
		Describe(DescLink_NieShiChen.."S¸t thñ cã mét tè chÊt rÊt quan träng gäi lµ khinh kÎ b¹i trËn. H«m nay ng­¬i ®· h¹ gôc "..SoLuongBossSatThuTrongNgay.." tªn s¸t thñ råi, ngµy mai h·y quay l¹i.", 1, ContentList[15]);
		return 0;
	elseif (myDate ~= nDate) then
		nt_setTask(TSKID_KILLERMAXCOUNT, 0);
		nt_setTask(TSKID_KILLERDATE, nDate);
	end;
	return 1;
end;
