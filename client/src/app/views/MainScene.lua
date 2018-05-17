
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

-- MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()
    printf("resource node = %s", tostring(self:getResourceNode()))

    --- [[ you can create scene with following comment code instead of using csb file.
    -- add background image
    display.newSprite("hall/images/back/loading.jpg")
        :move(display.center)
        :addTo(self)

    display.newSprite("hall/images/back/logo.png")
        :move(display.center)
        :addTo(self)
    --]]
end

-- 场景进入成功
function MainScene:onEnterTransitionFinish()
    require("app.MyApp").instance:enterScene("loadingScene", "FADE", 0.5)
end

return MainScene
