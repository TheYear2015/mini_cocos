-- 加载场景，处理资源加载，资源更新
local loadingScene = class("loadingScene", cc.load("mvc").ViewBase)


-- 资源
loadingScene.RESOURCE_FILENAME = "hall/scenes/loadingscene.csb"

function loadingScene:onCreate()
end

-- 开始进入
function loadingScene:onEnter()
end

-- 场景进入成功
function loadingScene:onEnterTransitionFinish()
    self:getConfig()
end

-- 更新时的回调
function loadingScene:updateCallBack(state, code)
    print("updateCallBack", tostring(state), tostring(code))
end

function loadingScene:getConfig()
    print("loadingScene:getConfig begin")
    -- 进行配置下载
    local appConfig = require("app.models.appConfig")
    local _params = {
        remoteUrls = {app.config.configURL, app.config.configURLNext},
        getConfigFromServer = app.config.getConfigFromServer,
    }

    appConfig.setParams(_params)

    local function callBack(isOk, data)
        print("getConfig", tostring(isOk))
        if isOk then
            -- 配置加载成功
            -- 进行更新
            local handle
            handle = self:getScheduler():scheduleScriptFunc(function()
                self:getScheduler():unscheduleScriptEntry(handle)
                local update = require("app.models.appUpdate")
                update.setParams(
                    {
                        downloadUrls = {app.config.scriptUpdateURL, app.config.scriptUpdateURL1},
                        needCheckHotUpdate = app.config.needCheckHotUpdate,
                        oldVersion = app.version,
                        newVersion = data.scriptVersion,
                        gameName = app.config.gameName,
                    }
                )
                update.doUpdate(function(state, code)self:updateCallBack(state, code) end)
            end, 1, false)

        else
            -- 配置加载失败
            -- TODO:
            -- 提示网络连接失败，点击后重新获取配置文件
            end
    end

    appConfig.getConfig(callBack)
end

return loadingScene
