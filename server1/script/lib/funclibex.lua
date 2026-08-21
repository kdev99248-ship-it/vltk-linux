G_PlayerDailogData = {}
function SayEx(nDesc,tbOpt,nSelectPerPage,nPage)
--C¸ch dïng
--local LoiThoai = ""
--local tb = {}
--tinsert(tb,{"Dßng lùa chän",Func,{Value1,Value2}})
--SayEx(LoiThoai,tb) --KhuyÕn c¸o lµ 10 lùa chän cho 1 Page lµ tèi ®a, nhiÒu qu¸ sau khi thªm 2 dßng "Trang tr­íc" vµ "Trang KÕ" sÏ kh«ng hiÓn thÞ hÕt
--Kh«ng cÇn thªm dßng "KÕt thóc ®èi tho¹i" v× nã sÏ tù thªm
    if nDesc == "" or nDesc == nil then nDesc = " " end
    local nTotalSelect = getn(tbOpt)
    if nPage == nil then nPage = 1 end
    if nSelectPerPage == nil then nSelectPerPage = 10 end
    local nStart = (nPage - 1) * nSelectPerPage + 1
    local nEnd = nStart + nSelectPerPage - 1
    if nStart > nTotalSelect then
        return
    end
    if nEnd > nTotalSelect then
        nEnd = nTotalSelect
    end
    local tbSayOpt = {}
    for i=nStart, nEnd do
        tinsert(tbSayOpt,{tbOpt[i][1],tbOpt[i][2],tbOpt[i][3]})
    end
    if nStart > 1 then
        tinsert(tbSayOpt, {"Trang Tr­íc", SayEx, {nDesc,tbOpt,nSelectPerPage, nPage - 1}})
    end
    if nEnd < nTotalSelect then
        tinsert(tbSayOpt, {"Trang Sau ", SayEx, {nDesc,tbOpt,nSelectPerPage, nPage + 1}})
    end
    tinsert(tbSayOpt, {"KÕt thóc ®èi tho¹i"})
    G_PlayerDailogData[PlayerIndex] = tbSayOpt
    local tb = {}
    for i= 1, getn(tbSayOpt) do
        tinsert(tb, tbSayOpt[i][1].. format("/#g_DailogBack(%d)", i))
    end
    if type(nDesc) == "number" then
        Describe(nDesc, getn(tb), tb)
    else
        TaskSay("<dec>"..nDesc, tb)
    end
end
function g_DailogBack(nSelectId, nCount) --Hâ trî hµm SayEx
    local tbSayOpt = G_PlayerDailogData[PlayerIndex]
    G_PlayerDailogData[PlayerIndex] = nil
    
    if tbSayOpt and tbSayOpt[nSelectId] then
        local nParamCount = getn(tbSayOpt[nSelectId])
        if nParamCount == 1 then
            return
        elseif nParamCount == 2 then
            local pFun = tbSayOpt[nSelectId][2]
            pFun()
        elseif nParamCount == 3 then
            local pFun = tbSayOpt[nSelectId][2]
            local tbParam = tbSayOpt[nSelectId][3]
            
            call(pFun, tbParam)    
        end
    end
end
function FindNpc(nName,nIDMap,nType)
--Hµm nµy sÏ t×m kiÕm 1 NPC nµo ®ã dùa theo tªn vµ ID map
--Sau khi t×m xong hµm sÏ tr¶ vÒ 3 gi¸ trÞ bao gåm 2 gi¸ trÞ to¹ ®é vµ 1 gi¸ trÞ ID cña Map. 2 gi¸ trÞ to¹ ®é vµ ID map nµy cã thÓ dïng ®Ó teleport ®Õn n¬i
--NÕu kh«ng t×m ®­îc th× sÏ tr¶ vÒ 3 gi¸ trÞ lµ 0,0,0
--nType: 1-HiÖn th«ng b¸o kh«ng t×m thÊy npc qua kªnh Msg2Player 0:Kh«ng hiÖn c¸i th«ng b¸o nµo c¶. MÆc ®Þnh lµ 0
    if nType == nil then nType = 0 end
    NpcIndex = GetMapNpcWithName(nIDMap,nName)
    if NpcIndex == nil or NpcIndex == nName then
        if nType == 1 then
            Msg2Player("<color=green>Kh«ng t×m thÊy NPC cã tªn <color=yellow>"..nName.."<color> t¹i b¶n ®å <color=yellow>"..SubWorldName(SubWorldID2Idx(nIDMap)).."<color>.<color>")
        end
        return 0,0,0
    end
    x, y,subworld = GetNpcPos(NpcIndex[1])
    m,n,k = floor(x/32),floor(y/32),SubWorldIdx2ID(subworld)
    return m,n,k
end 