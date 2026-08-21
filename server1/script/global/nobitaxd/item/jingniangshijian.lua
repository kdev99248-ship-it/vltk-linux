---------------------------------------------------------------------------------
--  NobitaXD
---------------------------------------------------------------------------------

function main()
	dofile("script/global/nobitaxd/item/jingniangshijian.lua");
	local szMsg = "<link=image[0,0]:\\spr\\item\\script\\jingniangshijian.spr><link> Sö dông cÈm nang sù kiÖn."
	local tbOpt = {}	
	tinsert(tbOpt, "Hñy bá /OnCancel")
	
	Describe(szMsg, getn(tbOpt), tbOpt);
end