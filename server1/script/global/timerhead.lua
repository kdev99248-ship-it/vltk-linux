-- script viet hoa By http://tranhba.com  TimerHead.lua 
-- script viet hoa By http://tranhba.com  By: Dan_Deng(2003-08-23) tİnh giê khİ t­¬ng quan c«ng cô 

FramePerSec = 18 -- script viet hoa By http://tranhba.com  mçi gi©y tr¸nh ®Õm lµm thµnh th­êng l­îng xö lı 
CTime = 600 -- script viet hoa By http://tranhba.com  mçi canh giê theo nh­ 600 gi©y #10 phót # tİnh to¸n 

function GetRestSec(i) -- script viet hoa By http://tranhba.com  trùc tiÕp trë vÒ tİnh giê khİ cßn thõa l¹i gi©y ®Õm 
return floor(GetRestTime(i) / FramePerSec) 
end; 

function GetRestCTime(i) -- script viet hoa By http://tranhba.com  lÊy ®­îc tİnh giê khİ cßn thõa l¹i thêi gian , lín h¬n mét canh giê lóc theo nh­ Trung quèc thêi gian chuyÓn ®æi 
x = floor(GetRestTime(i) / FramePerSec) 
if (x < CTime) then -- script viet hoa By http://tranhba.com  ch­a ®ñ mét canh giê 
y = x.." gi©y " 
else 
y = floor(x / CTime).." c¸ canh giê " 
end 
return y 
end; 

function GetTimerTask(i) -- script viet hoa By http://tranhba.com  th«ng qua tİnh giê khİ ID sè gi¶i tİch t­¬ng øng nhiÖm vô 

end
