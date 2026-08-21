IncludeLib("SETTING")
IncludeLib("FILESYS")
IncludeLib("TASKSYS")
 IncludeLib("LEAGUE")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\lib\\awardtemplet.lua")

function main(nItemIdx)
	if CalcFreeItemCellCount() < 10 then
		Say("H∑y c t bÌt vÀt ph»m Æ” Æ∂m b∂o c„ 10 ´ trËng rÂi h∑y nhÀn.",0);
		return 1;
	end
if (CountFreeRoomByWH(5,2,1) < 1) then
		Talk(1, "", "Kh´ng ÆÒ chÁ trËng, xin sˆa sang lπi hµnh trang 5x2 ´ trËng");
		return 1;
	end
	tbAwardTemplet:GiveAwardByList({{szName = "ti™n thÊ lÈ",tbProp={6,1,71,1,1},nCount=1,nExpiredTime=24*60*7,nBindState=-2,},}, "test", 1);
	tbAwardTemplet:GiveAwardByList({{szName = "Th«n Hµnh PhÔ",tbProp={6,1,1266,1,1},nCount=1,nExpiredTime=24*60*7,nBindState=-2,},}, "lebao_vlhx", 1);
	local szNews = format("ChÛc mıng Æπi hi÷p <color=green>"..GetName().."<color> Æ∑ nhÀn Æ≠Óc ph«n th≠Îng tı <color=wood> L‘ Bao V‚ L©m HÂi X≠a")
	AddGlobalNews(szNews);
	LG_ApplyDoScript(1, "", "", "\\script\\event\\msg2allworld.lua", "battle_msg2allworld", szNews , "", "");
end
