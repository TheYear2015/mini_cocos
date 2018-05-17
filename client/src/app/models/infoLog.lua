-- 信息系统
module(..., package.seeall)

local device = require("app.framework.device")
local openUDID = device.getOpenUDID()
local bridge = require("app.framework.Bridge")
local json = require("app.framework.json")
local httpUtils = require("app.framework.HttpUtils")
-- local urlAddress = "http://192.168.1.237/api/services/app/message/Post"
local urlAddress = "http://msg.fljoy.net/api/services/app/message/post"
-- local urlAddress = "http://118.123.213.240:82/api/services/app/message/post"

-- 信息编码
infoCode = {
    connectServerOK = 2, -- 连接服务器成功
    scriptError = -1, -- 脚本异常
    getAppInfoError = -2, -- 获取配置文件失败
    getVersionInfo = -3, -- 获取版本文件失败
    getWechatInfoError = -4, -- 微信验证错误
    connectServerFailed = -5, -- 连接服务器失败
    checkISPFailed = -6, -- 检查运营商失败
}

local function getTime()
    return os.date("%Y-%m-%d %H:%M:%S")
end

local function formatPostData(code, info, userId)

    local t = {}
    t.sendTime = getTime();
    t.gameKey = "dzpk2"
    t.deviceNumber = openUDID
    t.clientVersion = string.format("version:%s/%s/%s", bridge.getAppInfo().app_version, bridge.getAppInfo().app_build, g_scriptVersion)
    t.userId = userId
    t.code = code
    t.desc = info

    return json.encode(t)

end

local preTime = 0

-- 发送信息
function sendInfo(code, info, userId)

    local nowTime = os.time()
    if preTime + 10 > nowTime then
        return
    end
    preTime = nowTime

    local postString = formatPostData(code, info, userId)

	local xhr = cc.XMLHttpRequest:new()
	xhr.responseType = 4 -- cc.XMLHTTPREQUEST_RESPONSE_JSON

	xhr:open("POST", urlAddress)

	local function onResult(msg)

    end

    xhr:setRequestHeader("Content-Type", "application/json")
    xhr:registerScriptHandler(onResult)
    xhr.timeout = 10

    xhr:send(postString)
    -- print("info is sent, msg:"..postString)
end
