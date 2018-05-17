local MyAppClass = class("MyApp", cc.load("mvc").AppBase)

require("app.framework.tableEx")

function MyAppClass:onCreate()
    math.randomseed(os.time())
end

local MyApp = {}

-- device
MyApp.device = require("app.framework.device")

-- 配置
MyApp.config = require("app.config").get()

-- project配置
local project = require("app.project")
local projectCfg = require("app.project.config")
projectCfg.set(MyApp.config, project)

-- 加载自定义配置
local myConfig = require("app.MyConfig")
table.merge(MyApp.config, myConfig)

-- 获得的初始版本号
MyApp.version = cc.FileUtils:getInstance():getStringFromFile("app/version")

-- 获得更新下来的版本号
local update = require("app.models.appUpdate")
updateVersion = update.updateDataVersion()

local r = update.versionCompare(MyApp.version, updateVersion)
if r <= 0 then
    -- 追加update目录
    update.addUpdatePath()
    if updateVersion and updateVersion ~= "" then
        MyApp.version = updateVersion
    end
else
end

-- 开始
function MyApp.start(configs)
    MyApp.instance = MyAppClass:create(appConfig)
    MyApp.instance:run()
end

-- MyApp 全局访问入口
app = MyApp

return MyApp
