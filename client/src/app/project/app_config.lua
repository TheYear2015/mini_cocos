-- app相关配置文件
module(..., package.seeall)

local config = {
    [1] = {
        -- 正式版配置
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
        configURL = "http://192.168.1.238:8080/game/dzpk2/app_config.json",

        -- 配置文件地址2
        configURLNext = "http://192.168.1.238:8080/game/dzpk2/app_config.json",

        -- 更新地址1
        scriptUpdateURL = "http://192.168.1.238:8080/game/dzpk2/update/",

        -- 更新地址2
        scriptUpdateURL1 = "http://192.168.1.238:8080/game/dzpk2/update/",
    },
    [2] = {
        -- 外网测试配置
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
        configURL = "http://192.168.1.238:8080/game/dzpk2/app_config.json",

        -- 配置文件地址2
        configURLNext = "http://192.168.1.238:8080/game/dzpk2/app_config.json",

        -- 更新地址1
        scriptUpdateURL = "http://192.168.1.238:8080/game/dzpk2/update/",

        -- 更新地址2
        scriptUpdateURL1 = "http://192.168.1.238:8080/game/dzpk2/update/",
    },
    [3] = {
        -- 内网配置
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
        configURL = "http://192.168.1.238:8080/game/dzpk2/app_config.json",

        -- 配置文件地址2
        configURLNext = "http://192.168.1.238:8080/game/dzpk2/app_config.json",

        -- 更新地址1
        scriptUpdateURL = "http://192.168.1.238:8080/game/dzpk2/update/",

        -- 更新地址2
        scriptUpdateURL1 = "http://192.168.1.238:8080/game/dzpk2/update/",
    },
}

-- 设置数据
function set(t, param)
    param = param or 1
    local __p = config[param]
    table.merge(t, __p)
end
