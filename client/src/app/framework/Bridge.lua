-- 引用的局部变量
local display = display
local string = string
local app = app

local bridge = {}
local targetPlatform = cc.Application:getInstance():getTargetPlatform()
local luaj
local luaoc
local httpUtil = require("app.framework.HttpUtils")

if cc.PLATFORM_OS_ANDROID == targetPlatform then
    luaj = require("cocos.cocos2d.luaj")
end
if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
    luaoc = require("cocos.cocos2d.luaoc")
end

local javaClassName = "org/cocos2dx/lua/AppActivity"
local iosClassName = "CallOC"

bridge.returnFlag = {
    Ok = 0,
    MethodNotFound = -1, -- 版本错误
    RunError = -2,  -- 执行失败
}

bridge.appInfo = nil

function bridge.getAppInfo()
    if not bridge.appInfo then
        local versionCode = 0
        local methodName = "getAppInfo"
        if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
            local ok, ret = luaoc.callStaticMethod(iosClassName, methodName)
            if ok then
                ret.app_build = ret.app_build or "1"
                ret.app_version = ret.app_version or "1.0"
                print("app_build = " .. ret.app_build)
                print("app_version = " .. ret.app_version)
                bridge.appInfo = ret
            end
        elseif cc.PLATFORM_OS_ANDROID == targetPlatform then
            local args = {}
            local sig = "()Ljava/lang/String;"
            local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sig)
            if ok then
                print("getAppInfo:" .. ret)
                ret = tostring(ret)
                print("getAppInfo:" .. ret)
                local data = loadstring("return " .. ret)
                ret = data()
                print("app_build = " .. ret.app_build)
                print("app_version = " .. ret.app_version)
                bridge.appInfo = ret
            end
        else
            bridge.appInfo = {app_version = "1.0", app_build = 1}
        end
    end
    return bridge.appInfo
end

function bridge.playPhoneShock()
    local methodName = "playPhoneShock"
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName)
        if not ok then
            print("------------IOS shock fail")
        end
    elseif cc.PLATFORM_OS_ANDROID == targetPlatform then
        local args = {}
        local sig = "()V"
        local ok, ret = luaj.callStaticMethod(className, methodName, args, sig)
        if not ok then
            print("------------Android shock fail")
        end
    else
        print("------------win32 shock")
    end
end

function bridge.isWeChatInstalled()
    local methodName = "isWeChatInstalled"
    print(methodName)
    local sig = "()Z"
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local args = {}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sig)
        if not ok then
            print("------------Android isWeChatInstalled fail")
        else
            return ret
        end
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = {}
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName)
        if not ok then
            print("------------IOS isWeChatInstalled fail")
        else
            return ret
        end
    end
end

function bridge.isWeChatAPISupported()
    local methodName = "isTimeLineSupported"
    print(methodName)
    local sig = "()Z"
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local args = {}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sig)
        if not ok then
            print("------------Android isWeChatAPISupported fail")
        else
            return ret
        end
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        return true
    end
end

local function callBackShareToWeChat(result)
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        print("callBackShareToWeChat, string from JAVA:" .. result)
        local data = loadstring("return " .. result)
        data = data()
        print("type=" .. data.type .. ",result=" .. data.result)
        display:getRunningScene().root.eventProtocol:dispatchEvent({name = "SHARE_TO_WECHAT_RESULT", data = data})
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local data = result
        print("type=" .. data.type .. ",result=" .. data.result)
        display:getRunningScene().root.eventProtocol:dispatchEvent({name = "SHARE_TO_WECHAT_RESULT", data = data})
    end
end

function bridge.shareToWeChat(scene, strTitle, strContent, strUrl, img)
    local methodName = "shareToWeChat"
    print(methodName)
    local sig = "(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V"
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local args = {scene, strTitle, strContent, strUrl, img, callBackShareToWeChat}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sig)
        if not ok then
            print("------------Android shareToWeChat fail")
        end
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = {}
        args.scene = scene
        args.title = strTitle
        args.content = strContent
        args.url = strUrl
        args.imagepath = img
        args.listener = callBackShareToWeChat
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS shareToWeChat fail")
        end
    end
end

function bridge.shareToWeChatImg(scene, strTitle, strContent, img)
    local methodName = "sendImageToWeiXinScene"
    print(methodName)
    local sig = "(ILjava/lang/String;Ljava/lang/String;)V"
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local args = {scene, strTitle, strContent}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sig)
        if not ok then
            print("------------Android shareToWeChatImg fail")
        end
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = {}
        args.scene = scene
        args.title = strTitle
        args.content = strContent
        args.img = img
        args.listener = callBackShareToWeChat
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS shareToWeChat fail")
        end
    end
end

local function callBackLoginWithWeChat(result)
    release_print(result)
    display:getRunningScene().root.eventProtocol:dispatchEvent({name = "ON_WECHAT_LOGIN_RESULT", data = result})
end

local function callBackLoginWithToken(result)
    release_print(result.result)
    if result.result == "failed" then
        display:getRunningScene().root.eventProtocol:dispatchEvent({name = "ON_WECHAT_LOGIN_RESULT", data = result.result})
    else
        --app.msgBox.show(result.result)
        httpUtil.reqHttp(result.result, function(ret, response)
            if ret then
                local json = require "app.framework.json"
                local data = json.decode(response)
                callBackLoginWithToken2(data)
            else
                app.msgBox.show("get Token failed")
                app.holdOn.hide()
            end
        end, false)
    end
end

function callBackLoginWithToken2(data)
    local url = "https://api.weixin.qq.com/sns/userinfo?access_token=" .. data.access_token .. "&openid=" .. data.openid
    --app.msgBox.show(url)
    httpUtil.reqHttp(url, function(ret, response)
        if ret then
            --release_print(response)
            local json = require "app.framework.json"
            local newdata = json.decode(response)
            newdata.refreshToken = data.refresh_token
            display:getRunningScene().root.eventProtocol:dispatchEvent({name = "ON_WECHAT_LOGIN_RESULT", data = json.encode(newdata)})
        else
            app.msgBox.show("get userinfo failed")
            app.holdOn.hide()
        end
    end, false)
end

function checkRefreshToken(refreshToken)
    local url = "https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=" .. "wx20faa33fe5dceaaa" .. "&refresh_token=" .. refreshToken .. "&grant_type=" .. "refresh_token"
    --app.msgBox.show(url)
    httpUtil.reqHttp(url, function(ret, response)
        if ret then
            --release_print(response)
            local json = require "app.framework.json"
            local data = json.decode(response)
            if data.openid ~= nil then
                callBackLoginWithToken2(data)
            else
                bridge.loginWithWeChat("")
            end
        else
            bridge.loginWithWeChat("")
        end
    end, false)
end


function bridge.loginWithWeChat(refreshToken)
    local methodName = "loginWithWeChat"
    release_print(methodName)
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        if refreshToken == nil or refreshToken == "" then
            local sig = "(I)V"
            local args = {callBackLoginWithWeChat}
            local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sig)
            if not ok then
                print("------------Android loginWithWeChat fail")
            end
        else
            local sig = "(Ljava/lang/String;I)V"
            local args = {refreshToken, callBackLoginWithWeChat}
            local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sig)
            if not ok then
                print("------------Android loginWithWeChat fail")
            end
        end
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        if refreshToken == "" then
            local args = {}
            args.listener = callBackLoginWithToken
            local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
            if not ok then
                print("------------IOS callBackLoginWithToken fail")
            end
        else
            checkRefreshToken(refreshToken)
        end
    end
end

function bridge.getExternalStorageDirectory()
    local methodName = "getExternalStorageDirectory"
    print(methodName)
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local sign = "()Ljava/lang/String;"
        local args = {}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sign)
        if not ok then
            print("------------Android getExternalStorageDirectory fail")
        end
        return ret
    end
end

function bridge.callPhone(strPhone)
    local methodName = "callPhone"
    print(methodName)
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local sign = "(Ljava/lang/String;)V"
        local args = {strPhone}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sign)
        if not ok then
            print("------------Android callPhone fail")
        end
        return ret
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = {["strPhone"] = strPhone}
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        return ret
    end
end

function bridge.updateApplication()
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local methodName = "doNewVersionUpdate"
        local sign = "(Ljava/lang/String;)Ljava/lang/String;"
        local args = {app.configURL .. "twoseventen.apk"}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sign)
        if not ok then
            print("------------Android doNewVersionUpdate fail")
        end
        return ret
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local strUrl = "https://itunes.apple.com/cn/app/fu-le-si-chuan-xue-zhan-ma-jiang/id1023662786?mt=8"
        bridge.openAppStore(strUrl)
    end
end

--[[/******************************
* @bief	修改屏幕的方式
* @param
* @return
* @notify 	-1-unspecified:默认值; 0-landscape:横屏; 1-portrait:竖屏; 2-user:当前首选方向;
* 			3-behind:在activity堆栈中和下面的一致; 4-sensor:由感应器决定; 5-nosensor:忽略感应器;
*********/]]
function bridge.setScreenOrientation(dir)
    if cc.PLATFORM_OS_ANDROID == targetPlatform then

        -----------------------------
        local view = cc.Director:getInstance():getOpenGLView()
        local plat = cc.Application:getInstance():getTargetPlatform()
        if bridge.getScreenOrientation() ~= dir then
            local winSz = view:getFrameSize()
            view:setFrameSize(winSz.height, winSz.width)
        end
        ---------------------------------------------
        local methodName = "setScreenOrientation"
        local sign = "(I)V"
        local args = {dir}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sign)
        if not ok then
            print("------------Android setScreenOrientation fail")
        else
            return ret
        end

    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local methodName = "setScreenOrientation"
        local args = {dir = dir}
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS setScreenOrientation fail")
        else
            return ret
        end

    else
        end
end

--- 获取屏幕朝向方式
function bridge.getScreenOrientation()
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local methodName = "getScreenOrientation"
        local sign = "()I"
        local args = {}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sign)
        if not ok then
            print("------------Android getScreenOrientation fail")
        else
            return ret
        end

    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local methodName = "getScreenOrientation"
        local args = {}
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS getScreenOrientation fail")
        else
            return ret
        end

    else
        return CC_DESIGN_RESOLUTION.orientation
    end
end

function bridge.restartApplication()
    if cc.PLATFORM_OS_ANDROID == targetPlatform then
        local methodName = "restartApplication"
        local sign = "()V"
        local args = {}
        local ok, ret = luaj.callStaticMethod(javaClassName, methodName, args, sign)
        if not ok then
            print("------------Android restartApplication fail")
        end
        return ret
    elseif (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then

    end
end

function bridge.openAppStore(url)
    local methodName = "openAppStore"
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = {}
        print(methodName .. " " .. url)
        args.url = url
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS open app store failed")
        end
    end
end


local function callBackPay(result)
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        print("callBackPay, result:"..result.userId..result.transActionId..result.receiptData)
        cc.shopLogic:checkConfidenceInfo(result.userId, result.transActionId, result.receiptData)
    end
end

function bridge.IOSPay(productId)
    local methodName = "IOSPay"
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = {}
        args.productId = productId
        args.listener = callBackPay
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS pay fail")
        end
    end
end

function bridge.setIOSPayCallBack()
    local methodName = "setCallBackPay"
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = {}
        args.listener = callBackPay
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IsetCallBackPay fail")
        end
    end
end

function bridge.setCurrUserId(userId)
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        bridge.setIOSPayCallBack()
        local methodName = "iosSetCurrUserId"
        local args = {}
        args.userId = userId
        print("userId:"..userId)
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS set userId failed")
        end
    end
end

function bridge.onIOSRechargeResult(result)
    local methodName = "onIOSRechargeResult"
    if (cc.PLATFORM_OS_IPHONE == targetPlatform) or (cc.PLATFORM_OS_IPAD == targetPlatform) then
        local args = result
        args.currUserId = result.userId
        local ok, ret = luaoc.callStaticMethod(iosClassName, methodName, args)
        if not ok then
            print("------------IOS set userId failed")
        end
    end
end

return bridge
