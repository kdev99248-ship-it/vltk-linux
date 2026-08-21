-- ´óºì°ü¹¦ÄÜ		ºì°üÊ¹ÓÃ
-- By Spe(2004-01-01)

Include([[\script\event\ma_chunjie\head.lua]])

function main(nItemIdx)
	
	local nG, nD, nP = GetItemProp(nItemIdx);
	if (not TB_firecracker_ID[nP]) then
		return 1;
	end;
	dostring(TB_firecracker_ID[nP].."()");
end;

function GetDesc(nItemIdx)
	local szDesc = "\nThêi h¹n sö dông<color=blue>24 giê ngµy 20 th¸ng 1 n¨m 2005<color>"
	return szDesc;
end