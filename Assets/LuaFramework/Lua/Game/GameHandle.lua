local PlatformSpawner = require "Game/PlatformSpawner"
local PlayerController = require "Game/PlayerController"
local GameCamera = require "Game/GameCamera"

GameHandle = {};
this = GameHandle;

this.Property = {
	title = 0,
	playerSkin = 0,
}

function this.Awake(gameObject)
	OpenPanel(PanelNames.DeskTop)
	--平台初始化
	PlatformSpawner:Init()
	--玩家初始化
	PlayerController:Init()
	GameCamera:Init(gameObject.transform:Find("MainCamera").gameObject)
end

function this.Start()
	
end

function this.PlayerOnGrand()
	logError("玩家第一次碰到平台")
	PlayerController:SetPlayerDirection()
end

function this.OnDestroy()
	this.Property = nil
	PlatformSpawner:Clear()
	PlayerController:Clear()
	GameCamera:Clear()
end