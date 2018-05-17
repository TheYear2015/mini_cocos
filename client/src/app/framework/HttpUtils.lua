local httpUtils = {}

function httpUtils.reqHttp(strUrl, callBack, isPost)

    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = 4 --貌似无用

    local reqType = "GET"
    if isPost then
        reqType = "POST"
    end
    xhr:open(reqType, strUrl)
    local bDone = false
    local function onResult()
        if xhr.readyState == 4 and (xhr.status == 200 or xhr.status == 302) then
            callBack(true, xhr.response, xhr.status)
        else
            callBack(false, nil, xhr.status)
        end
    end
    xhr:registerScriptHandler(onResult)
    xhr.timeout = 10
    xhr:send()

    return xhr
end

function httpUtils.reqHttpUploadBlob(strUrl, dataName, data, callBack)
    release_print("httpUtils.reqHttpUploadBlob begin " .. strUrl)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = 4 -- cc.XMLHTTPREQUEST_RESPONSE_JSON

    xhr:open("POST", strUrl)
    local function onResult()
        release_print("httpUtils.reqHttpUploadBlob onResult")
        -- release_print(" "..xhr.readyState.." "..xhr.status.." "..xhr.response)
        if xhr.readyState == 4 and (xhr.status == 200 or xhr.status == 302) then
            callBack(true, xhr.response, xhr.status)
        else
            callBack(false, nil, xhr.status)
        end
    end

    local boundary = "----WebKitFormBoundyndaryEm5WNw6Bg6hGiQUB"

    xhr:setRequestHeader("Accept", "*/*")
    xhr:setRequestHeader("accept-encoding", "gzip, deflate")
    xhr:setRequestHeader("Content-Type", "multipart/form-data; boundary=" .. boundary)

    xhr:registerScriptHandler(onResult)
    xhr.timeout = 10
    local str = "\r\n--" .. boundary .. "\r\n" .. "Content-Disposition: form-data; name=\"file\"; filename=\"" .. dataName .. "\"\r\n" .. "Content-Type: application/octet-stream\r\n\r\n" .. data .. "\r\n--" .. boundary .. "--\r\n"
    xhr:send(str)
    release_print("httpUtils.reqHttpUploadBlob end")
    return xhr
end

function httpUtils.reqHttpBlob(strUrl, callBack, postData)
    release_print("httpUtils.reqHttpBlob begin " .. strUrl)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = 4 -- cc.XMLHTTPREQUEST_RESPONSE_JSON

    if postData then
        xhr:open("POST", strUrl)
    else
        xhr:open("GET", strUrl)
    end
    local function onResult()
        release_print("httpUtils.reqHttpBlob onResult")
        -- release_print(" "..xhr.readyState.." "..xhr.status.." "..xhr.response)
        if xhr.readyState == 4 and xhr.status == 200 or xhr.status == 302 then
            callBack(true, xhr.response, xhr.status)
        else
            callBack(false, nil, xhr.status)
        end
    end

    xhr:registerScriptHandler(onResult)
    xhr.timeout = 10

    if postData then
        xhr:send(postData)
    else
        xhr:send()
    end

    return xhr
end

function httpUtils.reqHttpJson(strUrl, callBack, postData)
    release_print("httpUtils.reqHttpJson begin " .. strUrl)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = 4 -- cc.XMLHTTPREQUEST_RESPONSE_JSON

    if postData then
        xhr:setRequestHeader("Content-Type", "application/json")
        xhr:open("POST", strUrl)
    else
        xhr:open("GET", strUrl)
    end
    local function onResult()
        -- release_print(" "..xhr.readyState.." "..xhr.status.." "..xhr.response)
        if xhr.readyState == 4 and xhr.status == 200 or xhr.status == 302 then
            callBack(true, xhr.response, xhr.status)
        else
            callBack(false, nil, xhr.status)
        end
    end

    xhr:registerScriptHandler(onResult)
    xhr.timeout = 10

    if postData then
        xhr:send(postData)
    else
        xhr:send()
    end

    return xhr
end

return httpUtils
