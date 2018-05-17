local SceneSwitcher = class("SceneSwitcher")
local scheduler = require("framework.scheduler")

local _lastPlayingGame = ""
local dataMgr = app.dataMgr

function SceneSwitcher:ctor()
	self.viewFlag = nil
end

function SceneSwitcher:unloadgameres()
	if dataMgr.playingGame == "scmj" then
		if _lastPlayingGame == "twoseventen" then
			local resHelper = require("ResHelper")
			resHelper.removeSpriteFrames()
			resHelper.removeAudio()
			--print("unload 2710")
		end
	elseif dataMgr.playingGame == "twoseventen" then
		if _lastPlayingGame == "scmj" then
			local gameModuleName = "hall.src." .. _lastPlayingGame
  			local gameEntry = require(gameModuleName .. ".entry")
    		gameEntry.UnLoadGame()
			--print("unload scmj")
		end
	end
end

function SceneSwitcher:enterScene(sceneName)
	---[[
	dataMgr.playingGame = "twoseventen"
	self:unloadgameres()

	_lastPlayingGame = dataMgr.playingGame
	collectgarbage("collect")
	--]]
	print("enterScene is " ..sceneName)
	cc.sceneTransFini = false
	require("app.MyApp"):create({viewsRoot = "hall/src/app/views"}):enterScene(sceneName, "FADE", 0.5)
end

function SceneSwitcher:enterGameScene()
	self:unloadgameres()
	collectgarbage("collect")
	_lastPlayingGame = dataMgr.playingGame
	cc.sceneTransFini = false
	if dataMgr.playingGame == "scmj" then

		local gameModuleName = "hall.src." .. dataMgr.playingGame
  		local gameEntry = require(gameModuleName .. ".entry")
    	gameEntry.LoadGame()
		require("app.MyApp"):create({viewsRoot = "scmj/src"}):enterScene("GameScene", "FADE", 0.5)
	else
		local resHelper = require("ResHelper")
		resHelper.loadSpriteFrames()
		resHelper.loadAudio()

		if dataMgr.tablePlyNum == 3 then
			require("app.MyApp"):create({viewsRoot = "twoseventen"}):enterScene("GameScene", "FADE", 0.5)
		elseif dataMgr.tablePlyNum == 4 then
			require("app.MyApp"):create({viewsRoot = "twoseventen/FourPlayersGame"}):enterScene("GameScene", "FADE", 0.5)
		end
	end
end

function SceneSwitcher:enterRecordScene()
	collectgarbage("collect")
	local resHelper = require("ResHelper")
	resHelper.loadSpriteFrames()
	resHelper.loadAudio()

	cc.sceneTransFini = false
	if dataMgr.tablePlyNum == 3 then
		require("app.MyApp"):create({viewsRoot = "twoseventen"}):enterScene("RecordScene", "FADE", 0.5)
	elseif dataMgr.tablePlyNum == 4 then
		require("app.MyApp"):create({viewsRoot = "twoseventen/FourPlayersGame"}):enterScene("RecordScene", "FADE", 0.5)
	end
end



return SceneSwitcher
