------------------------
-- NobitaXD
-- 2023/08/20
------------------------
Include("\\script\\global\\nobitaxd\\npc\\npcsukien_quanly.lua")
Include("\\script\\global\\nobitaxd\\config\\cfg_server.lua")
Include([[\script\event\teachersday06_v\head.lua]]);
Include([[\script\event\zhongqiu2007\item\yuanliao.lua]]);
Include([[\script\event\yn_chunjie\head.lua]]);
Include([[\script\event\ma_chunjie\head.lua]]);

function IsPickable( nItemIndex, nPlayerIndex )
	if GetExtPoint(0) <= 0 then
		Msg2Player("ChØ cã ng­êi ch¬i ®· n¹p thÎ míi cã thÓ nhÆt ®­îc tói nguyªn liÖu.")
		return 0
	end
	return 1;
end
function PickUp( nItemIndex, nPlayerIndex )

	if (CFG_vm_birthplan	==	1) then
		AddItem(6,1,1099,1,0,0,0)	
	elseif (CFG_cookies2007	== 1) then	-- CFG_cookies2007		= 0	-- 10/3		03/2007			Done
		AddItem(6,1,1393,1,0,0,0)		--Tói hµng hãa	6	1	1393
	elseif (CFG_mid_autumn05	==	1) then
		AddItem(6,1,897,1,0,0,0)	
	elseif (CFG_2006vm_NationalDay	==	1) then
		AddItem(6,1,1155,1,0,0,0)	
	elseif (CFG_menglan_2006	==	1) then
		AddItem(6,1,random(1126,1130),1,0,0,0)	
	elseif (CFG_Act2Years2007	==	1) then
		AddItem(6,1,1438,1,0,0,0)	
	elseif (CFG_GUOQING2007	==	1) then
		AddItem(6,1,1494,1,0,0,0)	
	elseif (CFG_mid_autumn06	==	1) then
		AddItem(6,1,1220,1,0,0,0)	
	elseif (CFG_xmas2007	== 1) then	--CFG_xmas2007			= 0	-- Giang sinh		12/2007			Done
		AddItem(6,1,1627,1,0,0,0)	
	elseif (CFG_xmas2006	== 1) then	--CFG_xmas2006			= 0	-- Giang sinh		12/2006			Done
		AddItem(6,1,1311,1,0,0,0)	
	elseif (CFG_zhongqiu2007	==	1) then
		zhongqiu2007_addzi();
	elseif (CFG_newyear_2008	==	1) then
		AddItem(6,1,1652,1,0,0,0)	
	elseif (CFG_newyear_2009	==	1) then
		AddItem(6,1,random(1884,1885),1,0,0,0)	
	elseif (CFG_jiefang_jieri2008	==	1) then
		AddItem(6,1,1734,1,0,0,0)	
	elseif (CFG_jiefang_jieri2009	==	1) then
		AddItem(6,1,2009,1,0,0,0)	
	elseif (CFG_pingzi	==	1) then
		AddItem(6,1,random(1748,1751),1,0,0,0)	
	elseif (CFG_teachersday06	==	1) then
		vt06_addzi();
	elseif (CFG_yn_chunjie	==	1) then
		yn_chunjie_addi();
	elseif (CFG_ma_chunjie	==	1) then
		ma_chunjie_addi();
	elseif (CFG_teacher_day_200711	==	1) then
		AddItem(6,1,1598,1,0,0,0)	
	elseif (CFG_birthday_jieri_2009	==	1) then
		AddItem(6,1,2061,1,0,0,0)	
	elseif (CFG_mengjiang2007	==	1) then
		AddItem(6,1,1477,1,0,0,0)	
	else
		AddLeadExp(0)
	end
		return 0;	-- É¾³ýÎïÆ·

end