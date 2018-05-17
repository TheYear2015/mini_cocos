-- 游戏功能相关配置
module(..., package.seeall)

local config = {
    [1] = {
        -- 正式版配置
        noticeURL = "http://192.168.1.237/api/GNotice/QueryNotices",
        refereeUrl = "http://192.168.1.237/api/guser/AgentBinding",
        rouletteUrl = "http://192.168.1.55:81/api/Draw",
    },
    [2] = {
        -- 外网测试配置
        noticeURL = "http://192.168.1.237/api/GNotice/QueryNotices",
        refereeUrl = "http://192.168.1.237/api/guser/AgentBinding",
        rouletteUrl = "http://192.168.1.55:81/api/Draw",
    },
    [3] = {
        -- 内网配置
        noticeURL = "http://192.168.1.237/api/GNotice/QueryNotices",
        refereeUrl = "http://192.168.1.237/api/guser/AgentBinding",
        rouletteUrl = "http://192.168.1.55:81/api/Draw",
    },
}

-- 设置数据
function set(t, param)
    if not param then
        param = 1
    end
    local __p = config[param]
    table.merge(t, __p)
end
