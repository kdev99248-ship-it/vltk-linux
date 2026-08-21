--zhongchaolong
--ÏÉÎèÀ¯Öò
--8¸öĞ¡Ê±Ö®ÄÚ´ò¹Ö»á»ñµÃ¾­Ñé·­±¶
--100%¸ÅÂÊÈÃ1¸ö¡¾×ßÂíµÆ¡¿Í¬Ê±³öÏÖ¡£×ßÂíµÆµÄ´æÔÚÊ±¼äÎª5·ÖÖÓ.
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\event\\zhongqiu_jieri\\200808\\taskctrl.lua")

Include("\\script\\event\\zhongqiu_jieri\\200808\\lib\\common.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

local tbNpcList =
{
	{szName = "§Ìn kĞo qu©n", nLevel = 1, nNpcId = 1220, nTime = 60*5, szScriptPath = "\\script\\event\\zhongqiu_jieri\\200808\\sanyue\\denglong.lua"},
	
}
function main()
	zhongqiu0808_ResetTask()
	local nDate = tonumber(GetLocalDate("%y%m%d"))
	if (CFG_zhongqiu_jieri_2008 == 0) then
		Say("VËt phÈm nµy ®· qu¸ h¹n.",0)
		return 0;
	end
--	if zhongqiu0808_PlayerLimit() ~= 1 then
--		
--		Say("±ØĞëÊÇ50¼¶ÒÔÉÏµÄ³äÖµÍæ¼Ò¡£", 0)
--		return 1
--	end
	AddSkillState(892, 1, 1, 18*60*60*8);
	local nMapId,nPosX,nPosY = GetWorldPos()
	zhongqiu0808_CallNpc(%tbNpcList[1], nMapId, (nPosX + random(-2,2))*32, (nPosY + random(-2,2))*32 )
end