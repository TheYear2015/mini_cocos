-- 初始配置
local config = {}

local configD = {

        -- 游戏名
        gameName = "dzpk2",

        isDebug = false,

        -- 是否需要进行热更新检查
        needCheckHotUpdate = true,

        -- 是否进行app引擎检查
        needCheckAppUpdate = true,

        -- 需要从远端下载配置
        getConfigFromServer = true,

        -- apple store id
        appStoreId = "1023662786",

        -- 配置文件地址1
        configURL = "http://116.211.169.120:18080/twoseventen/app_config.json",

        -- 配置文件地址2
        configURLNext = "http://tsconfig.fljoy.net:18080/twoseventen/app_config.json",

        -- 更新地址1
        scriptUpdateURL = "http://dtsupdate.fljoy.net/twoseventen/",

        -- 更新地址2
        scriptUpdateURL1 = "http://tsupdate.fljoy.net/twoseventen/",

}

function config.get()
    return table.deepcopy(configD)
end

return config
