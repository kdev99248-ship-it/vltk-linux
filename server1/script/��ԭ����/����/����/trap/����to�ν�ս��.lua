--ÖĞÔ­ÄÏÇø ÏåÑôtoËÎ½ğÕ½³¡
--Trap ID£ºÖĞÔ­ÄÏÇø 49
Include("\\script\\battles\\battlehead.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")

function main(sel)
	if ( GetLevel() < 40 ) then
		Talk( 1, "", "ChiÕn tr­êng Tèng Kim gian khæ khèc liÖt, ng­¬i ch­a ®¹t ®Õn cÊp 40 h·y vÒ luyÖn thªm råi h·y tİnh." );
	elseif ( GetLevel() >= 40 and GetLevel() < CapDoTK1 ) then
		NewWorld( 323, 1541, 3178);
		SetFightState(0);
		Msg2Player( "§Õn n¬i b¸o danh ChiÕn Tr­êng Tèng Kim S¬ CÊp" );
	elseif ( GetLevel() >= CapDoTK1 and GetLevel() < CapDoTK2 ) then
		NewWorld( 324, 1541, 3178);
		SetFightState(0);
		Msg2Player( "§Õn n¬i b¸o danh ChiÕn Tr­êng Tèng Kim Trung CÊp" );
	else
		NewWorld( 325, 1541, 3178);
		SetFightState(0);
		Msg2Player( "§Õn n¬i b¸o danh ChiÕn Tr­êng Tèng Kim Cao CÊp" );
	end
SetProtectTime(18*3)
	AddSkillState(963, 1, 0, 18*3) 
end;