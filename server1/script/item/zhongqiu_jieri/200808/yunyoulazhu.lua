--zhongchaolong
--ÔÆÓÎÀ¯Öò
--1¸öÐ¡Ê±Ö®ÄÚ´ò¹Ö»á»ñµÃ¾­Ñé·­±¶
--100%¸ÅÂÊÈÃ4ÖÖµÆÁý¡¾ ºûµûµÆÁý ¡¿£¬¡¾ Îå½ÇÐÇµÆÁý ¡¿£¬¡¾ Ô²µÆÁý ¡¿£¬¡¾ ³¤µÆÁý ¡¿Í¬Ê±³öÏÖ£¬´æÔÚÊ±¼äÎª5·ÖÖÓ¡£
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\event\\zhongqiu_jieri\\200808\\taskctrl.lua")
Include("\\script\\event\\zhongqiu_jieri\\200808\\lib\\common.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

local tbNpcList =
{
	{szName = "Lång ®Ìn b­¬m b­ím", nLevel = 1, nNpcId = 1215, nTime = 60*5, szScriptPath = "\\script\\event\\zhongqiu_jieri\\200808\\sanyue\\denglong.lua"},
	{szName = "Lång ®Ìn ng«i sao", nLevel = 1, nNpcId = 1216,nTime = 60*5, szScriptPath = "\\script\\event\\zhongqiu_jieri\\200808\\sanyue\\denglong.lua"},
	{szName = "Lång ®Ìn trßn", nLevel = 1, nNpcId = 1218, nTime = 60*5, szScriptPath = "\\script\\event\\zhongqiu_jieri\\200808\\sanyue\\denglong.lua"},
	{szName = "Lång ®Ìn èng", nLevel = 1, nNpcId = 1217, nTime = 60*5, szScriptPath = "\\script\\event\\zhongqiu_jieri\\200808\\sanyue\\denglong.lua"},
	
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
--		Say("±ØÐëÊÇ50¼¶ÒÔÉÏµÄ³äÖµÍæ¼Ò¡£", 0)
--		return 1
--	end
	AddSkillState(892, 1, 1, 18*60*60);
	
	
	local nMapId,nPosX,nPosY = GetWorldPos()
	zhongqiu0808_CallNpc(%tbNpcList[random(1,getn(%tbNpcList))], nMapId, (nPosX + random(-5,5))*32, (nPosY + random(-5,5))*32 )
	
	
end