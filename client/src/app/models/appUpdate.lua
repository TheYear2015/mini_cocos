-- app 更新逻辑
module(..., package.seeall)

local _params = {
    downloadUrls = {},
    needCheckHotUpdate = true,
    oldVersion = "0.0",
    newVersion = "0.0",
    gameName = "",
}


local _updatePath = cc.FileUtils:getInstance():getWritablePath() .. "/update/"

-- 获得更新文件的目录
function updatePath()
    return _updatePath
end

-- 获得更新文件的版本号
function updateDataVersion()
    local updateVersion = cc.FileUtils:getInstance():getStringFromFile(_updatePath .. "app/_version")
    return updateVersion
end

-- 版本号比较 -1 left < right, 0 right == left, 1 left > right
function versionCompare(left, right)
    local lefts = string.split(left, ".")
    local rights = string.split(right, ".")
    local allL = math.max(#lefts, #rights)
    for i = 1, allL do
        local l = 0
        local r = 0
        if lefts[i] ~= nil then
            l = tonumber(lefts[i])
            l = l or 0
        end
        if rights[i] ~= nil then
            r = tonumber(rights[i])
            r = r or 0
        end
        if l < r then
            return -1
        end
        if l > r then
            return 1
        end
    end
    return 0
end

local isAddUpdatePath = false

-- 追加update目录
function addUpdatePath()
    if isAddUpdatePath then
        return
    end
    isAddUpdatePath = true
    cc.FileUtils:getInstance():addSearchPath(updatePath())
    cc.FileUtils:getInstance():addSearchPath(updatePath() .. "res")
end

-- 设置参数
function setParams(params)
    for k, v in pairs(_params) do
        if _params[k] then
            _params[k] = params[k]
        end
    end
end

-- 增量更新的url
local function getPatchUrl(gamename, oldVersion, newVersion, rootUrl)
    return rootUrl .. newVersion .. "/" .. gamename .. "_" .. oldVersion .. ".zip"
end

-- 全部更新的url
local function getFullPatchUrl(gamename, newVersion, rootUrl)
    return rootUrl .. newVersion .. "/" .. gamename .. "_" .. newVersion .. ".zip"
end

local function onError(errorCode, onResult)
    print("errorCode = " .. errorCode)
    local CREATE_FILE = 0
    local NETWORK_ERROR = 1
    local NO_NEW_VERSION = 2
    local UNCOMPRESS = 3
    onResult(-1, errorCode)
end

local function onProgress(percent, onResult)
    if percent <= 0 then percent = 0 end
    print("downloading percent = " .. percent)
    onResult(2, percent)
end

local function onSuccess(onResult)
    print("download and install ok")

    -- 设置版本号
    local updateVersion = cc.FileUtils:getInstance():getStringFromFile(_updatePath .. "app/version")
    local filePath = _updatePath .. "app/_version"
    local file = io.open(filePath, "w+")
    file:write(updateVersion)
    file:close()
    app.version = updateDataVersion()
    -- 修改 search path
    addUpdatePath()

    onResult(1)
end

local function downloadPacthFile(callBack, fileUrl, savePatch)
    local assetsManager = nil
    local function getAssetsManager()
        if nil == assetsManager then
            print("fileUrl = " .. fileUrl)
            assetsManager = cc.AssetsManagerFJ:new(fileUrl, _updatePath)
            assetsManager:retain()
            assetsManager:setDelegate(function(code)
                onError(code, callBack)
            end, 2)
            assetsManager:setDelegate(function(percent)
                onProgress(percent, callBack)
            end, 0)
            assetsManager:setDelegate(function()
                onSuccess(callBack)
            end, 1)
            assetsManager:setConnectionTimeout(3)
        end
        return assetsManager
    end
    getAssetsManager():doUpdate()
end

-- 执行更新
function doUpdate(callBack)
    print("doUpdate")
    if not _params.needCheckHotUpdate then
        -- 不需要更新
        callBack(0)
        return
    end

    -- 比较版本
    if versionCompare(_params.oldVersion, _params.newVersion) >= 0 then
        -- 不需要更新
        callBack(0)
        return
    end

    if not cc.FileUtils:getInstance():isDirectoryExist(_updatePath) then
        cc.FileUtils:getInstance():createDirectory(_updatePath)
    end

    local patchUrls = {}
    for i = 1, #_params.downloadUrls do
        local updateUrl = getPatchUrl(_params.gameName, _params.oldVersion, _params.newVersion, _params.downloadUrls[i])
        local fullUpdateUrl = getFullPatchUrl(_params.gameName, _params.newVersion, _params.downloadUrls[i])
        if not table.indexof(patchUrls, updateUrl) then
            patchUrls[#patchUrls + 1] = updateUrl
        end
        if not table.indexof(patchUrls, fullUpdateUrl) then
            patchUrls[#patchUrls + 1] = fullUpdateUrl
        end
    end

    local i = 1
    local function _call(state, data)
        if state == -1 then
            if i == #patchUrls then
                callBack(state, data)
            else
                i = i + 1
                local scheduler = require("app.framework.scheduler")
                scheduler.performWithDelayGlobal(function()
                    downloadPacthFile(_call, patchUrls[i], _updatePath)
                end, 1)
            end
        else
            callBack(state, data)
        end
    end

    downloadPacthFile(_call, patchUrls[i], _updatePath)

end
