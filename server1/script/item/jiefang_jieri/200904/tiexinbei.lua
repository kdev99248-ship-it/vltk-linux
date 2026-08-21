-- ÌùÐÄ±­ by bel at 20090409 10£º04

Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\event\\jiefang_jieri\\200904\\taskctrl.lua");
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function main()
	local ndate = tonumber(GetLocalDate("%Y%m%d"));
	if (CFG_jiefang_jieri2009	== 0) then
		Msg2Player("VËt phÈm nµy ®· qu¸ h¹n.");
		return 0;
	end
	
	jf0904_InitTaskctrl();
	
	SetTask(jf0904_TSK_jiuexplt, 30000);
end
