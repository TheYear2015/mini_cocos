-- app 的配置
module(..., package.seeall)

local json = require("app.framework.json")

local _params = {
    remoteUrls = {},
    getConfigFromServer = true,
}

-- 存储配置到本地
local function saveConfigString(strContent)
    local filePath = cc.FileUtils:getInstance():getWritablePath() .. "app_config"
    local file = io.open(filePath, "w+")
    if file then
        file:write(strContent)
        file:close()
    end
end

-- 读取本地配置
local function readConfigString()
    local strContent = ""
    local filePath = cc.FileUtils:getInstance():getWritablePath() .. "app_config"
    if cc.FileUtils:getInstance():isFileExist(filePath) then
        strContent = cc.FileUtils:getInstance():getStringFromFile(filePath)
    end
    return strContent
end


local function onFailed(status)
    local logUpload = require("app.models.infoLog")
    logUpload.sendInfo(logUpload.infoCode.getAppInfoError, "获取配置文件失败，statues:" .. (status or "nil") .. " 0", 0)
end

-- 从远端获得配置
local function getConfigFromServer(url, callBack)
    print("-------- getConfigFromServer --------- ", url)
    if url == "" then
        callBack(false, {})
        return
    end
    local handled = false
    local httpUtil = require("app.framework.HttpUtils")
    httpUtil.reqHttp(url, function(ret, response, status)
        if handled then
            return
        end
        handled = true
        if ret and response then
            local data = json.decode(response)
            if data ~= nil then
                saveConfigString(response)
                print("getConfigFromServer ok")
                callBack(true, data)
            else
                onFailed(status)
                callBack(false, {})
            end
        else
            onFailed(status)
            callBack(false, {})
        end
    end, false)
end

-- 设置配置
function setParams(params)
    for k, v in pairs(_params) do
        if _params[k] then
            _params[k] = params[k]
        end
    end
end

-- 获得配置
function getConfig(callBack)
    local cf
    local strContent = readConfigString()
    if strContent then
        cf = json.decode(strContent)
    else
        cf = {}
    end

    if (not _params.getConfigFromServer) or (not _params.remoteUrls) or (#_params.remoteUrls == 0) then
        callBack(true, cf)
        return
    end

    local i = 1
    local function _call(isSuccess, data)
        if isSuccess then
            callBack(isSuccess, data)
        else
            if i == #_params.remoteUrls then
                callBack(false, cf)
            else
                i = i + 1
                getConfigFromServer(_params.remoteUrls[i], _call)
            end
        end
    end
    getConfigFromServer(_params.remoteUrls[i], _call)

end
