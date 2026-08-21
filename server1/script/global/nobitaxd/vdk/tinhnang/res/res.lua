tbTaskTemp = {};

tbTaskTemp.ids = {
    checkRes = 199,
    checkResNpcValue = 200,
    checkResMantleValue = 201,
};

ModFunctionRes = {};

ModFunctionRes.type = {
    HEML = 1,
    ARMOR = 2,
    WEAPON = 3,
    HORSE = 4,
    NPC = 5,
    FIFENG = 6,
};

ModFunctionRes.data = {
    [ModFunctionRes.type.HEML] = {
        name = "ß«u - Kh´i",
    },
    [ModFunctionRes.type.ARMOR] = {
        name = "Th©n - Gi∏p",
    },
    [ModFunctionRes.type.WEAPON] = {
        name = "VÚ kh›",
    },
    [ModFunctionRes.type.HORSE] = {
        name = "Ng˘a",
    },
    [ModFunctionRes.type.NPC] = {
        name = "Npc - Boss - Kh∏c",
    },
    [ModFunctionRes.type.FIFENG] = {
        name = "Phi Phong",
    },
};

function ModFunctionRes:handleButton(isBack)
    local type = GetTaskTemp(tbTaskTemp.ids.checkRes);
    if (type == nil or type <= 0) then
        Msg2Player("Loπi ngoπi trang c«n ki”m tra kh´ng hÓp l÷, Æ∑ tho∏t ki”m tra.");
        return -1;
    end

    local step = 1;
    if (isBack == 1) then
        step = -1;
    end

    local charIdx = -1 - GetSex();
    local helm, armor, weapon, horse = GetPlayerFeature(PlayerIndex);
    local canChange = 0;
    local tempResId = -1;
    local mantleIdx = 0;

    if (type == ModFunctionRes.type.HEML) then
        helm = helm + step;
        tempResId = helm;
        canChange = self:canChange(helm);
    elseif (type == ModFunctionRes.type.ARMOR) then
        armor = armor + step;
        tempResId = armor;
        canChange = self:canChange(armor);
    elseif (type == ModFunctionRes.type.WEAPON) then
        weapon = weapon + step;
        tempResId = weapon;
        canChange = self:canChange(weapon);
    elseif (type == ModFunctionRes.type.HORSE) then
        horse = horse + step;
        tempResId = horse;
        canChange = self:canChange(horse);
    elseif (type == ModFunctionRes.type.NPC) then
        tempResId = GetTaskTemp(tbTaskTemp.ids.checkResNpcValue);
        tempResId = tempResId + step;
        canChange = self:canChange(tempResId);
    elseif (type == ModFunctionRes.type.FIFENG) then
        local tbEquips = GetAllEquipment();
        mantleIdx = tbEquips[13];
        if (mantleIdx > 0) then
            tempResId = GetTaskTemp(tbTaskTemp.ids.checkResMantleValue);
            if tempResId == nil then
                tempResId = -1;
            end
            tempResId = tempResId + step;
            canChange = self:canChange(tempResId);
        end
    end

    if (canChange == 1) then
        if (type == ModFunctionRes.type.NPC) then
            ChangeOwnFeature(0, 0, tempResId);
            SetTaskTemp(tbTaskTemp.ids.checkResNpcValue, tempResId);
        elseif (type == ModFunctionRes.type.FIFENG) then
            SetItemNewFeature(mantleIdx, tempResId);
            SetTaskTemp(tbTaskTemp.ids.checkResMantleValue, tempResId);
        else
            ChangeOwnFeature(0, -1, charIdx, helm, armor, weapon, horse);
        end
        Msg2Player("Ngoπi trang <color=green>" ..
            ModFunctionRes.data[type].name .. "<color> hi÷n tπi c„ id lµ: <color=yellow>" .. tempResId);
    else
        Msg2Player("Kh´ng tÂn tπi ngoπi trang loπi <color=green>" ..
            ModFunctionRes.data[type].name .. "<color> c„ id lµ: <color=yellow>" .. tempResId);
    end
end

function ModFunctionRes:canChange(resId)
    if (resId ~= nil and resId >= 0) then
        return 1;
    end
    return 0;
end

function ModFunctionRes:chooseOptionToCheck(type)
    if (type == nil or type <= 0) then
        type = ModFunctionRes.type.HEML;
    end

    SetTaskTemp(tbTaskTemp.ids.checkRes, type);
    local msg =
    "L≠u task ki”m tra ngoπi trang Î id <color=green>%d<color>. Ngoπi trang c«n ki”m tra lµ <color=yellow>%d<color> - <color=yellow>%s<color>.";
    Msg2Player(format(msg, tbTaskTemp.ids.checkRes, type, ModFunctionRes.data[type].name));

    if (type == ModFunctionRes.type.NPC) then
        local defaultValue = -1;
        SetTaskTemp(tbTaskTemp.ids.checkResNpcValue, defaultValue);
        local msgNpc =
        "L≠u gi∏ trﬁ hi÷n tπi cho ki”m tra NPC Î task <color=green>%d<color>. Gi∏ trﬁ hi÷n tπi lµ <color=yellow>%d<color>.";
        Msg2Player(format(msgNpc, tbTaskTemp.ids.checkResNpcValue, defaultValue));
    end
end

function ModFunctionRes:no()
    RestoreOwnFeature();
    SetTaskTemp(tbTaskTemp.ids.checkRes, nil);
    SetTaskTemp(tbTaskTemp.ids.checkResNpcValue, nil);

    local tbEquips = GetAllEquipment();
    local mantleIdx = tbEquips[13];
    if (mantleIdx > 0) then
        SetItemNewFeature(mantleIdx, -1);
    end
    SetTaskTemp(tbTaskTemp.ids.checkResMantleValue, nil);
end
