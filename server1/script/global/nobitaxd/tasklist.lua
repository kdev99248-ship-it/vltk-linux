Include("\\script\\lib\\player.lua")
--Include("\\script\\updateconfig\\configlist.lua")

Master_TaskID = {
	[1] = {TaskCount = {5500}, TaskName = "Timer"},
	[2] = {TaskCount = {5501}, TaskName = "Timer_sp"},
	[3] = {TaskCount = {5502}, TaskName = "Né"},
	[4] = {TaskCount = {5503}, TaskName = "¢m"},
	[5] = {TaskCount = {5504}, TaskName = "Task exp"},
	[6] = {TaskCount = {5505}, TaskName = "Task cash"},

	-- Hé Tèng HuyÕt Th­ (VËn Tiªu)
	[7] = {TaskCount = {5506}, TaskName = "Task Thêi Gian Reset"},
	[8] = {TaskCount = {5507}, TaskName = "Task Giíi H¹n Sè LÇn"},
	[9] = {TaskCount = {5508}, TaskName = "Task NhiÖm Vô Hé Tèng"},
	[10] = {TaskCount = {5509}, TaskName = "Task ¸p Th­"},
	[11] = {TaskCount = {5510}, TaskName = "Task NhËn Th­"},
	[12] = {TaskCount = {5511}, TaskName = "Task Thêi Gian ¸p Tiªu"},
	[13] = {TaskCount = {5512}, TaskName = "Task Flag"},
	[14] = {TaskCount = {5513}, TaskName = "Task Tiªu Xa"},
	[15] = {TaskCount = {5514}, TaskName = "Task Thêi Gian Cßn L¹i"},
	[16] = {TaskCount = {5515}, TaskName = "Task Tiªu Xa death"},

	--NhiÖm Vô Th­¬ng Héi
	[17] = {TaskCount = {5516}, TaskName = "Task Reset NhiÖm Vô Mçi Ngµy"},
	[18] = {TaskCount = {5517}, TaskName = "Task Giíi H¹n Sè LÇn NhËn NhiÖm Vô"},
	[19] = {TaskCount = {5518}, TaskName = "Task Giíi H¹n Sè LÇn Hoµn Thµnh NhiÖm Vô"},
	[20] = {TaskCount = {5519}, TaskName = "Task NhËn Th­ëng Hµng Ngµy"},
	[21] = {TaskCount = {5520}, TaskName = "Task NhiÖm Vô Th­¬ng Héi"},
	[22] = {TaskCount = {5521}, TaskName = "Task Kill Qu¸i"},	
	[23] = {TaskCount = {5522}, TaskName = "NVTH.TSK_COUNTLIMIT"},	

	[24] = {TaskCount = {5523}, TaskName = "CÊm"},		
	[25] = {TaskCount = {5524}, TaskName = "V¹n VËt C©u PhÇn"},	
	[26] = {TaskCount = {5525}, TaskName = "Th¸nh Háa Liªu Nguyªn"},	
	[27] = {TaskCount = {5526}, TaskName = "Th©u Thiªn Ho¸n NhËt"},
	[28] = {TaskCount = {5527}, TaskName = "Timer cæ mé 12x"},
----- NhËn Th­ëng Mçi ngµy		
	[29] = {TaskCount = {5528}, TaskName = "NhËn Th­ëng Ngµy"},	
	[30] = {TaskCount = {5529}, TaskName = "NhËn Th­ëng Cuèi TuÇn"},
	[31] = {TaskCount = {5530}, TaskName = "Giíi H¹n"},
	--------------------tinh luc
	[32] = {TaskCount = {5531}, TaskName = "Giíi H¹n"},
	--------®Æt c­îc l«i dµi-----------------
	[33] = {TaskCount = {5532}, TaskName = "Task TiÒn Xu C«ng B×nh Tö"},
	[34] = {TaskCount = {5533}, TaskName = "Task TiÒn V¹n C«ng B×nh Tö"},
	[35] = {TaskCount = {5534}, TaskName = "Task Kim Nguyªn B¶o C«ng B×nh Tö"},
	[36] = {TaskCount = {5535}, TaskName = "XU CA CUOC"},
	[37] = {TaskCount = {5536}, TaskName = "Kü n¨ng sèng"},
	[38] = {TaskCount = {5537}, TaskName = "Kü n¨ng sèng"},
	[39] = {TaskCount = {5538}, TaskName = "Kü n¨ng sèng"},
	[40] = {TaskCount = {5539}, TaskName = "Kü n¨ng sèng"},
	[41] = {TaskCount = {5540}, TaskName = "Kü n¨ng sèng"},
	[42] = {TaskCount = {5541}, TaskName = "Kü n¨ng sèng"},
	[43] = {TaskCount = {5550}, TaskName = "PÐt"},
	[44] = {TaskCount = {5947}, TaskName = "N©ng cÊp ngùa"},
	[45] = {TaskCount = {5948}, TaskName = "N©ng cÊp ngùa"},
	[46] = {TaskCount = {5949}, TaskName = "N©ng cÊp ngùa"},
	[47] = {TaskCount = {5950}, TaskName = "N©ng cÊp ngùa"},
	[48] = {TaskCount = {5951}, TaskName = "N©ng cÊp ngùa"},
	[49] = {TaskCount = {5952}, TaskName = "N©ng cÊp ngùa"},
	[50] = {TaskCount = {5953}, TaskName = "N©ng cÊp ngùa"},
	[51] = {TaskCount = {5954}, TaskName = "TRONG CAY BAP"},
	[52] = {TaskCount = {5955}, TaskName = "TRONG  CAROT"},
	[53] = {TaskCount = {5956}, TaskName = "Tói M¸u T©n Thñ"},
	[54] = {TaskCount = {5960}, TaskName = "Max X× Gµ"},
	[55] = {TaskCount = {5961}, TaskName = "Giíi H¹n ngµy"},
	[56] = {TaskCount = {5962}, TaskName = "Tói M¸u T©n Thñ"},


}

function HN_GetTaskID(TaskID)
return callPlayerFunction(PlayerIndex, GetTask, Master_TaskID[TaskID].TaskCount[1])
end

function HN_SetTaskID(TaskID, Value)
return callPlayerFunction(PlayerIndex, SetTask, Master_TaskID[TaskID].TaskCount[1], Value)
end

--======================================================================================================================================================================================================--