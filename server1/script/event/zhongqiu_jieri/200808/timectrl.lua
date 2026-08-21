--时间控制管理
--从2008年09月05日至2008年10月05日24点
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

zhongqiu0808_StartTime	= 080905
zhongqiu0808_EndTime	= 501005
zhongqiu0808_liheEndTime = 501005
zhongqiu0808_ItemEndTime = 501031
zhongqiu0808_ZhanGongStartTime = 080905
zhongqiu0808_ZhanGongEndTime = 501005

function zhongqiu0808_IsActDate()
	local nDate = tonumber(GetLocalDate("%y%m%d"))
	if (CFG_zhongqiu_jieri_2008	== 1) then
		return 1
	end
	return nil
end