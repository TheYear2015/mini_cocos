cc.FileUtils:getInstance():setPopupNotify(false)
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("src/res")

require("config")
require("cocos.init")

-- 配置
local appConfig =
    {
        viewsRoot = {"app.views", "app.game.scenes"},
        modelsRoot = "app.models",
        defaultSceneName = "MainScene",
    }
--

-- cclog
local cclog = function(...)
    release_print(string.format(...))
end

-- main
local function main()
    require("app.MyApp").start(appConfig)
end

--for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    local msg = string.format("%s\n%s", tostring(msg), debug.traceback())
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. msg .. "\n")
    cclog("----------------------------------------")

    --local errProc = require("app.error.scriptTrackBack")
    if errProc then
        errProc.trackBack(msg)
    else
        cclog("errProc is nil.")
    end
    return msg
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
