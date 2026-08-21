-- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com  
-- script viet hoa By http://tranhba.com  tiÒn trang chøc n¨ng ®Ých ®Çu v¨n kiÖn 

Include("\\script\\global\\systemconfig.lua") -- script viet hoa By http://tranhba.com  ÏµÍ³ÅäÖÃ

IncludeForRegionVer("\\script\\global\\", "gamebank_head.lua")

-- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com  

QUESTKEY_TICKET = 488; -- script viet hoa By http://tranhba.com  ng©n phiÕu ®Ých vËt phÈm ID 
EXTPOINT_TICKET = 2; -- script viet hoa By http://tranhba.com  ng©n phiÕu ®Ých ph¸t triÓn ®iÓm 
EXTPOINT_TICKET_NEW = 6; 
QUESTKEY_TICKET_NEW = 962 

EXTPOINT_MAXVAL = 32768; 
-- script viet hoa By http://tranhba.com  ph¸t triÓn ®iÓm ®Ých lín nhÊt trÞ gi¸ 
-- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com - 
-- script viet hoa By http://tranhba.com  sö dông ng©n phiÕu chøc n¨ng hµm sè ng©n phiÕu ph©n ng©n phiÕu cïng míi ng©n phiÕu hai lo¹i , vèn function thèng nhÊt xö lý 
-- script viet hoa By http://tranhba.com  ®­a vµo tham sæ , ticket ng©n phiÕu sè l­îng logstr thao t¸c miªu t¶ # sÏ nhí ngµy chÝ # 
-- script viet hoa By http://tranhba.com  trë vÒ trÞ gi¸ lµ -1 dÞ th­êng 0 ng©n phiÕu kh«ng ®ñ 1 ng©n phiÕu khÊu trõ thµnh c«ng 
-- script viet hoa By http://tranhba.com  nÕu nh­ ng©n phiÕu kh«ng ®ñ , sÏ kh«ng trõ ng©n phiÕu ®Ých 

function qz_use_silver( ticket , logstr) 
if (logstr == nil) then 
logstr = "[ kh«ng biÕt ]" 
end 

if (SYSCFG_GAMEBANK_TICKET_USE == nil) then -- script viet hoa By http://tranhba.com  sai lÇm ~~ 
print("use_ticket have close, but something is wrong..."); 
Msg2Player("Chøc n¨ng bÞ lçi #"); 
return -1 
end 

if (ticket < 1 or ticket == nil) then 
Msg2Player("Chøc n¨ng bÞ lçi ") 
return -1 
end 
local nCountOld = GetItemCountEx(488);-- script viet hoa By http://tranhba.com  cùu ng©n phiÕu 
local nCountNew = GetItemCountEx(962); 
	if (nCountOld + nCountNew < ticket) then
return 0; 
end 

local nDelCountOld = ticket; 
local nDelCountNew = 0; 
if (nCountOld < ticket) then 
nDelCountOld = nCountOld; 
nDelCountNew = ticket - nCountOld; 
end; 
for i = 1, nDelCountOld do 
DelItemEx(488); 
end 
for i = 1, nDelCountNew do 
DelItemEx(962); 
end 
WriteGoldLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount().." , ["..GetName().."]# tèn hao "..ticket.." tÊm ng©n phiÕu "..logstr, 0, 0, 0, (-ticket)); 

if (nDelCountOld > 0) then 
UseSilver(2, 2, nDelCountOld); -- script viet hoa By http://tranhba.com  ng©n phiÕu ®æi v× ®ång tiÒn ®Ých tiªu hao thèng kª ( trùc tiÕp tiªu hao nguyªn b¶o ng©n phiÕu , cïng ®ång tiÒn ®æi chê cïng xö lý ) 
end; 
if (nDelCountNew > 0) then 
UseSilver(3, 2, nDelCountNew); -- script viet hoa By http://tranhba.com  ng©n phiÕu ®æi v× ®ång tiÒn ®Ých tiªu hao thèng kª ( trùc tiÕp tiªu hao nguyªn b¶o ng©n phiÕu , cïng ®ång tiÒn ®æi chê cïng xö lý ) 
end; 
SaveNow(); -- script viet hoa By http://tranhba.com  lËp tøc tån m©m 
return 1; 
end 

function buy_hunyuanlinglu() 
local szMsg = 
{ 
" tiÒn Cöu gia # gÇn nhÊt tõ kinh thµnh vµo mét nhãm hçn nguyªn linh lé # ë trong chøa 100 tinh luyÖn th¹ch # , cã thÓ ®Ó cho ng­¬i ë ®©y du lÞch giang hå lóc luyÖn chÕ tèt h¬n trang bÞ , cßn cã thÓ v× ®æi lÊy c¸c lo¹i vËt phÈm . toµn Trung Nguyªn chØ nµy mét nhµ , tuyÖt kh«ng ph©n hµo . cã muèn nh×n mét chót hay kh«ng ? ", -- script viet hoa By http://tranhba.com 1 
"1 ®ång tiÒn mua hçn nguyªn linh lé /#buy_addhunyuan_yes(1)", -- script viet hoa By http://tranhba.com 2 
"5 ®ång tiÒn mua hçn nguyªn linh lé /#buy_addhunyuan_yes(5)", -- script viet hoa By http://tranhba.com 3 
"10 ®ång tiÒn mua hçn nguyªn linh lé /#buy_addhunyuan_yes(10)", -- script viet hoa By http://tranhba.com 4 
"50 ®ång tiÒn mua hçn nguyªn linh lé /#buy_addhunyuan_yes(50)", -- script viet hoa By http://tranhba.com 5 
"100 ®ång tiÒn mua hçn nguyªn linh lé /#buy_addhunyuan_yes(100)", -- script viet hoa By http://tranhba.com 6 
" ta kh«ng cã høng thó /no", -- script viet hoa By http://tranhba.com 7 
}; 

Say(szMsg[1], 6, szMsg[2], szMsg[3], szMsg[4], szMsg[5], szMsg[6], szMsg[7]); 

end 

function buy_addhunyuan_yes(nNedCount) 
if (nNedCount < 1 or nNedCount == nil) then 
print("Fail!!!!"); 
return 
end; 
if(CalcFreeItemCellCount() < 5) then 
Say("Tói ®eo l­ng chç trèng ch­a ®ñ , Ýt nhÊt cÇn 5 c¸ch chç trèng ", 0); 
return 
end 
local nCount = CalcEquiproomItemCount(4, 417, 1, 1) 

if (nCount < nNedCount) then 
Talk(1,"","Ngµi tiÒn trªn ng­êi kh«ng ®ñ , quyªn gãp ®ñ tiÒn trë l¹i ®i . ") 
return 1; 
end 
ConsumeEquiproomItem(nNedCount, 4, 417, 1, 1) 

WriteGoldLog(date("%Y-%m-%d %H:%M:%S").." "..GetAccount()..", ["..GetName()..format("]: tèn hao %d ®ång tiÒn , mua hçn nguyªn linh lé .",nNedCount),-2,0,0,0); 
for i=1,nNedCount do 
AddItem(6,1,2312,1,0,0,0) -- script viet hoa By http://tranhba.com -- script viet hoa By http://tranhba.com  hçn nguyªn linh lé 
end 

UseSilver(1, 2, nNedCount); -- script viet hoa By http://tranhba.com  kim nguyªn b¶o ®æi v× ®ång tiÒn ®Ých tiªu hao thèng kª ( trùc tiÕp tiªu hao nguyªn b¶o ng©n phiÕu , cïng ®ång tiÒn ®æi chê cïng xö lý ) 
SaveNow(); -- script viet hoa By http://tranhba.com  lËp tøc tån m©m 

Talk(1,"","Mua hçn nguyªn linh lé thµnh c«ng # xin/mêi kiÓm tra <color=yellow> tói ®eo l­ng <color>") 
Msg2Player("Mua hçn nguyªn linh lé thµnh c«ng # xin/mêi tra xÐt tói ®eo l­ng . ") 
end 
