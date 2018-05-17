-- project 相关配置
module(..., package.seeall)
local _appConf = require("app.project.app_config")
local _gameConf = require("app.project.game_config")

-- 设置数据
function set(t, param)
    _appConf.set(t, param)
    _gameConf.set(t, param)
end
