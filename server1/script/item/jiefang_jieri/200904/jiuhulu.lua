-- ¾ÆºùÂ« by bel at 20090409 10£º04

Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\event\\jiefang_jieri\\200904\\taskctrl.lua");
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function main()
	local ndate = tonumber(GetLocalDate("%Y%m%d"));
	if (CFG_jiefang_jieri2009	== 0) then
		Msg2Player("VËt phÈm nµy ®· qu¸ h¹n.");
		return 0;
	end
	
	if (GetLevel() < 50 or GetExtPoint(0) < 1) then
		Say("§¹i hiÖp vÉn ch­a ®ñ cÊp 50 hoÆc vÉn ch­a nép thÎ, v× vËy kh«ng thÓ tham gia ho¹t ®éng", 0);
		return 1;
	end
	
	if CalcFreeItemCellCount() < 10 then
		Say(format("§Ó b¶o ®¶m an toµn tµi s¶n, xin mêi ®Ó trèng %d «.", 10), 0);
		return 1;
	end
	
	jf0904_InitTaskctrl();
	
	if (GetTask(jf0904_TSK_jiuexp) >= GetTask(jf0904_TSK_jiuexplt)) then
		Say("§· ®¹t ®Õn kinh nghiÖm cao nhÊt, kh«ng thÓ sö dông thªm BÇu R­îu.", 0);
		return 1;
	end
	
	local nAddedExp = 15;
	if (GetTask(jf0904_TSK_jiuexp) + nAddedExp > GetTask(jf0904_TSK_jiuexplt)) then
		nAddedExp = GetTask(jf0904_TSK_jiuexplt) - GetTask(jf0904_TSK_jiuexp);
	end	
	
	AddOwnExp(nAddedExp * 100000);
	SetTask(jf0904_TSK_jiuexp, GetTask(jf0904_TSK_jiuexp) + nAddedExp);
end
