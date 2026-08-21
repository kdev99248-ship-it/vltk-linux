IncludeLib("TASKSYS")
Include("\\script\\global\\signet_head.lua")
Include("\\script\\missions\\basemission\\lib.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
IncludeLib("LEAGUE")
Include("\\script\\lib\\droptemplet.lua")
Include("\\script\\lib\\objbuffer_head.lua")

local  _Message =  function (nItemIndex)
	local handle = OB_Create()
	local msg = format("ChÛc mıng cao thÒ <color=green>%s<color> Æ∏nh rÌt <color=orange>%s<color> tı <color=yellow> Boss Ti”u Hoµng Kim<color>" ,GetName(),GetItemName(nItemIndex))
	ObjBuffer:PushObject(handle, msg)
	RemoteExecute("\\script\\event\\msg2allworld.lua", "broadcast", handle)
	OB_Release(handle)
end

KILLBOSSEXPAWARD = 1000000
KILLBOSSNEAREXPAWARD = 500000

local tbVnNewItemDropAward = 
{
	{{szName="Phi tËc hoµn l‘ bao",tbProp={6,1,2520,1,0,0},nCount=1,nRate=60},},
	{{szName="ßπi l˘c hoµn l‘ bao",tbProp={6,1,2517,1,0,0},nCount=1,nRate=60},},
	{{szName="Tˆ ThÒy Tinh",tbProp={4,239,1,1,0,0},nCount=1,nRate=10},},
	{{szName="Lam ThÒy Tinh",tbProp={4,238,1,1,0,0},nCount=1,nRate=10},},
	{{szName="LÙc ThÒy Tinh",tbProp={4,240,1,1,0,0},nCount=1,nRate=10},},
	{{szName="Tinh HÂng B∂o Thπch",tbProp={4,353,1,1,0,0},nCount=1,nRate=10},},
	{{szName="Ti™n Th∂o LÈ Æ∆c bi÷t",tbProp={6,1,1181,1,0,0},nCount=1,nRate=10},},

	{{szName = "M∑nh ßﬁnh QuËc",tbProp = {4,random(927,932),1,1,0,0},nCount = 1,						nRate = 1,nQuality = 1, },},
	{{szName = "M∑nh ßﬁnh QuËc",tbProp = {4,random(783,788),1,1,0,0},nCount = 1,						nRate = 1,nQuality = 1, },},
	{{szName = "M∑nh ßﬁnh QuËc",tbProp = {4,random(931,936),1,1,0,0},nCount = 1,						nRate = 1,nQuality = 1, },},
	{{szName = "M∑nh ßﬁnh QuËc",tbProp = {4,random(935,940),1,1,0,0},nCount = 1,						nRate = 1,nQuality = 1, },},
	{{szName = "M∑nh ßﬁnh QuËc",tbProp = {4,random(939,944),1,1,0,0},nCount = 1,						nRate = 1,nQuality = 1, },},
	{{szName = "M∑nh An Bang",tbProp = {4,random(747,752),1,1,0,0},nCount = 1,						nRate = 0.5,nQuality = 1, },},
	{{szName = "M∑nh An Bang",tbProp = {4,random(753,758),1,1,0,0},nCount = 1,						nRate = 0.5,nQuality = 1, },},
	{{szName = "M∑nh An Bang",tbProp = {4,random(759,764),1,1,0,0},nCount = 1,						nRate = 0.5,nQuality = 1, },},
	{{szName = "M∑nh An Bang",tbProp = {4,random(765,770),1,1,0,0},nCount = 1,						nRate = 0.5,nQuality = 1, },},

	{{szName = "Hi÷p CËt Thi’t Huy’t Sam",tbProp = {0,186},nCount = 1, 					nRate = 0.5,nQuality = 1, },},
	{{szName = "Hi÷p CËt ßa T◊nh Hoµn",tbProp = {0,187},nCount = 1, 					nRate = 0.5,nQuality = 1, },},
	{{szName = "Hi÷p CËt ßan T©m GiÌi",tbProp = {0,188},nCount = 1, 					nRate = 0.5,nQuality = 1, },},
	{{szName = "Hi÷p CËt T◊nh ˝ K’t",tbProp = {0,189},nCount = 1, 						nRate = 0.25,nQuality = 1, },},
	{{szName = "Nhu T◊nh C©n QuËc Ngh÷ Th≠Íng",tbProp = {0,190},nCount = 1,					nRate = 0.25,nQuality = 1, },},
	{{szName = "Nhu T◊nh ThÙc N˜ Hπng Li™n",tbProp = {0,191},nCount = 1, 					nRate = 0.5,nQuality = 1, },},
	{{szName = "Nhu T◊nh PhÙng Nghi Gi Ìi Chÿ",tbProp = {0,192},nCount = 1, 					nRate = 0.5,nQuality = 1, },},
	{{szName = "Nhu T◊nh Tu÷ T©m Ng‰c BÈi",tbProp = {0,193},nCount = 1, 					nRate = 0.25,nQuality = 1, },},


	{{szName = "Huy“n Thi’t Ki’m",tbProp = {0,0,0,10,random(0,4),25},tbParam = {10,10,10,10,10,10}, nCount=3,	nRate=50},},
	{{szName = "ßπi Phong ßao",tbProp = {0,0,1,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Kim C´ BÊng",tbProp = {0,0,2,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Ph∏ Thi™n K›ch",tbProp = {0,0,3,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Ph∏ Thi™n Chu˙",tbProp = {0,0,4,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "Th´n NhÀt Tr∂m",tbProp = {0,0,5,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "B∏ V≠¨ng Ti™u",tbProp = {0,1,0,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "To∏i Nguy÷t ßao",tbProp = {0,1,1,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
	{{szName = "KhÊng T≠Ìc Linh",tbProp = {0,1,2,10,random(0,4),25},tbParam = {10,10,10,10,10,10},nCount=3,		nRate=50},},
}
local tbVnNewItemDropAwardMP = 
{	
	[1]=		-- Thi™n V≠¨ng
	{
		{szName="ßÂ phÊ Hoµng Kim - H∏m Thi™n Kim Hoµn ßπi Nh∑n Th«n ChÔy",tbProp={6,1,254,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - H∏m Thi™n VÚ Th«n T≠¨ng Kim Gi∏p",tbProp={6,1,255,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - H∏m Thi™n Uy VÚ ThÛc Y™u ß∏i",tbProp={6,1,255,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - H∏m Thi™n HÊ ß«u Kh»n ThÛc Uy”n",tbProp={6,1,257,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - H∏m Thi™n Thıa Long Chi’n Ngoa",tbProp={6,1,258,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - K’ Nghi÷p B´n L´i Toµn Long Th≠¨ng",tbProp={6,1,259,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - K’ Nghi÷p Huy“n VÚ Hoµng Kim Kh∂i",tbProp={6,1,260,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - K’ Nghi÷p Bπch HÊ V´ Song Kh u",tbProp={6,1,261,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - K’ Nghi÷p H·a V©n K˙ L©n thÒ ",tbProp={6,1,262,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - K’ Nghi÷p Chu T≠Ìc L®ng V©n Ngoa",tbProp={6,1,263,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ng˘ Long L≠Óng Ng©n B∂o ßao",tbProp={6,1,264,1,0,0},nCount=1,nRate=5},	
		{szName="ßÂ phÊ hoµng kim - Ng˘ Long Chi’n Th«n Qua TrÙy",tbProp={6,1,265,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ng˘ Long Thi™n M´n ThÛc Y™u Hoµn",tbProp={6,1,266,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ng˘ Long T n Phong Ph∏t C¨",tbProp={6,1,267,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ng˘ Long Tuy÷t M÷nh Chÿ Hoµn",tbProp={6,1,268,1,0,0},nCount=1,nRate=8},
	},
	[2]=		--Thi’u l©m
	{
		{szName="ßÂ phÊ Hoµng Kim - MÈng Long Ch›nh Hoµng T®ng M∑o",tbProp={6,1,239,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - MÈng Long Kim Ti Ch›nh HÂng Cµ Sa",tbProp={6,1,240,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - MÈng Long Huy“n Ti Ph∏p ß∏i ",tbProp={6,1,241,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - MÈng Long PhÀt Ph∏p Huy“n BÈi ",tbProp={6,1,242,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - MÈng Long Tˆ Kim B∏t Nh∑ GiÌi ",tbProp={6,1,243,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - PhÙc Ma Tˆ Kim C´n ",tbProp={6,1,244,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - PhÙc Ma V´ L≠Óng Kim Cang Uy”n ",tbProp={6,1,245,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - PhÙc Ma § Kim Nhuy‘n ßi“u",tbProp={6,1,246,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - PhÙc Ma PhÀt T©m Nhuy‘n Kh u",tbProp={6,1,247,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - PhÙc Ma PhÊ ßÈ T®ng Hµi",tbProp={6,1,248,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - T¯ Kh´ng Gi∏ng Ma GiÌi ßao ",tbProp={6,1,249,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - T¯ Kh´ng ßπt Ma T®ng Hµi ",tbProp={6,1,250,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - T¯ Kh´ng HÈ Ph∏p Y™u ß∏i ",tbProp={6,1,251,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - T¯ Kh´ng Nhuy‘n B◊ HÈ Uy”n ",tbProp={6,1,252,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - T¯ Kh´ng GiÌi LuÀt Ph∏p GiÌi ",tbProp={6,1,253,1,0,0},nCount=1,nRate=8},
	},


	[3]=		-- ß≠Íng M´n
	{
		{szName="ßÂ phÊ Hoµng Kim - B®ng Hµn ß¨n Chÿ Phi ßao",tbProp={6,1,309,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - B®ng Hµn Huy“n Y ThÛc Gi∏p",tbProp={6,1,310,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - B®ng Hµn T©m Ti‘n Y™u Kh u",tbProp={6,1,311,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - B®ng Hµn Huy“n Thi™n B®ng H·a BÈi",tbProp={6,1,312,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - B®ng Hµn Nguy÷t ∂nh Ngoa",tbProp={6,1,313,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Thi™n Quang Hoa VÚ Mπn Thi™n",tbProp={6,1,314,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - Thi™n Quang ßﬁnh T©m Ng≠ng Th«n phÔ ",tbProp={6,1,315,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Thi™n Quang S©m La ThÛc Y™u",tbProp={6,1,316,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Thi™n Quang ßﬁa Hµnh Thi™n L˝ Ngoa",tbProp={6,1,317,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Thi™n Quang ThÛc Thi™n Ph≠Óc ßﬁa Hoµn",tbProp={6,1,318,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S©m Hoang Phi Tinh ßoπt HÂn",tbProp={6,1,319,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - S©m Hoang Kim Ti“n Li™n Hoµn Gi∏p",tbProp={6,1,320,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S©m Hoang HÂn Gi∂o Y™u ThÛc",tbProp={6,1,321,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S©m Hoang Huy“n Thi’t T≠¨ng Ng‰c BÈi",tbProp={6,1,322,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S©m Hoang Tinh V…n Phi L˝ ",tbProp={6,1,323,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁa Ph∏ch NgÚ Hµnh Li™n Hoµn Qu∏n",tbProp={6,1,324,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁa Ph∏ch Hæc Di÷m Xung Thi™n Li™n",tbProp={6,1,325,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁa Ph∏ch T›ch Lﬁch L´i H·a GiÌi",tbProp={6,1,326,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁa Ph∏ch Kh u T©m Trπc",tbProp={6,1,327,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁa Ph∏ch Phong Hµn ThÛc Y™u",tbProp={6,1,328,1,0,0},nCount=1,nRate=8},
		
	},
	[4]=		-- NgÚ ßÈc
	{
		{szName="ßÂ phÊ Hoµng Kim - U Lung Kim Xµ Ph∏t ß∏i",tbProp={6,1,294,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - U Lung X›ch Hi’t MÀt Trang",tbProp={6,1,295,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - U Lung Thanh Ng´ Tri“n Y™u",tbProp={6,1,296,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - U Lung Ng©n Thi“m HÈ Uy”n",tbProp={6,1,297,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - U Lung M∆c ThÔ Nhuy‘n L˝ ",tbProp={6,1,298,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Minh ∂o Tµ S∏t ßÈc NhÀn",tbProp={6,1,299,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Minh ∂o U CÊ ∏m Y",tbProp={6,1,300,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Minh ∂o Thanh Hi’t Chÿ Hoµn",tbProp={6,1,301,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Minh ∂o HÒ CËt HÈ Uy”n",tbProp={6,1,302,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Minh Hoan Song Hoµn Xµ Kh u",tbProp={6,1,303,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ChÛ Ph≠Óc Ph∏ Gi∏p ß«u Hoµn",tbProp={6,1,304,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ChÛ Ph≠Óc Di÷t L´i C∂nh PhÔ ",tbProp={6,1,305,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ChÛ Ph≠Óc U ∂o Chÿ Hoµn",tbProp={6,1,306,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ChÛ Ph≠Óc Xuy™n T©m ßÈc Uy”n",tbProp={6,1,307,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ChÛ Ph‰c Th˘c CËt Ng‰c BÈi",tbProp={6,1,308,1,0,0},nCount=1,nRate=8},
	},
	[5]=		-- Nga Mi
	{
		{szName="ßÂ phÊ Hoµng Kim - V´ Gian ˚ Thi™n Ki’m",tbProp={6,1,269,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - V´ gian Thanh phong nhuy‘n l˜",tbProp={6,1,270,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Gian Ph t V©n Ti ß∏i",tbProp={6,1,271,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Gian C«m VÀn HÈ Uy”n",tbProp={6,1,272,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Gian Bπch Ng‰c Bµn Chÿ ",tbProp={6,1,273,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Ma Ma Ni Qu∏n",tbProp={6,1,274,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ ma thu thÒy l≠u quang Æai",tbProp={6,1,275,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Ma B®ng Tinh Chÿ Hoµn",tbProp={6,1,276,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Ma T»y T≠Óng Ng‰c Kh u",tbProp={6,1,277,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Ma HÂng Truy Nhuy‘n Th∏p Hµi ",tbProp={6,1,278,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - V´ Tr«n Ng‰c N˜ TË T©m Qu∏n",tbProp={6,1,279,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Tr«n Thanh T©m H≠Ìng Thi÷n Ch©u",tbProp={6,1,280,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Tr«n Tı Bi Ng‰c Bµn Chÿ ",tbProp={6,1,281,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - V´ Tr«n Tﬁnh ∂nh L≠u T´",tbProp={6,1,282,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ hoµng kim - V´ Tr«n PhÀt Quang Chÿ Hoµn",tbProp={6,1,283,1,0,0},nCount=1,nRate=8},
	},
	[6]=		-- ThÛy Y™n
	{
		{szName="ßÂ phÊ Hoµng Kim - T™ Hoµng PhÙng Nghi ßao",tbProp={6,1,284,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - Th™ Hoµng Hu÷ T©m Tr≠Íng Sinh Kh u",tbProp={6,1,285,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - T™ Hoµng Phong Tuy’t Bπch V©n ThÛc ß∏i",tbProp={6,1,286,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - T™ Hoµng B®ng Tung C»m Uy”n",tbProp={6,1,287,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - T™ Hoµng ThÛy Ng‰c Chÿ Hoµn",tbProp={6,1,288,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - B›ch H∂i Uy™n ¶¨ng Li™n Hoµn Æao",tbProp={6,1,289,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - B›ch H∂i Hoµn Ch©u Tuy™n Thanh C©n",tbProp={6,1,290,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - B›ch H∂i HÂng Linh Kim Ti ß∏i",tbProp={6,1,291,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - B›ch H∂i HÂng L®ng Ba",tbProp={6,1,292,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - B›ch H∂i Khi™n T’ Chÿ Hoµn",tbProp={6,1,293,1,0,0},nCount=1,nRate=8},
	},
	[7]=		-- C∏i Bang
	{
		{szName="ßÂ phÊ Hoµng Kim - ßﬁch Kh∏i LÙc Ng‰c Tr≠Óng",tbProp={6,1,329,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁch Kh∏i Cˆu ßπi C∏i Y",tbProp={6,1,330,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁch Kh∏i Tri“n M∑ng Y™u ß∏i",tbProp={6,1,331,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁch Kh∏i C»u T›ch B◊ HÈ Uy”n",tbProp={6,1,332,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßﬁch Kh∏i Th∂o Gian Thπch GiÌi",tbProp={6,1,333,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßÂng Cıu Ng˘ Long Ng‰c BÈi",tbProp={6,1,334,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßÂng Cıu Gi∏ng Long C∏i Y",tbProp={6,1,335,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßÂng Cıu Ti“m Long Y™u ß∏i",tbProp={6,1,336,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - ßÂng Cıu Kh∏ng Long HÈ Uy”n",tbProp={6,1,337,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - ßÂng Cıu Ki’n Long Ban Chÿ",tbProp={6,1,338,1,0,0},nCount=1,nRate=8},
	},
	[8]=		-- Thi™n Nh…n
	{
		{szName="ßÂ phÊ Hoµng Kim - Ma S∏t Qu˚ CËc U Minh Th≠¨ng",tbProp={6,1,339,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - Ma S∏t Tµn D≠¨ng ∏nh Huy’t Gi∏p",tbProp={6,1,340,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma S∏t X›ch K˝ T·a Y™u Kh u",tbProp={6,1,341,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma S∏t Cˆ H·a Li™u Thi™n Hoµn",tbProp={6,1,342,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma S∏t V©n Long ThÊ Ch©u GiÌi",tbProp={6,1,343,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Thﬁ Li÷t Di÷m Qu∏n Mi÷n",tbProp={6,1,344,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Thﬁ L÷ Ma Ph÷ T©m ß∏i",tbProp={6,1,345,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Thﬁ Nghi÷p H·a U Minh GiÌi",tbProp={6,1,346,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Thﬁ Huy’t Ng‰c Th t S∏t BÈi",tbProp={6,1,347,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Thﬁ s¨n  H∂i Phi HÂng L˝ ",tbProp={6,1,348,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Hoµng Kim Gi∏p Kh´i",tbProp={6,1,349,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Hoµng ∏n Xu t HÊ Hπng Khuy™n",tbProp={6,1,350,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Hoµng Kh™ CËc ThÛc Y™u ß∏i",tbProp={6,1,351,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Hoµng Huy’t Y ThÛ Trπc",tbProp={6,1,352,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - Ma Hoµng Dung Kim ßoπn NhÀt GiÌi",tbProp={6,1,353,1,0,0},nCount=1,nRate=8},
	},
	[9]=		-- V‚ ßang
	{
		{szName="ßÂ phÊ hoµng kim - L®ng Nhπc Th∏i C˘c Ki’m",tbProp={6,1,354,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - L®ng Nhπc V´ Ng∑ ThÛc ß∏i",tbProp={6,1,355,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ hoµng kim - L®ng Nhπc NÈ L´i Ph∏p GiÌi",tbProp={6,1,356,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - L®ng Nhπc V´ C˘c Huy“n Ng‰c BÈi",tbProp={6,1,357,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - L®ng Nhπc Thi™n ßﬁa Huy“n Hoµng giÌi",tbProp={6,1,358,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - CÀp Phong Ch©n VÚ Ki’m",tbProp={6,1,359,1,0,0},nCount=1,nRate=5},
		{szName="ßÂ phÊ Hoµng Kim - CÀp Phong Tam Thanh PhÔ ",tbProp={6,1,360,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - CÀp Phong Huy“n Ti Tam ßoπn C»m",tbProp={6,1,361,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - CÀp Phong ThÛy NG‰c Huy“n Hoµng Uy”n",tbProp={6,1,362,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - CÀp Phong Thanh TÔng Ph∏p GiÌi",tbProp={6,1,363,1,0,0},nCount=1,nRate=8},
	},
	[10]=		-- C´n L´n
	{		
		{szName="ßÂ phÊ Hoµng Kim - S≠¨ng Tinh Thi™n Ni™n Hµn Thi’t",tbProp={6,1,364,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S≠¨ng Tinh L≠u Tinh C∂n Nguy÷t Kh u",tbProp={6,1,365,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S≠¨ng Tinh Thanh Phong LÚ ß∏i",tbProp={6,1,366,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S≠¨ng Tinh Thi™n Thanh B®ng Tinh ThÒ ",tbProp={6,1,367,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - S≠¨ng Tinh Phong Bπo Chÿ Hoµn",tbProp={6,1,368,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - L´i Khung Hµn TÔng B®ng B∏ch Quan",tbProp={6,1,369,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - L´i Khung Thi™n ßﬁa HÈ PhÔ ",tbProp={6,1,370,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - L´i Khung Phong L´i Thanh C»m ß∏i",tbProp={6,1,371,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - L´i Khung Linh Ng‰c §n L´i",tbProp={6,1,372,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - L´i Khung Cˆu Thi™n D…n L´i GiÌi",tbProp={6,1,373,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - VÙ ∂o Bæc Minh ßπo Qu∏n",tbProp={6,1,374,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - VÙ Hoan Th∏i Uy™n ch©n VÚ Li™n",tbProp={6,1,375,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - VÙ ∂o ThÛc T©m Chÿ Hoµn",tbProp={6,1,376,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - VÙ ∂o Thanh ∂nh Huy“n Ng‰c BÈi",tbProp={6,1,377,1,0,0},nCount=1,nRate=8},
		{szName="ßÂ phÊ Hoµng Kim - VÙ ∂o Tung Phong Tuy’t ∂nh ngoa",tbProp={6,1,378,1,0,0},nCount=1,nRate=8},
	},
}

function OnDeath( nNpcIndex )
	local x, y, world = GetNpcPos(nNpcIndex);
	local nNpcID = GetNpcParam(nNpcIndex,1);
	tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex,%tbVnNewItemDropAward,format("killed_%s",GetNpcName(nNpcIndex)))
	if 	nNpcID== 1356   	then STTID= 1
		elseif nNpcID== 1355 	then STTID= 2 
		elseif nNpcID== 523 	then STTID= 3 
		elseif nNpcID== 1358   	then STTID= 4
		elseif nNpcID== 513   	then STTID= 5 
		elseif nNpcID== 1360   	then STTID= 6 
		elseif nNpcID== 1361   	then STTID= 7 
		elseif nNpcID== 1362	then STTID= 8
		elseif nNpcID== 511 		then STTID= 9
		elseif nNpcID== 1364   	then STTID= 10 
	end
	local ListItem=%tbVnNewItemDropAwardMP[STTID];
	tbDropTemplet:GiveAwardByList(nNpcIndex, PlayerIndex,ListItem,format("killed_%s",GetNpcName(nNpcIndex)))	

	local nTeamSize = GetTeamSize();
	local szName;
	
	if (nTeamSize > 1) then
		for i=1,nTeamSize do
			if(doFunByPlayer(GetTeamMember(i), IsCaptain)==1)then
				szName = doFunByPlayer(GetTeamMember(i), GetName);
			end
			doFunByPlayer(GetTeamMember(i), PlayerFunLib.AddExp, PlayerFunLib, KILLBOSSEXPAWARD, 0, format("%s ph«n th≠Îng","Kinh nghi÷m Æ∂ bπi BOSS hoµng kim"));
		end
	else -- “ª∏ˆ»À
		szName = GetName();
		PlayerFunLib:AddExp(KILLBOSSEXPAWARD, 0, format("%s ph«n th≠Îng","Kinh nghi÷m Æ∂ bπi BOSS hoµng kim"));
	end
	
	local tbRoundPlayer, nCount = GetNpcAroundPlayerList(nNpcIndex, 20);
	
	for i=1,nCount do
		doFunByPlayer(tbRoundPlayer[i], PlayerFunLib.AddExp, PlayerFunLib, KILLBOSSNEAREXPAWARD, 0, format("%s ph«n th≠Îng","Kinh nghi÷m Æ¯ng g«n lÛc BOSS hoµng kim bﬁ ti™u di÷t"));
	end
end;

function OnTimer(nNpcIndex,nTimeOut)
	DelNpc(nNpcIndex);
end