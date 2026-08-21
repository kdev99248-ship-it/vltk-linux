-- ======================
-- haozhu_death.lua - gioi han 20 lan/ngay, tu reset theo ngay, khong can birthday0905
-- Lua 4.x: bien local dau file truy cap trong function qua upvalue %
-- ======================================================
Include("\\script\\task\\task_addplayerexp.lua");

local SHOULIE_TASKID   = 8500;	-- ®Õm sè lÇn s¨n
local SHOULIE_EXPID    = 8501;	-- céng dån exp
local SHOULIE_DAYID    = 8502;	-- l­u ngµy ®Ó reset
local MAX_COUNT        = 20;
local MAX_EXP_FROMHUNT = 30000;

local tbAwardItem = 
{
	{szName="Tiªn Th¶o Lé ", nRate=10, tbProp={6, 1, 71, 1, 0, 0}},
	{szName="B¸ch Qu¶ Lé ", nRate=10, tbProp={6, 1, 73, 1, 0, 0}},
	{szName="QuÕ Hoa Töu", nRate=10, tbProp={6, 1, 125, 1, 0, 0}},
};

local tbDropItem = {}
function tbDropItem:DropItemdByRate(tbItem, szLogTitle, nMapId, nPosX32, nPosY32, nSeries)
	if tbItem == nil then return 0 end
	local rtotal = 10000000
	local rcur=random(1,rtotal);
	local rstep=0;
	for i=1,getn(tbItem) do
		rstep=rstep+floor(tbItem[i].nRate*rtotal/100);
		if(rcur <= rstep) then
			return self:DropItemByList(tbItem[i], szLogTitle, nMapId, nPosX32, nPosY32, nSeries)
		end
	end
end
function tbDropItem:DropItemByList(tbItem, szLogTitle, nMapId, nPosX32, nPosY32, nSeries)
	if not tbItem then return 0 end
	if type(tbItem[1]) == "table" then
		if tbItem[1].nRate then
			return self:DropItemdByRate(tbItem, szLogTitle, nMapId, nPosX32, nPosY32, nSeries)
		else
			for i = 1, getn(tbItem) do
				self:DropItemByList(tbItem[i], szLogTitle, nMapId, nPosX32, nPosY32, nSeries)
			end	
			return 1;
		end
	end
	local tbItemProp	= tbItem.tbProp;
	local nItemCount	= tbItem.nCount or 1
	if tbItemProp then
		local nItemIndex	= 0;
		for i = 1, nItemCount do
			local nQuality = tbItem.nQuality or 0
			if nQuality == 0 then
				tbItemProp[4] = tbItemProp[4] or 1
				tbItemProp[5] = tbItemProp[5] or 0
				tbItemProp[6] = tbItemProp[6] or 0
			end
			nItemIndex = DropItemEx( SubWorldID2Idx(nMapId), nPosX32, nPosY32, -1,4, 0, nQuality, tbItemProp[1], tbItemProp[2], tbItemProp[3] or 0, tbItemProp[4] or 1, tbItemProp[5] or nSeries or 0, tbItemProp[6] or 0,0,0,0,0,0)
			if nItemIndex <= 0 then return 0 end
			if type(tbItem.CallBack) == "function" then
				tbItem.CallBack(nItemIndex)
			end
		end
	end
	return 1
end

function OnDeath( nNpcIndex )
	if (GetTeamSize() ~= 0) then
		return
	end

	-- Reset theo ngay: ghep yyyymmdd thanh 1 so
	local nToday = tonumber(GetLocalDate("%Y%m%d"));
	if (GetTask(%SHOULIE_DAYID) ~= nToday) then
		SetTask(%SHOULIE_DAYID, nToday);
		SetTask(%SHOULIE_TASKID, 0);
		SetTask(%SHOULIE_EXPID, 0);
	end

	local nCount = GetTask(%SHOULIE_TASKID);
	if (nCount >= %MAX_COUNT) then
		Msg2Player("H«m nay ®· s¨n b¾t 20 NhÝm bÐo ph× råi, ngµy mai h·y ®Õn l¹i nhÐ.");
		return
	end

	local x, y, nMapIndex = GetNpcPos(nNpcIndex);
	local nSeries = GetNpcSeries();

	%tbDropItem:DropItemByList(%tbAwardItem, "PangHaozhu_death", SubWorldIdx2ID(nMapIndex), x, y, nSeries);

	local nCurExp = GetTask(%SHOULIE_EXPID);
	if (nCurExp < %MAX_EXP_FROMHUNT) then
		tl_addPlayerExp(3000000);
		SetTask(%SHOULIE_EXPID, nCurExp + 3000);
	end

	Earn(10000)

	SetTask(%SHOULIE_TASKID, nCount + 1);
end

function OnTimer(nNpcIndex, nTimeOut)
	DelNpc(nNpcIndex)
end