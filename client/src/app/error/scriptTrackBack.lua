-- 脚本错误回调
local mT = {}
local dataMgr

function mT.trackBack(msg)
    local logUpload = require("app.models.infoLog")
    local userID = 0
    if dataMgr ~= nil then
        userID = dataMgr.userId or 0
    end
    msg = string.format("%s\nlua memory %s K", msg, tostring(collectgarbage("count")))
    logUpload.sendInfo(logUpload.infoCode.scriptError, msg, userID)
    local pathRoot
    local targetPlatform = cc.Application:getInstance():getTargetPlatform()
    if targetPlatform == cc.PLATFORM_OS_ANDROID then
        local bridge = require("app.framework.Bridge")
        pathRoot = bridge.getExternalStorageDirectory()
        if pathRoot ~= nil then
            print("android storagePath:", pathRoot)
        else
            print("getExternalStorageDirectory failed")
        end
    elseif targetPlatform == cc.PLATFORM_OS_WINDOWS then
        local pathRoot = cc.FileUtils:getInstance():getWritablePath()
        if pathRoot ~= nil then
            print("windows writable path:", pathRoot)
        end
    end

    if pathRoot ~= nil then
        local file = io.open(pathRoot .. "/dzpk2Log.txt", "a+")
        file:write("\n----------------------------------------")
        local time = os.date("%Y-%m-%d %H:%M:%S")
        file:write("\n" .. time .. "\n")
        file:write("LUA ERROR: " .. msg .. "\n")
        file:write("\n----------------------------------------")
        file:close()
    end

    if targetPlatform == cc.PLATFORM_OS_WINDOWS then
        cc.Director:getInstance():endToLua()
    end

end

return mT
