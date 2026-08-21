------NhËn SKILL-----------
Include("\\script\\global\\skills_table.lua");
function NhanSkill()
local szTitle = "Xin chµo Admin <color=red>"..GetName().."<color>,Nh÷ng chøc n¨ng bªn d­íi cã thÓ gióp b¹n kiÓm tra Server hoÆc hæ trî ng­êi ch¬i.\n\n<pic=137> Online    : <color=green>"..GetPlayerCount().."<color>"
local tbOpt =
	{		
		{"Vµo Ph¸i Vµ Häc Skill 120",choose_faction12x},
		{"Céng ®iÓm kü n¨ng", congdiemkynang},
		{"LÊy Skill Theo ID", LaySkillID},
		{"§æi Tªn Nh©n VËt", doiten},	
		--{"ChuyÓn ®æi ngò hµnh", nguhanh},
		--{"TÈy Tñy",clear_attibute_point},
		{"Trë L¹i",testserver},
		{"Tho¸t"},
	}
	CreateNewSayEx(szTitle, tbOpt)
end

------------------------Cong Diem Ky Nang------------------------------
	----------------------
tb_skill_add = {    [0] = { --thiÕu l©m
        [1] = {10,14,4,6,8,15,16,20,11,19,271,21,273},
        [2] = {"ThiÕu L©m QuyÒn","QuyÒn Ph¸p",14,8,271,273},
        [3] = {"ThiÕu L©m §ao","§ao Ph¸p",6,19,273},
        [4] = {"ThiÕu L©m C«n","C«n Ph¸p",10,4,11,273},
    },
    [1] = { --thiªn v­¬ng
        [1] = {29,30,34,23,24,26,33,31,35,3740,42,32,36,41,324},
        [2] = {"Thiªn V­¬ng Th­¬ng","Th­¬ng Ph¸p",30,23,35,41,36},
        [3] = {"Thiªn V­¬ng Chïy","Chïy Ph¸p",29,26,31,324,36},
        [4] = {"Thiªn V­¬ng §ao","§ao Ph¸p",34,24,32,37,36},
    },
    [2] = { --®­êng m«n
        [1] = {45,43,347,303,47,50,54,343,345,349,48,58,249,341},
        [2] = {"§­êng M«n - Phi Tiªu","Phi Tiªu ThuËt",45,43,47,341,48},
        [3] = {"§­êng M«n - Phi §ao","Phi §ao ThuËt",45,43,50,249,48},
        [4] = {"§­êng M«n - Tô TiÔn","Tô TiÔn ThuËt",45,43,54,58,48},
        [5] = {"§­êng M«n - BÉy","H·m TÜnh ThuËt",303,347,343,349,345,48},
    },
    [3] = { --ngò ®éc
        [1] = {63,65,60,62,67,66,70,64,68,69,384,73,356,72,71,74,75},
        [2] = {"Ngò §éc §ao","§ao Ph¸p",65,60,384,74,75},
        [3] = {"Ngò §éc Ch­ëng","Ch­ëng Ph¸p",63,62,68,71,75},
        [4] = {"Ngò §éc Bïa","Bïa Chó",67,70,64,356,72,75},
    },
    [4] = { --nga mi
        [1] = {80,85,77,79,93,82,89,385,86,92,88,91,252,282},
        [2] = {"Nga Mi KiÕm","KiÕm Ph¸p",85,77,385,88,252},
        [3] = {"Nga Mi Ch­ëng","Ch­ëng Ph¸p",80,79,82,91,252},
        [4] = {"Nga Mi Phô Trî","Phô Trî",93,89,86,92,282,252},
    },
    [5] = { --thóy yªn
        [1] = {99,102,95,97,269,105,113,100,109,108,111,114},
        [2] = {"Thóy Yªn §ao","§ao Ph¸p",99,95,105,109,108,114},
        [3] = {"Thóy Yªn Song §ao","Ch­ëng Ph¸p",102,97,113,111, 114},
    },
    [6] = { --c¸i bang
        [1] = {119,122,115,116,129,124,274,277,125,128,130,360},
        [2] = {"C¸i Bang Bæng","Bæng Ph¸p",119,115,124,125,360,130},
        [3] = {"C¸i Bang Rång","Ch­ëng Ph¸p",122,116,274,128,360,130},
    },
    [7] = { --thiªn nhÉn
        [1] = {135,145,131,132,136,137,138,140,141,364,143,142,148,150},
        [2] = {"Thiªn NhÉn M©u","M©u Ph¸p",135,132,141,142,150},
        [3] = {"Thiªn NhÉn §ao Ph¸p","§ao Ph¸p",145,131,138,148,150},
        [4] = {"Thiªn NhÉn Bïa","Bïa Chó",136,137,140,364,143,150},
    },
    [8] = { --vâ ®ang
        [1] = {153,155,151,152,159,158,164,160,157,165,166,267},
        [2] = {"Vâ §ang KiÕm","KiÕm Ph¸p",155,151,158,267,166},
        [3] = {"Vâ §ang KhÝ","QuyÒn Ph¸p",153,152,164,165,166},
    },
    [9] = { --c«n l«n
        [1] = {169,179,167,168,171,392,174,172,173,178,393,175,181,90,176,182,275,630},
        [2] = {"C«n L«n §ao","§ao Ph¸p",169,167,178,176,275},
        [3] = {"C«n L«n KiÕm","KiÕm Ph¸p",179,168,172,182,275},
        [4] = {"C«n L«n Bïa","Bïa Chó",392,174,393,175,90,275},
    },
}
NpcName = "<color=yellow>Hç Trî Céng §iÓm Kü N¨ng<color>: "
function congdiemkynang()
    local nFaction = GetLastFactionNumber()
    if GetLevel() < 10 or nFaction < 0 then
        Say("Nh©n vËt ®¹t cÊp 10 vµ ®· gia nhËp m«n ph¸i míi dïng ®­îc chøc n¨ng nµy.", 1, "Tho¸t/Quit")
        return
    end
    Say("Ng­¬i muèn céng kü n¨ng thÕ nµo?", 5,
        "Céng theo tõng kü n¨ng/#Add_PointMagic(1,"..nFaction..")",
        "Céng theo h­íng luyÖn c«ng/#Add_PointMagic(2,"..nFaction..")",
        "Céng toµn bé kü n¨ng lªn cÊp cao nhÊt/#Add_PointMagic(3,"..nFaction..")",
        "Quay l¹i/NhanSkill",
        "Tho¸t/Quit"
    )
end
function add_magic(nFaction)
    if nFaction < 0 then
        nMonPhai = "Ch­a Gia NhËp Ph¸i"
    elseif nFaction == 0 then
        nMonPhai = "ThiÕu L©m"
    elseif nFaction == 1 then
        nMonPhai = "Thiªn V­¬ng"
    elseif nFaction == 2 then
        nMonPhai = "§­êng M«n"
    elseif nFaction == 3 then
        nMonPhai = "Ngò §éc"
    elseif nFaction == 4 then
        nMonPhai = "Nga My"
    elseif nFaction == 5 then
        nMonPhai = "Thóy Yªn"
    elseif nFaction == 6 then
        nMonPhai = "C¸i Bang"
    elseif nFaction == 7 then
        nMonPhai = "Thiªn NhÉn"
    elseif nFaction == 8 then
        nMonPhai = "Vâ §ang"
    elseif nFaction == 9 then
        nMonPhai = "C«n L«n"
    end
    if GetLevel()< 10 or nFaction < 0 then
        local tab_Content = {
        "Quay l¹i/main",
        "Tho¸t/Quit",
        }
        Say(NpcName.."Nh©n vËt ®¹t ®¼ng cÊp 10 trë lªn ®· gia nhËp m«n ph¸i míi cã thÓ sö dông chøc n¨ng nµy.", getn(tab_Content),tab_Content);
    return
    end
    local tab_Content = {
    "Céng theo tõng kü n¨ng/#Add_PointMagic(1,"..nFaction..")",
    "Céng theo h­íng luyÖn c«ng/#Add_PointMagic(2,"..nFaction..")",
    "Céng toµn bé kü n¨ng lªn cÊp cao nhÊt./#Add_PointMagic(3,"..nFaction..")",
    "Quay l¹i/main",
    "Tho¸t/Quit",
    }
    Say(NpcName.."Ng­¬i ®· gia nhËp m«n ph¸i <color=yellow>"..nMonPhai.."<color>, ng­¬i muèn céng kü n¨ng thÕ nµo?", getn(tab_Content),tab_Content);
end
function Add_PointMagic(nId,nFaction)
    if nFaction < 0 then
        nMonPhai = "Ch­a Gia NhËp Ph¸i"
    elseif nFaction == 0 then
        nMonPhai = "ThiÕu L©m"
    elseif nFaction == 1 then
        nMonPhai = "Thiªn V­¬ng"
    elseif nFaction == 2 then
        nMonPhai = "§­êng M«n"
    elseif nFaction == 3 then
        nMonPhai = "Ngò §éc"
    elseif nFaction == 4 then
        nMonPhai = "Nga My"
    elseif nFaction == 5 then
        nMonPhai = "Thóy Yªn"
    elseif nFaction == 6 then
        nMonPhai = "C¸i Bang"
    elseif nFaction == 7 then
        nMonPhai = "Thiªn NhÉn"
    elseif nFaction == 8 then
        nMonPhai = "Vâ §ang"
    elseif nFaction == 9 then
        nMonPhai = "C«n L«n"
    end
    if nId == 1 then
        local tb_Desc = {}; 
        for i = 1, getn(tb_skill_add[nFaction][1]) do
            local skillcur = HaveMagic(tb_skill_add[nFaction][1][i]);
            local skillmax = GetSkillMaxLevel(tb_skill_add[nFaction][1][i]) + GetSkillMaxLevelAddons()
            if skillcur >= 0 and skillcur < skillmax then
                local nPointAdd = skillmax - skillcur
                tinsert(tb_Desc, format("Th¨ng cÊp ".."%s".."[Max: ".."%s".."]/#Add_PointMagic_Type1(%d,%d,%d,%d,%d)", GetSkillName(tb_skill_add[nFaction][1][i]),skillmax, tb_skill_add[nFaction][1][i],nPointAdd,nFaction,i,skillmax)); 
            end
        end
        tinsert(tb_Desc, 1,NpcName.."Lùa chän kü n¨ng th¨ng cÊp"); 
        tinsert(tb_Desc,"Quay l¹i/#add_magic("..nFaction..")"); 
        tinsert(tb_Desc,"Tho¸t/OnCancel"); 
        CreateTaskSay(tb_Desc); 
    elseif nId == 2 then
        local HuongLC = getn(tb_skill_add[nFaction])-1
        local TongSkill1 = 0
        local TongSkill2 = 0
        for i=3,getn(tb_skill_add[nFaction][2]) do
            TongSkill1 = TongSkill1 + GetSkillMaxLevel(tb_skill_add[nFaction][2][i]) + GetSkillMaxLevelAddons() - HaveMagic(tb_skill_add[nFaction][2][i]);
        end
        for i=3,getn(tb_skill_add[nFaction][3]) do
            TongSkill2 = TongSkill2 + GetSkillMaxLevel(tb_skill_add[nFaction][3][i]) + GetSkillMaxLevelAddons() - HaveMagic(tb_skill_add[nFaction][3][i]);
        end
        if HuongLC == 2 then
            local tab_Content = {
            "Céng theo "..tb_skill_add[nFaction][2][2]..", cÇn tæng céng ["..TongSkill1.."] ®iÓm Kü N¨ng/#AddHuongLC(2,"..nFaction..","..TongSkill1..")",
            "Céng theo "..tb_skill_add[nFaction][3][2]..", cÇn tæng céng ["..TongSkill2.."] ®iÓm Kü N¨ng/#AddHuongLC(3,"..nFaction..","..TongSkill2..")",
            "Quay l¹i/#add_magic("..nFaction..")",
            "Tho¸t/Quit",
            }
            Say(NpcName.."M«n ph¸i "..nMonPhai.." cã "..HuongLC.." h­íng luyÖn c«ng ®ã lµ: "..tb_skill_add[nFaction][2][2].." vµ "..tb_skill_add[nFaction][3][2]..".<enter>"..tb_skill_add[nFaction][2][2].." bao gåm "..(getn(tb_skill_add[nFaction][2])-2).." Kü N¨ng.<enter>"..tb_skill_add[nFaction][3][2].." bao gåm "..(getn(tb_skill_add[nFaction][3])-2).." Kü N¨ng.",getn(tab_Content),tab_Content);
        elseif HuongLC == 3 then
            --local TongSkill3 = (    (getn(tb_skill_add[nFaction][4])-3)*20+30    ) + (getn(tb_skill_add[nFaction][4])-2)*GetSkillMaxLevelAddons()
            local TongSkill3 = 0
            for i=3,getn(tb_skill_add[nFaction][4]) do
                TongSkill3 = TongSkill3 + GetSkillMaxLevel(tb_skill_add[nFaction][4][i]) + GetSkillMaxLevelAddons() - HaveMagic(tb_skill_add[nFaction][4][i]);
            end
            local tab_Content = {
            "Céng theo "..tb_skill_add[nFaction][2][2]..", cÇn tæng céng ["..TongSkill1.."] ®iÓm Kü N¨ng/#AddHuongLC(2,"..nFaction..","..TongSkill1..")",
            "Céng theo "..tb_skill_add[nFaction][3][2]..", cÇn tæng céng ["..TongSkill2.."] ®iÓm Kü N¨ng/#AddHuongLC(3,"..nFaction..","..TongSkill2..")",
            "Céng theo "..tb_skill_add[nFaction][4][2]..", cÇn tæng céng ["..TongSkill3.."] ®iÓm Kü N¨ng/#AddHuongLC(4,"..nFaction..","..TongSkill3..")",
            "Quay l¹i/#add_magic("..nFaction..")",
            "Tho¸t/Quit",
            }
            Say(NpcName.."M«n ph¸i "..nMonPhai.." cã "..HuongLC.." h­íng luyÖn c«ng ®ã lµ: "
            ..tb_skill_add[nFaction][2][2]..", "..tb_skill_add[nFaction][3][2]..".vµ "..tb_skill_add[nFaction][4][2].."<enter>"
            ..tb_skill_add[nFaction][2][2].." bao gåm "..(getn(tb_skill_add[nFaction][2])-2).." Kü N¨ng.<enter>"
            ..tb_skill_add[nFaction][3][2].." bao gåm "..(getn(tb_skill_add[nFaction][3])-2).." Kü N¨ng.<enter>"
            ..tb_skill_add[nFaction][4][2].." bao gåm "..(getn(tb_skill_add[nFaction][4])-2).." Kü N¨ng.",
            getn(tab_Content),tab_Content
            );
        elseif HuongLC == 4 then
            --local TongSkill3 = (    (getn(tb_skill_add[nFaction][4])-3)*20+30    ) + (getn(tb_skill_add[nFaction][4])-2)*GetSkillMaxLevelAddons()
            --local TongSkill4 = (    (getn(tb_skill_add[nFaction][5])-3)*20+30    ) + (getn(tb_skill_add[nFaction][5])-2)*GetSkillMaxLevelAddons()
            local TongSkill3 = 0
            local TongSkill4 = 0
            for i=3,getn(tb_skill_add[nFaction][4]) do
                TongSkill3 = TongSkill3 + GetSkillMaxLevel(tb_skill_add[nFaction][4][i]) + GetSkillMaxLevelAddons() - HaveMagic(tb_skill_add[nFaction][4][i]);
            end
            for i=3,getn(tb_skill_add[nFaction][5]) do
                TongSkill4 = TongSkill4 + GetSkillMaxLevel(tb_skill_add[nFaction][5][i]) + GetSkillMaxLevelAddons() - HaveMagic(tb_skill_add[nFaction][5][i]);
            end
            local tab_Content = {
            "Céng theo "..tb_skill_add[nFaction][2][2]..", cÇn tæng céng ["..TongSkill1.."] ®iÓm Kü N¨ng/#AddHuongLC(2,"..nFaction..","..TongSkill1..")",
            "Céng theo "..tb_skill_add[nFaction][3][2]..", cÇn tæng céng ["..TongSkill2.."] ®iÓm Kü N¨ng/#AddHuongLC(3,"..nFaction..","..TongSkill2..")",
            "Céng theo "..tb_skill_add[nFaction][4][2]..", cÇn tæng céng ["..TongSkill3.."] ®iÓm Kü N¨ng/#AddHuongLC(4,"..nFaction..","..TongSkill3..")",
            "Céng theo "..tb_skill_add[nFaction][5][2]..", cÇn tæng céng ["..TongSkill4.."] ®iÓm Kü N¨ng/#AddHuongLC(5,"..nFaction..","..TongSkill4..")",
            "Quay l¹i/#add_magic("..nFaction..")",
            "Tho¸t/Quit",
            }
            Say(NpcName.."M«n ph¸i "..nMonPhai.." cã "..HuongLC.." h­íng luyÖn c«ng ®ã lµ: "
            ..tb_skill_add[nFaction][2][2]..", "..tb_skill_add[nFaction][3][2]..", "..tb_skill_add[nFaction][4][2].." vµ "..tb_skill_add[nFaction][5][2].."<enter>"
            ..tb_skill_add[nFaction][2][2].." bao gåm "..(getn(tb_skill_add[nFaction][2])-2).." Kü N¨ng.<enter>"
            ..tb_skill_add[nFaction][3][2].." bao gåm "..(getn(tb_skill_add[nFaction][3])-2).." Kü N¨ng.<enter>"
            ..tb_skill_add[nFaction][4][2].." bao gåm "..(getn(tb_skill_add[nFaction][4])-2).." Kü N¨ng.<enter>"
            ..tb_skill_add[nFaction][5][2].." bao gåm "..(getn(tb_skill_add[nFaction][5])-2).." Kü N¨ng.",
            getn(tab_Content),tab_Content
            );
        end
    elseif nId == 3 then
        local nTongSoSkill = getn(tb_skill_add[nFaction][1])
        local nTongSoPoint_Need = 0
        local CheckFullSkill = 0
        for i=1,nTongSoSkill do
        local nSkillHienTai = HaveMagic(tb_skill_add[nFaction][1][i]);
            if nSkillHienTai >= 0 then
                CheckFullSkill = CheckFullSkill + 1
            end
        local nSkillToiDa = GetSkillMaxLevel(tb_skill_add[nFaction][1][i]) + GetSkillMaxLevelAddons()
        local nPointNeed = nSkillToiDa - nSkillHienTai
            nTongSoPoint_Need = nTongSoPoint_Need + nPointNeed
        end
        if CheckFullSkill < nTongSoSkill then --NÕu ch­a häc ®ñ skill
            local tab_Content = {
            "Quay l¹i/#add_magic("..nFaction..")",
            "Tho¸t/Quit",
            }
            Say(NpcName.."Ng­¬i lµ mét ®Ö tö cña ph¸i <color=yellow>"..nMonPhai.."<color>. M«n ph¸i cã tæng céng <color=green>"..nTongSoSkill.."<color> Kü n¨ng cã thÓ th¨ng cÊp. Ng­¬i míi chØ l·nh gi¸o ®­îc <color=green>"..CheckFullSkill.."<color> Kü n¨ng. H·y cè g¾ng tu luyÖn thªm, khi nµo ®Çy ®ñ <color=green>"..nTongSoSkill.."<color> Kü N¨ng míi cã thÓ sö dông chøc n¨ng nµy.", getn(tab_Content),tab_Content);
            return
        end
        if GetMagicPoint() < nTongSoPoint_Need then --NÕu sè ®iÓm yªu cÇu kh«ng ®ñ ®Ó céng.
            local tab_Content = {
            "Quay l¹i/#add_magic("..nFaction..")",
            "Tho¸t/Quit",
            }
            Say(NpcName.."Ng­¬i lµ mét ®Ö tö cña ph¸i <color=yellow>"..nMonPhai.."<color>. M«n ph¸i cã tæng céng <color=green>"..nTongSoSkill.."<color> Kü n¨ng, yªu cÇu ph¶i cã Ýt nhÊt <color=green>"..nTongSoPoint_Need.."<color> ®iÓm Kü N¨ng míi cã thÓ n©ng cÊp. H·y tu luyÖn thªm ®i.", getn(tab_Content),tab_Content);
            return
        end
        for i=1,nTongSoSkill do
            local nIdSkill = tb_skill_add[nFaction][1][i]
            local SkillCaoNhat = GetSkillMaxLevel(nIdSkill) + GetSkillMaxLevelAddons()
            local SkillPointNeed = GetSkillMaxLevel(nIdSkill) + GetSkillMaxLevelAddons() - HaveMagic(nIdSkill);
            AddMagic(nIdSkill,SkillCaoNhat)
            AddMagicPoint(-SkillPointNeed)
            Msg2Player("N©ng thµnh c«ng <color=yellow>"..GetSkillName(nIdSkill).."<color> lªn cÊp <color=green>"..SkillCaoNhat.."<color>. §iÓm Kü N¨ng cßn l¹i <color=yellow>"..GetMagicPoint().."<color> ®iÓm.")
        end
    end
end
function AddHuongLC(nId,nFaction,nTotalSkillNeed)
    if GetMagicPoint() < nTotalSkillNeed then
        local tab_Content = {
        "Quay l¹i/#Add_PointMagic(2,"..nFaction..")",
        "Tho¸t/Quit",
        }
        Say(NpcName.."L­îng ®iÓm Kü N¨ng cßn l¹i kh«ng ®ñ ®Ó n©ng kü n¨ng theo h­íng <color=yellow>"..tb_skill_add[nFaction][nId][2].."<color>. CÇn tèi thiÓu "..nTotalSkillNeed.." ®iÓm kü n¨ng", getn(tab_Content),tab_Content);
        return
    end
    for i=3,getn(tb_skill_add[nFaction][nId]) do
        local Id_Skill = tb_skill_add[nFaction][nId][i]
        if HaveMagic(Id_Skill) < 0 then
            Msg2Player("Ch­a häc ®Çy ®ñ c¸c kÜ n¨ng ch­a sö dông ®­îc chøc n¨ng nµy.")
        return
        end
        local DiemCong = GetSkillMaxLevel(Id_Skill) - HaveMagic(Id_Skill);
        local TenSkill = GetSkillName(Id_Skill)
        local Skill_CaoNhat = GetSkillMaxLevel(Id_Skill) + GetSkillMaxLevelAddons()
        AddMagic(Id_Skill,Skill_CaoNhat)
        AddMagicPoint(-DiemCong)
        Msg2Player("N©ng thµnh c«ng <color=yellow>"..TenSkill.."<color> lªn cÊp <color=green>"..GetSkillMaxLevel(Id_Skill).."<color>. §iÓm Kü N¨ng cßn l¹i <color=yellow>"..GetMagicPoint().."<color> ®iÓm.")
    end
end
function Add_PointMagic_Type1(nIdSkill,nPointAdd,nFaction,nViTri,nMaxSkill)
    local SkillName = GetSkillName(tb_skill_add[nFaction][1][nViTri])
    if GetMagicPoint() < nPointAdd then
        local tab_Content = {
        "Quay l¹i/#Add_PointMagic(1,"..nFaction..")",
        "Tho¸t/Quit",
        }
        Say(NpcName.."L­îng ®iÓm Kü N¨ng cßn l¹i kh«ng ®ñ ®Ó n©ng <color=yellow>"..SkillName.."<color> lªn cÊp <color=yellow>"..nMaxSkill.."<color>.", getn(tab_Content),tab_Content);
    else
        AddMagic(nIdSkill,nMaxSkill)
        AddMagicPoint(-nPointAdd)
        Msg2Player("N©ng thµnh c«ng <color=yellow>"..SkillName.."<color> lªn cÊp <color=green>"..nMaxSkill.."<color>. §iÓm Kü N¨ng cßn l¹i <color=yellow>"..GetMagicPoint().."<color> ®iÓm.")
    end
end
-----------------------------------------------------------------------tbFaction------------------------------------------------------------------------
local tbFaction =
{
	[1] =
	{
		szShowName = "ThiÕu L©m",
		szFaction = "shaolin",
		nShortFaction = "sl",
		tbSkill = {318, 319, 321, 709},
		tbRank={72},
	},
	[2] =
	{
		szShowName = "Thiªn V­¬ng Bang",
		szFaction = "tianwang",
		nShortFaction = "tw",
		tbSkill = {322, 325, 323, 708},
		tbRank={69},
	},
	[3] =
	{
		szShowName = "§­êng M«n",
		szFaction = "tangmen",
		nShortFaction = "tm",
		tbSkill = {339, 302, 342, 710},
		tbRank={76},
	},
	[4] =
	{
		szShowName = "Ngò §éc Gi¸o",
		szFaction = "wudu",
		nShortFaction = "wu",
		tbSkill = {353, 355, 711},
		tbRank={80},
	},
	[5] =
	{
		szShowName = "Nga Mi",
		szFaction = "emei",
		nShortFaction = "em",
		tbSkill = {380, 328, 712},
		tbRank={64},
	},
	[6] =
	{
		szShowName = "Thóy Yªn",
		szFaction = "cuiyan",
		nShortFaction = "cy",
		tbSkill = {336, 337, 713},
		tbRank={67},
	},
	[7] =
	{
		szShowName = "C¸i Bang",
		szFaction = "gaibang",
		nShortFaction = "gb",
		tbSkill = {357, 359, 714},
		tbRank={78},
	},
	[8] =
	{
		szShowName = "Thiªn NhÉn Gi¸o",
		szFaction = "tianren",
		nShortFaction = "tr",
		tbSkill = {361, 362, 715},
		tbRank={81},
	},
	[9] =
	{
		szShowName = "Vâ §ang",
		szFaction = "wudang",
		nShortFaction = "wd",
		tbSkill = {365, 368, 716},
		tbRank={73},
	},
	[10] =
	{
		szShowName = "C«n L«n",
		szFaction = "kunlun",
		nShortFaction = "kl",
		tbSkill = {372, 375, 717},
		tbRank={75},
	},
}
local tbFactionSeries =
{
[1] = {1, 2},
[2] = {3, 4},
[3] = {5, 6},
[4] = {7, 8},
[5] = {9, 10},
}

function doiten()
	AskClientForString("doitennv", "", 1, 100, "Xin nhËp tªn míi");
end
function doitennv(strings)
	RenameRole(strings)
end

function nguhanh()
local szTitle = "<npc>Ng­¬i cÇn g×?"
	local tbOpt =
	{
		{"ChuyÓn ®æi sang n÷ hÖ Kim", nukim},
		{"Chuyªn ®æi sang nam hÖ Thuû", namthuy},
		{"Tho¸t"},
	}

	CreateNewSayEx(szTitle, tbOpt)
end
function nukim()
if GetSex() == 1 then
SetSeries(0)
KickOutSelf()
	else
	Talk(1,"","Ng­¬i lµ Pª §ª µ ?")
end
end

function namthuy()
if GetSex() == 0 then
SetSeries(2)
KickOutSelf()
	else
	Talk(1,"","Vui lßng kiÓm tra l¹i giíi tÝnh")
end
end

--function check_faction()
--	local szCurFaction = GetFaction()
--	if szCurFaction ~= nil and szCurFaction ~= "" then
--		return
--	end
--	return 1
--end

function knang150xx()
if check_faction() == 1 then
	Talk(1, "", "Ch­a gia nhËp m«n ph¸i kh«ng thÓ nhËn Skill ®­îc.")
	return end

if GetLevel() >= 150 then	
if GetLastFactionNumber() == 0 then  ------thieu lam
--if GetFaction() == "shaolin" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1055,20)
AddMagic(1056,20)
AddMagic(1057,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña ThiÕu L©m. ")

elseif GetLastFactionNumber() == 1 then --------thien vuong vuong
--elseif GetFaction() == "tianwang" then
AddMagic(1058,20)
AddMagic(1059,20)
AddMagic(1060,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Thiªn V­¬ng. ")

elseif GetLastFactionNumber() == 2 then ---------duong mon
--elseif GetFaction() == "tangmen" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1069,20)
AddMagic(1070,20)
AddMagic(1071,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña §­êng M«n. ")

elseif GetLastFactionNumber() == 3 then  ----------ngu doc
--elseif GetFaction() == "wudu" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1066,20)
AddMagic(1067,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Ngò §éc.")

elseif GetLastFactionNumber() == 4 then  ----------nga my
--elseif GetFaction() == "emei" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1061,20)
AddMagic(1062,20)
AddMagic(1114,20)
AddMagic(332,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Nga My.")

elseif GetFaction() == "cuiyan" then -----thuy yen
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1063,20)
AddMagic(1065,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Thóy Yªn.")

elseif GetLastFactionNumber == 5 then  -------thuy yen
--elseif GetFaction() == "cuiyan" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1063,20)
AddMagic(1065,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Thóy Yªn.")

elseif GetLastFactionNumber() == 6 then -----gaibang
--elseif GetFaction() == "gaibang" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1073,20)
AddMagic(1074,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña C¸i Bang.")

elseif GetLastFactionNumber() == 7 then -----thien nhan
--elseif GetFaction() == "tianren" then
AddMagic(1075,20)
AddMagic(1076,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Thiªn NhÉn.")

elseif GetLastFactionNumber() == 8 then -------vo dang
--elseif GetFaction() == "wudang" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1078,20)
AddMagic(1079,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Vâ §ang.")

elseif GetLastFactionNumber() == 9 then ------con luon
--elseif GetFaction() == "kunlun" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
AddMagic(1080,20)
AddMagic(1081,20)
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña C«n L«n.")

elseif GetLastFactionNumber() == 10 then ------hoa son
--elseif GetFaction() == "kunlun" then
		for i=1220,1229 do
		DelMagic(i,0)
		end
		AddMagic(1364,20) --Skill Hoa son
		AddMagic(1382,20) --Skill Hoa son
		AddMagic(1363,20) --Skill Hoa son --------Skill
		AddMagic(1365,20) --Skill Hoa son
		AddMagic(1370,20) --Skill Hoa son
		AddMagic(1369,20) --Skill Hoa son
		AddMagic(1384,20) --Skill Hoa son
		AddMagic(1368,20) --Skill Hoa son --------Doc Co Cuu Kiem
Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Hoa S¬n.")
end
else
Talk(1, "", "LuyÖn ®Õn cÊp 150 råi h·y ®Õn t×m ta")
end
Talk(1, "", "Ban khong thuoc bat ky phai nao!")
		-- for i=1220,1229 do
		-- DelMagic(i,0)
		-- end
-- AddMagic(1063,20)
-- AddMagic(1065,20)
-- Talk(1,"","Chóc mõng b¹n ®· häc ®­îc tuyÖt kü 150 cña Thóy Yªn.")
end

SKILL_180 = {1220,1221,1223,1222,1224,1225,1227,1226,1228,1229 } --1235, 138, 
--------------------------------------------------------1296 tang toc do di chuye
local tbEquipFreeCell =
{
{2, 1}, {2, 2}, {1, 1}, {1, 2}, {2, 1},
{2, 3}, {2, 4}, {2, 2}, {1, 2}, {1, 1},
}

function knang180()
local nFaction = GetLastFactionNumber() + 1
if nFaction==0 then
Say("Kh«ng cã m«n ph¸i mµ ®åi nhËn skill thÊt truyÒn, ta kh«ng cã thêi gian ®ïa víi ng­¬i", 0)
return
else
for i=1,10 do
if (nFaction==i) then
if (HaveMagic(SKILL_180[i]) == -1) then
AddMagic(SKILL_180[i],20)
Say("B¹n häc ®­îc kü n¨ng cÊp 180 <color=yellow>"..GetSkillName(SKILL_180[i]), 0)
else
Say("Ng­¬i ®· cã kü n¨ng thÊt truyÒn råi, ®õng tham lam", 0)
return
end
end
end
end
end

------------------------Vµo ph¸i full skill 12x-----------------------------
function check_faction12x()
	local szCurFaction = GetFaction()
	if szCurFaction ~= nil and szCurFaction ~= "" then
		return
	end
	return 1
end

function choose_faction12x()
	if check_faction12x() ~= 1 then
		Talk(1, "", "Ng­¬i ®· gia nhËp m«n ph¸i.")
		return
	end
	local nSeries = GetSeries() + 1
	local szTitle = "Xin chµo <color=red>"..GetName().."<color>. Mét khi gia nhËp m«n ph¸i kh«ng thÓ thay ®æi, h·y suy nghÜ kü"
	local tbOpt = {}
	for i=1, getn(%tbFactionSeries[nSeries]) do
		local nIndex = %tbFactionSeries[nSeries][i]
		tinsert(tbOpt, {%tbFaction[nIndex].szShowName, set_faction12x, {nIndex}})
	end
	tinsert(tbOpt, {"Trë VÒ", NhanSkill})
	tinsert(tbOpt, {"Tho¸t"})
	CreateNewSayEx(szTitle, tbOpt)
end

function set_faction12x(nIndex)
	local szTitle = format("<color=red>"..GetName().."<color> Cã ch¾c ch¾n muèn gia nhËp ph¸i <color=yellow>%s<color> kh«ng?", %tbFaction[nIndex].szShowName)
	local tbOpt =
	{
		{"X¸c nhËn!", do_set_faction12x, {nIndex}},
		{"Trë VÒ.", choose_faction12x},
		{"Kªt thóc ®èi tho¹i."},
	}
	CreateNewSayEx(szTitle, tbOpt)
end

function do_set_faction12x(nIndex)
	if check_faction12x() ~= 1 then
		Talk(1, "", "Ng­¬i ®· gia nhËp m«n ph¸i.")
		return
	end
	local nResult = SetFaction(%tbFaction[nIndex].szFaction)
	if nResult == 0 then
		return
	end
	DynamicExecuteByPlayer(PlayerIndex, "\\script\\gmscript.lua", "AddSkills", %tbFaction[nIndex].nShortFaction, 0)
	for i=1, getn(%tbFaction[nIndex].tbSkill) do--Add Skill 90-120
		AddMagic(%tbFaction[nIndex].tbSkill[i], 1)
	end
	for i=1, getn(%tbFaction[nIndex].tbRank) do--Add X­ng HiÖu
		SetRank(%tbFaction[nIndex].tbRank[i])
	end
	Talk(1, "KickOutSelf", format("Ng­¬i ®· gia nhËp thµnh c«ng ph¸i <color=yellow>%s", %tbFaction[nIndex].szShowName))
end


------Tay Tuy------------
function clear_attibute_point()
local szTitle = "<#>Xin chµo <color=red>"..GetName().."<color>. B¹n cÇn tÈy ®iÓm TiÒm N¨ng hay Kü N¨ng?\n\nHiÖn t¹i cã <color=red>"..GetPlayerCount().." <color>ng­êi ch¬i ®ang trùc tuyÕn.<color>"
local tbOpt =
{
{"TÈy §iÓm Kü N¨ng.", do_clear_skill},
{"TÈy §iÓm TiÒm N¨ng.", do_clear_prop},
{"Trë VÒ", NhanSkill},
{"Tho¸t."},
}
CreateNewSayEx(szTitle, tbOpt)
end
function do_clear_skill()
local i = HaveMagic(210) 
local j = HaveMagic(400) 
local n = RollbackSkill() 
local x = 0
if (i ~= -1) then i = 1; x = x + i end 
if (j ~= -1) then x = x + j end
local rollback_point = n - x 
if (rollback_point + GetMagicPoint() < 0) then 
rollback_point = -1 * GetMagicPoint()
end
AddMagicPoint(rollback_point)
if (i ~= -1) then AddMagic(210, i) end 
if (j ~= -1) then AddMagic(400, j) end
Msg2Player("TÈy tñy thµnh c«ng! Ng­¬i cã "..rollback_point.." ®iÓm kü n¨ng ®Ó ph©n phèi l¹i.")
KickOutSelf()
end
function do_clear_prop()
local base_str = {35,20,25,30,20} 
local base_dex = {25,35,25,20,15}
local base_vit = {25,20,25,30,25}
local base_eng = {15,25,25,20,40}
local player_series = GetSeries() + 1

local Utask88 = GetTask(88)
AddStrg(base_str[player_series] - GetStrg(1) + GetByte(Utask88, 1))
AddDex(base_dex[player_series] - GetDex(1) + GetByte(Utask88, 2))
AddVit(base_vit[player_series] - GetVit(1) + GetByte(Utask88, 3))
AddEng(base_eng[player_series] - GetEng(1) + GetByte(Utask88, 4))
end
------Lay Skill Theo ID--------
function LaySkillID()
local szTitle = "Xin chµo Admin <color=red>"..GetName().."<color>,Nh÷ng chøc n¨ng bªn d­íi cã thÓ gióp b¹n kiÓm tra Server hoÆc hæ trî ng­êi ch¬i.\n\n<pic=137> Online    : <color=green>"..GetPlayerCount().."<color>"
local tbOpt =
{
	{"LÊy Skills", g_AskClientStringEx, {"1200,20", 0, 256, "ID Skill", {AddSkill, {self}} }}, 
	{"Xãa Skills", g_AskClientStringEx, {"1200", 0, 300, "ID Skill", {DelSkill, {self}} }},
	--{"Xãa Skills", skillmoi},
	{"LÊy Danh S¸ch Skills", g_AskClientStringEx, {"1200,1210", 0, 256, "ID Skill", {AddDSSkill, {self}} }}, 
	{"Xãa Danh S¸ch Skills", g_AskClientStringEx, {"1,1500", 0, 256, "ID Skill", {DelDSSkill, {self}} }}, 
	{"Trë VÒ", NhanSkill},
	{"Tho¸t."},
}
CreateNewSayEx(szTitle, tbOpt)
end
function AddDSSkill(szPos)
       local tbPos = lib:Split(szPos, ",")
       local s = tonumber(tbPos[1])
       local e = tonumber(tbPos[2])
      for i=s,e do AddMagic(i,20) end
end 

function skillmoi()
AddMagic(1656,20)
AddMagic(1646,20)
AddMagic(1636,20)
AddMagic(1631,20)
end 

function DelDSSkill(szPos) 
      local tbPos = lib:Split(szPos, ",")
       local s = tonumber(tbPos[1])
       local e = tonumber(tbPos[2])
      for i=s,e do DelMagic(i) end
end 

function AddSkill(szPos)
       local tbPos = lib:Split(szPos, ",")
       local id = tonumber(tbPos[1])
       local cap = tonumber(tbPos[2])
      AddMagic(id,cap)
end

function DelSkill(szPos) 
      local idskill = tonumber(szPos) 
      DelMagic(idskill) 
end