Include("\\script\\dailogsys\\dailogsay.lua");
IncludeLib("SETTING") 
IncludeLib("FILESYS"); 
--Include("\\script\\global\\vinh\\items\\nvhoangkim.lua")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\task\\newtask\\newtask_head.lua"); 
function diadovolam()
dofile("script/global/general/thunghiem/diadovolam.lua")
	local Talk = "CÈm nang ®Æc biÖt gióp dÞch chuyÓn nhanh c¸c ®Þa ®iÓm lµm nhiÖm vô.\nHoµn thµnh nhiÖm vô, ng­¬i sÏ nhËn ®­îc nh÷ng phÇn th­ëng xøng ®¸ng."
	local tb = {
	"Hç trî lµm nhiÖm vô M«n ph¸i nhanh/nvmonphai",
	"Hç trî lµm nhiÖm vô Th«n trÊn nhanh/nvthontran",
	"Hç trî lµm nhiÖm vô Hoµng kim nhanh/helpgoldquest",
	"Reset Chuçi NhiÖm vô Hoµng Kim/GQ_RS",
	"Tho¸t./Quit",
	}
	Say(Talk,getn(tb),tb)
return 1
end
-----------------------------------NV Th«n TrÊn-----------------------------------------------
tb_HelpThonTran = {
	[1] = {--Ba L¨ng HuyÖn 
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>Thuèc cho cha <color><color=red>TiÓu Ng­.<color> <enter>PhÇn th­ëng cho b¹n: Mét <color=green>®«i giµy<color> vµ <color=red>5 ®iÓm<color> danh väng.<enter> - §Õn <color=red> §«ng M«n - Ba L¨ng HuyÖn<color> t×m <color=red>TiÓu Ng­ (204/200)<color> tiÕp nhËn nhiÖm vô.<enter> - §Õn phÝa nam <color=red>Qu¶ng Tr­êng trung ­¬ng<color> t×m <color=red>Ng« ThÇn y (199/200)<color>. <color=red>Ng« ThÇn y<color> cho biÕt thuèc nµy ®· b¸n hÕt cho <color=red>Thiªn V­¬ng T­íng lÜnh.<color><enter> - B¹n lËp tøc ®uæi theo <color=red>Thiªn V­¬ng T­íng lÜnh (201/199)<color>, sau khi ®èi tho¹i b¹n sÏ ®­îc tÆng mét viªn <color=red>T× Bµ hoµn.<color><enter> - Mang thuèc vÒ cho <color=red>TiÓu Ng­.<color> Hoµn thµnh nhiÖm vô."},
			--Tu dong thu [2], khong nen de (202/201) toa do, vi no khong hien
			--so 0 la FightState - trang thai chien dau ko co, neu bang 1 thi dang o trang thai chien dau, 
			-- 1 la type Move luon la 1
			--162 Map Id
			-- Toa do
			-- neu 2 npc nv o gan ben thi de so 1 hoac 0, so 1 cuoi la neu la 1 thi se thuc hien newworld, con 0 la thong bao di ngua khi 2 npc gan nhau
			-- code go^'c co them 1 tham so [tham so nay giong tham so dau tien nhung co them toa do(204/201) de thong bao khi lam xong
			-- code go^'c co them 1 vai tham so khac nua
			[2] = {"GÆp TiÓu Ng­ tiÕp nhËn nhiÖm vô.",0,1,53,1632,3216},
			[3] = {"T×m Ng« ThÇn y.",0,1,53,1600,3200},
			[4] = {"§uæi theo Thiªn V­¬ng T­íng lÜnh",0,1,53,1608,3212},
			[5] = {"Mang thuèc vÒ cho TiÓu Ng­. Hoµn thµnh nhiÖm vô.",0,1,53,1632,3216},
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>Håi m«n cña A Ph­¬ng<color>. <enter>PhÇn th­ëng cho b¹n: Mét <color=green>chiÕc mò<color> vµ <color=red>6 ®iÓm<color> danh väng. <enter> - T×m gÆp <color=red>A Ph­¬ng (202/203)<color>, nhËn lêi ®i mua gióp c« ta mét <color=green>®«i b«ng tai<color> lµm cña håi m«n.<enter> - §i vÒ phÝa T©y t×m <color=red>ThÈm Cöu (188/198)<color> bá <color=yellow><color=yellow>200 l­îng<color><color> mua ®­îc mét <color=green>®«i b«ng tai.<color><enter> - Mang vÒ cho <color=red>A Ph­¬ng<color>. Hoµn thµnh nhiÖm vô."},
			[2] = {"T×m gÆp A Ph­¬ng.",0,1,53,1616,3248},
			[3] = {"T×m ThÈm Cöu mua mét ®«i b«ng tai.",0,1,53,1504,3168},
			[4] = {"VÒ chç A Ph­¬ng. Hoµn thµnh nhiÖm vô",0,1,53,1616,3248}			
		},
		[3] = {
			[1] = {"NhiÖm vô thø 3: <color=green>Con trai cña Cæ L·o Th¸i<color> <enter>PhÇn th­ëng cho b¹n: B¹n l¹i cã thªm <color=yellow>tiÒn<color> vµ <color=red>®iÓm danh väng<color> ®Ó ®i du ngo¹n giang hå råi!<enter> - §Õn gÆp <color=red>Cæ L·o Th¸i (204/202).<color> - ¤ng ta cho b¹n biÕt con trai cña m×nh ®i ®¸nh c¸ suèt ba ngµy nay kh«ng thÊy vÒ! Nhê b¹n ®i t×m gióp nã vÒ.<enter> - B¹n h·y ®i vÒ <color=red>h­íng §«ng B¾c<color>, ®Õn <color=red>§éng §×nh hå.<color> - B¹n kh«ng t×m thÊy con trai cña <color=red>Cæ gia<color> nh­ng l¹i nh×n thÊy mét <color=green>miÕng Ngäc Béi<color> <color=red>(225/188).<color><enter> - Mang miÕng <color=green>Ngäc Béi<color> vÒ cho <color=red>Cæ L·o Th¸i.<color> - ¤ng ta v« cïng ®au xãt. Sau mét håi khãc th­¬ng, «ng ta tÆng cho b¹n mét bøc tranh gäi lµ t¹ ¬n gióp ®ì. Hoµn thµnh nhiÖm vô vµ nhËn ®­îc <color=red>®iÓm danh väng.<color><enter> - B¹n cã nhí lµ lóc ®i ®Õn <color=red>§éng §×nh hå<color> ®· gÆp qua mét <color=red>Du kh¸ch (224/192)<color> kh«ng? <enter> - H·y trë l¹i ®ã ®Ó gÆp «ng Êy. Sau håi l©u ®èi tho¹i «ng ta sÏ mua bøc tranh nµy víi gi¸ <color=yellow>1000 l­îng<color> hoÆc h¬n. <enter> - "},			
			[2] = {"GÆp Cæ L·o Th¸i.",0,1,53,1636,3216},
			[3] = {"§i §éng §×nh Hé t×m ngäc béi.",0,1,53,1800,3008},
			[4] = {"Quay l¹i gÆp Cæ L·o, hoµn thµnh nhiÖm vô",0,1,53,1636,3216},
			[5] = {"B¸n bøc tranh cho du kh¸ch",0,1,53,1792,3088},
		},
	},
	[2] = {--Giang T©n Th«n
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>Hæ Tö b¸i s­<color><enter>PhÇn th­ëng cho b¹n: Mét <color=green>chiÕc mò<color> vµ <color=red>5 ®iÓm<color> danh väng. <enter>§Õn gÆp <color=red>Phô Th©n Hæ Tö (426/388).<color> - NhËn lêi ®i t×m gióp mét <color=red>Vâ s­<color> cho con cña «ng ta.<enter> - T×m thÊy <color=red>Vâ s­ (454/391),<color> «ng ta ®ång ý d¹y vâ cho <color=red>Hæ tö.<color><enter> - Quay trë l¹i gÆp <color=red>Phô Th©n Hæ Tö<color> b¸o tin <color=red>Vâ s­<color> ®· ®ång ý d¹y vâ cho <color=red>Hæ Tö<color> . Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp phô th©n TiÓu Hæ",0,1,20,3416,6208},
			[3] = {"T×m Vâ s­",1,1,20,3632,6256},
			[4] = {"GÆp l¹i phô th©n TiÓu Hæ. Hoµn thµnh nhiÖm vô",0,1,20,3416,6208},			
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>Thuèc cho Ng« L·o gia<color><enter>PhÇn th­ëng cho b¹n: Mét <color=green>®«i giµy<color> vµ <color=red>6 ®iÓm<color> danh väng.<enter> - §Õn gÆp <color=red>Ng« L·o gia (438/388).<color> NhËn lêi gióp «ng ta ®i mua thuèc. <enter> - §Õn <color=red>D­îc §iÕm (433/385)<color> bá ra <color=yellow>200 l­¬ng<color> mua <color=red>10 viªn Xuyªn Bèi hoµn.<color><enter> - Mang <color=red>10 viªn thuèc<color> vÒ cho <color=red>Ng« L·o gia<color>. ¤ng ta c¶m ¬n vµ nh¾n b¹n ®Õn gÆp <color=red>Ng« Hång Mai<color> nhËn phÇn th­ëng.<enter> - §Õn gÆp <color=red>Ng« Hång Mai (435/384)<color> nhËn phÇn th­ëng. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Ng« L·o gia",0,1,20,3504,6224},
			[3] = {"§Õn D­îc ®iÕm",0,1,20,3472,6160},
			[4] = {"GÆp l¹i Ng« L·o gia",0,1,20,3504,6224},			
			[5] = {"GÆp Ng« Hång Mai",0,1,20,3488,6144},				
		},
		[3] = {
			[1] = {"NhiÖm vô thø 3: <color=green>C©y n¸ cña Hæ Tö.<color><enter>PhÇn th­ëng cho b¹n: Mét mãn <color=green>binh khÝ<color> vµ <color=red>8 ®iÓm<color> danh väng.<enter> - §Õn gÆp <color=red>Hæ Tö (466/387)<color> nhËn lêi ®i lÊy gióp Hæ Tö giµn n¸.<enter> - §Õn chç <color=red>thî rÌn (429/388).<color> ¤ng ta nhê b¹n ®i t×m nguyªn liÖu lµm n¸.<enter> - B¹n ®i ra b×a rõng t×m mét <color=red>ch¹c ba (433/389)<color> vµ mét miÕng <color=red>da tr©u (466/395), (455/380).<color><enter> - Sau khi t×m ®­îc mang vÒ cho thî rÌn, ®îi mét chót b¹n sÏ cã ®­îc chiÕc n¸.<enter> - Mang n¸ vÒ cho Hæ Tö. Hoµn thµnh nhiÖm vô"},
			[2] = {"§Õn gÆp Hæ Tö",0,1,20,3570,6195},
			[3] = {"§Õn Thî rÌn",0,1,20,3435,6221},
			[4] = {"T×m ch¹c ba",1,1,20,3464,6245},
			[5] = {"T×m da tr©u",1,1,20,3725,6342},
			[6] = {"Mang vÒ Thî rÌn",0,1,20,3435,6221},
			[7] = {"Mang n¸ vÒ Hæ Tö. Hoµn thµnh nhiÖm vô",0,1,20,3570,6195},
			
		},

	},
	[3] = {--VÜnh L¹c TrÊn
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>§æi s¸ch<color><enter>PhÇn th­ëng cho b¹n: Mét c¸i <color=green>th¾t l­ng<color> vµ <color=red>5 ®iÓm<color> danh väng.<enter> - §Õn chç <color=red>Lç Gia (211/200)<color> biÕt «ng nµy lµ ng­êi thÝch ®äc s¸ch... nhËn nhiÖm vô trao ®æi s¸ch.<enter> - §i vÒ <color=red>phÝa Nam<color> t×m <color=red>C¸t Gia (207/207)<color>. ¤ng nµy biÕt râ ý ®å cña <color=red>Lç Gia<color> nªn yªu cÇu <color=yellow>®æi s¸ch<color><enter> - Quay l¹i gÆp <color=red>Lç Gia<color> , ®èi tho¹i....<enter> - Mang <color=red>quyÓn s¸ch Di Kiªn ChÝ<color> cña <color=red>Lç Gia<color> ®Õn cho <color=red>C¸t Gia<color>, ®èi tho¹i.<enter> - Mang <color=red>quyÓn s¸ch Kª ThÇn Lôc<color> cña <color=red>C¸t Gia<color> vÒ cho <color=red>Lç Gia<color>. Hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn chç Lç Gia",0,1,99,1689,3201},
			[3] = {"§i vÒ phÝa Nam t×m C¸t Gia",0,1,99,1664,3312},
			[4] = {"Quay l¹i gÆp Lç Gia",0,1,99,1689,3201},						
			[5] = {"Mang quyÓn s¸ch “Di Kiªn ChÝ” cña Lç Gia ®Õn cho C¸t Gia",0,1,99,1664,3312},
			[6] = {"Mang quyÓn s¸ch “Kª ThÇn Lôc“ cña C¸t Gia vÒ cho Lç Gia. Hoµn thµnh nhiÖm vô.",0,1,99,1689,3201},
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>Ng­u Ng­u muèn lµm ®¹i hiÖp<color><enter>PhÇn th­ëng cho b¹n: <color=green>Thuèc trÞ th­¬ng<color> vµ <color=red>6 ®iÓm<color> danh väng. <enter> - GÆp mÑ cña <color=red>Ng­u Ng­u (201/200)<color>, ®èi tho¹i...<enter> - §i t×m <color=red>Ng­u Ng­u (206/195)<color> (PhÝa sau Qu¶ng tr­êng lín) <enter> - B¹n h·y lùa chän 1 quyÕt ®Þnh : <color=blue>Khuyªn hay m¾ng nã<color><enter> - Cho dï b¹n chän lùa chän nµo còng Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Ng­u TÈu",0,1,99,1602,3248},
			[3] = {"T×m Ng­u Ng­u. Khuyªn hoÆc m¾ng. Hoµn thµnh nhiÖm vô",0,1,99,1648,3136},
			
		},
		[3] = {
			[1] = {"NhiÖm vô thø 3: <color=green>ChuyÓn qu¹t trao t×nh<color><enter>PhÇn th­ëng cho b¹n: <color=green>Mét chiÕc nhÉn<color> vµ <color=red>7 ®iÓm<color> danh väng.<enter> - B¹n h·y ®i ®Õn mét bê hå, gÆp <color=red>Lý Dù (195/203)<color>. NhËn nhiÖm vô chuyÓn qu¹t ®Õn cho <color=red>Xu©n H­¬ng<color>.<enter> - GÆp <color=red>Xu©n H­¬ng (210/205)<color>. Giao qu¹t cho c« ta. C« ta ra mét ®Ò thi.<enter> - Trë l¹i gÆp <color=red>Lý Dù.<color> TruyÒn ®¹t l¹i ®Ò thi cña <color=red>Xu©n H­¬ng<color>. Nh­ng h¾n ta l¹i kh«ng biÕt ®¸p ¸n, thÕ lµ l¹i ph¶i nhê tµi n¨ng cña b¹n th«i.<enter> - L¹i ®i ®Õn chç <color=red>Xu©n H­¬ng <color>(<color=red>Xu©n H­¬ng<color> sÏ ra mét c©u ®è vµ b¹n chØ viÖc chän c©u thø 3). ThÕ lµ c« Êy ®ång ý. Hoµn thµnh nhiÖm vô"},
			[2] = {"GÆp Lý Dù nhËn nhiÖm vô",0,1,99,1560,3248},
			[3] = {"GÆp Xu©n H­¬ng",0,1,99,1680,3280},
			[4] = {"Trë l¹i gÆp Lý Dù.",0,1,99,1560,3248},			
			[5] = {"L¹i ®i ®Õn chç Xu©n H­¬ng 1",0,1,99,1680,3280},				
			
		},
	},
	[4] = {--Chu Tiªn TrÊn
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>Khuyªn L·o Chu vÒ nhµ<color><enter>PhÇn th­ëng cho b¹n: <color=green>3 lä m¸u nhá<color> vµ <color=red>5 ®iÓm<color> danh väng.<enter> - GÆp <color=red>Chu TÈu (216/197)<color> NhËn lêi gióp bµ Êy khuyªn <color=red>l·o Chu<color> vÒ nhµ.<enter> - §Õn <color=red>Töu ®iÕm, gÆp l·o Chu (210/202).<color> B¹n khuyªn «ng ta vÒ nhµ!<enter> - Sau håi l©u thuyÕt phôc, «ng Êy ®· tØnh ngé, c¶m ¬n b¹n. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Chu TÈu ®èi tho¹i",0,1,100,1728,3152},
			[3] = {"§Õn Töu ®iÕm, gÆp l·o Chu khuyªn l·o vÒ nhµ. Hoµn thµnh nhiÖm vô.",0,1,100,1680,3232},
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>Kh¨n uyªn ­¬ng<color><enter>PhÇn th­ëng cho b¹n: b¹n nhËn ®­îc <color=green>1 ®«i giµy<color> vµ <color=red>5 ®iÓm<color> danh väng.<enter>GÆp <color=red>Doanh Doanh (217/197).<color> NhËn lêi gióp c« ta chuyÓn <color=green>kh¨n t×nh<color> ®Õn cho <color=red>Tr­¬ng §¹i Nguyªn.<color><enter> - B¹n ®i ®Õn gÇn mét chiÕc cÇu, gÆp <color=red>Tr­¬ng §¹i Nguyªn (211/199)<color> ®ang ®øng víi mét c« g¸i, b¹n <color=green>trao kh¨n<color> vµ chuyÓn lêi cña <color=red>Doanh Doanh<color>.<enter> - <color=red>Tr­¬ng §¹i Nguyªn<color> th¼ng thõng tõ chèi vµ cho r»ng b¹n dùng chuyÖn vu c¸o h¾n.<enter> - B¹n quay l¹i gÆp <color=red>Doanh Doanh<color>, th«ng b¸o l¹i víi c« Êy. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Doanh Doanh",0,1,100,1728,3152},
			[3] = {"GÆp Tr­¬ng §¹i Nguyªn",0,1,100,1688,3184},
			[4] = {"Quay l¹i gÆp Doanh Doanh, th«ng b¸o l¹i víi c« Êy. Hoµn thµnh nhiÖm vô.",0,1,100,1736,3152},
		},
		[3] = {  
			[1] = {"NhiÖm vô thø 3: <color=green>ChiÕc vßng cña Song Song<color><enter>PhÇn th­ëng cho b¹n: <color=yellow>200 l­îng<color> b¹c vµ <color=red>9 ®iÓm<color> danh väng.<enter> - Khi <color=red>Song Song<color> tÆng b¹n <color=yellow>200 l­îng<color>, b¹n h·y tõ chèi vµ Ên <color=red>F4<color> xem b¹n nhËn ®­îc c¸i g×.<enter> - B¹n nh×n thÊy <color=red>Song Song (214/196) (gÇn chç Chu tÈu)<color> cø liªn tôc ®i ®i l¹i l¹i, liÒn tiÕn ®Õn hái. Th× ra c« ta lµm r¬i mÊt mét <color=green>chiÕc NhÉn<color>. NhËn lêi gióp <color=red>Song Song<color> ®i t×m <color=green>chiÕc NhÉn.<color> <enter> - B¹n ®i hái <color=red>TiÓu Hïng (206/201)<color>. <color=red>TiÓu Hïng<color> cho biÕt <color=green>chiÕc NhÉn<color> ®ã hiÖn ®ang ë trong tay cña mét <color=red>ng­êi ¨n mµy<color>.<enter> - B¹n ®i t×m <color=red>ng­êi ¨n mµy (206/197)<color>. H¾n muèn ®æi <color=green>chiÕc NhÉn<color> ®ã b»ng mét phÇn <color=red>“§Ëu Phô Ngò H­¬ng”<color>.<enter> - §Õn <color=red>Töu ®iÕm (chç l·o Chu)<color> gÆp <color=red>¤ng chñ töu ®iÕm (211/201)<color> bá <color=yellow>100 l­îng<color> mua ®­îc <color=green>§Ëu Phô Ngò H­¬ng<color>.<enter> - Mang <color=green>®Ëu hò<color> vÒ cho <color=red>tªn ¨n mµy<color>, ®æi lÊy chiÕc <color=green>NhÉn<color>.<enter> - Mang chiÕc <color=green>NhÉn<color> vÒ cho <color=red>Song Song<color>. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Song Song",0,1,100,1712,3136},
			[3] = {"§i hái TiÓu Hïng",0,1,100,1648,3216},
			[4] = {"§i t×m ng­êi ¨n mµy",0,1,100,1648,3152},
			[5] = {"§Õn Töu ®iÕm (chç l·o Chu) gÆp ¤ng chñ töu ®iÕm mua hµng",0,1,100,1688,3216},
			[6] = {"Mang ®Ëu hò vÒ cho tªn ¨n mµy, ®æi lÊy chiÕc NhÉn.",0,1,100,1648,3152},
			[7] = {"Mang chiÕc NhÉn vÒ cho Song Song. Hoµn thµnh nhiÖm vô",0,1,100,1712,3136},
		},
	},
	[5] = {--§¹o H­¬ng Th«n 
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>§i t×m TiÓu Long<color><enter>PhÇn th­ëng cho b¹n: Mét <color=green>sîi d©y th¾t l­ng<color> vµ <color=red>5 ®iÓm<color> danh väng.<enter> - B¹n gÆp <color=red>Hoa Hoa (213/203)<color> nhËn lêi gióp c« ta ®i t×m <color=red>TiÓu Long.<color><enter> - T×m thÊy <color=red>TiÓu Long (215/196)<color> ®ang ®øng nÊp sau mét gèc c©y, ®èi tho¹i míi biÕt th× ra cËu ta lµm r¬i mÊt tiÒn nªn kh«ng d¸m vÒ nhµ.<enter> - B¹n tÆng cho <color=red>TiÓu Long<color> <color=yellow>10 l­îng b¹c<color>, khuyªn nã ®i vÒ nhµ. Hoµn thµnh nhiÖm vô."},
			[2] = {"§i gÆp Hoa Hoa",0,1,101,1704,3248},
			[3] = {"T×m thÊy TiÓu Long, khuyªn nã vÒ nhµ. Hoµn thµnh nhiÖm vô",0,1,101,1552,3216},
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>T« Trung b¸o quèc<color><enter>PhÇn th­ëng cho b¹n: B¹n ®­îc tÆng <color=green>3 b×nh Kim S¸ng d­îc<color> vµ <color=red>4 ®iÓm<color> danh väng.<enter> - GÆp <color=red>T« §¹i Ma (200/196)<color> ®ang ®øng bªn ®­êng. Bµ ta rÊt lo l¾ng cho con cña bµ ta, b¹n t×nh nguyÖn ®i t×m hái gióp bµ ta.<enter> - §i t×m <color=red>T« Trung (215/196).<color> Th× ra cËu ta mong muèn gia nhËp qu©n ®éi.<enter> - B¹n sÏ chän mét trong hai c¸ch: <color=blue>ñng hé hoÆc khuyªn cËu ta.<color> Cho dï chän ph­¬ng ¸n nµo th× b¹n còng hoµn thµnh nhiÖm vô.<enter> - Quay vÒ b¸o l¹i cho <color=red>T« §¹i Ma.<color> Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp T« §¹i Ma",0,1,101,1616,3120},
			[3] = {"§i t×m T« Trung",0,1,101,1720,3136},
			[4] = {"Quay vÒ b¸o l¹i cho T« §¹i Ma. Hoµn thµnh nhiÖm vô.",0,1,101,1616,3120},
		},
		[3] = {
			[1] = {"NhiÖm vô thø 3: <color=green>X¹ h­¬ng Hæ cèt cao<color><enter>PhÇn th­ëng cho b¹n: Mét <color=green>chiÕc nhÉn<color> vµ <color=red>8 ®iÓm<color> danh väng.<enter> - B¹n nh×n thÊy <color=red>TiÓu Lan (206/206)<color> ®ang ®øng khãc rÊt th¶m thiÕt. Th× ra cha cña c« ta ®ang bÞ bÖnh nÆng.<enter> - §i ®Õn d­îc ®iÕm, gÆp <color=red>¤ng chñ d­îc ®iÕm (209/199),<color> «ng ta cho b¹n 2 lùa chän:<enter> - B¹n cã thÓ bá tiÒn ra ®Ó mua lu«n thuèc.<enter> - ¤ng chñ hiÖu thuèc cho b¹n biÕt cÇn ph¶i ®i t×m hai lo¹i d­îc liÖu th× míi cã thÓ phèi thuèc cøu cha cña <color=red>TiÓu Lan:<color><enter> - §i t×m mét ng­êi <color=red>thî s¨n (210/205)<color> bá <color=yellow>150 l­îng<color> mua ®­îc mét <color=green>bé Hæ cèt (x­¬ng hæ).<color><enter> - §i t×m <color=red>Hµnh C­íc Th­¬ng Nh©n (205/200)<color> bá <color=yellow>200 l­îng<color> mua ®­îc <color=green>X¹ h­¬ng.<color><enter> - Mang <color=red>hai lo¹i d­îc liÖu<color> trë l¹i <color=red>d­îc ®iÕm<color> giao cho «ng chñ. ¤ng ta cho biÕt nöa giê sau b¹n cã thÓ trë l¹i ®Ó lÊy thuèc.<enter> - Mang thuèc vÒ cho <color=red>TiÓu Lan.<color> Hoµn thµnh nhiÖm vô."},
			[2] = {"§èi tho¹i víi TiÓu Lan",0,1,101,1648,3312},
			[3] = {"GÆp ¤ng chñ d­îc ®iÕm",0,1,101,1672,3184},
			[4] = {"§i t×m mét ng­êi thî s¨n",0,1,101,1688,3296},
			[5] = {"§i t×m Hµnh C­íc Th­¬ng Nh©n",0,1,101,1640,3200},
			[6] = {"Trë l¹i d­îc ®iÕm giao cho «ng chñ.",0,1,101,1672,3184},
			[7] = {"Mang thuèc vÒ cho TiÓu Lan. Hoµn thµnh nhiÖm vô.",0,1,101,1648,3312},
		},
	},
	[6] = {--Long M«n TrÊn 
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>Giíi thiÖu c«ng viÖc<color><enter>PhÇn th­ëng cho b¹n: b¹n ®­îc tÆng <color=green>1 mãn vò khÝ<color> vµ <color=red>3 ®iÓm <color>danh väng.<enter> - GÆp Th­îng Quan Thu (240/282). ThÊy hoµn c¶nh h¾n ®¸ng th­¬ng b¹n t×nh nguyÖn ®i t×m gióp h¾n 1 c«ng viÖc.<enter> - B¹n ®i ®Õn <color=red>“Long M«n Kh¸ch c¬” (246/283)<color>. gÆp bµ chñ ®Ó xin viÖc lµm cho <color=red>Th­îng Quan Thu.<color><enter> - Quay l¹i gÆp <color=red> Th­îng Quan Thu<color> b¸o tin. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Th­îng Quan Thu",0,1,121,1928,4526},
			[3] = {"B¹n ®i ®Õn “Long M«n Kh¸ch c¬”",0,1,121,1976,4544},
			[4] = {"Quay l¹i gÆp Th­îng Quan Thu b¸o tin. Hoµn thµnh nhiÖm vô",0,1,121,1928,4516},
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>ChuyÓn tin<color><enter>PhÇn th­ëng cho b¹n: <color=green>1 c¸i bao tay<color> vµ <color=red>5 ®iÓm<color> danh väng.<enter> - §Õn gÆp mét <color=red>ng­êi ¨n mµy (234/281)<color>, nhËn lêi chuyÓn tin.<enter> - B¹n ®i t×m <color=red>TriÖu My Nhi (249/279)<color> ®Ó chuyÓn lêi nh­ng kh«ng ngê ph¶n øng cña c« ta rÊt m¹nh mÏ. B¹n quyÕt t©m gÆp l¹i tªn ¨n mµy hái cho ra lÏ.<enter> - Sau ®ã quay l¹i b¸o tin cho <color=red>tªn ¨n mµy<color>. Nh­ng b¹n còng kh«ng biÒt ®­îc g× h¬n! Hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn gÆp mét ng­êi ¨n mµy",0,1,121,1872,4496},
			[3] = {"§i t×m TriÖu My Nhi",0,1,121,1992,4486},
			[4] = {"GÆp l¹i tªn ¨n mµy b¸o tin. Hoµn thµnh nhiÖm vô",0,1,121,1872,4496},
		},
		[3] = {
			[1] = {"NhiÖm vô thø 3: <color=green>§i giÕt heo rõng<color><enter>PhÇn th­ëng cho b¹n: b¹n ®­îc th­ëng <color=green>1 chiÕc mò<color> vµ <color=red>9 ®iÓm<color> danh väng.<enter> - §Õn <color=red>Long m«n kh¸ch c¬<color> gÆp <color=red>bµ chñ (246/283).<color> <color=red>Bµ chñ: <color>“H·y ®i ra rõng lÊy ba miÕng thÞt heo rõng vÒ cho ta ®·i kh¸ch”.<enter>Ra rõng ®¸nh <color=red>con Heo rõng (222/260; 276/260; 281/291).<color> LÊy ®­îc <color=red>ba miÕng thÞt<color>.<enter> - Mang <color=red>thÞt<color> vÒ cho <color=red>bµ chñ<color>. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp bµ chñ Long m«n kh¸ch c¬",0,1,121,1976,4544},
			[3] = {"Heo rõng 1",0,1,121,1792,4192},
			[4] = {"Heo rõng 2",0,1,121,2208,4192},
			[5] = {"Heo rõng 3",0,1,121,2248,4656},
			[6] = {"Mang thÞt vÒ cho bµ chñ. Hoµn thµnh nhiÖm vô.",0,1,121,1976,4544},
		},
	},
	[7] = {--Th¹ch Cæ TrÊn 
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>§­a c¬m<color><enter>PhÇn th­ëng cho b¹n: Mét mãn <color=green>vò khÝ<color> vµ <color=red>3 ®iÓm<color> danh väng.<enter> - T×m gÆp <color=red>LiÔu DiÖp Nhi (207/201)<color>, nhËn nhiÖm vô ®i ®­a c¬m.<enter> - §i t×m <color=red>Vâ s­ (207/203)<color>. §­a c¬m cho «ng Êy. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp LiÔu DiÖp Nhi",0,1,153,1656,3232},
			[3] = {"§i t×m Vâ s­ ®­a c¬m. Hoµn thµnh nhiÖm vô",0,1,153,1656,3248},
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>Tr¶ tiÒn<color><enter>PhÇn th­ëng cho b¹n: Mét <color=green>chiÕc ¸o v¶i<color> vµ <color=red>7 ®iÓm<color> danh väng.<enter> - B¹n l¹i ®i d¹o phè mét vßng, bÊt chît gÆp <color=red>A Toµn<color> vµ <color=red>A M· (208/202)<color>, hai ng­êi thËt ®¸ng th­¬ng! X¶y ra chuyÖn g× vËy ?<enter> - Sau khi biÕt râ sù t×nh, b¹n t×m ®Õn chç <color=red>ThÈm gia (201/200)<color> ®èi tho¹i……, xin <color=red>ThÈm gia<color> xãa nî cho <color=red>A Toµn<color> vµ <color=red>A M·<color><enter>Bá ra <color=yellow>300 l­îng<color> tr¶ nî. Trë l¹i b¸o tin cho <color=red>A Toµn<color> vµ <color=red>A M·<color>. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp A Toµn vµ A M·",0,1,153,1664,3232},
			[3] = {"GÆp ThÈm gia",0,1,153,1608,3216},
			[4] = {"B¸o tin cho A Toµn vµ A M· tr¶ nî. Hoµn thµnh nhiÖm vô",0,1,153,1664,3232},
		 },
		[3] = {
			[1] = {"NhiÖm vô thø 3: <color=green>ChiÕc nhÉn cña A Kinh<color><enter>PhÇn th­ëng cho b¹n: Mét chiÕc <color=green>®ai th¾t trªn ®Çu<color> vµ <color=red>7 ®iÓm<color> danh väng.<enter> - GÆp <color=red>A Kinh (206/199)<color> ®ang ®øng biÕt r»ng c« ta bÞ mÊt 1 <color=green>chiÕc nhÉn.<color><enter> - B¹n an ñi c« ta, sau ®ã ®i ra ngoµi th«n. B¹n ph¸t hiÖn ra mét con <color=red>Linh miªu (213/201)<color> tr«ng thËt kinh khiÕp nh­ng ®õng ®Ó ý ®Õn nã, sau nhiÒu lÇn qua l¹i th× b¹n ph¸t hiÖn ra chÝnh con <color=red>Linh Miªu<color> nµy ®ang gi÷ <color=green>chiÕc nhÉn<color> vµ quyÕt t©m b¶o vÖ <color=red>“chiÕn lîi phÈm”<color>. B¹n c¶m thÊy rÊt ®au khæ khi ph¶i giÕt nã. Dï sao b¹n còng ph¶i lÊy l¹i <color=green>chiÕc nhÉn<color>.<enter> - Mang <color=red>nhÉn<color> vÒ cho <color=red>A Kinh.<color> C« ta rÊt vui mõng vµ tÆng b¹n mét <color=green>mãn quµ<color>. Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp A Kinh",0,1,153,1640,3200},
			[3] = {"Ph¸t hiÖn ra mét con Linh miªu",0,1,153,1704,3216},
			[4] = {"Mang nhÉn vÒ cho A Kinh. Hoµn thµnh nhiÖm vô",0,1,153,1640,3200},
		},
	},
	[8] = {--Long TuyÒn Th«n
		[1] = {
			[1] = {"NhiÖm vô thø 1: <color=green>Cha sau cã tèt kh«ng?<color><enter>PhÇn th­ëng cho b¹n: Mét <color=green>chiÕc ¸o<color> vµ <color=red>5 ®iÓm<color> danh väng.<enter> - §Õn <color=red>tiÖm t¹p hãa (195/200),<color> ®èi tho¹i víi «ng chñ. BiÕt ®­îc hoµn c¶nh cña «ng ta vµ b¹n quyÕt ®Þnh gióp «ng Êy.<enter> - GÆp <color=red>Khæng HiÓu (203/205)<color> ®èi tho¹i. B¹n míi biÕt r»ng cËu bÐ rÊt kÝnh phôc ng­êi cha míi cña m×nh.<enter> - Trë l¹i tiÖm t¹p hãa b¸o tin vui cho «ng chñ. Hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn tiÖm t¹p hãa",0,1,174,1580,3216},
			[3] = {"GÆp Khæng HiÓu",0,1,174,1624,3280},
			[4] = {"B¸o tin vui cho «ng chñ. Hoµn thµnh nhiÖm vô.",0,1,174,1580,3216},
		},
		[2] = {
			[1] = {"NhiÖm vô thø 2: <color=green>Gióp Bµnh Phãng söa ®ao<color><enter>PhÇn th­ëng cho b¹n: Mét <color=green>bao tay (g¨ng tay)<color> vµ <color=red>6 ®iÓm<color> danh väng.<enter> - GÆp <color=red>Bµnh Phãng (207/203)<color>. NhËn nhiÖm vô mang gióp anh ta <color=green>c©y ®ao<color> ®Õn chç <color=red>thî rÌn<color> nhê söa l¹i.<enter> - Mang <color=green>c©y ®ao<color> ®Õn chç <color=red>Thî rÌn (200/203)<color>, phÝ söa lµ <color=yellow>120 l­îng<color>. Hai giê sau b¹n quay l¹i lÊy.<enter> - B¹n h·y ®i d¹o mét vßng sau ®ã quay l¹i lÊy ®ao.<enter> - Mang <color=red>®ao<color> vÒ cho <color=red>Bµnh Phãng.<color> Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Bµnh Phãng",0,1,174,1660,3256},
			[3] = {"Mang c©y ®ao ®Õn chç Thî rÌn sau ®ã ®i d¹o",0,1,174,1584,3248},
			[4] = {"Mang ®ao vÒ cho Bµnh Phãng",0,1,174,1660,3256},
		},
		[3] = {
			[1] = {"NhiÖm vô thø 3: <color=green>Canh D­¬ng Xu©n B¹ch TuyÕt<color><enter>PhÇn th­ëng cho b¹n: Mét miÕng <color=green>Ngäc Béi<color> vµ <color=red>8 ®iÓm<color> danh väng.<enter> - B¹n ®i vµo trong rõng ®µo gÆp mét ng­êi tªn <color=red>Chung Ly (205/201).<color> NhËn lêi ®i t×m <color=red>D­¬ng Xu©n Linh Chi<color> vµ <color=red>B¹ch TuyÕt B¸ch Hîp.<color><enter> - §i ®Õn <color=red>TiÖm t¹p hãa (195/200)<color>, chØ cÇn bá ra <color=yellow>500 l­îng<color> b¹n sÏ mua ®­îc <color=red>D­¬ng Xu©n Linh Chi<color><enter>NÕu b¹n ®· lµm <color=red>nhiÖm vô 1<color> th× «ng chñ tiÖm sÏ tÆng b¹n <color=red>Linh Chi.<color><enter> - <color=red>B¹ch TuyÕt B¸ch Hîp <color> cùc kú khã t×m, b¹n h·y ®i ra ngoµi th«n <color=red>(192/202)<color> b¹n sÏ h¸i ®­îc nã.<enter> - NÕu b¹n ®Õn ®óng ®Þa chØ mµ kh«ng thÊy th× b¹n ngåi chê mét chót nã sÏ mäc ra vµ b¹n chØ viÖc h¸i nã.<enter>Mang hai mãn d­îc liÖu trªn vÒ cho Chung Ly . Hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp mét ng­êi tªn Chung Ly",0,1,174,1640,3216},
			[3] = {"§i ®Õn TiÖm t¹p hãa",0,1,174,1580,3216},
			[4] = {"T×m B¹ch TuyÕt B¸ch Hîp",0,1,174,1526,3222},
			[5] = {"Mang d­îc liÖu vÒ cho Chung Ly. Hoµn thµnh nhiÖm vô.",0,1,174,1640,3216},
		},
	},
}


function nvthontran()
	local Talk = "CÈm nang ®Æc biÖt gióp dÞch chuyÓn nhanh c¸c ®Þa ®iÓm lµm nhiÖm vô Th«n trÊn.\nHoµn thµnh nhiÖm vô, ng­¬i sÏ nhËn ®­îc nh÷ng phÇn th­ëng xøng ®¸ng."
	local tb = {
	"Ba L¨ng HuyÖn/#villagequest(1)",
	"Giang T©n Th«n/#villagequest(2)",
	"VÜnh L¹c TrÊn/#villagequest(3)",
	"Chu Tiªn TrÊn/#villagequest(4)",
	"§¹o H­¬ng Th«n/#villagequest(5)",
	"Long M«n TrÊn/#villagequest(6)",
	"Th¹ch Cæ TrÊn/#villagequest(7)",
	"Long TuyÒn Th«n/#villagequest(8)",
    "Quay l¹i/main",
	"Tho¸t./Quit",
	}
	Say(Talk,getn(tb),tb)
return 1
end

function villagequest(IDv)
	local MissType = IDv --Loai thon tran
	local tb = {
	
	"NhiÖm vô 1/#villagequest_step1("..MissType..",1)",
	"NhiÖm vô 2/#villagequest_step1("..MissType..",2)",
	"NhiÖm vô 3/#villagequest_step1("..MissType..",3)",
	"Quay l¹i/nvthontran",	
	"KÕt thóc ®èi tho¹i/Quit"
	}
	Say("Mçi th«n lµng ®Òu cã Ýt nhÊt 3 nhiÖm vô, nÕu th«n nµo hay trÊn nµo kh«ng cã nhiÖm vô thø 3 th× sÏ kh«ng hiÓn thÞ.",getn(tb),tb)
end

function villagequest_step1(ID1,ID2)
	local MissType = ID1 --Loai Thon Tran
	local PheType = ID2 --loai NV
	local strDesc = tb_HelpThonTran[MissType][PheType][1][1]
	local tbOpt = {}
	local TotalSelect = getn(tb_HelpThonTran[MissType][PheType]) 
	for i=2,TotalSelect do
		local FightState = tb_HelpThonTran[MissType][PheType][i][2] 
		local MapId = tb_HelpThonTran[MissType][PheType][i][4]
		local nX =tb_HelpThonTran[MissType][PheType][i][5]
		local nY = tb_HelpThonTran[MissType][PheType][i][6]
		tinsert(tbOpt, {tb_HelpThonTran[MissType][PheType][i][1],villagequest_step3,{FightState,MapId,nX,nY}})
		
	end
	tinsert(tbOpt, {"Quay l¹i",main})
	tinsert(tbOpt, {"Tho¸t."})
	CreateNewSayEx(strDesc, tbOpt);
end

function villagequest_step3(ID1,ID2,ID3,ID4)
	local FightState = ID1
	local MapId = ID2
	local nX = ID3
	local nY = ID4
	NewWorld(MapId,nX,nY)
	SetFightState(FightState)
end
------------------------------------------------------------------------NV M«n Ph¸i-------------------------------------------------------------------------------------------
tb_HelpMonPhai = {
	[0] = { --Thieu lam
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 ThiÕu L©m Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>ThiÕu L©m C«n Ph¸p<enter>ThiÕu L©m QuyÒn Ph¸p<enter>ThiÕu L©m §ao Ph¸p<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hé ViÖn Vâ T¨ng. Häc ®­îc vâ c«ng: ThiÕu L©m §ao Ph¸p, C«n ph¸p, QuyÒn ph¸p. N¬i tiÕp nhËn nhiÖm vô: Tõ Nh©n Ph­¬ng Tr­îng.<enter><color=red>B¬íc 1<color>: §Õn Ph­¬ng Tr¬îng ThiÒn phßng (230/184), gÆp Tõ Nh©n Ph­¬ng Tr¬îng, tiÕp nhËn nhiÖm vô.<enter><color=red>B¬íc 2<color>: Vµo trong §¹t Ma §¬êng (210/188), phÝa sau pho t¬îng trong §¹t Ma §¬êng cã 1 con hÎm nhá, vµo trong ®ã ®¸nh b¹i nh÷ng tªn C¬ Quan Nh©n (192/197), (203/200), (216/201) ®Õn khi lÊy ®­îc Kim Liªn Hoa.<enter><color=red>B¬íc 3<color>: Mang Kim Liªn Hoa vÒ giao cho Tõ Nh©n Ph­¬ng Tr¬îng , hoµn thµnh nhiÖm vô"},
			[2] = {"GÆp Tõ Nh©n Ph­¬ng Tr­îng","",0,1,109,1598,3178},
			[3] = {"§¸nh b¹i C¬ Quan Nh©n lÊy Kim Liªn Hoa","",1,1,111,1544,3162},
			[4] = {"Quay l¹i Tõ Nh©n Ph­¬ng Tr­îng hoµn thµnh nhiÖm vô","",0,1,109,1598,3178},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 ThiÕu L©m Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>BÊt §éng Minh V­¬ng<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hé Tù Kim Cang. Häc ®­îc vâ c«ng: BÊt §éng Minh V­¬ng. N¬i tiÕp nhËn nhiÖm vô: HuyÒn Bi..<enter><color=red>B­íc 1<color>: §Õn §¹t Ma §­êng (210/188), t×m gÆp HuyÒn Bi, tiÕp nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn BiÖn Kinh Phñ -> T©y Phôc Ng­u S¬n t×m n¨m tªn Man Di (280/185), (269/184), (264/185), (262/183), (277/187). Sau khi ®¸nh ®ñ 5 con ë 5 ®Þa chØ trªn sÏ cã dßng ch÷ hiÖn lªn: <color=yellow>B¹n ®· d¹y dç ®­îc 5 tªn Man Di, chóng høa tõ nay sÏ kh«ng quËy ph¸ n÷a...<color>.<enter><color=red>B­íc 3<color>: Trë l¹i §¹t Ma §­êng gÆp HuyÒn Bi phôc mÖnh, hoµn thµnh nhiÖm vô"},
			[2] = {"GÆp HuyÒn Bi","",0,1,105,1599,3191},
			[3] = {"§¸nh b¹i Man Di thø nhÊt ë Phôc Ng­u S¬n T©y","",1,1,41,2235,2970},
			[4] = {"§¸nh b¹i Man Di thø hai ë Phôc Ng­u S¬n T©y","",1,1,41,2160,2943},
			[5] = {"§¸nh b¹i Man Di thø ba ë Phôc Ng­u S¬n T©y","",1,0,41,264,185},
			[6] = {"§¸nh b¹i Man Di thø t­ ë Phôc Ng­u S¬n T©y (Ngay gÇn con thø 3)","",1,1,41,2094,2926},
			[7] = {"§¸nh b¹i Man Di thø n¨m ë Phôc Ng­u S¬n T©y","",1,1,41,2210,3010},
			[8] = {"Trë vÒ phông mÖnh HuyÒn Bi, hoµn thµnh nhiÖm vô","",0,1,105,1599,3191},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 ThiÕu L©m Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>La H¸n TrËn<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hé Ph¸p La H¸n. Häc ®­îc vâ c«ng: La H¸n TrËn. N¬i tiÕp nhËn nhiÖm vô: HuyÒn Gi¸c.<enter><color=red>B­íc 1<color>: §Õn hå Phãng sinh t×m gÆp HuyÒn Gi¸c <color=yellow>(220/193)<color>, tiÕp nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn rõng th¸p bªn ngoµi chïa, ph¸t hiÖn nh÷ng kÎ cã hµnh tung mê ¸m. §¸nh b¹i M¹ch Anh <color=yellow>(238/200), (231/204)<color>, cho ®Õn khi nµo biÕt ®­îc bän chóng chÝnh lµ gi¸n ®iÖp cña Kim quèc, ®ång ®¶ng cña bän chóng ®· ®¸nh c¾p thµnh c«ng <color=yellow>B¸t Nh· Ba La MËt §a T©m Kinh<color> hiÖn giê ®· ch¹y ®Õn Kim Quang ®éng ë KiÕm C¸c T©y B¾c.<enter><color=red>B­íc 3<color>: §Õn Ph­îng T­êng Phñ -> KiÕm C¸c Thôc §¹o -> Kim Quang §éng, ®¸nh bän Trém kinh <color=yellow>(218/182), (179/186), (198/196)<color> ®Õn khi lÊy lÊy l¹i ®­îc <color=yellow>B¸t Nh· Ba La MËt §a T©m Kinh<color>.<enter><color=red>B­íc 4<color>: Trë l¹i ThiÕu L©m, ®Õn hå Phãng sinh, mang kinh giao cho HuyÒn Gi¸c, hoµn thµnh nhiÖm vô"},
			[2] = {"§Õn Hå Phãng Sinh gÆp HuyÒn Gi¸c","",0,0,103,220,193},
			[3] = {"§¸nh b¹i M¹ch Anh","",1,1,103,1908,3210},
			[4] = {"§¸nh b¹i bän trém kinh ë Kim Quang §éng",	"",1,0,4,218,182},
			[5] = {"Trë l¹i gÆp HuyÒn Gi¸c, hoµn thµnh nhiÖm vô","",0,0,103,220,193},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 ThiÕu L©m Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>S­ Tö Hèng<color>"},
			--[1] = {"SÏ ®­îc phong lµ: TruyÒn Kinh La H¸n. Häc ®­îc vâ c«ng: S­ Tö Hèng. N¬i tiÕp nhËn nhiÖm vô: Tõ Nh©n Ph­¬ng Tr­îng.<enter><color=red>B­íc 1<color>: §Õn Ph­¬ng Tr­îng ThiÒn phßng <color=yellow>(230/184)<color> t×m gÆp <color=green>Tõ Nh©n Ph­¬ng tr­îng<color>, tiÕp nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn ThiÕu L©m MËt ThÊt <color=yellow>(168/166)<color> ë phÝa B¾c Chïa ThiÕu L©m, tr¶ lêi 3 c©u hái ®Ó vµo ®­îc trong MËt ThÊt <color=yellow>(thø tù tr¶ lêi lµ 1 - 2 - 1)<color>.<enter><color=red>B­íc 3<color>: §¸nh <color=green>Kim Cang Nh©n<color> <color=yellow>(213/205), (203/198), (204/205), (208/201)<color> ®Ó lÊy ®­îc khÈu quyÕt.<enter><color=red>B­íc 4<color>: §Õn cuèi hang ®éng <color=yellow>(230/207)<color> sÏ nh×n thÊy mét th¹ch thÊt, nhÊp vµo phiÕn ®¸, ®äc ®óng khÈu quyÕt sÏ cã thÓ cïng <color=green>NhÞ T¨ng<color> ®èi tho¹i, ph¶i chó ý nghe thø tù n¨m c©u nãi cña <color=green>NhÞ T¨ng<color> (c¸c b¹n nªn ghi l¹i).<enter><color=red>B­íc 5<color>: Trë l¹i Ph­¬ng tr­îng ThiÒn phßng, gÆp <color=green>Tõ Nh©n Ph­¬ng Tr­îng<color>, thuËt l¹i thø tù n¨m c©u nãi cña <color=green>NhÞ T¨ng<color>:<enter>\t\t- NÕu Nh­ thø tù chÝnh x¸c, hoµn thµnh nhiÖm vô.<enter>\t\t- NÕu Nh­ thø tù bÞ sai, <color=green>Tõ Nh©n Ph­¬ng tr­îng<color> : <color=yellow>Ta kh«ng hiÓu ®­îc ý nghÜa n¨m c©u nµy, cã ph¶i ng­¬i ®· bÞ lÇm lÉn thø tù kh«ng?<color> B¹n ph¶i thùc hiÖn l¹i nhiÖm vô"},
			[2] = {"§Õn gÆp Tõ Nh©n Ph­¬ng Tr­îng.","",0,1,109,1598,3178},
			[3] = {"§Õn ThiÕu L©m mËt thÊt","",1,0,103,168,166},
			[4] = {"§¸nh b¹i kim cang nh©n thø nhÊt","",1,0,113,213,206},
			[5] = {"§¸nh b¹i kim cang nh©n thø hai","",1,0,113,203,199},
			[6] = {"§¸nh b¹i kim cang nh©n thø ba","",1,0,113,204,205},
			[7] = {"§¸nh b¹i kim cang nh©n thø t­","",1,0,113,208,202},
			[8] = {"§èi tho¹i cïng NhÞ T¨ng","",0,0,113,230,207},
			[9] = {"Trë l¹i gÆp Tõ Nh©n Ph­¬ng Tr­îng, hoµn thµnh nhiÖm vô","",0,1,109,1598,3178},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 ThiÕu L©m Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Hoµnh T¶o Lôc Hîp<enter>Ma Ha V« L­îng<enter>Long Hæ Tr¶o<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Phôc Ma Thiªn Vu¬ng. Häc ®­îc vâ c«ng: Hoµnh T¶o Lôc Hîp, Ma Ha V« L­îng, Long Hæ Tr¶o. N¬i tiÕp nhËn nhiÖm vô: HuyÒn Tõ.<enter><color=red>B­íc 1<color>: §Õn Tµng Kinh C¸c(218/190) , gÆp HuyÒn Tõ, tiÕp nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn s©n luyÖn vâ gÆp Trõng T©m (224/178). H¾n muèn b¹n kiÕm cho h¾n 1 con gµ quay.<enter><color=red>B­íc 3<color>: §Õn Töu lÇu ë BiÖn Kinh (210/193), bá 500 l­îng mua gµ quay mang vÒ giao cho Trõng T©m.<enter><color=red>B­íc 4<color>: §Õn rõng th«ng, trong rõng lµ mét mª cung c©y th«ng, trong mª cung cã rÊt nhiÒu ®¸, c¨n cø theo sù s¾p xÕp Tø, Ngò, Tam, sÏ t×m ®­îc t¶ng ®¸ cã giÊu tµng th¬ (231/170), ®Èy nã ra sÏ lÊy ®­îc <color=yellow>DÞch C©n Kinh<color>.<enter><color=red>B­íc 5<color>: Trë l¹i Tµng Kinh C¸c, mang DÞch C©n Kinh giao cho HuyÒn Tõ, hoµn thµnh nhiÖm vô"},
			[2] = {"§Õn Tµng Kinh C¸c gÆp HuyÒn Tõ","",0,1,104,1594,3183},
			[3] = {"GÆp Trõng T©m t¹i s©n luyÖn vâ","",0,0,103,224,178},
			[4] = {"Mua gµ quay t¹i töu lÇu BiÖn Kinh","",0,0,37,210,193},
			[5] = {"Mang gµ quay vÒ cho Trõng T©m","",0,0,103,224,178},
			[6] = {"§Õn rõng th«ng t×m DÞch Ch©n Kinh","",1,0,103,230,169},
			[7] = {"Mang DÞch C©n Kinh cho HuyÒn Tõ, hoµn thµnh nhiÖm vô","",0,1,104,1594,3183},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ ThiÕu L©m Ph¸i<color>"},
			--[1] = {"SÏ ®­îc phong lµ: V« L­îng ThÝch T«n. N¬i nhËn nhiÖm vô: HuyÒn Nan.<enter><color=red>B­íc 1<color>: §Õn La H¸n ®­êng <color=yellow>(202/192)<color>, gÆp HuyÒn Nan, tiÕp nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn La H¸n trËn (lèi ®i vµo phÝa sau t­îng PhËt trong La H¸n ®­êng), ®¸nh b¹i c¸c tªn T¨ng Binh §Çu LÜnh <color=yellow>(197/211), (211/224), (206/196), (229/208)<color>, b¹n sÏ lÊy ®­îc NiÖm Ch©u, ThiÒn tr­îng, Méc Ng­ vµ B¸t Vu.<enter><color=red>B­íc 3<color>: Mang 4 b¶o vËt trªn vÒ giao cho HuyÒn Nan, hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn La H¸n ®­êng gÆp HuyÒn Nan","",0,0,103,202,192},
			[3] = {"§¸nh b¹i t¨ng ®Çu lÜnh","",1,1,114,1580,3380},
			[4] = {"Mang 4 b¶o vËt vÒ cho HuyÒn Nan, hoµn thµnh nhiÖm vô",0,0,103,202,192},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n ThiÕu L©m Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Nh­ Lai Thiªn DiÖp<enter>DÞch C©n Kinh<color>"},
			--[1] = {"<color=red>Yªu cÇu<color>: ng­êi ch¬i ®· xuÊt s­, ®¼ng cÊp trªn 60, ch­a gia nhËp bang ph¸i nµo, cã thÓ ®Õn gÆp tr­ëng m«n cña ph¸i giao 5 v¹n l­îng ®Ó trïng ph¶n s­ m«n. Tõ ®ã vÒ sau cã thÓ tïy ý ra vµo s­ m«n.<enter><color=red>Häc ®­îc vâ c«ng<color>: Nh­ Lai Thiªn DiÖp, DÞch C©n Kinh.<enter>§­îc phßng lµm Hé Ph¸p Tr­ëng L·o."},
			[2] = {"§èi tho¹i Ch­ëng M«n, nép 5 v¹n l­îng","",0,1,103,202,192},
		},
		[8] = {
			[1] = {"<color=green>NhiÖm vô cÊp 90 ThiÕu L©m Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>§¹t Ma §é Giang<enter>Hoµnh T¶o Thiªn Qu©n<enter>V« T­íng Tr¶m<color>"},
			--[1] = {"<color=red>Yªu cÇu<color>: Tõ cÊp <color=yellow>90<color> trë lªn, danh väng trªn <color=yellow>240<color> ®iÓm, lµ <color=yellow>ThiÕu L©m ký danh ®Ö tö<color>, tr­íc m¾t ch­a gia nhËp m«n ph¸i nµo.(Ch÷ ®á)<enter><color=red>PhÇn th­ëng<color>: häc ®­îc <color=yellow>§¹t Ma §é Giang , Hoµnh T¶o Thiªn Qu©n , V« T­íng Tr¶m<color>. Danh väng ®­îc <color=yellow>30<color> ®iÓm. (TÊt c¶ c¸c m«n ph¸i kh¸c ®Òu cã thÓ lµm nhiÖm vô nµy ®Ó nhËn phÇn th­ëng ®iÓm danh väng, nh¬ng kh«ng häc ®­îc chiªu thøc).<enter><color=red>B­íc 1<color>: Tõ bÊt kú thµnh chÝnh nµo b¹n ®i Xa phu -> Hoa S¬n C¶nh kü tr­êng gÆp Th­êng B¸ch Lý vµ Lý §Þch Phong <color=yellow>(326/224)<color>, nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: VÒ ThiÕu L©m ®Õn §¹t Ma §­êng <color=yellow>(210/188)<color> t×m gÆp HuyÒn Bi.<enter><color=red>B­íc 3<color>: Sang La H¸n ®­êng <color=yellow>(202/192)<color>, gÆp HuyÒn Nan.<enter><color=red>B­íc 4<color>: Trë l¹i §¹t Ma §­êng nãi chuyÖn víi HuyÒn Bi nhËn lÖnh bµi ®Ó ®i thùc hiÖn nhiÖm vô.<enter><color=red>B­íc 5<color>: Quay l¹i Hoa S¬n C¶nh kü tr­êng gÆp Th­êng B¸ch Lý vµ Lý §Þch Phong ®Ó ®­a lÖnh bµi.<enter><color=red>B­íc 6<color>: §¸nh b¹i Kim Quèc T­íng LÜnh <color=yellow>(323/240)<color> råi gÆp Th­êng B¸ch Lý vµ Lý §Þch Phong b¸o tin.<enter><color=red>B­íc 7<color>: VÒ ThiÕu L©m ®Õn §¹t Ma §­êng t×m gÆp HuyÒn Bi b¸o tin.<enter><color=red>B­íc 8<color>: Sang La H¸n ®­êng, gÆp HuyÒn Nan b¸o tin, hoµn thµnh nhiÖm vô."},
			[2] = {"Lªn Hoa S¬n C¶nh Kü Tr­êng gÆp Th­êng B¸ch Lý vµ Lý DÞch Phong","",0,0,2,326,224},
			[3] = {"T×m gÆp HuyÒn Bi","",0,1,105,1599,3191},
			[4] = {"§Õn La H¸n ®­êng gÆp HuyÒn Nan","",0,0,103,202,192},
			[5] = {"T×m gÆp HuyÒn Bi nhËn lÖnh bµi.","",0,1,105,1599,3191},
			[6] = {"Trë l¹i t×m Th­êng B¸ch Lý vµ Lý DÞch Phong ®­a lÖnh bµi.","",0,0,2,326,224},
			[7] = {"Tiªu diÖt Kim Quèc t­íng lÜnh","",1,0,2,323,240},
			[8] = {"Trë l¹i t×m Th­êng B¸ch Lý vµ Lý DÞch Phong b¸o tin tiªu diÖt Kim Quèc t­íng lÜnh.","",0,0,2,326,224},
			[9] = {"Trë vÒ t×m gÆp HuyÒn Bi b¸o tin","",0,1,105,1599,3191},
			[10] = {"B¸o tin cho HuyÒn Nan, hoµn thµnh nhiÖm vô","",0,0,103,202,192},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
			--[1] = {"MËt tÞch kü n¨ng 120 cã thÓ ®æi t¹i Ch­ëng m«n. <enter>VËt phÈm cÇn thiÕt ®Ó ®æi:<enter>1 quyÓn Bµn Nh­îc T©m Kinh, 1 bé s¸ch kü n¨ng 90 cña m«n ph¸i m×nh, 1 viªn Tinh Hång B¶o Th¹ch vµ 1 viªn Thñy Tinh."},
		},
		[10] = {
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö ThiÕu L©m Ph¸i<color>"},
			--[1] = {"<color=red>B­íc 1<color>: §Õn BiÖn Kinh phñ råi ®i theo h­íng t©y nam ®Õn chïa ThiÕu L©m. Vµo trong chïa gÆp Tri T¨ng Kh¸ch (211/195) «ng ta muèn b¹n chøng tá 4 phÈm chÊt: XÝch ®¶m trung t©m, h¹o nhiªn chÝnh khÝ, kiªn nhÉn b¸t ®¹t vµ v« t¬ v« ng·.<enter><color=red>B­íc 2<color>: Quay l¹i BiÖn Kinh phñ, ®Õn t×m T©n Khëi TËt (220/187) lÊy ®­îc Qu¶ng Ho¾c H­¬ng.<enter><color=red>B­íc 3<color>: GÆp Kim Quèc Vâ SÜ (209/201) nhËn ®­îc Kiªn Tinh Th¹ch.<enter><color=red>B­íc 4<color>: §Õn cæng thµnh phÝa B¾c T¸n gÉu víi VÖ Binh Thµnh M«n (198/187), h¾n sÏ hái b¹n vÒ lßng trung thµnh, b¹n h·y chän c©u tr¶ lêi thõ hai ®­îc tÆng XÝch §ång Kho¸ng.<enter><color=red>B­íc 5<color>: Mang c¶ 3 mãn nµy tÆng cho Ng­êi ¨n mµy (210/186) vµ ®­îc giao cho mét L¸ th¬. CÇm l¸ th¬ ®ã vÒ chïa ThiÕu L©m giao l¹i cho Tri T¨ng Kh¸ch , thÕ lµ ®­îc tiÕp nhËn lµm ®Ö tö ký danh"},
			[2] = {"GÆp Tri Kh¸ch T¨ng","",0,0,103,211,195},
			[3] = {"§Õn BiÖn Kinh t×m TÇn Khëi TËt lÊy Qu¶ng H¾c H­¬ng","",0,0,37,220,187},
			[4] = {"GÆp Kim Quèc Vâ SÜ lÊy Kim Tinh Th¹ch","",0,0,37,209,201},
			[5] = {"Nãi chuyÖn víi vÖ binh thµnh m«n phÝa b¾c",	"",0,0,37,198,187},
			[6] = {"T×m gÆp ng­êi ¨n mµy tÆng 3 b¶o vËt","",0,1,37,1685,2998},
			[7] = {"Trë vÒ giao th¬ cho Tri Kh¸ch T¨ng","",0,0,103,211,195},
		},
	},
	[1] = { --Thien vuong 
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 Thiªn V­¬ng Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thiªn V­¬ng Th­¬ng Ph¸p<enter>Thiªn V­¬ng §ao ph¸p<enter>Thiªn V­¬ng Chïy ph¸p<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Tr­ëng ThÞ VÖ. Häc ®­îc vâ c«ng: Thiªn V­¬ng Th­¬ng Ph¸p, Thiªn V­¬ng §ao ph¸p, Thiªn V­¬ng Chïy ph¸p, N¬i tiÕp nhËn nhiÖm vô: TiÒn Sø V­¬ng T¸.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1<color>: §Õn §¹i §iÖn (201/198) gÆp TiÒn Sø V­¬ng T¸ nhËn nhiÖm vô. §i t×m 3 viªn Kª HuyÕt Th¹ch.<enter><color=red>B­íc 2<color>: §Õn S¬n §éng (225/185) phÝa ®«ng b¾c cña ®¶o, t×m ®¸nh Kim Miªu V­¬ng (225/201),(196/191), X¸ LÞ Tinh (234/196), §¹i Hoµn Hïng (210/195),(209/185) cho ®Õn khi nhËn ®ñ 3 viªn Kª HuyÕt Th¹ch<enter><color=red>B­íc 3<color>: Mang Kª HuyÕt Th¹ch vÒ giao cho TiÒn Sø V­¬ng T¸, hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp V­¬ng T¸","",0,1,60,1599,3185},
			[3] = {"§¸nh Kim Miªu V­¬ng","",1,1,65,1810,3210},
			[4] = {"VÒ gÆp V­¬ng T¸, hoµn thµnh nhiÖm vô","",0,1,60,1599,3185},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 Thiªn V­¬ng Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>TÜnh T©m QuyÕt<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Thñ Tr¹i H·n T­íng. Häc ®­îc vâ c«ng: TÜnh T©m QuyÕt. N¬i tiÕp nhËn nhiÖm vô: H÷u Sø D­¬ng Hå.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1<color>: §Õn phÝa Nam TÈm Cung gÆp H÷u Sø D­¬ng Hå (218/198) nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §i Ba L¨ng HuyÖn -> Vò L¨ng S¬n -> B¹ch Thñy §éng. Vµo ®éng ®¸nh tªn Thæ PhØ ®Çu môc (203/194), (194/196), (206/201) ®Õn khi nhËn ®­îc 1 l¸ cê GÊm.<enter><color=red>B­íc 3<color>: Mang cê vÒ giao cho H÷u Sø D­¬ng Hå (218/198), hoµn thµnh nhiÖm vô.<enter><color=red>Chó ý<color>: §¸nh ®i ®¸nh l¹i c¶ 3 Thæ PhØ §Çu Môc ®Õn khi nhËn ®­îc Cê GÊm"},
			[2] = {"GÆp D­¬ng Hå","",0,1,59,1749,3173},
			[3] = {"Thá phØ ®Çu môc 1","",1,1,71,1630,3114},
			[4] = {"Thæ phØ ®Çu môc 2","",1,1,71,1554,3149},
			[5] = {"Thæ phØ ®Çu môc 3","",1,1,71,1650,3216},
			[6] = {"GÆp D­¬ng Hå, hoµn thµnh nhiÖm vô","",0,1,59,1749,3173},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 Thiªn V­¬ng Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>B¸t Phong Tr¶m<enter>D­¬ng Quan Tam DiÖp<enter>Hµng V©n QuyÕt<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Ch­ëng §µ §Çu LÜnh. Häc ®­îc vâ c«ng: B¸t Phong Tr¶m, D­¬ng Quan Tam DiÖp, Hµng V©n QuyÕt, N¬i tiÕp nhËn nhiÖm vô: T¶ Sø Cæ B¸ch.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1<color>: §Õn phÝa T©y Qu¶ng Tr­¬ng gÆp T¶ Sø Cæ B¸ch (202/193). NhËn lêi gióp «ng ta t×m Thiªn V­¬ng LÖnh.<enter><color=red>B­íc 2<color>: §i Ba L¨ng huyÖn -> Miªu LÜnh -> YÕn Tö §éng, ®¸nh b¹i B¸o Tö §Çu (191/210) cho ®Õn khi nhËn ®­îc Thiªn V­¬ng LÖnh míi th«i.<enter><color=red>B­íc 3<color>: Mang Trë vÒ giao Thiªn V­¬ng LÖnh cho T¶ Sø Cæ B¸ch (202/193), hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Cæ B¸ch","",0,1,59,1619,3092},
			[3] = {"§¸nh B¸o tö ®Çu lÊy Thiªn V­¬ng lÖnh","",1,1,77,1528,3360},
			[4] = {"VÒ gÆp Cæ B¸ch, hoµn thµnh nhiÖm vô","",0,1,59,1619,3092},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 Thiªn V­¬ng Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>§o¹n Hån ThÝch<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Thñy §¹o Thèng LÜnh. Häc ®­îc vâ c«ng: §o¹n Hån ThÝch, N¬i tiÕp nhËn nhiÖm vô: Lé V©n ViÔn.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1<color>: §Õn Thiªn V­¬ng §¹i §iÖn (214/192) gÆp Thiªn Hé Ph¸p Lé V©n ViÔn nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn Ba L¨ng HuyÖn gÆp Ng« thÇn Y (199/200). ¤ng ta nãi cÇn ph¶i cã 2 lo¹i d­îc liÖu lµ v¶y th»n l»n löa vµ l«ng mai rïa lôc m·o.<enter><color=red>B­íc 3<color>: Tõ Ba L¨ng HuyÖn -> Vò L¨ng S¬n -> Phôc L­u §éng. §¸nh c¸c con Th»n L»n ®á (179/190), (216/190), (204/192), (188/183) lÊy v¶y th»n l»n löa.<enter><color=red>B­íc 4<color>: VÒ Thiªn V­¬ng §¶o gÆp l·o Ng­ ¤ng (179/210). ¤ng Êy chÊp nhËn cho b¹n con rïa xanh víi ®iÒu kiÖn b¹n ph¶i t×m cho «ng Êy vµi con giun ®Êt vÒ lµm måi c©u.<enter><color=red>B­íc 5<color>: Qua gÆp cËu bÐ Thñy Sinh (184/212). CËu ta ®ång ý ®µo cho b¹n vµi con giun ®Êt nÕu b¹n t×m cho cËu ta mãn trøng luéc cËu ta ­a thÝch.<enter><color=red>B­íc 6<color>: GÆp Ng­ Phô Hµ TÈu (190/213). NhËn lêi ®i mua dïm mét Ýt Liªn Tö.<enter><color=red>B­íc 7<color>: VÒ Ba l¨ng HuyÖn, ®Õn TiÖm t¹p hãa (199/198) mua h¹t sen ®em vÒ cho Ng­ Phô Hµ TÈu.<enter><color=red>B­íc 8<color>: LÇn l­ît gÆp : Ng­ Phô Hµ TÈu -> bÐ Thñy Sinh -> l·o Ng­ ¤ng.<enter><color=red>B­íc 9<color>: LÊy ®­îc 2 vËt phÈm, ®em vÒ §¹i §iÖn cho Lé V©n ViÔn, hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Lé V¨n ViÔn","",0,1,61,1603,3191},
			[3] = {"Ng« thÇn y","",0,1,53,1600,3211},
			[4] = {"§¸nh th»n l»n ®á lÊy vÈy th»n l»n löa","",1,1,73,1431,3052},
			[5] = {"GÆp Ng­ «ng","",0,1,59,1429,3378},
			[6] = {"Thñy Sinh","",0,1,59,1479,3405},
			[7] = {"Hµ TÈu","",0,0,59,190,213},
			[8] = {"T¹p hãa Ba L¨ng HuyÖn","",0,0,53,199,198},
			[9] = {"Hµ TÈu","",0,0,59,190,213},
			[10] = {"Thñy Sinh","",0,1,59,1479,3405},
			[11] = {"GÆp Ng­ «ng","",0,1,59,1429,3378},
			[12] = {"GÆp Lé V¨n ViÔn","",0,1,61,1603,3191},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 Thiªn V­¬ng Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Kim Chung Tr¸o<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hé §¶o T­íng Qu©n. Häc ®­îc vâ c«ng: Kim Chung Tr¸o. N¬i tiÕp nhËn nhiÖm vô: §Þa Hé Ph¸p H¹ Thµnh.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1<color>: GÆp §Þa Hé Ph¸p H¹ Thµnh (209/196) nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn §éng §×nh hå (209/196) ë phÝa ®«ng Thiªn V­¬ng §¶o. Vµo tÇng 2, ®¸nh Thñy Qu¸i (209/196) ®Õn khi nµo l­îm ®­îc ®¸ ngò s¾c.<enter><color=red>B­íc 3<color>: Trë VÒ trao ®¸ ngò s¾c cho §Þa Hé Ph¸p H¹ Thµnh (209/196), hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp H¹ Thµnh","",0,1,59,1672,3145},
			[3] = {"§¸nh Thñy Qu¸i lÊy §¸ ngò s¾c","",1,1,67,1420,3140},
			[4] = {"GÆp H¹ Thµnh","",0,1,59,1672,3145},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ Thiªn V­¬ng Bang<color>"},
			--[1] = {"SÏ ®­îc phong lµ: K×nh Thiªn Nguyªn So¸i. N¬i tiÕp nhËn nhiÖm vô: Thiªn V­¬ng Bang Chñ D­¬ng Anh.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1<color>: §Õn TÈm Cung gÆp bang chñ D­¬ng Anh (223/196), nhËn nhiÖm vô ®i lÊy Thiªn V­¬ng Di Th¬.<enter><color=red>B­íc 2<color>: Ra bÕn tµu (177/216), ®Õn Thanh Loa ®¶o.<enter><color=red>B­íc 3<color>: §¸nh mét trong 5 con m·nh thó: Cãc Tinh (194/195), (201/187), C¸ SÊu Tinh (184/188), (186/197), Th»n L»n Tinh (206/194) lÊy ch×a khãa.<enter><color=red>B­íc 4<color>: Cã ®­îc ch×a khãa, ®Õn më r­¬ng trªn Thanh Loa ®¶o (205/186). Ph¸t hiÖn r­¬ng trèng kh«ng. Di Th¬ ®· bÞ mét nhãm ng­êi lÊy ®i, ch¹y vµo Thanh Loa s¬n ®éng.<enter><color=red>B­íc 5<color>: Vµo Thanh Loa s¬n ®éng ®¸nh b¹i §å TÓ (240/199). LÊy l¹i ®­îc Di Th¬.<enter><color=red>B­íc 6<color>: Mang Di th¬ vÒ cho bang chñ D­¬ng Anh (223/196), hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp D­¬ng Anh","",0,1,62,1609,3199},
			[3] = {"Ra bÕn tµu ®i Thanh Loa §¶o","",1,1,59,1416,3467},
			[4] = {"Tiªu diÖt Cãc tinh kiÕm ch×a khãa","",1,1,68,1552,3125},
			[5] = {"Më r­¬ng t×m kiÕm bøc th¬","",1,1,68,1643,2985},
			[6] = {"§¸nh b¹i §å TÓ lÊy thiªn v­¬ng di th­","",1,1,69,1920,3190},
			[7] = {"Mang di th¬ cho bang chñ D­¬ng Anh","",0,1,62,1609,3199},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n Thiªn V­¬ng Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thiªn V­¬ng ChiÕn ý<enter>V« T©m Tr¶m, HuyÕt ChiÕn B¸t Ph­¬ng<enter>Thõa Long QuyÕt<color>"},
			[2] = {"§èi tho¹i Bang Chñ, nép 5 v¹n l­îng","",0,1,62,1609,3199},
		},
		[8] = {---------------------------------------------------
			[1] = {"<color=green>NhiÖm vô cÊp 90 Thiªn V­¬ng Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Ph¸ Thiªn Tr¶m<enter>Truy Tinh Trôc NguyÖt<enter>Truy Phong QuyÕt<color>"},
			--[1] = {"Yªu cÇu: Tõ cÊp 90 trë lªn, danh väng trªn 240 ®iÓm, lµ §­êng M«n ký danh ®Ö tö, tr­íc m¾t ch­a gia nhËp m«n ph¸i nµo.<enter>PhÇn th­ëng:<enter>NhiÕp Hån NguyÖt ¶nh<enter>Cöu Cung Phi TÝnh<enter>B¹o Vò Lª Hoa<enter>Lo¹n Hoµn KÝch<enter>Danh väng ®­îc 30 ®iÓm. (TÊt c¶ c¸c m«n ph¸i kh¸c ®Òu cã thÓ lµm nhiÖm vô nµy ®Ó nhËn phÇn th­ëng ®iÓm danh väng, nh¬ng kh«ng häc ®­îc chiªu thøc)<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1: <color>§Õn Thµnh §« -> th«n Giang T©n, gÆp §­êng Nguyªn (430,385), biÕt ®­îc §­êng BÊt NhiÔm cã nh÷ng dÊu hiÖu bÊt th­êng vµ b¹n quyÕt t©m t×m hiÓu cho cÆn kÏ mäi viÖc.<enter><color=red>B­íc 2: <color>§Õn §­êng M«n t¹i phßng TÕ tæ phßng (513,317), gÆp §­êng BÊt NhiÔm... H¾n nhê b¹n chuyÓn dïm 1 bøc th¬.<enter><color=red>B­íc 3: <color>§Õn BiÖn Kinh gÆp B¹ch C«ng Tö (207,191) giao th¬. H¾n ®äc th¬ mét håi råi giao l¹i cho b¹n 1 bøc th¬ håi ©m.<enter><color=red>B­íc 4: <color>Quay l¹i §­êng M«n giao th¬ cho §­êng BÊt NhiÔm . §¸nh b¹i §­êng BÊt NhiÔm, nhËn quyÓn s¸ch §­êng M«n TuyÖt Häc MËt TÞch. (L­u ý: nÕu Nh­ trong lóc ®¸nh, b¹n cã bÞ tö th­¬ng, b¹n vÉn cã thÓ vµo ®¸nh tiÕp, m¸u cña §­êng BÊt NhiÔm vÉn bÞ mÊt Nh­ thêi ®iÓm b¹n chÕt).<enter><color=red>B­íc 5: <color>§Õn BiÖn Kinh -> Thiªn NhÉn gi¸o -> tÇng 1 -> tÇng 2 -> tÇng 3 gÆp §oan Méc DuÖ (225,199) giao s¸ch. §oan Méc DuÖ l¹i nhê b¹n göi lêi ®Õn §­êng BÊt NhiÔm.<enter><color=red>B­íc 6: <color>Quay l¹i §­êng M«n gÆp §­êng BÊt NhiÔm, hoµn thµnh nhiÖm vô.<enter>L­u ý:<enter>NÕu ®· lªn ®­îc tÇng 2 råi mµ bÞ chÕt th× khi vµo ®éng l¹i cø viÖc lªn tÇng 2, kh«ng cÇn ®¸nh l¹i ë tÇng 1."},
			[2] = {"GÆp Tr­¬ng TiÓu TuyÒn","",0,1},
			[3] = {"GÆp Hµ Mé TuyÕt","",0,1},
			[4] = {"GÆp H÷u Sø D­¬ng Hå","",0,1},
			[5] = {"Quay l¹i Hµ Mé TuyÕt","",0,1},
			[6] = {"GÆp Kh©u Anh","",0,0},
			[7] = {"Quay vÒ H÷u Sø D­¬ng Hå, hoµn thµnh nhiÖm vô","",0,1},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = {--------------------------------------------------
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö Thiªn V­¬ng Bang<color>"},
			[2] = {"GÆp T«n §¹o LÜnh","",0,1},
			[3] = {"GÆp ¤ng chñ Töu ®iÕm Ba L¨ng HuyÖn","",0,1},
			[4] = {"T×m HuyÒn S©m","",0,1},
			[5] = {"T×m Linh Chi","",0,1},
			[6] = {"GÆp Hµ Thñ ¤","",0,0},
			[7] = {"Quay vÒ ¤ng chñ Töu ®iÕm (Quay l¹i lÇn n÷a sau 1 tiÕng)","",0,1},
			[7] = {"Quay vÒ ¤ng chñ Töu ®iÕm(","",0,1},
			[7] = {"Mang R­îu cho T«n §¹o LÜnh, hoµn thµnh nhiÖm vô","",0,1},
		},
	},
	[2] = { --Duong Mon
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 §­êng M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>§­êng M«n ¸m khÝ<enter>§Þa DiÖm Háa<color>"},
			--[1] = {"SÏ ®­îc phong lµ: <color=yellow>Tr¸ng §inh<color>.<enter>Häc ®­îc vâ c«ng: §­êng M«n ¸m khÝ , §Þa DiÖm Háa <enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1:<color> §Õn phßng vâ c«ng (510,317), gÆp §­êng H¹c tiÕp nhËn nhiÖm vô truy t×m Ma Vò Ch©m.<enter><color=red>B­íc 2:<color> §Õn Thµnh §« (tõ §­êng M«n ch¹y xuèng cæng phÝa d­íi), t×m Mai N­¬ng (389,315).<enter><color=red>B­íc 3:<color> §Õn nhµ T«n UyÓn (394,323). C« Êy chÊp nhËn ®æi cho b¹n Ma Vò Ch©m lÊy 1 c¸i NhÉn M· N·o.<enter><color=red>B­íc 4:<color> §Õn TiÖm t¹p hãa trong Thµnh §« (386,321) dïng 500 l­îng mua chiÕc NhÉn M· N·o , trë vÒ ®æi cho T«n UyÓn lÊy Ma Vò Ch©m.<enter><color=red>B­íc 5:<color> Trë vÒ §­êng M«n, giao Ma Vò Ch©m cho §­êng H¹c , hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn phßng vâ c«ng gÆp §­êng H¹c","",0,1,31,1607,3204},
			[3] = {"§Õn Thµnh §« gÆp Mai N­¬ng","",0,1,11,3116,5053},
			[4] = {"GÆp T«n UyÓn ®æi Ma Vò Ch©m","",0,1,11,3155,5184},
			[5] = {"Mua nhÉn m· n·o t¹i t¹p hãa","",0,1,11,3094,5139},
			[6] = {"Mang nhÉn M· N·o ®æi Ma Vò Ch©m cña T«n UyÓn","",0,1,11,3155,5184},
			[7] = {"Giao Ma Vò Ch©m cho §­êng H¹c, hoµn thµnh nhiÖm vô","",0,1,31,1607,3204},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 §­êng M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>§éc ThÝch Cèt<color>"},
			--[1] = {"SÏ ®­îc phong lµ: <color=yellow>Hé ViÖn<color>.<enter>Häc ®­îc vâ c«ng: §éc ThÝch Cèt<enter>N¬i tiÕp nhËn nhiÖm vô: §­êng NhÊt TrÇn.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1:<color> §Õn §¹i s¶nh Phßng nghÞ sù (507,319) gÆp §­êng NhÊt TrÇn , nhËn nhiÖm vô.<enter><color=red>B­íc 2:<color> §Õn V« T©m Cèc (tõ §­êng M«n ®i sang cæng bªn phÝa ®«ng b¾c) ®¸nh b¹i 2 con GÊu Ngùa (526,291), (531,293) vµ 2 con X¸ LÞ tinh (528,294), (524,290) lÊy ®­îc 4 sîi t¬ trªn ®ã ghi khÈu quyÕt.<enter><color=red>B­íc 3:<color> §Õn tr­íc c¨n nhµ ë V« T©m Cèc (528,291), nhÊp vµo khung cöa sÏ ®èi tho¹i víi §­êng U.<enter><color=red>B­íc 4:<color> §Õn hå PhØ Thóy ë phÝa T©y §­êng M«n, ph¸t hiÖn ra mét con XÝch DiÖm Ng¹c (c¸ sÊu) (472,324), ®¸nh b¹i nã lÊy ®­îc Kim H¹ng QuyÒn (X¸c suÊt 50 %).<enter><color=red>B­íc 5:<color> Trë l¹i V« T©m Cèc, nhÊp vµo cöa gç, ®èi tho¹i víi §­êng U. Bµ ta yªu cÇu b¹n mang sîi d©y chuyÒn vÒ giao cho Ch­ëng m«n §­êng Cõu.<enter><color=red>B­íc 6:<color> §Õn phßng kh¸ch (508,322) gÆp Ch­ëng m«n §­êng Cõu giao Kim H¹ng QuyÒn , hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp §­êng NhÊt TrÇn","",0,1,34,1593,3204},
			[3] = {"§¸nh b¹i GÊu Ngùa - Täa §é 1","",1,1,25,4211,4674},
			[4] = {"§¸nh b¹i GÊu Ngùa - Täa ®é 2","",1,1,25,4248,4688},
			[5] = {"§¸nh b¹i X¸ LÞ Tinh - Täa ®é 1","",1,1,25,230,4724},
			[6] = {"§¸nh b¹i X¸ LÞ Tinh - Täa ®é 2","",1,1,25,4197,4635},
			[7] = {"§èi tho¹i víi §­êng U trong c¨n nhµ gç","",1,1,25,4227,4667},
			[8] = {"§¸nh XÝch DiÖm Ng¹c [C¸ SÊu §á] lÊy Kim H¹ng QuyÒn","",1,1,25,3716,5050},
			[9] = {"Trë l¹i gÆp §­êng U nãi chuyÖn","",1,1,25,4227,4667},
			[10] = {"Giao Kim H¹ng QuyÒn cho §­êng Cõu, hoµn thµnh nhiÖm vô","",0,1,33,1617,3191},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 §­êng M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Truy T©m TiÔn<enter>M¹n Thiªn Hoa Vò <enter>§o¹t Hån Tiªu<enter>Xuyªn T©m Thø<color>"},
			--[1] = {"SÏ ®­îc phong lµ: <color=yellow>Giíi TiÒn Hé VÖ<color>.<enter>Häc ®­îc vâ c«ng:<enter>Truy T©m TiÔn<enter>M¹n Thiªn Hoa Vò <enter>§o¹t Hån Tiªu<enter>Xuyªn T©m Thø <enter>N¬i tiÕp nhËn nhiÖm vô: <color=yellow>§­êng BÊt NhiÔm<color>.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1:<color> §Õn phßng TÕ tæ phßng (514,318), gÆp §­êng BÊt NhiÔm, nhËn nhiÖm vô. Gióp §­êng V©n s¬ thóc tr¶ thï vµ lÊy l¹i Háa KhÝ phæ.<enter><color=red>B­íc 2:<color> §Õn Thµnh §« -> Thanh Thµnh S¬n -> B¹ch V©n ®éng (356,242) ®¸nh b¹i §¹i ®Çu môc Cuång Sa (229,200), biÕt ®­îc Háa KhÝ phæ ®· bÞ giÊu trong r­¬ng. Cßn ch×a khãa bÞ giÊu t¹i mét n¬i nµo ®ã trong ®éng.<enter><color=red>B­íc 3:<color> §¸nh b¹i 4 tªn tiÓu ®Çu môc: §éc NhÜ (218,200), ThiÕt TÝ (219,207), Quû ¶nh (239,202), LÞch QuyÒn (228,197), lÊy ®­îc ch×a khãa (x¸c suÊt 50%), më r­¬ng (230,199) lÊy ®­îc Háa KhÝ phæ.<enter><color=red>B­íc 4:<color> Trë vÒ §­êng M«n, ®Õn phßng Háa d­îc (512,324) giao Háa KhÝ phæ cho §­êng V©n, hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp §­êng BÊt NhiÔm","",0,1,36,1595,3189},
			[3] = {"§¸nh §¹i §Çu Môc Cuång Sa - B¹ch V©n §éng","",1,1,22,1831,3200},
			[4] = {"§¸nh b¹i §éc NhÜ","",1,1,22,1748,3201},
			[5] = {"§¸nh b¹i ThiÕt TÝ","",1,1,22,1757,3313},
			[6] = {"§¸nh b¹i Quû ¶nh","",1,1,22,1910,3241},
			[7] = {"§¸nh b¹i LÞch QuyÒn","",1,1,22,1833,3148},
			[8] = {"Më R­¬ng lÊy háa KhÝ Phæ","",1,1,22,1841,3194},
			[9] = {"Mang háa KhÝ Phæ cho §­êng V©n, hoµn thµnh nhiÖm vô","",0,1,30,1599,3203},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 §­êng M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Hµn B¨ng ThÝch<color>"},
			--[1] = {"SÏ ®­îc phong lµ: <color=yellow>NhËp C¸c §Ö Tö<color>.<enter>Häc ®­îc vâ c«ng: Hµn B¨ng ThÝch <enter>N¬i tiÕp nhËn nhiÖm vô: §­êng D·<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1:<color> §Õn phßng Y D­îc (515,322) gÆp §­êng D·, nhËn nhiÖm vô.<enter><color=red>B­íc 2:<color> §Õn Thµnh §« -> Thanh Thµnh S¬n, ®i th¼ng vÒ phÝ t©y gÆp C¶nh Tö Kú (230,245). ¤ng ta b¾t b¹n ph¶i v­ît qua mét thö th¸ch lµ ®¸nh b¹i n¨m con gia sóc cña «ng ta lµ: Sãi x¸m (238,244), M·nh Hæ (241,259), Kim TiÒn B¸o (224,247), Heo Rõng (234,236), T«ng Hïng (241,238).<enter><color=red>B­íc 3:<color> Sau khi ®¸nh b¹i n¨m con thó, quay l¹i gÆp C¶nh Tö Kú. C¶nh Tö Kú nhê b¹n t×m c¸ch cøu con g¸i «ng ta ®ang l©m träng bÖnh.<enter><color=red>B­íc 4:<color> Trë l¹i §­êng M«n ®Õn phßng Y D­îc, gÆp §­êng D· . ¤ng ta b¶o cho b¹n biÕt ph­¬ng thuèc ch÷a c¨n bÖnh kú l¹ ®ã.<enter><color=red>B­íc 5:<color> Trë lªn Thanh Thµnh S¬n , t¹i Thanh D­¬ng phong (297,233) ë §«ng B¾c Thanh Thµnh s¬n, ®¸nh b¹i Hung Thó vµ Linh §iªu (316,215), (304,227), (304,218), (308,225), (314,223), H¾c ¬ng (297,231) lÊy ®­îc n¨m lo¹i d­îc liÖu: da cña Ve sÇu, gan r¾n ®éc, vá h¹t Anh Tóc, ®u«i rÕt ®éc, ®Çu cña Thiªn t»m.<enter><color=red>B­íc 6:<color> Quay l¹i gÆp C¶nh Tö Kú . C¶nh Tö Kú tá ý hèi hËn v× ®· hiÓu lÇm §­êng D· tr­íc ®©y.<enter><color=red>B­íc 7:<color> Trë l¹i §­êng M«n ®Õn phßng Y D­îc, b¸o l¹i kÕt qu¶ víi §­êng D· . Hoµn thµnh nhiÖm vô"},
			[2] = {"GÆp §­êng D·","",0,1,32,1603,3210},
			[3] = {"GÆp C¶nh Tö Kú","",1,1,21,1846,3924},
			[4] = {"§¸nh b¹i Sãi X¸m","",1,1,21,1906,3913},
			[5] = {"§¸nh b¹i M·nh Hæ","",1,0,21,241,259},
			[6] = {"§¸nh b¹i Kim TiÒn B¸o","",1,1,21,1797,3952},
			[7] = {"§¸nh b¹i Heo Rõng","",1,1,21,1881,3788},
			[8] = {"§¸nh b¹i T«ng Hïng","",1,0,21,241,238},
			[9] = {"Quay l¹i gÆp C¶nh Tö Kú","",1,1,21,1846,3924},
			[10] = {"Trë l¹i §­êng M«n ®Õn phßng Y D­îc, gÆp §­êng D·","",0,1,32,1603,3210},
			[11] = {"§¸nh b¹i Hung Thó - Täa §é 1","",1,1,21,2545,3415},
			[12] = {"§¸nh b¹i Hung Thó - Täa §é 2","",1,1,21,2436,3635},
			[13] = {"§¸nh b¹i Linh §iªu - Täa §é 1","",1,1,21,2535,3448},
			[14] = {"§¸nh b¹i Linh §iªu - Täa §é 2","",1,1,21,2434,3492},
			[15] = {"§¸nh b¹i Linh §iªu - Täa §é 3","",1,1,21,2502,3578},
			[16] = {"§¸nh b¹i H¾c ¦ng","",1,1,21,2370,3708},
			[17] = {"Quay l¹i gÆp C¶nh Tö Kú","",1,1,21,1846,3924},
			[18] = {"Trë l¹i §­êng M«n ®Õn phßng Y D­îc, gÆp §­êng D·, hoµn thµnh nhiÖm vô","",0,1,32,1603,3210},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 §­êng M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>L«i KÝch thuËt<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Tø L·o M«n Nh©n.<enter>Häc ®­îc vâ c«ng: L«i KÝch thuËt<enter>N¬i tiÕp nhËn nhiÖm vô: §­êng Nhµn.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1:<color> §Õn phßng ¸m khÝ (504/317) gÆp §­êng Nhµn, nhËn nhiÖm vô truy t×m bÝ kÝp bÞ mÊt.<enter><color=red>B­íc 2:<color> §Õn phßng NghÞ sù (507/319) gÆp §­êng NhÊt TrÇn , biÕt ®­îc cã 2 kÎ ®¸ng kh¶ nghi.<enter><color=red>B­íc 3:<color> §Õn Thµnh §« -> th«n Giang T©n, gÆp §­êng Nguyªn (430/385). §­êng Nguyªn cho biÕt ®· thÊy §­êng Hßa ®· ®i ®Õn H­ëng Thñy §«ng.<enter><color=red>B­íc 4:<color> §Õn Thµnh §« -> Thanh Thµnh S¬n -> H­ëng Thñy ®éng (214/242) n»m ë cùc t©y cña nói Thanh Thµnh. Vµo ®éng ®¸nh b¹i §­êng Hßa (234/207), biÕt ®­îc ¸m KhÝ phæ ®ang giÊu trong s¬n ®éng.<enter><color=red>B­íc 5:<color> §¸nh b¹i c¸c tªn ®ång ®¶ng cña §­êng Hßa lµ: ThiÕt QuyÒn DiÖm La (232/210; 214/203; 224/201; 246/204) hoÆc ThiÕt Chïy Ma Qu©n (217/205; 234/200). §¸nh b¹i bän chóng sÏ lÊy l¹i ®­îc ¸m KhÝ phæ (X¸c suÊt 50%).<enter><color=red>B­íc 6:<color> Trë l¹i phßng ¸m khÝ, giao ¸m KhÝ phæ cho §­êng Nhµn , hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp §­êng Nhµn","",0,1,29,1599,3203},
			[3] = {"GÆp §­êng NhÊt TrÇn","",0,1,34,1593,3204},
			[4] = {"GÆp §­êng Nguyªn","",0,1,20,3444,6169},
			[5] = {"§¸nh b¹i §­êng Hßa","",1,0,24,234,207},
			[6] = {"§¸nh b¹i ThiÕt QuyÒn DiÖm La","",1,0,24,232,210},
			[7] = {"§¸nh b¹i ThiÕt Chïy Ma Qu©n","",1,1,24,1736,3295},
			[8] = {"Giao ¸m KhÝ phæ cho §­êng Nhµn, hoµn thµnh nhiÖm vô","",0,1,29,1599,3203},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ §­êng M«n<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Thiªn Thñ ThÇn VÖ.<enter>N¬i tiÕp nhËn nhiÖm vô: Ch­ëng M«n §­êng Cöu.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1:<color> §Õn Phßng kh¸ch (508,322) gÆp Ch­ëng m«n §­êng Cõu , nhËn nhiÖm vô thu håi ThÊt Tinh TuyÖt MÖnh KiÕm.<enter><color=red>B­íc 2:<color> §Õn Tróc T¬ ®éng (523,326) (®i cöa bªn ph¶i cña §­êng M«n).<enter><color=red>B­íc 3:<color> T¹i tÇng 1 ®¸nh b¹i tªn M·ng H¸n §Çu LÜnh (189,205; 185,204; 190,202; 192,200; 197,201) sÏ lÊy ®­îc ch×a kho¸ tÇng 2.<enter><color=red>B­íc 4:<color> T¹i tÇng 2 ®¸nh b¹i Tinh Hæ (194,198; 197,201) sÏ lÊy ®­îc ch×a kho¸ lªn tÇng 3.<enter><color=red>B­íc 5:<color> Lªn tÇng 3 cã 2 r­¬ng: trªn vµ d­íi (1 chøa tiÒn, 1 chøa §o¹t Hån KiÕm). Chän r­¬ng ë trªn sÏ lÊy ®­îc ThÊt Tinh TuyÖt MÖnh KiÕm.<enter><color=red>B­íc 6:<color> VÒ giao kiÕm cho Ch­ëng m«n §­êng Cõu lµ hoµn thµnh nhiÖm vô. Cßn nÕu chän nhÇm r­¬ng chøa tiÒn th× vÒ gÆp Ch­ëng m«n §­êng Cõu nép ph¹t 4 v¹n l­îng råi lµm l¹i nhiÖm vô.<enter><color=red>L­u ý:<color><enter>NÕu ®· lªn ®­îc tÇng 2 råi mµ bÞ chÕt th× khi vµo ®éng l¹i cø viÖc lªn tÇng 2, kh«ng cÇn ®¸nh l¹i ë tÇng 1."},
			[2] = {"GÆp Ch­ëng m«n §­êng Cõu","",0,1,33,1617,3191},
			[3] = {"§¸nh b¹i tªn M·ng H¸n §Çu LÜnh","",1,1,26,1512,3290},
			[4] = {"Sö dông ch×a khãa lªn tÇng 2","",1,1,26,1597,3216},
			[5] = {"§¸nh b¹i Tinh Hæ","",1,0,27,194,198},
			[6] = {"Sö dông ch×a khãa lªn tÇng 3","",1,1,27,1602,3210},
			[7] = {"GÆp Ch­ëng m«n §­êng Cõu, hoµn thµnh nhiÖm vô","",0,1,33,1617,3191},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n §­êng M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>TiÓu Lý Phi §ao<enter>T¸n Hoa Tiªu<enter>Thiªn La §Þa Vâng<enter>T©m Nh·n<color>"},
			--[1] = {"Yªu cÇu: ng­êi ch¬i ®· xuÊt s­, ®¼ng cÊp trªn 60, ch­a gia nhËp bang ph¸i nµo, cã thÓ ®Õn gÆp tr­ëng m«n cña ph¸i giao 5 v¹n l­îng ®Ó trïng ph¶n s­ m«n. Tõ ®ã vÒ sau cã thÓ tïy ý ra vµo s­ m«n.<enter>PhÇn Thuëng:<enter>TiÓu Lý Phi §ao<enter>T¸n Hoa Tiªu<enter>Thiªn La §Þa Vâng<enter>T©m Nh·n<enter>§­îc phong lµm: Lôc C¸c Tr­ëng L·o."},
			[2] = {"§èi tho¹i Ch­ëng M«n, nép 5 v¹n l­îng","",0,1,33,1617,3191},
		},
		[8] = {
			[1] = {"<color=green>NhiÖm vô cÊp 90 §­êng M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>NhiÕp Hån NguyÖt ¶nh<enter>Cöu Cung Phi TÝnh<enter>B¹o Vò Lª Hoa<enter>Lo¹n Hoµn KÝch<color>"},
			--[1] = {"Yªu cÇu: Tõ cÊp 90 trë lªn, danh väng trªn 240 ®iÓm, lµ §­êng M«n ký danh ®Ö tö, tr­íc m¾t ch­a gia nhËp m«n ph¸i nµo.<enter>PhÇn th­ëng:<enter>NhiÕp Hån NguyÖt ¶nh<enter>Cöu Cung Phi TÝnh<enter>B¹o Vò Lª Hoa<enter>Lo¹n Hoµn KÝch<enter>Danh väng ®­îc 30 ®iÓm. (TÊt c¶ c¸c m«n ph¸i kh¸c ®Òu cã thÓ lµm nhiÖm vô nµy ®Ó nhËn phÇn th­ëng ®iÓm danh väng, nh¬ng kh«ng häc ®­îc chiªu thøc)<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1: <color>§Õn Thµnh §« -> th«n Giang T©n, gÆp §­êng Nguyªn (430,385), biÕt ®­îc §­êng BÊt NhiÔm cã nh÷ng dÊu hiÖu bÊt th­êng vµ b¹n quyÕt t©m t×m hiÓu cho cÆn kÏ mäi viÖc.<enter><color=red>B­íc 2: <color>§Õn §­êng M«n t¹i phßng TÕ tæ phßng (513,317), gÆp §­êng BÊt NhiÔm... H¾n nhê b¹n chuyÓn dïm 1 bøc th¬.<enter><color=red>B­íc 3: <color>§Õn BiÖn Kinh gÆp B¹ch C«ng Tö (207,191) giao th¬. H¾n ®äc th¬ mét håi råi giao l¹i cho b¹n 1 bøc th¬ håi ©m.<enter><color=red>B­íc 4: <color>Quay l¹i §­êng M«n giao th¬ cho §­êng BÊt NhiÔm . §¸nh b¹i §­êng BÊt NhiÔm, nhËn quyÓn s¸ch §­êng M«n TuyÖt Häc MËt TÞch. (L­u ý: nÕu Nh­ trong lóc ®¸nh, b¹n cã bÞ tö th­¬ng, b¹n vÉn cã thÓ vµo ®¸nh tiÕp, m¸u cña §­êng BÊt NhiÔm vÉn bÞ mÊt Nh­ thêi ®iÓm b¹n chÕt).<enter><color=red>B­íc 5: <color>§Õn BiÖn Kinh -> Thiªn NhÉn gi¸o -> tÇng 1 -> tÇng 2 -> tÇng 3 gÆp §oan Méc DuÖ (225,199) giao s¸ch. §oan Méc DuÖ l¹i nhê b¹n göi lêi ®Õn §­êng BÊt NhiÔm.<enter><color=red>B­íc 6: <color>Quay l¹i §­êng M«n gÆp §­êng BÊt NhiÔm, hoµn thµnh nhiÖm vô.<enter>L­u ý:<enter>NÕu ®· lªn ®­îc tÇng 2 råi mµ bÞ chÕt th× khi vµo ®éng l¹i cø viÖc lªn tÇng 2, kh«ng cÇn ®¸nh l¹i ë tÇng 1."},
			[2] = {"GÆp §­êng Nguyªn","",0,1,20,3444,6169},
			[3] = {"GÆp §­êng BÊt NhiÔm","",0,1,36,1595,3189},
			[4] = {"GÆp B¹ch C«ng Tö","",0,1,37,1656,3062},
			[5] = {"Giao th¬ cho §­êng BÊt NhiÔm","",0,1,36,1595,3189},
			[6] = {"GÆp §oan Méc DuÖ","",0,0,49,1793,3190},
			[7] = {"GÆp §­êng BÊt NhiÔm, hoµn thµnh nhiÖm vô","",0,1,36,1595,3189},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
			--[1] = {"MËt tÞch kü n¨ng 120 cã thÓ ®æi t¹i Ch­ëng m«n. <enter>VËt phÈm cÇn thiÕt ®Ó ®æi:<enter>1 quyÓn Bµn Nh­îc T©m Kinh, 1 bé s¸ch kü n¨ng 90 cña m«n ph¸i m×nh, 1 viªn Tinh Hång B¶o Th¹ch vµ 1 viªn Thñy Tinh."},
		},
		[10] = {
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö §­êng M«n<color>"},
			--[1] = {"<color=red>B­íc 1: <color>T×m c¸ch vÒ Thµnh §« Phñ, råi ch¹y bé theo h­íng §«ng-Nam ®Ó sang §­êng M«n. §Õn lèi vµo Tróc H¶i Tam Quan, b¹n h·y nãi chuyÖn víi §­êng M«n Tr¸ng §inh thø nhÊt (453,357), vµ xin nhËn lµm ®Ö tö Ký danh, y sÏ nãi cho b¹n biÕt ph¶i lµm g×.<enter><color=red>B­íc 2: <color>ChØ cÇn giÕt 1 trong 3 con §¹i M· HÇu (461,357), (460,354), (455,354) lÊy ®­îc Thanh S¾c Tróc Tr­îng (gËy tróc mµu xanh).<enter><color=red>B­íc 3: <color>Råi ®i tiÕp gÆp §­êng M«n Tr¸ng §inh thø 2 (468,349), tªn nµy sÏ b¾t b¹n gi¶i mét bµi to¸n ma trËn, nÕu b¹n c¶m thÊy khã kh¨n khi gi¶i bµi to¸n nµy h·y tr· lêi Nh­ sau: [2-9-4], [7-5-3], [6-1-8]. Gi¶i xong bµi to¸n ®ã, y sÏ tÆng b¹n B¹ch S¾c Tróc Tr­îng (gËy tróc mµu tr¾ng).<enter><color=red>B­íc 4: <color>C¸c h¹ t×m ®Õn tªn §­êng M«n Tr¸ng §inh thø ba (474,342). H¾n sÏ ®­a ra mét sè c©u quÎ cña Khæng Minh cho b¹n gi¶i. (®¸p ¸n: LiÖt ho¶ oanh l«i - M­a giã khëi sinh - Thiªn tai dÞch häa. Sau khi tr¶ lêi xong, y sÏ tÆng b¹n Tö S¾c Tróc Tr­îng (gËy tróc mµu tÝm).<enter><color=red>B­íc 5: <color>Mang c¶ 3 c©y gËy ®ã tíi gÆp tªn §­êng M«n Tr¸ng §inh thø t­ (479,339) vµ giao cho h¾n. Hoµn thµnh nhiÖm vô!"},
			[2] = {"GÆp §­êng M«n Tr¸ng §inh thø nhÊt","",1,1,25,3630,5741},
			[3] = {"GiÕt §¹i M· HÇu","",1,0,25,461,357},
			[4] = {"GÆp §­êng M«n Tr¸ng §inh thø 2","",1,1,25,3749,5599},
			[5] = {"GÆp §­êng M«n Tr¸ng §inh thø 3","",1,1,25,3792,5480},
			[6] = {"GÆp §­êng M«n Tr¸ng §inh thø t­, hoµn thµnh nhiÖm vô","",0,0,25,479,339},
		},
	},
	[3] = { --Ngu doc
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 Ngò §éc Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Ngò §éc §ao ph¸p<enter>Ngò §éc Ch­ëng ph¸p<enter>Cöu Thiªn Cuång L«i<color>"},
			--[1] = {"SÏ ®­îc phong lµ: §o¹t Hån T¸n Nh©n. Häc ®­îc vâ c«ng: Ngò §éc §ao ph¸p, Ngò §éc Ch­ëng ph¸p, Cöu Thiªn Cuång L«i. N¬i tiÕp nhËn nhiÖm vô: MÆc Thï tr¹i, chñ tr¹i §éc Nha."},
			[2] = {"GÆp Tang Chu","",0,1,186,1599,3193},
			[3] = {"NhÖn 1 (Thu thËp ®ñ 10 con)","",1,1,195,716,2920},
			[4] = {"NhÖn 2 (Thu thËp ®ñ 10 con)","",1,1,195,713,3048},
			[5] = {"NhÖn 3 (Thu thËp ®ñ 10 con)","",1,1,195,726,3169},
			[6] = {"NhÖn 4 (Thu thËp ®ñ 10 con)","",1,1,195,790,3126},
			[7] = {"Mua 10 bao tÝn th¹ch","",0,1,174,1574,3255},
			[8] = {"Quay vÒ gÆp Tang Chu, hoµn thµnh nhiÖm vô","",0,1,186,1599,3193},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 Ngò §éc Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>XÝch DiÖm Thùc Thiªn<enter>T¹p Nan D­îc Kinh<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Th«i MÖnh Sø gi¶. Häc ®­îc vâ c«ng: XÝch DiÖm Thùc Thiªn, T¹p Nan D­îc Kinh, N¬i tiÕp nhËn nhiÖm vô: Ng©n ThiÒm tr¹i chñ B¹ch Doanh Doanh."},
			[2] = {"GÆp B¹ch Doanh Doanh","",0,1,188,1602,3189},
			[3] = {"S¾c Quû 1 (Thu thËp 7 ®Çu ng­êi)","",1,1,179,1962,2661},
			[4] = {"S¾c Quû 2 (Thu thËp 7 ®Çu ng­êi)","",1,1,179,1976,2724},
			[5] = {"S¾c Quû 3 (Thu thËp 7 ®Çu ng­êi)","",1,1,179,1932,2706},
			[6] = {"S¾c Quû 4 (Thu thËp 7 ®Çu ng­êi)","",1,1,179,1851,2557},
			[7] = {"S¾c Quû 5 (Thu thËp 7 ®Çu ng­êi)","",1,1,179,1809,2599},
			[8] = {"S¾c Quû 6 (Thu thËp 7 ®Çu ng­êi)","",1,1,179,1828,2666},
			[9] = {"S¾c Quû 7 (Thu thËp 7 ®Çu ng­êi)","",1,1,179,1859,2712},
			[10] = {"GÆp B¹ch Doanh Doanh, hoµn thµnh nhiÖm vô","",0,1,188,1602,3189},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 Ngò §éc Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>U Minh Kh« L©u<enter>V« H×nh §éc<enter>B¸ch ®éc Xuyªn T©m<enter>B¨ng Lam HuyÒn Tinh<color>"},
			--[1] = {"SÏ ®­îc phong lµ: H¾c ¸m Diªm La. Häc ®­îc vâ c«ng: U Minh Kh« L©u, V« H×nh §éc, B¸ch ®éc Xuyªn T©m, B¨ng Lam HuyÒn Tinh. N¬i tiÕp nhËn nhiÖm vô: XÝch YÕt tr¹i chñ §å DÞ."},
			[2] = {"GÆp §å DÞ","",0,1,184,1599,3197},
			[3] = {"§¸nh b¹i Ph¶n TÆc (lÊy Méc H­¬ng §Ønh)","",1,1,193,1170,2928},
			[4] = {"Giao l¹i cho §å DÞ","",0,1,184,1599,3197},
			[5] = {"§¸nh Ph¶n TÆc §Çu Môc (lÊy Méc H­¬ng §Ønh thËt)","",1,1,193,1170,2928},
			[6] = {"Giao cho §å DÞ, hoµn thµnh nhiÖm vô","",0,1,184,1599,3197},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 Ngò §éc Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>V¹n §éc Thùc T©m<enter>Xuyªn Y Ph¸ Gi¸p<color>"},
			--[1] = {"SÏ ®­îc phong lµ: V« §éng La S¸t. Häc ®­îc vâ c«ng: V¹n §éc Thùc T©m, Xuyªn Y Ph¸ Gi¸p. N¬i tiÕp nhËn nhiÖm vô: Kim Xµ tr¹i chñ V©n BÊt Tµ."},
			[2] = {"GÆp V©n BÊt Tµ","",0,1,185,1607,3200},
			[3] = {"§Õn HiÖu thuèc (Mua X¹ H­¬ng)","",0,1,80,1771,3079},
			[4] = {"§¸nh Nh·n KÝnh V­¬ng M·ng Xµ (B¾t 1 con)","",1,1,183,944,2240},
			[5] = {"GÆp V©n BÊt Tµ, hoµn thµnh nhiÖm vô","",0,1,185,1607,3200},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 Ngò §éc Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Xuyªn T©m §éc Thø<color>"},
			--[1] = {"SÏ ®­îc phong lµ: C« §éc T«n Gi¶. Häc ®­îc vâ c«ng: Xuyªn T©m §éc Thø. N¬i tiÕp nhËn nhiÖm vô: Thanh Ng« tr¹i chñ Thang BËt."},
			[2] = {"GÆp Thang BËt","",0,1,187,1598,3192},
			[3] = {"L­u KhÊu 1 (lÊy tin tøc vÒ Ngäc San H«","",1,1,194,1835,3215},
			[4] = {"L­u KhÊu 2 (lÊy tin tøc vÒ Ngäc San H«","",1,1,194,1561,2816},
			[5] = {"§¸nh tªn C­êng §¹o (lÊy Ngäc San H«)","",1,1,182,1896,3464},
			[6] = {"Giao cho Thang BËt, hoµn thµnh nhiÖm vô","",0,1,187,1598,3192},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ Ngò §éc Gi¸o<color>"},
			--[1] = {"SÏ ®­îc phong lµ: U Minh Quû Sø. N¬i tiÕp nhËn nhiÖm vô: Gi¸o chñ Ngò §éc gi¸o H¾c DiÖn Lang Qu©n."},
			[2] = {"GÆp H¾c DiÖn Lang Qu©n","",0,1,189,1606,3189},
			[3] = {"§¸nh Nh¹n ®¨ng ph¸i ®Ö tö (§Õn khi Ch­ëng m«n xuÊt hiÖn, ®¸nh b¹i Ch­ëng m«n lÊy Tõ §éc Chu)","",1,1,196,1648,2944},
			[4] = {"GÆp H¾c DiÖn Lang Qu©n, hoµn thµnh nhiÖm vô","",0,1,189,1606,3189},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n Ngò §éc Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thiªn C­¬ng §Þa S¸t<enter>Chu C¸t Thanh Minh<enter>Ngò §éc Kú Kinh<color>"},
			[2] = {"§èi tho¹i Gi¸o chñ, nép 5 v¹n l­îng","",0,1,189,1606,3189},
		},
		[8] = {----------------------------------------
			[1] = {"<color=green>NhiÖm vô cÊp 90 Ngò §éc Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>¢m Phong Thùc Cèt<enter>HuyÒn ¢m Tr¶m<enter>§o¹n C©n Hñ Cèt<color>"},
			[2] = {"GÆp Uy DuÉn Chu©n","",0,1},
			[3] = {"GÆp V©n BÊt Tµ","",0,1},
			[4] = {"GÆp §­êng D·","",0,1},
			[5] = {"Quay l¹i gÆp V©n BÊt Tµ","",0,1},
			[6] = {"Quay l¹i Uy DuÉn Chu©n, hoµn thµnh nhiÖm vô","",0,1},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = {---------------------------------------------------
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö Ngò §éc Gi¸o<color>"},
			[2] = {"GÆp §Ö Tø Ngò §éc Gi¸o","",0,1},
			[3] = {"GiÕt §éc m·ng","",1,1},
			[4] = {"GiÕt Bä c¹p chóa","",1,1},
			[5] = {"GiÕt NhÖn ®éc","",1,1},
			[6] = {"GiÕt Cãc ®á","",1,1},
			[7] = {"GiÕt Th»n L»n","",1,1},
			[6] = {"Giao cho §Ö Tø Ngò §éc Gi¸o ë cöa ®éng, hoµn thµnh nhiÖm vô","",0,1},
		},
	},
	[4] = { -- Nga Mi
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 Nga Mi Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Nga My KiÕm ph¸p<enter>Nga My Ch­ëng ph¸p<color>"},
			--[1] = {"SÏ ®­îc phong lµ: <color=yellow>Vò Y Ni<color>.<enter>Häc ®­îc vâ c«ng:<color=yellow>Nga My KiÕm ph¸p<color>, <color=yellow>Nga My Ch­ëng ph¸p<color><enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1: <color>§Õn TiÒn ®iÖn (238,310) gÆp DiÖu Èn , tiÕp nhËn nhiÖm vô gióp c« Êy hµn g¾n chiÕc g­¬ng ®ång.<enter><color=red>B­íc 2: <color>Xuèng nói, t×m DiÖu Èn t­íng c«ng (241,328), nhÊp vµo lêi tho¹i, nhËn ®­îc nöa miÕng g­¬ng cßn l¹i.<enter><color=red>B­íc 3: <color>§Õn Thµnh §« gÆp thî rÌn (388,320).<enter><color=red>B­íc 4: <color>§Ó hai miÕng g­¬ng l¹i chç ng­êi thî rÌn, ®i t×m L­îng Ng©n Kho¸ng trong rõng phÝa t©y Thµnh §« (378,303; 379,299; 386,302; 386,300; 375,301; 375,297; 370,299). ChØ cÇn lÊy 1 viªn.<enter><color=red>B­íc 5: <color>Giao l­îng Ng©n Kho¸ng cho thî rÌn, nhËn ®­îc tÊm g­¬ng ®· söa xong.<enter><color=red>B­íc 6: <color>Trë vÒ Nga My ph¸i gÆp DiÖu Èn.<enter><color=red>B­íc 7: <color>Xuèng nói, gÆp DiÖu Èn t­íng c«ng , truyÒn lêi cña DiÖu Èn.<enter><color=red>B­íc 8: <color>Trë vÒ Nga My ph¸i, gÆp DiÖu Èn , hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp DiÖu ¢n","",0,1,16,1604,3170},
			[3] = {"T×m DiÖu Èn t­íng c«ng","",1,1,13,1927,5260},
			[4] = {"T×m thî rÌn Thµnh §«","",0,0,11,388,320},
			[5] = {"§i lÊy L­îng Ng©n Kho¸ng","",1,0,11,378,303},
			[6] = {"Giao L­îng Ng©n Kho¸ng cho thî rÌn","",0,0,11,388,320},
			[7] = {"GÆp DiÖu ¢n","",0,1,16,1604,3170},
			[8] = {"T×m DiÖu Èn t­íng c«ng","",1,1,13,1927,5260},
			[9] = {"GÆp DiÖu ¢n, hoµn thµnh nhiÖm vô","",0,1,16,1604,3170},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 Nga Mi Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Tõ Hµng Phæ §é<color>"},
			--[1] = {"SÏ ®­îc phong lµ: <color=yellow>CÈm Y Ni<color>.<enter>Häc ®­îc vâ c«ng: <color=yellow>Tõ Hµng Phæ §é<color><enter>N¬i tiÕp nhËn nhiÖm vô: Gi¶ng Kinh §­êng, DiÖu Nh­.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1: <color>§Õn Gi¶ng Kinh ®­êng (240,307) gÆp DiÖu Nh­, tiÕp nhËn nhiÖm vô thu phôc M·nh hæ.<enter><color=red>B­íc 2: <color>§Õn M·nh Hæ huyÖt ®éng phÝa sau nói, trong ®ã cã ba con B¹ch Hæ (Hæ Tr¾ng) (222,199; 225,201; 222,202), ph¶i ®¸nh ba con nµy liªn tôc ba lÇn, sÏ khuÊt phôc ®­îc chóng.<enter><color=red>B­íc 3: <color>Trë vÒ Gi¶ng Kinh ®­êng gÆp DiÖu Nh­ phôc mÖnh, hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp DiÖu Nh­","§Õn Gi¶ng Kinh ®­êng gÆp DiÖu Nh­, tiÕp nhËn nhiÖm vô thu phôc M·nh hæ",0,1,15,1586,3199},
			[3] = {"§Õn M·nh Hæ huyÖt ®éng","§Õn M·nh Hæ huyÖt ®éng phÝa sau nói, trong ®ã cã ba con B¹ch Hæ, ph¶i ®¸nh ba con nµy liªn tôc ba lÇn, sÏ khuÊt phôc ®­îc chóng.",1,1,14,1784,3197},
			[4] = {"GÆp DiÖu Nh­","Trë vÒ Gi¶ng Kinh ®­êng gÆp DiÖu Nh­ phôc mÖnh, hoµn thµnh nhiÖm vô",0,1,15,1586,3199},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 Nga Mi Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Th«i Song Väng NguyÖt<enter>Tø T­îng §ång Quy<enter>Méng §iÖp<color>"},
			--[1] = {"SÏ ®­îc phong lµ: B¹ch Liªn Tiªn Tö.<enter>Häc ®­îc vâ c«ng:<enter>Th«i Song Väng NguyÖt<enter>Tø T­îng §ång Quy<enter>Méng §iÖp<enter>N¬i tiÕp nhËn nhiÖm vô: Môc V©n Tõ.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1: <color>§Õn phÝa sau HËu ®iÖn (242,305), gÆp Môc V©n Tõ, tiÕp nhËn nhiÖm vô.<enter><color=red>B­íc 2: <color>§Õn tiÖm t¹p hãa ë Thµnh §« (386,321) mua ch©n gµ<enter><color=red>B­íc 3: <color>§Õn phÝa sau nói, t×m thÊy mét ®Çm n­íc, ®¸nh b¹i n¨m con Th»n L»n Chóa (297,302; 327,294; 312,304; 324,298; 311,300) sÏ cøu ®­îc Háa Hå (X¸c suÊt 50%). Háa Hå sÏ ph¸n ®o¸n xem b¹n cã ch©n gµ hay kh«ng, nÕu cã th× b¹n cøu nã thµnh c«ng. NÕu b¹n kh«ng cã ch©n gµ th× xem Nh­ ph¶i thùc hiÖn nhiÖm vô l¹i tõ ®Çu.<enter><color=red>B­íc 4: <color>Trë vÒ giao Háa Hå giao cho Môc V©n Tõ hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Môc V©n Tõ","",0,1,13,1937,4893},
			[3] = {"§Õn tiÖm t¹p hãa ë Thµnh §«","",0,1,11,3095,5137},
			[4] = {"§¸nh Th»n L»n Chóa","",1,0,13,297,302},
			[5] = {"GÆp Môc V©n Tõ, hoµn thµnh nhiÖm vô","",0,1,13,1937,4893},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 Nga Mi Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>L­u Thñy<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Thanh Liªn Tiªn Tö.<enter>Häc ®­îc vâ c«ng: L­u Thñy<enter>N¬i tiÕp nhËn nhiÖm vô: T¶ Thiªn ®iÖn <color=yellow>B¸i NguyÖt Tiªn Tö<color> T« Tõ Hinh.<enter>C¸c b­íc thùc hiÖn nhiÖm vô<enter><color=red>B­íc 1: <color>§Õn T¶ Thiªn ®iÖn (246,304) gÆp T« Tõ Hinh, tiÕp nhËn nhiÖm vô t×m B¹ch §iÓu TriÒu Phông khóc phæ.<enter><color=red>B­íc 2: <color>§Õn Thµnh §« -> Thanh Thµnh S¬n -> ThÇn Tiªn §éng. Vµo trong ®éng t×m Cao nh©n (234,204), «ng ta sÏ yªu cÇu B¹n ®¸nh b¹i con Linh thó (235,203).<enter><color=red>B­íc 3: <color>Sau khi ®¸nh b¹i nã, b¹n l¹i nhÊp vµo lêi tho¹i víi Cao nh©n. ¤ng ta yªu cÇu b¹n mang bøc tranh Phï Dung CÈm Kª ®Õn ®æi khóc phæ.<enter><color=red>B­íc 4: <color>§Õn Th¸i B×nh Tiªu Côc ë Thµnh §« phñ, gÆp «ng chñ Tiªu Côc (376,316), nhÊp vµo lêi tho¹i, «ng ta yªu cÇu b¹n t×m Linh X¹ H­¬ng nang, ¦ng T×nh Hé Th©n phï vµ BÝch Tû Giíi ChØ, sÏ giao Phï Dung CÈm Kª.<enter><color=red>B­íc 5: <color>Vµo trong thµnh ®i t×m ba ng­êi, b¹n sÏ lÊy ®­îc ba mãn b¶o vËt nãi trªn :<enter>- Linh X¹ H­¬ng nang: §Õn Thµnh §« t×m TiÕt TiÓu muéi (383,315), nhÊp vµo lêi tho¹i, TiÕt TiÓu muéi yªu cÇu b¹n mang Ng©n thiÒm (Tr©m cµi) ®Õn ®æi. §Õn tiÖm t¹p hãa mua Ng©n thiÒm (386,321) víi gi¸ 200 l­îng. Trë l¹i gÆp TiÕt TiÓu muéi, dïng Ng©n thiÒm (Tr©m cµi) ®æi H­¬ng nang. <enter>- ¦ng T×nh Hé Th©n phï: T×m gÆp Tõ V©n Ph¸p S¬ t¹i TÝn T­íng tù (403,319) ë Thµnh §« phñ, lÇn l­ît tr¶ lêi ba c©u hái, sÏ nhËn ®­îc ¦ng T×nh Hé Th©n phï. (§¸p ¸n lÇn l­ît lµ: B, D, C). NÕu Nh­ ®¸p sai, b¹n cã thÓ nhÊp vµo lêi tho¹i ®Ó thùc hiÖn l¹i. <enter>- BÝch Tû Giíi ChØ: §Õn Thµnh §« t×m T©n Viªn Ngo¹i (400,309), tr¶ lêi hai c©u hái sÏ nhËn ®­îc BÝch Tû Giíi ChØ (§¸p ¸n lµ : B, C). NÕu Nh­ ®¸p sai, b¹n cã thÓ nhÊp vµo lêi tho¹i ®Ó thùc hiÖn l¹i.<enter><color=red>B­íc 6: <color>Trë l¹i Th¸i B×nh Tiªu Côc ë Thµnh §« phñ, giao Linh X¹ H­¬ng nang, ¦ng T×nh Hé Th©n phï vµ BÝch Tû Giíi ChØ ®Ó ®æi Phï Dung CÈm Kª.<enter><color=red>B­íc 7: <color>Trë vÒ ThÇn Tiªn ®éng, gÆp Cao nh©n, nhÊp vµo lêi tho¹i, dïng Phï Dung CÈm Kª ®æi B¸ch §iÓu TriÒu Phong.<enter><color=red>B­íc 8: <color>Trë vÒ Nga My ph¸i, ®Õn T¶ Thiªn ®iÖn gÆp T« Tõ Hinh, giao B¸ch §iÓu TriÒu Phong, hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp T« Tõ Hinh","",0,1,18,1603,3190},
			[3] = {"T×m  Cao nh©n","",1,0,23,234,204},
			[4] = {"GÆp «ng chñ Tiªu Côc","",0,1,11,3012,5060},
			[5] = {"T×m TiÕt TiÓu muéi","",0,1,11,3068,5048},
			[6] = {"§Õn tiÖm t¹p hãa mua Ng©n thiÒm","",0,1,11,3096,5136},
			[7] = {"Trë l¹i gÆp TiÕt TiÓu muéi","",0,1,11,3068,5048},
			[8] = {"T×m gÆp Tõ V©n Ph¸p S­","",0,1,11,3223,5108},
			[9] = {"T×m T©n Viªn Ngo¹i","",0,1,11,3202,4951},
			[10] = {"Trë l¹i Th¸i B×nh Tiªu Côc","",0,1,11,3012,5060},
			[11] = {"Trë l¹i gÆp Cao nh©n","",1,0,23,234,204},
			[12] = {"Trë vÒ gÆp T« Tõ Hinh, hoµn thµnh nhiÖm vô","",0,1,18,1603,3190},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 Nga Mi Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>PhËt T©m Tõ H÷u<color>"},
			--[1] = {"SÏ ®­îc phong lµ: T¸n Hoa Thiªn N÷. Häc ®­îc vâ c«ng: PhËt T©m Tõ H÷u, N¬i tiÕp nhËn nhiÖm vô: Ch¸nh ®iÖn, Ch­ëng m«n Thanh HiÓu S­ Th¸i."},
			[2] = {"GÆp Thanh HiÓu S­ Th¸i","",0,1,17,1595,3207},
			[3] = {"GÆp Tõ V©n Ph¸p S­","",0,1,11,3222,5107},
			[4] = {"§¸nh b¹i Ph¶n T¨ng §Çu Môc cøu Tõ H¶i §¹i S­","",1,1,12,1841,3181},
			[5] = {"GÆp Thanh HiÓu S­ Th¸i, hoµn thµnh nhiÖm vô","",0,1,17,1595,3207},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ Nga Mi Ph¸i<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Th¸nh N÷. N¬i tiÕp nhËn nhiÖm vô: Ch¸nh ®iÖn, Ch­ëng m«n Thanh HiÓu S­ Th¸i."},
			[2] = {"GÆp Thanh HiÓu S­ Th¸i","",0,1,17,1595,3207},
			[3] = {"§¸nh Thanh Hßa lÊy Yªn Ngäc ChØ Hoµn","",1,1,9,2111,5992},
			[4] = {"GÆp Thanh HiÓu S­ Th¸i, hoµn thµnh nhiÖm vô","",0,1,17,1595,3207},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n Nga Mi Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>BÊt DiÖt BÊt TuyÖt, PhËt Quang Phæ ChiÕu<enter>Phan ¢m Ph¹n X­íng<enter>PhËt Ph¸p V« Biªn<color>"},
			--[1] = {"Yªu cÇu: ng­êi ch¬i ®· xuÊt s­, ®¼ng cÊp trªn 60, ch­a gia nhËp bang ph¸i nµo, cã thÓ ®Õn gÆp tr­ëng m«n cña ph¸i giao 5 v¹n l­îng ®Ó trïng ph¶n s­ m«n. Tõ ®ã vÒ sau cã thÓ tïy ý ra vµo s­ m«n. PhÇn Thuëng: BÊt DiÖt BÊt TuyÖt, PhËt Quang Phæ ChiÕu, Phan ¢m Ph¹n X­íng, PhËt Ph¸p V« Biªn. §­îc phong lµm:Kim §Ønh Th¸nh N÷."},
			[2] = {"§èi tho¹i Ch­ëng M«n, nép 5 v¹n l­îng","",0,1,17,1595,3207},
		},
		[8] = {
			[1] = {"<color=green>NhiÖm vô cÊp 90 Nga Mi Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Tam Nga TÕ NguyÖt<enter>Phong S­¬ng To¸i ¶nh<enter>Phæ §é Chóng Sinh<color>"},
			--[1] = {"Yªu cÇu: Tõ cÊp 90 trë lªn, danh väng trªn 240 ®iÓm, lµ Nga My ký danh ®Ö tö, tr­íc m¾t ch­a gia nhËp m«n ph¸i nµo. PhÇn th­ëng: Tam Nga TÕ NguyÖt, Phong S­¬ng To¸i ¶nh, Phæ §é Chóng Sinh. Danh väng ®­îc 30 ®iÓm."},
			[2] = {"GÆp Tiªu Bµ Bµ","",0,1,11,3109,5011},
			[3] = {"§¸nh D¹ Xoa, lÊy V« Tù Thiªn th­","",1,1,23,1669,3164},
			[4] = {"GÆp Tiªu Bµ Bµ","",0,1,11,3109,5011},
			[5] = {"GÆp Thanh HiÓu S­ Th¸i","",0,1,17,1595,3207},
			[6] = {"GÆp Tiªu Bµ Bµ","",0,1,11,3109,5011},
			[7] = {"GÆp Thanh HiÓu S­ Th¸i, hoµn thµnh nhiÖm vô","",0,1,17,1595,3207},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = {
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö Ph¸i Nga Mi<color>"},
			--[1] = {"NhiÖm vô ký danh ®Ö tö ph¸i Nga My. Ph¶i xuÊt s­ míi cã thÓ lµm nhiÖm vô nµy."},
			[2] = {"GÆp DiÖp B¨ng Hµn. §¸p ¸n 3-3-1","",1,1,13,1916,5320},
			[3] = {"GÆp TÇn Kú Phong. §¸p ¸n 3-1-2","",1,1,13,1817,5157},
			[4] = {"GÆp Hµ Linh Phiªu. §¸p ¸n 1-2-3","",1,1,13,1836,5126},
			[5] = {"GÆp T¹ V©n La","",1,1,13,1775,5145},
			[6] = {"§¸nh b¹i Vò Y Ni lÊy B¹ch Ngäc Nh­ ý","",1,1,13,1733,5116},
			[7] = {"GÆp DiÖu TrÇn","",1,1,13,1845,5010},
		},
	},
	[5] = { --Thuy yen
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 Thóy Yªn M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thóy Yªn §ao Ph¸p<enter>Thóy Yªn Song §ao<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Tam PhÈm Hoa Sø. Häc ®­îc vâ c«ng: Thóy Yªn §ao Ph¸p, Thóy Yªn Song §ao. N¬i tiÕp nhËn nhiÖm vô: Chñ phßng, Ch­ëng m«n Do·n Hµm Yªn.\n<color=red>B­íc 1<color>: §Õn Chñ phßng <color=yellow>(35/75)<color> gÆp Ch­ëng m«n Do·n Hµm Yªn , tiÕp nhËn nhiÖm vô truy t×m c©y Tr©m bÞ thÊt l¹c.\n<color=red>B­íc 2<color>: §Õn khu rõng phÝa §«ng cña Thuý Yªn, b¹n h·y ®¸nh nh÷ng con Hång Hå (C¸o ®á) <color=yellow>(83/105; 90/99; 82/ 99; 87/ 97)<color> lÊy ®­îc Thóy Vò Tr©m.\n<color=red>B­íc 3<color>: Mang Thóy Vò Tr©m vÒ giao cho Ch­ëng m«n Do·n Hµm Yªn, hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Do·n Hµm Yªn","",0,1,161,1591,3203},
			[3] = {"§¸nh b¹i C¸o §á","",1,1,154,667,1691},
			[4] = {"Trë vÒ giao Thóy Vò Tr©m cho Do·n Hµm Yªn, hoµn thµnh nhiÖm vô","",0,1,161,1591,3203},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 Thóy Yªn M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>B¨ng T©m Tr¸i ¶nh<color>"},
			--[1] = {"SÏ ®­îc phong lµ: NhÞ PhÈm Hoa Sø. Häc ®­îc vâ c«ng: B¨ng T©m Tr¸i ¶nh. N¬i tiÕp nhËn nhiÖm vô: Thiªn §iÖn, Yªn HiÓu Tr¸i..\n<color=red>B­íc 1<color>: §Õn Thñ Ngäc §×nh <color=yellow>(43/90)<color> gÆp Yªn HiÓu Tr¸i , tiÕp nhËn nhiÖm vô ®i h¸i hoa. (M¹n §µ La Hoa lµ mét lo¹i hoa kÞch ®éc, v× vËy néi trong thêi gian quy ®Þnh ph¶i h¸i ®ñ ®em vÒ ®Ó ®­îc Ch­ëng m«n gi¶i ®éc, nÕu kh«ng b¹n sÏ chÕt).\n<color=red>B­íc 2<color>: §i vÒ h­íng T©y B¾c (bªn tr¸i gÇn Mª Cung cÊm ®Þa), h·y h¸i 10 ®ãa §¹i M¹n §µ La hoa (56/59; 55/63; 72/42; 69/53; 61/48; 73/47; 80/43; 72/39; 66/39; 63/40). Khi b¹n b¾t ®Çu h¸i ®ãa hoa ®Çu tiªn th× thêi gian tróng ®éc cña b¹n b¾t ®Çu ®­îc tÝnh. Tróng ®éc chia lµm bèn giai ®o¹n, mçi giai ®o¹n lµ 30 phót.\n<color=red>B­íc 3<color>: Mçi giai ®o¹n bÞ tróng ®éc, hÖ thèng ®Òu ph¸t ra th«ng b¸o cho ng­êi ch¬i biÕt, sau khi giai ®o¹n thø t­ kÕt thóc, ng­êi ch¬i sÏ bÞ chÕt. Lóc nµy b¹n sÏ ph¶i thùc hiÖn nhiÖm vô l¹i tõ ®Çu. Tr­íc khi giai ®o¹n thø t­ kÕt thóc, b¹n ph¶i ®i t×m Yªn HiÓu Tr¸i ®Ó ®­îc gi¶i ®éc vµ tÝnh sè l­îng hoa. Néi trong thêi gian h¹n ®Þnh b¹n h¸i ®ñ 10 ®ãa hoa ®em vÒ giao th× míi hoµn thµnh ®­îc nhiÖm vô.\nMang ®ñ 10 ®ãa hoa vÒ cho Yªn HiÓu Tr¸i , hoµn thµnh nhiÖm vô."},
			[2] = {"GÆp Yªn HiÓu Tr¸i","",0,1,160,1593,3195},
			[3] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 1","",1,0,154,56,59},
			[4] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 2","",1,1,154,446,1020},
			[5] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 3","",1,1,154,579,680},
			[6] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 4","",1,0,154,69,53},
			[7] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 5","",1,0,154,60,49},
			[8] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 6","",1,1,154,587,769},
			[9] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 7","",1,0,154,80,43},
			[10] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 8","",1,0,154,72,39},
			[11] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 9","",1,0,154,66,39},
			[12] = {"§Õn n¬i h¸i §¹i M¹n §µ La Hoa 10","",1,1,154,509,648},
			[13] = {"Trë vÒ giao cho Yªn HiÓu Tr¸i, hoµn thµnh nhiÖm vô","",0,1,160,1593,3195},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 Thóy Yªn M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Vò §¶ Lª Hoa<enter>Phï V©n Tµn TuyÕt<color>"},
			--[1] = {"SÏ ®­îc phong lµ: <color=yellow>NhÊt PhÈm Hoa Sø<color>. Häc ®­îc vâ c«ng: <color=yellow>Vò §¶ Lª Hoa, Phï V©n Tµn TuyÕt<color>. N¬i tiÕp nhËn nhiÖm vô: <color=yellow>B¸ch Hoa ®iÖn, Hµ Mé TuyÕt<color>.<enter><color=red>B­íc 1<color>: §Õn B¸ch Hoa §iÖn <color=yellow>(53/85)<color> gÆp <color=yellow>Hµ Mé TuyÕt<color>, tiÕp nhËn nhiÖm vô.<enter><color=red>B­íc 2<color>: §Õn <color=yellow>§¹i Lý<color> t×m <color=yellow>§oµn L·o H¸n (189/204)<color>, võa gÆp th× thÊy <color=yellow>§oµn L·o H¸n<color> ®ang khãc lãc ®au buån, biÕt ®­îc con g¸i l·o bÞ <color=yellow>Thæ PhØ<color> b¾t ®i.<enter><color=red>B­íc 3<color>: §i vÒ phÝa t©y thµnh, ®Õn §iÓm Th­¬ng S¬n, ®i vµo Thæ phØ s¬n ®éng <color=yellow>(232/172)<color>, giÕt tªn Thæ phØ <color=yellow>(232/193)<color> b¹n cã thÓ cøu ®­îc con g¸i cña §oµn L·o H¸n nh¬ng x¸c suÊt rÊt thÊp.<enter><color=red>B­íc 4<color>: Trë l¹i gÆp <color=yellow>§oµn L·o H¸n<color>, nhÊp vµo lêi tho¹i, biÕt ®­îc cÇn ph¶i ®i t×m ba lo¹i d­îc liÖu.<enter><color=red>B­íc 5<color>: §Õn BÕn Tµu t×m mét ThuyÒn gia <color=yellow>(204/183)<color>, bá 1000 l­îng mua ®­îc vµi con Ng©n TuyÕt Ng-.<enter><color=red>B­íc 6<color>: Vµo Thµnh §¹i Lý ®Õn suèi Hå §iÖp, sÏ thÊy hai con b­ím BÝch Th­êng Phông §iÖp <color=yellow>(184/196)<color>, b¹n chØ cÇn nhÊp chuét vµo mét con, sÏ thÊy xuÊt hiÖn dßng ch÷ <color=yellow>NhËn ®­îc BÝch Th­êng Phông §iÖp<color>, b¹n chØ cÇn lÊy mét con lµ ®ñ.<enter><color=red>B­íc 7<color>: §Õn V©n Léng §×nh, t×m mét con Th»n l»n ®á <color=yellow>(182/197)<color>, nhÊp chuét vµo nã, sÏ thÊy xuÊt hiÖn dßng ch÷: <color=yellow>NhËn ®­îc th»n l»n ®á<color> (SÏ h¬i khã t×m v× nã bi m¸i ®×nh che khuÊt), b¹n chØ cÇn lÊy mét con lµ ®ñ.<enter><color=red>B­íc 8<color>: Sau khi t×m ®­îc ba lo¹i d­îc liÖu trªn, trë vÒ Thóy Yªn m«n, giao cho Hµ Mé TuyÕt, hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn B¸ch Hoa §iÖn gÆp Hµ Mé TuyÕt","",0,1,155,1586,3205},
			[3] = {"§Õn §¹i Lý t×m §oµn L·o Ho¸n","",0,1,162,1512,3277},
			[4] = {"Vµo Thæ PhØ S¬n §éng giÕt Thæ PhØ cøu con g¸i §oµn L·o Ho¸n","",1,1,170,1858,3094},
			[5] = {"Trë l¹i gÆp §oµn L·o Ho¸n","",0,1,162,1512,3277},
			[6] = {"§Õn bÕn tµu mua Ng©n TuyÕt Ng­ cña ThuyÒn Gia","",1,1,162,1640,2935},
			[7] = {"§Õn suèi Hå §iÖp thµnh §¹i Lý b¾t BÝch Th­êng Phông §iÖp","",0,1,162,1472,3145},
			[8] = {"§Õn V©n Léng §×nh b¾t Th»n L»n §á","",0,1,162,1459,3146},
			[9] = {"Quay trë vÒ gÆp Hµ Mé TuyÕt, hoµn thµnh nhiÖm vô","",0,1,155,1586,3205},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 Thóy Yªn M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Hé ThÓ Hµn B¨ng<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hoa ThÇn Sø Gi¶. Häc ®­îc vâ c«ng: <color=yellow>Hé ThÓ Hµn B¨ng<color>. N¬i tiÕp nhËn nhiÖm vô: Thiªn §iÖn, Yªn HiÓu Tr¸i.<enter><color=red>B­íc 1<color>: §Õn Thñ Ngäc §×nh (43/90) gÆp Yªn HiÓu Tr¸i, tiÕp nhËn nhiÖm vô ®i cøu nh÷ng c« g¸i bÞ ¸c b¸ b¾t ®i.<enter><color=red>B­íc 2<color>: §Õn §¹i Lý, t×m nhµ tªn ¸c b¸ (206/200), trong nhµ sÏ kh«ng cã ai, trong s©n b¹n sÏ ph¸t hiÖn ra mét lèi ®i vµo mËt ®¹o. §i vµo trong MËt ®¹o ®¸nh b¹i nh÷ng tªn ¸c b¸ ®¶ thñ (223/199; 201/204; 197/195), ph¸t hiÖn ra ¸c b¸ ®· mang nh÷ng c« g¸i kia lªn §iÓm Th­¬ng S¬n.<enter><color=red>B­íc 3<color>: LËp tøc lªn §iÓm Th­¬ng S¬n, tiÕn vµo §iÓm Th­¬ng ®éng (210/195), bªn trong lµ mét mª cung cã rÊt nhiÒu <color=yellow>§¶ Thñ<color>\n\t\t\t-T¹i tÇng mét b¹n ®¸nh b¹i hai tªn ¸c B¸ B¶o Tiªu (199/191; 186/189), lÊy ®­îc chiÕc ch×a khãa thø nhÊt (X¸c suÊt 50%).\n\t\t\t- T¹i tÇng thø hai ®¸nh hai tªn ¸c B¸ Hé ViÖn (193/190; 186/195), lÊy ®­îc chiÕc ch×a khãa thø hai (X¸c suÊt 40%).\n\t\t\t- Lªn tÇng thø ba ®¸nh mét tªn ¸c B¸ §¶ Thñ (197/185; 196/186), lÊy ®­îc chiÕc ch×a khãa thø ba (X¸c suÊt 30%).<enter><color=red>B­íc 4<color>: Sau khi lÊy ®ñ ba chiÕc ch×a khãa, nhÊp chuét vµo c¬ quan (197/186), hÖ thèng sÏ xuÊt hiÖn dßng ch÷ <color=yellow>¸c B¸ ®· qu¸ sî b¹n nªn bá trèn råi ! H·y dïng ba chiÕc ch×a khãa më '¸m ThÊt' cøu c¸c c« g¸i ra<color>.<enter><color=red>B­íc 5<color>: Trë vÒ Thóy Yªn m«n gÆp Yªn HiÓu Tr¸i phôc mÖnh, hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn Thñ Ngäc §×nh gÆp Yªn HiÓu Tr¸i","",	0,1,160,1593,3195},
			[3] = {"§Õn ¸c B¸ gia ®Þa ®¹o tiªu diÖt ¸c B¸ §¶ Thñ","",1,1,163,1789,3195},
			[4] = {"Tiªu diÖt ¸c B¸ B¶o Tiªu","",1,0,171,199,191},
			[5] = {"Tiªu diÖt ¸c B¸ Hé ViÖn","",1,1,172,1550,3040},
			[6] = {"Tiªu diÖt ¸c B¸ §¶ Thñ t¹i tÇn 3 §iÓm Th­¬ng §éng","",1,1,173,1582,2966},
			[7] = {"Dïng 3 ch×a khãa më c¬ quan","",1,1,173,1582,2966},
			[8] = {"Trë vÒ gÆp Yªn HiÓu Tr¸i, hoµn thµnh nhiÖm vô","",0,1,160,1593,3195},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 Thóy Yªn M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>TuyÕt ¶nh<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hoa Tinh. Häc ®­îc vâ c«ng: <color=yellow>TuyÕt ¶nh<color>. N¬i tiÕp nhËn nhiÖm vô: Ch­ëng m«n Do·n Hµm Yªn.<enter><color=red>B­íc 1<color>: §Õn Chñ phßng (35/75) gÆp Ch­ëng m«n Do·n Hµm Yªn , tiÕp nhËn nhiÖm vô gióp H¬ Viªn ph­¬ng tr­îng ®o¹t l¹i Vò §ång Quan ¢m.<enter><color=red>B­íc 2<color>: §Õn §¹i Lý tr­íc mÆt Sïng Th¸nh tù lµ Thiªn TÇm th¸p. GÆp H¬ Viªn ph­¬ng tr­îng (219/196), nhÊp vµo lêi tho¹i.<enter><color=red>B­íc 3<color>: §i Vµo Thiªn TÇm Th¸p, Mçi tÇng chØ cÇn ®¸nh mét tªn trém b¶o tÆc. TÇng 1 (214/193), TÇng 2 (195/202), TÇng 3 (198/200), sau khi ®¸nh b¹i hÕt ba tªn sÏ lÊy l¹i ®­îc Vò §ång Quan ¢m .<enter><color=red>B­íc 4<color>: Mang Vò §ång Quan ¢m VÒ cho H¬ Viªn ph­¬ng tr­îng.<enter><color=red>B­íc 5<color>: Trë l¹i Thóy Yªn m«n gÆp Ch­ëng m«n Do·n Hµm Yªn phôc mÖnh, hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn chñ phßng gÆp Do·n Hµm Yªn","",0,1,161,1591,3203},
			[3] = {"§Õn §¹i Lý gÆp H­ Viªn Ph­¬ng Tr­îng","",0,1,162,1750,3136},
			[4] = {"Tiªu diÖt Trém B¶o TÆc t¹i tÇng 1 Thiªn T©m Th¸p","",1,1,164,1710,3088},
			[5] = {"Tiªu diÖt Trém B¶o TÆc t¹i tÇng 2 Thiªn T©m Th¸p","",1,1,165,1558,3232},
			[6] = {"Tiªu diÖt Trém B¶o TÆc t¹i tÇng 3 Thiªn T©m Th¸p","",1,1,166,1582,3200},
			[7] = {"Mang Vò §ång Quan ¢m cho H­ Viªn Ph­¬ng Tr­îng","",0,1,162,1750,3136},
			[8] = {"Trë vÒ gÆp Do·n Hµm Yªn, hoµn thµnh nhiÖm vô","",0,1,161,1591,3203},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ Thóy Yªn M«n<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hoa Tiªn. N¬i tiÕp nhËn nhiÖm vô: Xu©n Hoa Bµ Bµ.<enter><color=red>B­íc 1<color>: §Õn HËu Hoa Viªn (40/74) gÆp Xu©n Hoa Bµ Bµ, tiÕp nhËn nhiÖm vô ®iÒu tra sù thËt trong cÊm ®Þa Thóy Yªn m«n.<enter><color=red>B­íc 2<color>: §Õn §Çm Ngäc n÷ sÏ thÊy lèi vµo CÊm §Þa s¬n ®éng (78/78).<enter><color=red>B­íc 3<color>: Vµo CÊm §Þa s¬n ®éng, ®¸nh hai tªn Th¶o khÊu (187/193; 209/175), lÊy ®­îc mét chiÕc kh¨n t¬ (X¸c suÊt rÊt thÊp).<enter><color=red>B­íc 4<color>: §i vµo trong gÆp mét «ng giµ (228/191) nhËn 1 bøc th¬.<enter><color=red>B­íc 5<color>: Quay l¹i giao th¬ cho Xu©n Hoa Bµ Bµ.<enter><color=red>B­íc 6<color>: Sau ®ã ®Õn Chñ phßng (35/75) gÆp Ch­ëng m«n Do·n Hµm Yªn, hoµn thµnh nhiÖm vô."},
			[2] = {"§Õn hËu hoa viªn gÆp Xu©n Hoa Bµ Bµ","",0,0,154,40,74},
			[3] = {"Tiªu diÖt th¶o khÊu t¹i cÊm ®Þa s¬n ®éng lÊy kh¨n t¬","",1,1,158,1504,3098},
			[4] = {"NhËn bøc th¬ tõ mét «ng giµ","",1,1,158,1832,3066},
			[5] = {"Quay l¹i gÆp Xu©n Hoa Bµ Bµ","",0,0,154,40,74},
			[6] = {"GÆp tr­ëng m«n Do·n Hµm Yªn, hoµn thµnh nhiÖm vô","",0,1,161,1591,3203},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n Thóy Yªn<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Môc D· L­u Tinh<enter>BÝch H¶i TriÒu Sinh<enter>B¨ng Cèt TuyÕt T©m<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hoa ThÇn. Häc ®­îc vâ c«ng: <color=yellow>Môc D· L­u Tinh, BÝch H¶i TriÒu Sinh, B¨ng Cèt TuyÕt T©m<color>. N¬i tiÕp nhËn nhiÖm vô: Ch­ëng m«n Do·n Hµm Yªn.<enter><color=yellow>Yªu cÇu<color>: ng­êi ch¬i ®· xuÊt s­, ®¼ng cÊp trªn 60, ch­a gia nhËp bang ph¸i nµo, cã thÓ ®Õn gÆp tr­ëng m«n cña ph¸i giao 5 v¹n l­îng ®Ó trïng ph¶n s­ m«n. Tõ ®ã vÒ sau cã thÓ tïy ý ra vµo s­ m«n."},
			[2] = {"§èi tho¹i Ch­ëng M«n, nép 5 v¹n l­îng","",0,1,161,1591,3203},
		},
		[8] = { ----------------------------------------------------------------
			[1] = {"<color=green>NhiÖm vô cÊp 90 Thóy Yªn M«n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>B¨ng Tung V« ¶nh<enter>B¨ng Tinh Tiªn Tö<color>"},
			[2] = {"GÆp §oµn T­ Thµnh","",0,1},
			[3] = {"GÆp LÖ Thu Thñy","",0,1},
			[4] = {"GÆp Ch­ëng m«n Do·n Hµm Yªn","",0,1,161,1591,3203},
			[5] = {"Quay l¹i gÆp LÖ Thu Thñy","",0,1},
			[6] = {"Quay l¹i gÆp §oµn T­ Thµnh","",0,1},
			[7] = {"Quay l¹i gÆp LÖ Thu Thñy","",0,1},
			[8] = {"Quay l¹i gÆp §oµn T­ Thµnh","",0,1},
			[9] = {"Quay l¹i gÆp Ch­ëng m«n Do·n Hµm Yªn, hoµn thµnh nhiÖm vô","",0,1},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = { ---------------------------------------------------
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö Thóy Yªn<color>"},
			[2] = {"GÆp Thóy Yªn Hoa Sø","",0,1},
			[3] = {"§¸nh X¸ LÞ Tinh","",0,1},
			[4] = {"GÆp Thóy Yªn Hoa Sø ë lèi ra, hoµn thµnh nhiÖm vô","",0,1},		
		},
	},
	[6] = { --Cai bang OK
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 C¸i Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>C¸i Bang Bæng ph¸p<enter>C¸i Bang Ch­ëng ph¸p<color>"},
			--[1] = {"SÏ ®­îc phong lµ: ChÊp §¹i §Ö tö. Häc ®­îc vâ c«ng: C¸i Bang Bæng ph¸p, C¸i Bang Ch­ëng ph¸p. N¬i tiÕp nhËn nhiÖm vô: Bang chñ Hµ Nh©n Ng·.<enter><color=red>Chó ý<color>§èi tho¹i víi Tóy B¸n Tiªn ®øng c¹nh «ng chñ Töu LÇu ®¸p ¸n CBD"},
			[2] = {"§Õn gÆp Bang chñ Hµ Nh©n Ng·","",0,1,115,1527,3706},
			[3] = {"§Õn Töu lÇu (mua 4 lo¹i r­îu, cÇn ng©n l­îng)","",0,1,80,1731,3033},
			[4] = {"GÆp Tóy b¸n tiªn (ngay bªn c¹nh - ®¸p ¸n C-B-D)","",0,1,80,1731,3033},
			[5] = {"Mang 5 lo¹i r­îu vÒ cho Hµ Nh©n Ng·, hoµn thµnh nhiÖm vô","",0,1,115,1527,3706},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 C¸i Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Hãa HiÓm Vi Di<color>"},
			--[1] = {"SÏ ®­îc phong lµ: ChÊp B¸t §Ö tö. Häc ®­îc vâ c«ng: Hãa HiÓm Vi Di. N¬i tiÕp nhËn nhiÖm vô: §Ö tö C¸i Bang."},
			[2] = {"GÆp ®Ö tö c¸i bang","",0,1,115,1477,3575},
			[3] = {"§¸nh b¹i M¹nh ViÔn Tµi","",1,1,115,1529,3040},
			[4] = {"GÆp M¹nh Th­¬ng L­¬ng, hoµn thµnh nhiÖm vô","",0,1,115,1555,3792},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 C¸i Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Gi¸ng Long Ch­ëng<enter>§¶ CÈu TrËn<color>"},
			--[1] = {"SÏ ®­îc phong lµ: ChÊp Bæng §Ö tö. Häc ®­îc vâ c«ng: Gi¸ng Long Ch­ëng, §¶ CÈu TrËn. N¬i tiÕp nhËn nhiÖm vô: Ch­ëng Bæng Tr­ëng l·o La Khu«ng Sinh."},
			[2] = {"GÆp La Khu«ng Sinh","",0,1,115,1520,3616},
			[3] = {"T×m TriÖu §µ Chñ","",0,0,80,213,177},
			[4] = {"§¸nh b¹i Kim Binh (cøu ®Ö tö c¸i bang)","",1,1,92,1832,2487},
			[5] = {"T×m TriÖu §µ Chñ (nhËn V¨n Th¬)","",0,0,80,213,177},
			[6] = {"Giao cho La Khu«ng Sinh, hoµn thµnh nhiÖm vô","",0,1,115,1520,3616},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 C¸i Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Ho¹t BÊt L­u Thñ<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Long §Çu §Ö tö. Häc ®­îc vâ c«ng: Ho¹t BÊt L­u Thñ, N¬i tiÕp nhËn nhiÖm vô: TruyÒn C«ng Tr­ëng l·o Ngôy LiÔu ¤ng.<enter><color=red>Chó ý<color>§¸nh Kim Quèc ThÝch Kh¸ch cho tíi khi nhËn ThÝch s¸t mËt hµm"},
			[2] = {"§Õn gÆp Ngôy LiÔu ¤ng","",0,1,115,1530,3867},
			[3] = {"§¸nh b¹i Kim Quèc ThÝch Kh¸ch 1 (lÊy ThÝch s¸t mËt hµm - tû lÖ thÊp)","",1,0,180,226,183},
			[4] = {"§¸nh b¹i Kim Quèc ThÝch Kh¸ch 2 (lÊy ThÝch s¸t mËt hµm - tû lÖ thÊp)","",1,0,180,178,195},
			[5] = {"VÒ gÆp Ngôy LiÔu ¤ng","",0,1,115,1529,3866},
			[6] = {"GÆp Tr­¬ng TuÊn","",0,1,80,1608,3154},
			[7] = {"Trë l¹i gÆp Ngôy LiÔu ¤ng, hoµn thµnh nhiÖm vô","",0,1,115,1529,3866},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 C¸i Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Bæng §¶ ¸c CÈu<enter>Hµng Long H÷u Hèi<color>"},
			--[1] = {"SÏ ®­îc phong lµ: §¹i Long §Çu. Häc ®­îc vâ c«ng: Bæng §¶ ¸c CÈu, Hµng Long H÷u Hèi. N¬i tiÕp nhËn nhiÖm vô: Bang chñ Hµ Nh©n Ng·.<enter><color=red>Chó ý<color> Sau khi vµo ®­îc Hoµng Cung, tù ch¹y ®Õn 202 200 ®Ó vµo mËt thÊt, ®Õn 210 187 ®Ó ®­a ®Þa ®å cho Tµo C«ng C«ng.<enter><enter>Sau khi ph¸t hiÖn Tµo C«ng C«ng lµ néi gi¸n, quay l¹i mËt ®¹o, nhÊp nãi chuyÖn víi Tµo C«ng C«ng råi míi quay ra ®¸nh §éi Tr­ëng VÖ Binh, thÊy cã th«ng b¸o <color=red>(®¸nh ng· tªn vÖ sÜ hoµng cung ®ang b¶o vÖ tµo c«ng c«ng)<color> th× nãi chuyÖn víi Tµo C«ng C«ng."},
			[2] = {"§Õn gÆp Bang chñ Hµ Nh©n Ng·","",0,1,115,1527,3706},
			[3] = {"GÆp vÖ binh hoµng cung L©m An (bÞ ng¨n l¹i kh«ng cho vµo)","",0,1,176,1634,3203},
			[4] = {"T×m Tr­¬ng Tu©n","",0,1,176,1482,3416},
			[5] = {"Trë l¹i gÆp vÖ binh hoµng cung L©m An","",0,1,176,1634,3203},
			[6] = {"Sau khi ®­a ®Þa ®å cho Tµo C«ng C«ng, trë vÒ gÆp Tr­¬ng TuÊn","",0,1,176,1482,3416},
			[7] = {"§ót lãt TiÓu Th¸i Gi¸m ®Ó vµo Hoµng Cung","",0,1,176,1634,3203},
			[8] = {"§¸nh b¹i Tµo C«ng C«ng råi quay vÒ t×m Tr­¬ng Tu©n","",0,1,176,1482,3416},
			[9] = {"§Õn gÆp Bang chñ Hµ Nh©n Ng·, hoµn thµnh nhiÖm vô","",0,1,115,1527,3706},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ C¸i Bang<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Tiªu Dao ThÇn C¸i. N¬i tiÕp nhËn nhiÖm vô: Ch­ëng B¸t Tr­ëng l·o Tõ Tam Tr­îng.<enter><color=red>Chó ý<color> : ë nhiÖm vô nµy, ë c¸c r­¬ng cÇn ch×a khãa ®Ó më, b¹n cã thÓ ®¸nh b¹i qu¸i vËt t­¬ng øng ®Ó nhËn ch×a khãa nhiÒu lÇn. VÝ dô: sau khi ®· më r­¬ng b¹n cã thÓ quay l¹i ®¸nh Hæ QuyÒn lÇn n÷a ®Ó lÊy ch×a khãa ra më r­¬ng, cho ®Õn khi b¹n nhËn ®­îc 2 c¸i tói th× th«i.<enter>T©ng 1 : §¸nh Hæ QuyÒn më r­¬ng cho ®Õn khi lÊy ®­îc 2 tói v¶i<enter>T©ng 2 cã 2 r­¬ng nh¬ng chØ lÊy ®­îc 1 tói v¶i hoÆc kh«ng lÊy ®­îc tói nµo. T©ng 5 NhiÒu nhÊt lÊy ®­îc 2 tói v¶i. "},
			[2] = {"GÆp Tõ Tam Tr­îng","",0,1,115,1512,3790},
			[3] = {"T1 ®¸nh b¹i Hæ QuyÒn (lÊy ch×a khãa - max 2 c¸i)","",1,1,116,1711,3016},
			[4] = {"T1 më r­¬ng Hæ QuyÒn. Max 2 tói","",1,1,116,1775,3087},
			[5] = {"T2 kh«ng cÇn ch×a më r­¬ng 1. T2 2 r­¬ng max 1 tói","",1,1,117,1615,3131},
			[6] = {"T2 kh«ng cÇn ch×a më r­¬ng 2. T2 2 r­¬ng max 1 tói","",1,1,117,1688,3022},
			[7] = {"T4 kh«ng cÇn ch×a më r­¬ng 1. R­¬ng 1&2 max 2 tói","",1,1,119,1518,3122},
			[8] = {"T4 kh«ng cÇn ch×a më r­¬ng 2. R­¬ng 1&2 max 2 tói","",1,1,119,1526,3192},
			[9] = {"T4 ®¸nh b¹i VËt H¹c Hµnh (lÊy ch×a khãa)","",1,1,119,1511,3301},
			[10] = {"T4 më r­¬ng (lÊy tói råi quay l¹i ®¸nh H¹c Hµnh lÊy ch×a khãa 2). Max 2 tói","",1,1,119,1504,3327},
			[11]= {"T5 ®¸nh b¹i XÝch diÖm (lÊy ch×a khãa)","",1,1,120,1757,3041},
			[12]= {"T5 më r­¬ng 1. Max 2 tói","",1,1,120,1738,3024},
			[13]= {"T5 më r­¬ng 2. Max 2 tói","",1,1,120,1696,3051},
			[14] = {"§ñ 9 tói v¶i vÒ gÆp Tõ Tam Tr­îng, hoµn thµnh nhiÖm vô","",0,1,115,1512,3790},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n C¸i Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Tiªu Diªu C«ng<enter>Tóy §iÖp Cuång Vò<color>"},
			--[1] = {"Yªu cÇu: ng­êi ch¬i ®· xuÊt s­, ®¼ng cÊp trªn 60, ch­a gia nhËp bang ph¸i nµo, cã thÓ ®Õn gÆp tr­ëng m«n cña ph¸i giao 5 v¹n l­îng ®Ó trïng ph¶n s­ m«n. Tõ ®ã vÒ sau cã thÓ tïy ý ra vµo s­ m«n. Tiªu Diªu C«ng, Tóy §iÖp Cuång Vò. §­îc phong lµm:Cöu §¹i Tr­ëng L·o."},
			[2] = {"§èi tho¹i Bang chñ, nép 5 v¹n l­îng","",0,1,115,1527,3706},
		},
		[8] = {------------------------------------------------------------------------
			[1] = {"<color=green>NhiÖm vô cÊp 90 C¸i Bang<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Phi Long T¹i Thiªn<enter>Thiªn H¹ V« CÈu<color>"},
			--[1] = {"Yªu cÇu: Tõ cÊp 90 trë lªn, danh väng trªn 240 ®iÓm, lµ C¸i Bang ký danh ®Ö tö, tr­íc m¾t ch­a gia nhËp m«n ph¸i nµo (Ch÷ ®á). Häc ®­îc Phi Long T¹i Thiªn, Thiªn H¹ V« CÈu. Danh väng ®­îc 30 ®iÓm. (TÊt c¶ c¸c m«n ph¸i kh¸c ®Òu cã thÓ lµm nhiÖm vô nµy ®Ó nhËn phÇn th­ëng ®iÓm danh väng, nh¬ng kh«ng häc ®­îc chiªu thøc).<enter><color=red>Chó ý<color> Sau khi ®¸nh b¹i ®¸m cao thñ cøu ®­îc Giíi V« Tµ råi ph¶i nãi chuyÖn víi nã th× míi quay vÒ gÆp La Khu«ng Sinh"},
			[2] = {"GÆp Giíi V« Tµ","",1,1,9,2256,5936},
			[3] = {"Mua HuÖ TuyÒn Töu","",0,1,80,1737,3029},
			[4] = {"Mang r­îu cho Giíi V« Tµ","",1,1,9,2256,5936},
			[5] = {"GÆp La Khu«ng Sinh","",0,1,115,1520,3616},
			[6] = {"Quay trë l¹i gÆp Giíi V« Tµ","",1,1,9,2256,5936},
			[7] = {"Cøu ®­îc Giíi V« Tµ, quay vÒ gÆp La Khu«ng Sinh, hoµn thµnh nhiÖm vô","",0,1,115,1520,3616},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = {
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö C¸i Bang<color>"},
			[2] = {"GÆp Tõ Tam Tr­îng","",0,1,115,1512,3790},
			[3] = {"GÆp LiÔu §¹i Gia, nãi vÒ chuyÖn Con Ch¸u","",0,1,80,1666,3227},
			[4] = {"NhiÖm Thiªn Nhai, nãi vÒ chuyÖn C«ng Danh","",0,1,80,1769,3124},
			[5] = {"Nh¬ ý, nãi vÒ t­íng m¹o","",0,1,80,1689,3085},
			[6] = {"T«n Viªn Ngo¹i, nãi vÒ Tµi Phóc","",0,1,80,1621,3051},
			[7] = {"GÆp Tõ Tam Tr­îng, hoµn thµnh nhiÖm vô","",0,1,115,1512,3790},
		},
	},
	[7] = { --Thien nhan
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 Thiªn NhÉn<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thiªn NhÉn §ao ph¸p<enter>Thiªn NhÉn M©u ph¸p<enter>Háa PhÇn Liªn Hoa<color>"},
			--[1] = {"SÏ ®­îc phong lµ: V« ¶nh S¸t Thñ. Häc ®­îc vâ c«ng: Thiªn NhÉn §ao ph¸p, Thiªn NhÉn M©u ph¸p, Háa PhÇn Liªn Hoa. N¬i tiÕp nhËn nhiÖm vô: Háa §­êng §­êng chñ Ngét Ng¹o."},
			[2] = {"GÆp Ngét Ng¹o","",0,1,49,1642,3156},
			[3] = {"Tö tï 1 (lÊy LÖnh bµi 1)","",1,1,50,1500,3259},
			[4] = {"Tö tï 2 (lÊy LÖnh bµi 2)","",1,1,50,1495,3183},
			[5] = {"Tö tï 3 (lÊy LÖnh bµi 3)","",1,1,50,1569,3187},
			[6] = {"Tö tï 4 (lÊy LÖnh bµi 4)","",1,1,50,1569,3257},
			[7] = {"Tö tï 5 (lÊy LÖnh bµi 5)","",1,1,50,1526,3144},
			[8] = {"Tö tï 6 (lÊy LÖnh bµi 6)","",1,1,50,1601,3214},
			[9] = {"Tö tï 7 (lÊy LÖnh bµi 7)","",1,1,50,1533,3219},
			[10] = {"GÆp Ngét Ng¹o, hoµn thµnh nhiÖm vô","",0,1,49,1642,3156},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 Thiªn NhÉn<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>¶o ¶nh Phi Hå<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Tö SÜ. Häc ®­îc vâ c«ng: ¶o ¶nh Phi Hå. N¬i tiÕp nhËn nhiÖm vô: NhËt NguyÖt §µn Chñ ¤ Hîp T¸t."},
			[2] = {"GÆp ¤ Hîp T¸t (®¸p ¸n lµ H­íng xuèng ®Êt)","",1,1,45,1604,3181},
			[3] = {"gÆp bÐ trai (®¸p ¸n Anh Hai)","",1,1,45,1709,3251},
			[4] = {"T×m con chã nhá","",1,1,45,1685,3063},
			[5] = {"T×m con la x¸m","",1,1,45,1568,3123},
			[6] = {"gÆp bÐ trai (®æi NhËt nguyÖt song lu©n)","",1,1,45,1709,3251},
			[7] = {"Mang vÒ cho ¤ Hîp T¸t, hoµn thµnh nhiÖm vô","",1,1,45,1604,3181},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 Thiªn NhÉn<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Phi Hång V« TÝch<enter>LiÖt Háa T×nh Thiªn<enter>LiÖt Th«i S¬n §iÒn H¶i<color>"},
			--[1] = {"SÏ ®­îc phong lµ: U Minh Tö SÜ. Häc ®­îc vâ c«ng: Phi Hång V« TÝch, LiÖt Háa T×nh Thiªn, LiÖt Th«i S¬n §iÒn H¶i. N¬i tiÕp nhËn nhiÖm vô: Phong ®­êng ®­êng chñ: Hoµn Nhan TuyÕt Y."},
			[2] = {"GÆp Hoµn Nhan TuyÕt Y","",0,1,49,1708,3226},
			[3] = {"T×m N«ng phu (mua V©n Méng Tö)","",1,1,7,2373,2530},
			[4] = {"Trém b¶o tÆc 1 (lÊy C¸p huyÕt hång)","",1,1,8,1465,3255},
			[5] = {"Trém b¶o tÆc 2 ( lÊy B¨ng tinh lam)","",1,1,8,1676,3358},
			[6] = {"Trém b¶o tÆc 3 (lÊy Tæ mÉu lôc)","",1,1,8,1610,3207},
			[7] = {"Mang vÒ cho Hoµn Nhan TuyÕt Y, hoµn thµnh nhiÖm vô","",0,1,49,1708,3226},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 Thiªn NhÉn<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Bi T« Thanh Phong<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Ch­ëng Kú Sø. Häc ®­îc vâ c«ng: Bi T« Thanh Phong. N¬i tiÕp nhËn nhiÖm vô: H÷u Hé ph¸p Gia LuËt TÞ Li."},
			[2] = {"GÆp Gia LuËt TÞ Li","",0,1,49,1657,3032},
			[3] = {"§¸nh LiÖu Kú (lÊy Thiªn NhÉn mËt hµm)","",1,1,6,1570,3241},
			[4] = {"Giao l¹i cho Gia LuËt TÞ Li, hoµn thµnh nhiÖm vô","",0,1,49,1657,3032},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 Thiªn NhÉn<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>LÖ Ma §o¹t Hån<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Hé Gi¸o Sø. Häc ®­îc vâ c«ng: LÖ Ma §o¹t Hån. N¬i tiÕp nhËn nhiÖm vô: T¶ Hé ph¸p §oan Méc DuÖ."},
			[2] = {"GÆp §oan Méc DuÖ","",0,1,49,1798,3190},
			[3] = {"§¸nh §ao binh ®éi tr­ëng (lÊy ch×a khãa)","",1,1,38,1729,3033},
			[4] = {"Më r­¬ng tÇng 1 (®Ó më c¬ quan lªn tÇng 2)","",1,1,38,1665,3246},
			[5] = {"NhÊn vµo c¬ quan (®Ó lªn tÇng 2)","",1,1,38,1705,3131},
			[6] = {"§¸nh §ao binh thèng lÜnh (lÊy ch×a khãa)","",1,1,39,1734,3128},
			[7] = {"Më r­¬ng tÇng 2 (®Ó më c¬ quan lªn tÇng 3)","",1,1,39,1639,3201},
			[8] = {"NhÊn vµo c¬ quan (®Ó lªn tÇng 3)","",1,1,39,1688,3028},
			[9] = {"§¸nh Tæng binh (lÊy ch×a khãa)","",1,1,40,1626,3149},
			[10] = {"Më r­¬ng tÇng 3 (cøu Phông HÊp Nh-)","",1,1,40,1688,3019},
			[11] = {"Trë vÒ gÆp §oan Méc DuÖ, hoµn thµnh nhiÖm vô","",0,1,49,1798,3190},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ Thiªn NhÉn Gi¸o<color>"},
			[2] = {"GÆp Hoµn Nhan Hång LiÖt","",0,1,49,1721,3129},
			[3] = {"GÆp Khóc ThiÕt T­îng","",0,1,37,1746,3052},
			[4] = {"Mang ng©n tr©m cho Tr­¬ng qu¶ phô","",0,1,37,1707,3198},
			[5] = {"VÒ gÆp Khóc ThiÕt T­îng (lÊy YÓm NhËt KiÕm)","",0,1,37,1746,3052},
			[6] = {"GÆp T«n Tó Tµi (®¸p ¸n b-c-a-b-a) lÊy §o¹n Thñy KiÕm","",0,1,37,1834,2953},
			[7] = {"GÆp con b¹c (mua ChuyÓn Ph¸ch KiÕm víi gi¸ 500 l­îng)","",0,1,37,1608,3118},
			[8] = {"GÆp §«ng Mai","",0,1,37,1837,3053},
			[9] = {"GÆp TiÓu H¶i","",0,1,37,1762,3072},
			[10] = {"Quay l¹i §«ng Mai b¸o tin (lÊy Khø Tµ KiÕm)","",0,1,37,1837,3053},
			[11] = {"§Õn gÆp ¨n mµy (cho tiÒn 3 lÇn sÏ lÊy ®­îc DiÖt Hån KiÕm)","",0,1,37,1685,2998},
			[12] = {"Mang 5 thanh kiÕm vÒ cho Hoµn Nhan Hång LiÖt (sau ®ã tù ch¹y tíi cöa th¸nh ®éng ngay sau)","",0,1,49,1721,3129},
			[13] = {"NhÖn tinh","",1,1,51,1603,3188},
			[14] = {"§éc xµ tinh","",1,1,51,1878,3206},
			[15] = {"RÕt tinh","",1,1,51,1678,3112},
			[16] = {"NhÖn tinh","",1,1,51,1839,3166},
			[17] = {"Bß c¹p chóa (lÊy ch×a khãa th¸nh ®éng)","",1,1,52,1796,3106},
			[18] = {"Më r­¬ng (lÊy quyÓn s¸ch da dª)","",1,1,52,1865,3159},
			[19] = {"GÆp Hoµn Nhan Hång LiÖt, hoµn thµnh nhiÖm vô","",0,1,49,1721,3129},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n Thiªn NhÉn Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Th©u Thiªn Ho¸n NhËt<enter>Ma DiÖm ThÊt S¸t<enter>Thiªn Ma Gi¶i ThÕ<color>"},
			--[1] = {"Yªu cÇu: ng­êi ch¬i ®· xuÊt s­, ®¼ng cÊp trªn 60, ch­a gia nhËp bang ph¸i nµo, cã thÓ ®Õn gÆp tr­ëng m«n cña ph¸i giao 5 v¹n l­îng ®Ó trïng ph¶n s­ m«n. Tõ ®ã vÒ sau cã thÓ tïy ý ra vµo s­ m«n. PhÇn th­ëng: Th©u Thiªn Ho¸n NhËt, Ma DiÖm ThÊt S¸t, Thiªn Ma Gi¶i ThÕ. §­îc phong lµm:Th¸nh Gi¸o Tr­ëng L·o."},
			[2] = {"§èi tho¹i Gi¸o chñ, nép 5 v¹n l­îng","",0,1,49,1721,3129},
		},
		[8] = { --------------------------------------------------------
			[1] = {"<color=green>NhiÖm vô cÊp 90 Thiªn NhÉn Gi¸o<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>V©n Long KÝch<enter>Thiªn Ngo¹i L­u Tinh<enter>NhiÕp Hån Lo¹n T©m<color>"},
			[2] = {"GÆp L­u Viªn Ngo¹i","",0,1,37,1838,3115},
			[3] = {"GÆp Hoµn Nhan TuyÕt Y","",0,1,49,1708,3226},
			[4] = {"§¸nh Linh §iªu - Täa ®é 1","",1,1,3,878,3784},
			[5] = {"§¸nh Linh §iªu - Täa ®é 2","",1,1,3,1089,3874},
			[6] = {"Quay l¹i gÆp Hoµn Nhan TuyÕt Y","",0,1,49,1708,3226},
			[7] = {"Quay l¹i gÆp L­u Viªn Ngo¹i, hoµn thµnh nhiÖm vô","",0,1,37,1838,3115},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = { -----------------------------------------------------------
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö Thiªn NhÉn Gi¸o<color>"}, 
			[2] = {"GÆp Thiªn NhÉn gi¸o ®å","",0,1,45,1648,3148},
			[3] = {"GiÕt §¹i Hoµn Hïng ®o¹t Vò V­¬ng KiÕm","",1,1,2,2424,4043},
			[4] = {"GiÕt §¹i Hoµn Hïng thø hai lÊy Vò V­¬ng KiÕm thËt","",1,1,2,2509,4054},
			[5] = {"Quay l¹i gÆp Thiªn NhÉn gi¸o ®å, hoµn thµnh nhiÖm vô","",0,1,45,1648,3148},
		},
	},
	[8] = { --Vo dang
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 Vâ §ang Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Vâ §ang KiÕm Ph¸p<enter>Vâ §ang QuyÒn Ph¸p<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Nhµn T¸n §¹o Nh©n. Häc ®­îc vâ c«ng: Vâ §ang KiÕm Ph¸p, Vâ §ang QuyÒn Ph¸p. N¬i tiÕp nhËn nhiÖm vô: Tö Tiªu §¹i §iÖn, §¹o NhÊt Ch©n Nh©n."},
			[2] = {"GÆp §¹o NhÊt Ch©n Nh©n","",0,1,84,1598,3183},
			[3] = {"GÆp DiÖp TiÕp Mü (ChØ cÇn nhÊp vµo nãi chuyÖn)","",0,1,81,1703,3041},
			[4] = {"Tr¶ lêi §¹o NhÊt Ch©n Nh©n (C,B,B), hoµn thµnh nhiÖm vô","",0,1,84,1598,3183},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 Vâ §ang Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>ThÊt Tinh TrËn<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Thanh Tu §¹o Nh©n. Häc ®­îc vâ c«ng: ThÊt Tinh TrËn. N¬i tiÕp nhËn nhiÖm vô: Phô MÉu §iÖn, §µo Th¹ch M«n."},
			[2] = {"GÆp §µo Th¹ch M«n","",0,1,86,1605,3187},
			[3] = {"§¸nh Sãi §á 1 (LÊy Thiªn T»m Bµo r¸ch)","§Õn khi nhËn ®­îc Thiªn T»m §¹o Bµo r¸ch",1,1,83,1510,3050},
			[4] = {"§¸nh Sãi §á 2 (LÊy Thiªn T»m Bµo r¸ch)","§Õn khi nhËn ®­îc Thiªn T»m §¹o Bµo r¸ch",1,1,83,1642,2899},
			--[5] = {"§¸nh Sãi §á 3","§Õn khi nhËn ®­îc Thiªn T»m §¹o Bµo r¸ch",1,1,83,1750,3182},
			--[6] = {"§¸nh Sãi §á 4","§Õn khi nhËn ®­îc Thiªn T»m §¹o Bµo r¸ch",1,1,83,1680,3043},
			[5] = {"Quay l¹i gÆp §µo Th¹ch M«n","",0,1,86,1605,3187},
			[6] = {"§Õn T¹p Hãa T­¬ng D­¬ng v¸ ¸o","",0,1,78,1627,3259},
			[7] = {"§¸nh D· H¸n 1 (Cøu ®øa bÐ, lÊy thiªn t»m)","§Õn khi cøu ®­îc ®øa bÐ lÊy ®­îc Thiªn T»m",1,1,83,1582,2860},
			[8] = {"§¸nh D· H¸n 2 (Cøu ®øa bÐ, lÊy thiªn t»m)","§Õn khi cøu ®­îc ®øa bÐ lÊy ®­îc Thiªn T»m",1,1,83,1676,2932},
			[9] = {"Trë l¹i T¹p Hãa ®Ó v¸ ¸o","",0,1,78,1627,3259},
			[10] = {"Giao ¸o cho §µn Th¹ch M«n, hoµn thµnh nhiÖm vô","",0,1,86,1605,3187},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 Vâ §ang Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>KiÕm Phi Kinh Thiªn<enter>B¸t CÊp Nhi Phôc<color>"},
			--[1] = {"SÏ ®­îc phong lµ: TuÇn S¬n §¹i Nh©n. Häc ®­îc vâ c«ng: KiÕm Phi Kinh Thiªn, B¸t CÊp Nhi Phôc. N¬i tiÕp nhËn nhiÖm vô: ThËp Ph­¬ng ®iÖn, Tõ §¹i Nh¹c."},
			[2] = {"GÆp Tõ §¹i Nh¹c","",0,1,85,1598,3187},
			[3] = {"§¹i Háa Hæ 1 (lÊy 5 cá häa mi)","",1,1,90,1796,3286},
			[4] = {"§¹i Háa Hæ 2 (lÊy 5 cá häa mi)","",1,1,90,1617,3321},
			[5] = {"§¹i TuyÕt Lang 1 (lÊy 5 cá häa mi)","",1,1,90,1917,3086},
			[6] = {"§¹i TuyÕt Lang 2 (lÊy 5 cá häa mi)","",1,1,90,1742,3176},
			[7] = {"§¹i Thanh Lang 1 (lÊy 5 cá häa mi)","",1,1,90,1877,3186},
			[8] = {"§¹i Thanh Lang 2 (lÊy 5 cá häa mi)","",1,1,90,2009,3265},
			[9] = {"§¹i Thanh Lang 3 (lÊy 5 cá häa mi)","",1,1,90,1804,2979},
			[10] = {"§ñ 5 cá häa mi vÒ giao cho Tõ §¹i Nh¹c, hoµn thµnh nhiÖm vô","",0,1,85,1598,3187},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 Vâ §ang Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>ThÕ V©n Tung<color>"},
			--[1] = {"SÏ ®­îc phong lµ: NhËp Quan §¹o Nh©n. Häc ®­îc vâ c«ng: ThÕ V©n Tung. N¬i tiÕp nhËn nhiÖm vô: Chu V©n TuyÒn."},
			[2] = {"GÆp Chu V©n TuyÒn","",0,1,81,1754,3081},
			[3] = {"GÆp NhuËn N­¬ng","",1,1,91,1618,2962},
			[4] = {"B¹ch Ngäc Hæ 1","",1,1,91,1592,2931},
			[5] = {"B¹ch Ngäc Hæ 2","",1,1,91,1537,3016},
			[6] = {"B¹ch Ngäc Hæ 3","",1,1,91,1680,2965},
			[7] = {"B¹ch Ngäc Hæ 4","",1,1,91,1648,3088},
			[8] = {"B¹ch Ngäc Hæ 5","",1,1,91,1661,2891},
			[9] = {"VÒ gÆp NhuËn N­¬ng","",1,1,91,1618,2962},
			[10] = {"NhuËn N­¬ng Gia Hæ (lÊy th¬ håi ©m)","",1,1,91,1616,2819},
			[11] = {"NhuËn N­¬ng Gia B¸o (lÊy th¬ håi ©m)","",1,1,91,1697,2740},
			[12] = {"Giao th¬ cho §¹o NhÊt Ch©n Nh©n, hoµn thµnh nhiÖm vô","",0,1,84,1598,3183},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 Vâ §ang Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Täa Väng V« Ng·<color>"},
			--[1] = {"SÏ ®­îc phong lµ: Ch­ëng Kinh §¹o Nh©n. Häc ®­îc vâ c«ng: Täa Väng V« Ng·. N¬i tiÕp nhËn nhiÖm vô: Long Hæ ®iÖn, §¬n T¬ Nam."},
			[2] = {"GÆp §¬n T¬ Nam","",0,1,87,1602,3186},
			[3] = {"§Çu môc thæ phØ ThiÕt T¸o (lÊy 1 v¹n l­îng)","",1,1,42,1513,3168},
			[4] = {"GÆp §¬n T¬ Nam","",0,1,87,1602,3186},
			[5] = {"T×m TrÞnh Gia TÈu Tö","",0,1,78,1648,3277},
			[6] = {"Trë vÒ gÆp §¬n T¬ Nam, hoµn thµnh nhiÖm vô","",0,1,87,1602,3186},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ Vâ §ang Ph¸i<color>"},
			--[1] = {"SÏ ®­îc phong lµ: HuyÒn Vò ThÇn ThÞ. N¬i tiÕp nhËn nhiÖm vô: Tö Tiªu §¹i §iÖn, §¹o NhÊt Ch©n Nh©n."},
			[2] = {"GÆp §¹o NhÊt Ch©n Nh©n","",0,1,84,1598,3183},
			[3] = {"T×m c¸i r­¬ng thø nhÊt","",1,1,81,1897,2912},
			[4] = {"GÆp «ng chñ d­îc ®iÕm","",0,1,78,1610,3245},
			[5] = {"LÊy §­¬ng Quy","",1,1,90,2002,3454},
			[6] = {"LÊy Hîp Hoan","",1,1,90,1812,3652},
			[7] = {"LÊy HuyÒn S©m","",1,1,90,1745,3607},
			[8] = {"LÊy Phßng Kû","",1,1,90,1915,3554},
			[9] = {"LÊy Chu Sa","",1,1,90,1777,3667},
			[10] = {"Giao 5 d­îc liÖu cho «ng chñ d­îc ®iÕm","",0,1,78,1610,3245},
			[11] = {"VÒ më r­¬ng thø nhÊt (lÊy Ngäc Thanh ch©n kinh)","",1,1,81,1897,2912},
			[12] = {"T×m c¸i r­¬ng thø 2","",1,1,81,1897,2876},
			[13] = {"T×m thî rÌn","",0,1,78,1554,3216},
			[14] = {"LÊy Tõ thiÕt kho¸ng","",1,1,78,1422,2987},
			[15] = {"LÊy L­îng ng©n kho¸ng","",1,1,78,1400,3072},
			[16] = {"LÊy XÝch ®ång kho¸ng","",1,1,78,1466,2988},
			[17] = {"T×m thî rÌn","",0,1,78,1554,3216},
			[18] = {"VÒ më r­¬ng thø 2 (lÊy Th­îng Thanh ch©n kinh)","",1,1,81,1897,2876},
			[19] = {"T×m chiÕc r­¬ng thø 3","",1,1,81,1876,2833},
			[20] = {"T×m Nha m«n vÖ binh","",0,1,78,1590,3209},
			[21] = {"§¸nh b¹i T­¬ng D­¬ng thñ t­íng","",1,1,79,1750,3229},
			[22] = {"VÒ më r­¬ng thø 3 (lÊy Th¸i Thanh ch©n kinh)","",1,1,81,1876,2833},
			[23] = {"VÒ gÆp §¹o NhÊt Ch©n Nh©n, hoµn thµnh nhiÖm vô","",0,1,84,1598,3183},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n Vâ §ang Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Th¸i Cùc ThÇn C«ng<enter>V« Ng· V« KiÕm<enter>Tam Hoµn Thao NguyÖt<color>"},
			--[1] = {"Yªu cÇu: ng­êi ch¬i ®· xuÊt s­, ®¼ng cÊp trªn 60, ch­a gia nhËp bang ph¸i nµo, cã thÓ ®Õn gÆp tr­ëng m«n cña ph¸i giao 5 v¹n l­îng ®Ó trïng ph¶n s­ m«n. Tõ ®ã vÒ sau cã thÓ tïy ý ra vµo s­ m«n. PhÇn th­ëng: Th¸i Cùc ThÇn C«ng, V« Ng· V« KiÕm, Tam Hoµn Thao NguyÖt. §­îc phong lµm: HuyÒn Vâ Ch©n Qu©n."},
			[2] = {"§èi tho¹i Ch­ëng m«n, nép 5 v¹n l­îng","",0,1,49,1721,3129},
		},
		[8] = { -------------------------------------------------
			[1] = {"<color=green>NhiÖm vô cÊp 90 Vâ §ang Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thiªn §Þa V« Cùc<enter>Nh©n KiÕm Hîp NhÊt<color>"},
			[2] = {"GÆp §¹o tr­ëng Lý Thiªn Môc","",0,1},
			[3] = {"GÆp Chu V¨n TuyÒn","",0,1},
			[4] = {"GÆp Lý Thiªn Môc lÇn 2","",0,1},
			[5] = {"GÆp Chu V¨n TuyÒn lÇn 2","",1,1},
			[6] = {"GÆp Lý Thiªn Môc lÇn 3","",0,1},
			[7] = {"Vµo Thiªn T©m §éng tõ Phôc Ng­u S¬n T©y","",0,1},
			[8] = {"Quay vÒ gÆp Lý Thiªn Môc, hoµn thµnh nhiÖm vô","",0,1},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = { -----------------------------------------------------------------
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö Vâ §ang Ph¸i<color>"},
			[2] = {"GÆp Thanh Phong","",0,1},
			[3] = {"§¸nh Tr¨n lín","",0,1},
			[4] = {"Quay vÒ gÆp Thanh Phong, hoµn thµnh nhiÖm vô","",0,1},
		},
	},
	[9] = { --Con lon
		[1] = {
			[1] = {"<color=green>NhiÖm vô cÊp 10 C«n L«n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>C«n L«n §ao Ph¸p<enter>C«n L«n KiÕm Ph¸p<enter>Thanh Phong Phï<enter>Thóc Ph­îc Chó<color>"},
			[2] = {"GÆp TiÓu Hµn","",0,1,131,1472,3140},
			[3] = {"§¸nh MÌo Rõng lÊy 5 lo¹i th¶o d-îc","",1,1,140,2437,3742},
			[4] = {"Giao cho TiÓu Hµn, hoµn thµnh nhiÖm vô","",0,1,131,1472,3140},
		},
		[2] = {
			[1] = {"<color=green>NhiÖm vô cÊp 20 C«n L«n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Ky B¸n Phï<color>"},
			[2] = {"GÆp Th¸n Tøc L·o Nh©n nhËn nhiÖm vô","",0,1,131,1526,3225},
			[3] = {"§¸nh Thæ PhØ lÊy X­¬ng ®Çu l¹c ®µ","",1,1,141,1548,3193},
			[4] = {"Giao cho Th¸n Tøc L·o Nh©n, hoµn thµnh nhiÖm vô","",0,1,131,1526,3225},
		},
		[3] = {
			[1] = {"<color=green>NhiÖm vô cÊp 30 C«n L«n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thiªn TÕ TÊn L«i<enter>Thiªn Thanh §Þa Träc<enter>NhÊt KhÝ Tam Thanh<enter>B¾c Minh §¸o H¶i<color>"},
			[2] = {"GÆp Chu KhuyÕt §¹i S¬","",0,1,131,1587,3202},
			[3] = {"§¸nh C¸o §á lÊy 3 D¹ Minh Ch©u","",1,1,145,1629,3222},
			[4] = {"Giao cho Chu KhuyÕt §¹i S¬, hoµn thµnh nhiÖm vô","",0,1,131,1587,3202},
		},
		[4] = {
			[1] = {"<color=green>NhiÖm vô cÊp 40 C«n L«n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Khi Hµn Ng¹o TuyÕt<enter>KhÝ T©m Phï<color>"},
			[2] = {"GÆp Thanh Liªn Tö nhËn nhiÖm vô","",0,1,139,1606,3199},
			[3] = {"§¸nh b¹i Hång NguyÖt lÊy th«ng tin vÒ thanh kiÕm","",1,1,135,1675,2853},
			[4] = {"§¸nh Lam V©n lÊy ch×a khãa","",1,1,135,1764,3194},
			[5] = {"Dïng ch×a khãa më r­¬ng","",1,1,135,1529,2804},
			[6] = {"Giao HuyÕt Hån ThÇn KiÕm cho Thanh Liªn Tö, hoµn thµnh nhiÖm vô","",0,1,139,1606,3199},
		},
		[5] = {
			[1] = {"<color=green>NhiÖm vô cÊp 50 C«n L«n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Mª Tung Hoan ¶nh<enter>Cuång Phong SËu §iÖn<color>"},
			[2] = {"GÆp Ngäc Hoµnh Tö nhËn nhiÖm vô","",0,1,137,1596,3193},
			[3] = {"§¸nh §¹i tuyÕt qu¸i 1","",1,1,132,1472,3209},
			[4] = {"§¸nh §¹i tuyÕt qu¸i 2","",1,1,132,1645,3218},
			[5] = {"§¸nh §¹i tuyÕt qu¸i 3","",1,1,132,1620,3168},
			[6] = {"§¸nh §¹i tuyÕt qu¸i 4","",1,1,132,1528,3208},
			[7] = {"§¸nh §¹i tuyÕt qu¸i 5","",1,1,132,1476,3262},
			[8] = {"§¸nh qu¸i nh©n lÊy Nóm Tãc","",1,1,132,1574,3215},
			[9] = {"Giao cho Ngäc Hoµnh Tö, hoµn thµnh nhiÖm vô","",0,1,137,1596,3193},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ C«n L«n Ph¸i<color>"},
			[2] = {"GÆp TruyÒn C¬ Tö nhËn nhiÖm vô","",0,1,138,1596,3196},
			[3] = {"T×m gÆp V« Danh L·o §¹o","",1,1,122,1712,3142},
			[4] = {"§¸nh Truy Hån lÊy Phôc ty táa","",1,1,125,1689,3245},
			[5] = {"TiÕn vµo t©ng 2, chän Tôy Nh©n ®Ó lªn tÇng 2","",1,1,125,1591,3205},
			[6] = {"§¸nh Thõa Phong, lÊy Viªm ®Õ táa","",1,1,126,1614,3015},
			[7] = {"TiÕn vµo tÇng 3, chän Tinh VÖ ®Ó lªn tÇng 3","",1,1,126,1674,3060},
			[8] = {"§¸nh b¹i L­u Tinh, lÊy ThiÕu t¹o táa","",1,1,127,1664,3087},
			[9] = {"TiÕn vµo tÇng 4, chän Xu©n ®Ó lªn tÇng 4","",1,1,127,1697,3232},
			[10] = {"§¸nh b¹i TËt §iÖn, lÊy Chuyªn tóc táa","",1,1,128,1619,3142},
			[11] = {"TiÕn ®Õn tÇng 5, chän §Êt trêi ph©n ®«i ®Ó lªn tÇng 5","",1,1,128,1521,3057},
			[12] = {"§¸nh b¹i N÷ ThÝch Kh¸ch, lÊy Hoµng ®Õ táa","",1,1,129,1745,3347},
			[13] = {"TiÕn ®Õn tÇng 6, chän Hai bøc t­îng sóc vËt b»ng gç ®Ó lªn tÇng 6","",1,1,129,1645,3250},
			[14] = {"Më r­¬ng lÊy Ngò s¾c th¹ch","",1,1,130,1587,3195},
			[15] = {"Giao cho TruyÒn C¬ Tö, hoµn thµnh nhiÖm vô","",0,1,138,1596,3196},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n C«n L«n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Ngò L«i ChÝnh Ph¸p<enter>S­¬ng Ng¹o C«n L«n<color>"},
			[2] = {"§èi tho¹i Ch­ëng m«n, nép 5 v¹n l­îng","",0,1,138,1596,3196},
		},
		[8] = { ----------------------------------------------
			[1] = {"<color=green>NhiÖm vô cÊp 90 C«n L«n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Ng¹o TuyÕt Tiªu Phong<enter>L«i §éng Cöu Thiªn<color>"},
			[2] = {"GÆp Th¸n Tøc L·o Nh©n","",0,1},
			[3] = {"GÆp Ng­ Tè Ch©n vµ ThiÖu B¶o Nhi","",0,1},
			[4] = {"Quay vÒ gÆp Th¸n Tøc L·o Nh©n","",0,1},
			[5] = {"§¸nh b¹i Ng­ Tè Ch©n vµ ThiÖu B¶o Nhi","",1,1},
			[6] = {"Quay vÒ gÆp Th¸n Tøc L·o Nh©n, hoµn thµnh nhiÖm vô","",0,1},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = { ----------------------------------------------------------------------------
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö C«n L«n Ph¸i<color>"},
			[2] = {"GÆp §ång TÞch Nhan","",0,1},
			[3] = {"T×m Kim T¬ HÇu","",0,1},
			[4] = {"T×m mét chïm qu¶ S¬n Lý Hång","",0,1},
			[5] = {"GÆp TuyÒn C¬ Tö, hoµn thµnh nhiÖm vô","",0,1},
		},
	},
	[10] = {-- Hoa Son
		[1] = {
			[1] = {"NhiÖm vô cÊp 10 Hoa S¬n Ph¸i:<enter><color=green>LÊy n­íc th­ëng trµ<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>KiÕm T«ng Tæng QuyÕt<enter>Long NhiÔu Th©n<color>"},
			[2] = {"§èi tho¹i víi V¹n T­ ViÔn","",0,1,987,1454,2956},
			[3] = {"§Õn n¬i lÊy Thanh LiÖt TuyÒn Thñy","",0,1,987,1231,3248},
			[4] = {"Quay l¹i V¹n T­ ViÔn, hoµn thµnh nhiÖm vô","",0,1,987,1454,2956},
		},
		[2] = {
			[1] = {"NhiÖm vô cÊp 20 Hoa S¬n Ph¸i:<enter><color=green>Ngé KiÕm<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>D­ìng Ng« KiÕm Ph¸p<enter>H¶i N¹p B¸ch Xuyªn<color>"},
			[2] = {"§èi tho¹i víi Tõ Mé","",0,1,987,1507,2881},
			[3] = {"Thu thËp Dung TuyÕt Chi Thñy","",0,1,987,1360,2913},
			[4] = {"Thu thËp Nhai BÝch Chi Th¹ch","",0,1,987,1553,3137},
			[5] = {"Thu thËp Th­¬ng Tïng Ch©m DiÖp","",0,1,987,1538,3167},
			[6] = {"§èi tho¹i ®Ö tö luyÖn cÊp Ph¸i Hoa S¬n","",0,1,987,1385,3057},
			[7] = {"§i LuyÖn Vâ Tr­êng","",1,1,987,1506,2989},
			[8] = {"Quay l¹i Tõ Mé, nép vËt phÈm nhiÖm vô","",0,1,987,1507,2881},
		},
		[3] = {
			[1] = {"NhiÖm vô cÊp 30 Hoa S¬n Ph¸i:<enter><color=green>B¨ng Tµm Ngäc Lé Cao<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Kim Nh¹n Hoµnh Kh«ng<enter>Long HuyÒn KiÕm KhÝ<color>"},
			[2] = {"§èi tho¹i L¹n V©n Mi","",0,1,987,1306,3019},
			[3] = {"§èi tho¹i «ng chñ hiÖu thuèc Ph­îng T­êng","",0,1,1,1598,3195},
			[4] = {"§Õn KiÕm C¸c T©y B¾c ®¸nh b¹i kÎ c­íp","",1,1,3,960,3874},
			[5] = {"Quay l¹i «ng chñ hiÖu thuèc nép B¨ng Tµm ThuÕ","",0,1,1,1598,3195},
			[6] = {"Quay l¹i hiÖu thuèc nhËn B¨ng Tµm Ngäc Lé Cao","",0,1,1,1598,3195},
			[7] = {"Quay l¹i L¹n V©n Mi, hoµn thµnh nhiÖm vô","",0,1,987,1306,3019},
		},
		[4] = {
			[1] = {"NhiÖm vô cÊp 40 Hoa S¬n Ph¸i:<enter><color=green>V©n Tö Tr¾c Thu B×nh<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Hi Di KiÕm Ph¸p<enter>KhÝ ChÊn S¬n Hµ<color>"},
			[2] = {"§èi tho¹i ThÈm MÆc","",0,1,987,1431,2966},
			[3] = {"§èi tho¹i tiÖm t¹p Hãa Ph­îng T­êng","",0,1,1,1563,3210},
			[4] = {"§èi tho¹i L­u Viªn Ngo¹i","",0,1,1,1592,3314},
			[5] = {"Quay l¹i ThÈm MÆc, hoµn thµnh nhiÖm vô","",0,1,987,1431,2966},
		},
		[5] = {
			[1] = {"NhiÖm vô cÊp 50 Hoa S¬n Ph¸i:<enter><color=green>VÜnh L¹c Phong V©n<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>Thiªn Th©n §¶o HuyÒn<enter>KhÝ Qu¸n Tr­êng Hång<color>"},
			[2] = {"§èi tho¹i L¹n H¹o Thiªn","",0,1,987,1359,3050},
			[3] = {"Hái th¨m tin tøc tõ Hoµng thóc","",0,1,99,1622,3175},
			[4] = {"Hái th¨m tin tøc tõ §æng ®¹i thóc","",0,1,99,1588,3204},
			[5] = {"Hái th¨m tin tøc tõ Bµ Th­ ","",0,1,99,1641,3301},
			[6] = {"§Õn Kim Quang §éng ®¸nh b¹i S¬n PhØ lÊy 3 Tµi VËt","",1,1,4,1585,3109},
			[7] = {"Giao tr¶ Tµi VËt cho d©n lµng","",0,1,99,1622,3202},
			[8] = {"Quay l¹i L¹n H¹o Thiªn, hoµn thµnh nhiÖm vô","",0,1,987,1359,3050},
		},
		[6] = {
			[1] = {"<color=green>NhiÖm vô XuÊt S­ Hoa S¬n Ph¸i<color>"},
			[2] = {"§èi tho¹i Nam Cung NguyÖt","",0,1,987,1421,3048},
			[3] = {"§èi tho¹i ¢n KiÕm Thu","",0,1,987,1371,2917},
			[4] = {"§¸nh b¹i §iÕu T×nh B¹ch Hæ lÊy B¹ch Hæ TuyÕt","",1,1,145,1528,3319},
			[5] = {"Quay l¹i ¢n KiÕm Thu","",0,1,987,1371,2917},
			[6] = {"§i th¸c n­íc tÜnh t©m","",0,1,987,1479,2841},
			[7] = {"§i KiÕm C¸c T©y Nam h¹ Khóc V« H×nh","",1,1,19,3440,3631},
			[8] = {"Quay l¹i Nam Cung TuyÖt, hoµn thµnh nhiÖm vô","",0,1,987,1421,3048},
		},
		[7] = {
			[1] = {"<color=green>NhiÖm vô Trïng Ph¶n S­ M«n Hoa S¬n Ph¸i<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>HuyÒn Nh·n V©n Yªn<enter>Ma V©n KiÕm KhÝ<enter>Th­¬ng Tïng Nghªnh Kh¸ch<color>"},
			[2] = {"§èi tho¹i Ch­ëng M«n, nép 5 v¹n l­îng","",0,1,987,1421,3048},
		},
		[8] = {
			[1] = {"NhiÖm vô cÊp 90 Hoa S¬n Ph¸i:<enter><color=green>T­¬ng D­¬ng KÕt Tri Kû<color><enter>Häc ®­îc vâ c«ng:<enter><color=yellow>§o¹t MÖnh Liªn Hoµn Tam Tiªn KiÕm<enter>Ph¸ Th¹ch Ph¸ Ngäc<color>"},
			[2] = {"§èi tho¹i Nh¹c Minh Phi","",0,1,78,1574,3199},
			[3] = {"KiÓm tra c¸i ¸o","",1,1,78,1470,3560},
			[4] = {"Quay l¹i ®èi tho¹i Nh¹c Minh Phi","",0,1,78,1574,3199},
			[5] = {"§èi tho¹i T« Phãng","",0,1,987,1558,3150},
			[6] = {"§èi tho¹i L¹n H¹o Thiªn","",0,1,987,1359,3050},
			[7] = {"§èi tho¹i Nh¹c Minh Phi","",0,1,78,1574,3199},
			[8] = {"§i Phôc Ng­u S¬n §«ng h¹ 5 s¸t thñ Thiªn NhÉn Gi¸o","",1,1,90,1902,3434},
			[9] = {"§èi tho¹i Nh¹c Minh Phi hoµn thµnh nhiÖm vô","",0,1,78,1574,3199},
		},
		[9] = {
			[1] = {"<color=green>BÝ kÝp kü n¨ng cÊp 120 cã thÓ thu thËp t¹i Kú Tr©n C¸c<color>"},
		},
		[10] = {
			[1] = {"<color=green>NhiÖm vô Ký Danh §Ö Tö Hoa S¬n Ph¸i<color>"},
			[2] = {"§èi tho¹i Tiªu Ngäc","",0,1,987,1488,3067},
			[3] = {"§i §iÓm Th­¬ng S¬n thu thËp H¾c Hoµng §µn","",1,1,167,1511,2473},
			[4] = {"Quay l¹i Tiªu Ngäc, hoµn thµnh nhiÖm vô","",0,1,987,1488,3067},
		},
	},
}

function nvmonphai()
help_quest()
return 1
end

function help_quest()
	local nFaction = GetLastFactionNumber()
	if nFaction < 0 then
		Msg2Player("Xin h·y gia nhËp m«n ph¸i råi míi sö dông chøc n¨ng nµy!")
		return
	elseif nFaction == 0 then
		TenMP = "ThiÕu L©m"
	elseif nFaction == 1 then
		TenMP = "Thiªn V­¬ng"
	elseif nFaction == 2 then
		TenMP = "§­êng M«n"
	elseif nFaction == 3 then
		TenMP = "Ngò §éc"
	elseif nFaction == 4 then
		TenMP = "Nga My"
	elseif nFaction == 5 then
		TenMP = "Thóy Yªn"
	elseif nFaction == 6 then
		TenMP = "C¸i Bang"
	elseif nFaction == 7 then
		TenMP = "Thiªn NhÉn"
	elseif nFaction == 8 then
		TenMP = "Vâ §ang"
	elseif nFaction == 9 then
		TenMP = "C«n L«n"
	elseif nFaction == 10 then
		TenMP = "Hoa S¬n"
	elseif nFaction == 11 then
		TenMP = "Vò Hån"
	elseif nFaction == 12 then
		TenMP = "Tiªu Dao"
	end
	--if TenMP == "Vò Hån" then
	--	return
	--	Talk(1, "", "HiÖn t¹i ch­a ph¸t triÓn nhiÖm vô ph¸i Vò Hån.")
	--end
	local tab_Content = {
		"NhiÖm vô cÊp 10 "..TenMP.."/#help_quest_step1("..nFaction..",1,2,"..getn(tb_HelpMonPhai[nFaction][1])..")",
		"NhiÖm vô cÊp 20 "..TenMP.."/#help_quest_step1("..nFaction..",2,2,"..getn(tb_HelpMonPhai[nFaction][2])..")",
		"NhiÖm vô cÊp 30 "..TenMP.."/#help_quest_step1("..nFaction..",3,2,"..getn(tb_HelpMonPhai[nFaction][3])..")",
		"NhiÖm vô cÊp 40 "..TenMP.."/#help_quest_step1("..nFaction..",4,2,"..getn(tb_HelpMonPhai[nFaction][4])..")",
		"NhiÖm vô cÊp 50 "..TenMP.."/#help_quest_step1("..nFaction..",5,2,"..getn(tb_HelpMonPhai[nFaction][5])..")",
		"NhiÖm vô xuÊt s­ "..TenMP.."/#help_quest_step1("..nFaction..",6,2,"..getn(tb_HelpMonPhai[nFaction][6])..")",
		"NhiÖm vô Trïng Ph¶n s­ m«n "..TenMP.."/#help_quest_step1("..nFaction..",7,2,"..getn(tb_HelpMonPhai[nFaction][7])..")",
                                   "Ký danh ®Ö tö "..TenMP.."/#help_quest_step1("..nFaction..",10,2,"..getn(tb_HelpMonPhai[nFaction][10])..")",
		"NhiÖm vô cÊp 90 "..TenMP.."/#help_quest_step1("..nFaction..",8,2,"..getn(tb_HelpMonPhai[nFaction][8])..")",
		"Kü n¨ng 120 "..TenMP.."/#help_quest_step1("..nFaction..",9,2,"..getn(tb_HelpMonPhai[nFaction][9])..")",
		"KÕt thóc ®èi tho¹i/Quit"
		}
		Say("CÈm nang ®Æc biÖt gióp dÞch chuyÓn nhanh c¸c ®Þa ®iÓm lµm nhiÖm vô M«n Ph¸i.", getn(tab_Content), tab_Content);
end
function help_quest_step1(nFaction,nIDQ,nX,nY)
	local strDesc = tb_HelpMonPhai[nFaction][nIDQ][1][1]
	if (not nX) then
		nX1 = 2;
		nY1 = 10;
	else
		nX1 = nX;
		nY1 = nY;
	end
	if (nY1 - nX1 > 9) then
		nY1 = nX1 + 9;
	end
	if nIDQ == 1 then
		TenNV = "NhiÖm vô cÊp 10"
	elseif nIDQ == 2 then
		TenNV = "NhiÖm vô cÊp 20"
	elseif nIDQ == 3 then
		TenNV = "NhiÖm vô cÊp 30"
	elseif nIDQ == 4 then
		TenNV = "NhiÖm vô cÊp 40"
	elseif nIDQ == 5 then
		TenNV = "NhiÖm vô cÊp 50"
	elseif nIDQ == 6 then
		TenNV = "NhiÖm vô xuÊt s­"
	elseif nIDQ == 7 then
		TenNV = "NhiÖm vô Trïng Ph¶n s­ m«n"
	elseif nIDQ == 8 then
		TenNV = "NhiÖm vô cÊp 90"
	elseif nIDQ == 9 then
		TenNV = "Kü n¨ng 120"
	elseif nIDQ == 10 then
		TenNV = "Ký danh ®Ö tö"
	end
	local tbOpt = {}
	local TotalSelect = getn(tb_HelpMonPhai[nFaction][nIDQ])
	for i=nX1,nY1 do
		local FightState = tb_HelpMonPhai[nFaction][nIDQ][i][3]
		local TypeMove = tb_HelpMonPhai[nFaction][nIDQ][i][4] --Ban ®Çu m×nh lµm phÇn to¹ ®o¹ lµ kiÓu nh­ game vÝ dô 271 - 291 nh¬ng to¹ ®é nµy nã phï kh«ng chÝnh x¸c nªn vÒ sau ®Ó hÕt sang to¹ ®æ kiÓu 4 sè. TypeMove lu«n lµ 1
		local MapId = tb_HelpMonPhai[nFaction][nIDQ][i][5]
		local nX =tb_HelpMonPhai[nFaction][nIDQ][i][6]
		local nY = tb_HelpMonPhai[nFaction][nIDQ][i][7]
		tinsert(tbOpt, {tb_HelpMonPhai[nFaction][nIDQ][i][1],help_quest_step2,{FightState,TypeMove,MapId,nX,nY,TenMP,TenNV,tb_HelpMonPhai[nFaction][nIDQ][i][2],tb_HelpMonPhai[nFaction][nIDQ][i][1]}})
	end
	if (nX1 ~= 2) then
		tinsert(tbOpt,{"Trang tr­íc",help_quest_step1,{nFaction,nIDQ,2,nX1-1}});
	end
	if (nY1 < TotalSelect) then
		tinsert(tbOpt,{"Trang sau",help_quest_step1,{nFaction,nIDQ,nY1+1,TotalSelect}});
	end
	tinsert(tbOpt, {"Quay l¹i",help_quest})
	tinsert(tbOpt, {"Tho¸t."})
	CreateNewSayEx(strDesc, tbOpt);
end
function help_quest_step2(FightState,TypeMove,MapId,nX,nY,MonPhai,NhiemVu,BuocThucHien,NoiDungNhiemVu)
	if TypeMove == 0 then
		NewWorld(MapId,nX*8,nY*16) --
	else
		NewWorld(MapId,nX,nY) --
	end
	SetFightState(FightState)
	Msg2Player("§ang thùc hiÖn <color=yellow>"..NhiemVu.."<color> m«n ph¸i <color=yellow>"..MonPhai.."<color>. Néi dung nhiÖm vô: <color=green>"..NoiDungNhiemVu.."<color>")
	AddNote("Néi dung nhiÖm vô: <color=green>"..BuocThucHien.."<color>")
end
------------------------------------------------------------------------NV Hoµng Kim-------------------------------------------------------------------------------------------
tb_HelpGoldQuest = {
--=========================================================Hoµng Kim ChÝnh TuyÕn START
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
			{nTitle = "GÆp §oµn Méc DuÖ.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{360}}}, nItemCheck = {}, nFightState = 0, nW = 49, nX = 1798, nY = 3189},
			{nTitle = "GÆp §oµn Méc Thanh.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{400}}}, nItemCheck = {}, nFightState = 0, nW = 121, nX = 2013, nY = 4490},
			{nTitle = "Quay vÒ gÆp §oµn Méc Thanh.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 50, nLevelMax=200, nTaskCheck = {{1003,{409}}}, nItemCheck = {}, nFightState = 0, nW = 121, nX = 2013, nY = 4490},
			{nTitle = "Tiªu diÖt anh hïng kh¸ng Kim, Liªu §Þnh.", nName = "Tµ Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{410}}}, nItemCheck = {}, nFightState = 1, nW = 94, nX = 1565, nY = 3141},
			{nTitle = "Quay vÒ gÆp §oµn Méc Thanh.", nName = "Tµ Ph¸i CÊp 50",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{420}}}, nItemCheck = {}, nFightState = 0, nW = 121, nX = 2013, nY = 4490},
			{nTitle = "Cã thÓ ®Õn t×m Long Ngò nhËn phÇn th­ëng.",nName = "Tµ Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{430}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
			{nTitle = "§· hoµn thµnh chuçi nhiÖm vô hoµng kim Tµ Ph¸i. H·y tiÕp tôc rÌn luyÖn!!!",nName = "Tµ Ph¸i CÊp 60",nLevelMin = 60, nLevelMax=200, nTaskCheck = {{1003,{1000}}}, nItemCheck = {}, nFightState = 0, nW = 53, nX = 1619, nY = 3170},
		},
	},
--=========================================================Hoµng Kim ChÝnh TuyÕn END
--=========================================================Hoµng Kim Phô TuyÒn START
 	[2] = { --Phô tuyÕn MissType
		[1] = { --ChÝnh ph¸i PheType
			----------------------------------------------------------CÊp 20-29
			{nTitle = "§Õn Ph­îng T­êng gÆp Ng¹o V©n T«ng",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Ng¹o V©n T«ng b¶o b¹n ®Õn Thiªn Long tù ë §¹i Lý t×m Si T¨ng hái th¨m tin tøc.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{20,30}}}, nItemCheck = {}, nFightState = 0, nW = 332, nX = 167*8, nY = 176*16},
			{nTitle = "Si T¨ng nãi b¹n ra ngoµi ®¸nh Tµng B¶o Kh¸ch lÊy 5 cuèn Cê Phæ mang vÒ cho «ng ta",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{40}}}, nItemCheck = {{0,504,5}}, nFightState = 1, nW = 332, nX = 1252, nY = 3011},
			{nTitle = "§· lÊy ®ñ 5 cuèn Cê Phæ. Quay l¹i gÆp Si T¨ng",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{40}}}, nItemCheck = {{1,504,5}}, nFightState = 0, nW = 332, nX = 1345, nY = 2828},
			{nTitle = "Th× ra ng­êi nµy lµ Si T¨ng gi¶ d¹ng! B¹n h·y trë vÒ t×m Ng¹o V©n T«ng.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Lµ TiÔn §Çu b¹n cña ta. Ng­¬i ®i Hoa S¬n ph¸i t×m «ng ta ®i, «ng ta Èn c­ ë ®ã ®· 10 n¨m råi, n¨m x­a y tõng nh¾c ®Õn Thiªn Hoµng Long KhÝ",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{80,90}}}, nItemCheck = {}, nFightState = 0, nW = 333, nX = 1246, nY = 3267},
			{nTitle = "TiÔn §Çu b¶o b¹n ®Õn Ph­îng T­êng t×m SÇm Hïng hái th¨m tin tøc.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{100,110}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 192*8, nY = 201*16},
			{nTitle = "§¸nh b¹i Phan Nh­ Long ®ang ë ngoµi thµnh Ph­îng T­êng.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{120}}}, nItemCheck = {}, nFightState = 1, nW = 1, nX = 220*8, nY = 190*16},
			{nTitle = "Phan Nh­ Long lóc s¾p chÕt nãi, h¾n ta kh«ng ph¶i lµ ng­êi hµnh thÝch Nh¹c Phi! Hoµn thµnh nhiÖm vô.B¹n cã thÓ vÒ gÆp Ng¹o V©n T«ng.",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{130}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
			{nTitle = "Hoµn thµnh nhiÖm vô. Cã thÓ gÆp Ng¹o V©n T«ng nhËn th­ëng <<M¶nh B¶nh §å>> vµ <<D©y ChuyÒn Kim Phong>>",nName = "ChÝnh Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1050,{1000}},{196,{0}}}, nItemCheck = {}, nFightState = 0, nW = 1, nX = 1587, nY = 3303},
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
			{nTitle = "§Õn L©m An t×m gÆp LiÔu Nam V©n",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
			{nTitle = "TÇn L¨ng, n¬i ®ã ®ang bÞ n¹n giÆc NhÝm ph¸ ph¸ch, tr­íc tiªn h·y ®Õn TÇn L¨ng ®¸nh 50 con NhÝm.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{20}},{1012,{10}}}, nItemCheck = {}, nFightState = 1, nW = 7, nX = 2277, nY = 2824},
			{nTitle = "B¹n ®· giÕt ®­îc NhÝm, cã thÓ ®i D­¬ng Ch©u t×m Giang NhÊt Tiªu.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{20,30}},{1012,{20}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 204*8, nY = 192*16},
			{nTitle = "Ta cã quen L¹c Thanh Thu th­ sinh, y tõng lµ nhµ b×nh kiÕm næi tiÕng. ChØ v× mét lÇn ngoµi ý muèn ®· phÕ c¸nh tay, ng­¬i h·y ®Õn t×m «ng.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1694, nY = 3129},
			{nTitle = "GÆp con b¹c ë gÇn sßng b¹c. Gióp L¹c Thanh Thu gi¶i quyÕt kho¶n nî",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1744, nY = 3151},
			{nTitle = "§­îc! Ra ngoµi thµnh lÊy m¹ng Lé Tr­êng Thiªn, mãn nî cña hä L¹c kh«ng ph¶i tr¶.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{80}}}, nItemCheck = {}, nFightState = 1, nW = 80, nX = 1999, nY = 2882},
			{nTitle = "Lé Tr­êng Thiªn ®· bÞ b¹n khuÊt phôc, nhiÖm vô hoµn thµnh, b¹n cã thÓ vÒ t×m con b¹c.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{90,100}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1744, nY = 3151},
			{nTitle = "Mãn nî cña L¹c Thanh Thu ®· ®­îc xo¸. H·y quay vÒ gÆp L¹c Thanh Thu",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{110,120}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1694, nY = 3129},
			{nTitle = "H·y ra ngoµi thµnh ®o¹t lÊy b¶o kiÕm cña (Nh©n vËt Vâ l©m)",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{130}}}, nItemCheck = {}, nFightState = 1, nW = 80, nX = 1396, nY = 3397},
			{nTitle = "B¹n ®· lÊy ®­îc B¶o kiÕm, cã thÓ quay vÒ giao cho L¹c Thanh Thu.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{140}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1694, nY = 3129},
			{nTitle = "Quay l¹i gÆp LiÔu Nam V©n nhËn phÇn th­ëng.",nName = "Trung LËp CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1054,{1000}},{197,{0}}}, nItemCheck = {}, nFightState = 0, nW = 176, nX = 1368, nY = 3050},
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
			{nTitle = "GÆp Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{0,10}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Th¸c B¹t Hoµi Xuyªn b¶o b¹n ®i §­êng M«n Thµnh §« ®¸nh 50 con H¾c DiÖp HÇu.",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{20}},{1013,{10}}}, nItemCheck = {}, nFightState = 1, nW = 25, nX = 3952, nY = 5284},
			{nTitle = "§· ®¸nh b¹i 50 con H¾c DiÖp HÇu. Quay vÒ b¸o cho Th¸c B¹t Hoµi Xuyªn",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{20}},{1013,{20}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Th¸c B¹t Hoµi Xuyªn b¶o b¹n ®Õn Thµnh §« t×m gÆp Tr©u Tr­êng Cöu",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{40,50}}}, nItemCheck = {}, nFightState = 0, nW = 11, nX = 3139, nY = 5086},
			{nTitle = "NÕu cã thÓ tho¸t th©n ®­îc, cÇm nh÷ng quyÓn mËt tÞch nµy ®i D­¬ng Ch©u t×m ThÈm Phong. Nh×n thÊy vËt nµy, h¾n tù nhiªn sÏ hiÓu.",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{60,70}}}, nItemCheck = {}, nFightState = 0, nW = 80, nX = 1684, nY = 3078},
			{nTitle = "§¸nh b¹i Vâ SÜ gi¶ d¹ng ThÈm Phong",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{80}}}, nItemCheck = {}, nFightState = 1, nW = 80, nX = 1787, nY = 3378},
			{nTitle = "B¹n ®· h¹ gôc tªn Vâ sÜ gi¶ d¹ng ThÈm Phong. NhiÖm vô hoµn thµnh. Cã thÓ trë vÒ t×m Th¸c B¹t Hoµi Xuyªn!",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{90,100}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
			{nTitle = "Cã thÓ gÆp Th¸c B¹t Hoµi Xuyªn nhËn phÇn th­ëng",nName = "Tµ Ph¸i CÊp 20-29",nLevelMin = 20, nLevelMax = 29, nTaskCheck = {{1058,{1000}},{198,{0}}}, nItemCheck = {}, nFightState = 0, nW = 37, nX = 1677, nY = 3040},
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
function helpgoldquest()
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
	--tinsert(tbOpt, {"Rs Chuçi NVHK. Lµm l¹i tõ ®Çu.", GQ_RS});
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
		if GetLevel() >= LevelMin and GetLevel() <= LevelMax then
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
