--== Dua top - Thuong theo cap do | 08/03/2023 ==--

Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\functionlib.lua")
Include("\\script\\lib\\log.lua")
IncludeLib("SETTING")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\global\\fuyuan.lua")

function duatop()
	dofile("script/global/nobitaxd/npc/duatop.lua");	
	local szTitle = "<color=red>Hç trî GM<color>.<enter><color=yellow>Vâ L©m TruyÒn Kú<color><enter><color=red>T×nh Trong Thiªn H¹<color>.<enter>Hoan nghªnh c¸c anh hïng hµo kiÖt... !"
	local tbOpt =
		{
		--{"PhÇn th­ëng 10 Cao thñ SERVER", top10},	
		{"NhËn th­ìng cÊp 20", levl20},
		{"NhËn th­ìng cÊp 40", levl40},
		{"NhËn th­ìng cÊp 60", levl60},
		{"NhËn th­ìng cÊp 80", levl80},
		{"NhËn th­ìng cÊp 100", levl100},
		{"Tho¸t"},
		}
	CreateNewSayEx(szTitle, tbOpt)					
end

function top10()
	if CalcFreeItemCellCount() < 10 then
		Say("H·y cÊt bít vËt phÈm ®Ó ®¶m b¶o cã 50 « trèng råi h·y më.",0);
		return 1;
	end
	AskClientForString("checkcode", "", 1, 100, "Xin nhËp code");
end
tbitem  =
	{
		[1]	={szName = " Bé trang bŞ ®éng s¸t",tbProp={0,143},nQuality = 1,nCount = 1},
		[2]	={szName = " Bé trang bŞ ®éng s¸t",tbProp={0,144},nQuality = 1,nCount = 1},
		[3]	={szName = " Bé trang bŞ ®éng s¸t",tbProp={0,145},nQuality = 1,nCount = 1},
		[4]	={szName = " Bé trang bŞ ®éng s¸t",tbProp={0,146},nQuality = 1,nCount = 1},
		[5]	={szName = " cµn kh«n giíi chØ",tbProp={0,428},nQuality = 1,nCount = 2},
		[6]	={szName = " H·n HuyÕt Long C©u",tbProp={0,10,18,1,0,0},nWidth=2, nHeigth=3,nCount = 1},
	}
function checkcode(strings)
	if GetTask(3001)==1 then
		Talk(1, "", "B¹n ®· nhËn råi mµ ");
		return
	end
	if strings=="TOPALS"then
		tbAwardTemplet:GiveAwardByList(tbitem, "PhÇn th­ëng top 10");
		Earn(10000000)
		AddStackItem(100,4,417,1,1,0,0,0)	-- nhan 100 tien dong
		SetTask(3001,1)
		str = "Tin chÊn ®éng giang hå, Cao thñ<color=red>"..GetName().."<color> Ch¨m chØ luyÖn tËp ®· nhËn ®­îc <color=green>phÇn th­ëng ThËp §¹i Cao Thñ<color> x­ng b¸ thiªn h¹ kh«ng ®Şch thñ !."
		AddGlobalCountNews(str, 1)
		Msg2Player( "Chóc mõng b¹n ®· nhËn ®­îc phÇn th­¬ng ThËp §¹i Cao Thñ" );
	else
		Talk(1, "", "H·y ch¨m chØ luyÖn tËp ®Ó nhËn ®­îc b¸o vËt x­ng b¸ vâ l©m");
	end
end

function levl20()
	
	if GetTask(3002)==1 then
		Talk(1, "", "Ng­¬i ®· nhËn råi mµ cßn muèn nhËn thªm µ ! mau ®i ®i ! ");
		return
	end

	if GetLevel() < 20 then
		level = 20 - GetLevel()
			Talk(1, "", "§½ng cÊp cña ng­¬i qu¸ thÊp ®õng lµm phiÒn ta ! mau ®i tËp luyªn thªm <color=Green>"..level .." CÊp<color> nòa råi quay l¹i !");
	else
		for i=238,240 do
			AddItem(4, i, 1, 1, 0, 0)
		end
		Msg2Player("B¹n nhËn ®­îc 3 viªn thñy tinh")	
		SetTask(3002,1)
	end
end

function levl40()
	
	if GetTask(3002)==1 then
		if GetTask(3003)==1 then
			Talk(1, "", "Ng­¬i ®· nhËn råi mµ cßn muèn nhËn thªm µ ! mau ®i ®i ! ");
			return
		end
	
			if GetLevel() < 40 then
				level = 40 -GetLevel()
				Talk(1, "", "§½ng cÊp cña ng­¬i qu¸ thÊp ®õng lµm phiÒn ta ! mau ®i tËp luyªn thªm <color=Green>"..level .." CÊp<color> nòa råi quay l¹i !");
			else
				for i=1,6 do
					AddItem(4, 353, 1, 1, 0, 0)
				end	
				Msg2Player("B¹n nhËn ®­îc 4 mãn Trang BŞ Kim Phong tinh Hång B¶o Th¹ch!")	
				SetTask(3003,1)
		end
	else
		Talk(1, "", "PhÇn th­ëng cho ®½ng cÊp thÊp cßn ch­a lÊy ®­îc th× gÆp ta lµm g× ? Mau ®i tËp luyÖn thªm råi ®Õn ®©y t×m ta ! ");
	end	
end	

function levl60()
	
	if GetTask(3003)==1 then
		if GetTask(3004)==1 then
			Talk(1, "", "Ng­¬i ®· nhËn råi mµ cßn muèn nhËn thªm µ ! mau ®i ®i ! ");
			return
		end
	
			if GetLevel() < 60 then
				level = 60 -GetLevel()
					Talk(1, "", "§½ng cÊp cña ng­¬i qu¸ thÊp ®õng lµm phiÒn ta ! mau ®i tËp luyªn thªm <color=Green>"..level .." CÊp<color> nòa råi quay l¹i !");
			else
				for i=168,176 do
					local ItemIdx=AddGoldItem(0, i);
				end
				local tbAwardItem = {tbProp={0,10,2,1,5,0}}
				tbAwardTemplet:GiveAwardByList(tbAwardItem, "NhËn ®­îc Ng­a cÊp 60!");	
				Msg2Player("B¹n nhËn ®­îc Bé Trang BŞ Thiªn Hoµng!")	
				SetTask(3004,1)

		end
	else
		Talk(1, "", "PhÇn th­ëng cho ®½ng cÊp thÊp cßn ch­a lÊy ®­îc th× gÆp ta lµm g× ? Mau ®i tËp luyÖn thªm råi ®Õn ®©y t×m ta ! ");
	end
end

function levl80()
	
	if GetTask(3004)==1 then
		if GetTask(3005)==1 then
			Talk(1, "", "Ng­¬i ®· nhËn råi mµ cßn muèn nhËn thªm µ ! mau ®i ®i ! ");
			return
		end
	
			if GetLevel() < 80 then
				level = 80 -GetLevel()
				Talk(1, "", "§½ng cÊp cña ng­¬i qu¸ thÊp ®õng lµm phiÒn ta ! mau ®i tËp luyªn thªm <color=Green>"..level .." CÊp<color> nòa råi quay l¹i !");
			else
				AddGoldItem(0,159)
				AddGoldItem(0,160)
				AddGoldItem(0,161)
				AddGoldItem(0,162)
				AddGoldItem(0,163)
				AddItem(0,10,5,5,0,0)
				Msg2Player("B¹n nhËn ®­îc ChiÕu D¹ Ngäc S­ Tö")
				Msg2Player("B¹n nhËn ®­îc Bé Trang BŞ §Şnh Quèc !")	
				SetTask(3005,1)

		end
	else
		Talk(1, "", "PhÇn th­ëng cho ®½ng cÊp thÊp cßn ch­a lÊy ®­îc th× gÆp ta lµm g× ? Mau ®i tËp luyÖn thªm råi ®Õn ®©y t×m ta ! ");
	end
end

function levl100()
	
	if GetTask(3005)==1 then
		if GetTask(3006)==1 then
			Talk(1, "", "Ng­¬i ®· nhËn råi mµ cßn muèn nhËn thªm µ ! mau ®i ®i ! ");
			return
		end
	
			if GetLevel() < 100 then
				level = 100 -GetLevel()
				Talk(1, "", "§½ng cÊp cña ng­¬i qu¸ thÊp ®õng lµm phiÒn ta ! mau ®i tËp luyªn thªm <color=Green>"..level .." CÊp<color> nòa råi quay l¹i !");
			else
				for i=164,167 do
				local ItemIdx=AddGoldItem(0, i);		
			end
				Msg2Player("B¹n nhËn ®­îc Bé Trang BŞ An Bang !")	
				SetTask(3006,1)
		end
	else
		Talk(1, "", "PhÇn th­ëng cho ®½ng cÊp thÊp cßn ch­a lÊy ®­îc th× gÆp ta lµm g× ? Mau ®i tËp luyÖn thªm råi ®Õn ®©y t×m ta ! ");
	end
end
