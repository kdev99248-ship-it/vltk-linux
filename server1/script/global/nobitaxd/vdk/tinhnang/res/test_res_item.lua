IncludeLib("FILESYS");
IncludeLib("SETTING");
IncludeLib("ITEM");

Include("\\script\\dailogsys\\dailogsay.lua");
Include("\\script\\dailogsys\\g_dialog.lua");
Include("\\script\\lib\\common.lua");
Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\activitysys\\playerfunlib.lua");
Include("\\script\\activitysys\\functionlib.lua");

Include("\\script\\global\\nobitaxd\\vdk\\tinhnang\\res\\res.lua");

function kiemtrares()
    local title = "Ng­¬i muèn kiÓm tra ngo¹i trang lo¹i nµo?";
    local options = {};

    for index, value in ModFunctionRes.data do
        tinsert(options, { value.name, ModFunctionRes.chooseOptionToCheck, { ModFunctionRes, index } });
    end

    tinsert(options, { "Hñy", ModFunctionRes.no, { ModFunctionRes } });
    CreateNewSayEx(title, options);
    return 1;
end
