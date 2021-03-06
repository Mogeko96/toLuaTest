local PlatformSpawner = require "Game/PlatformSpawner"
local PlayerController = require "Game/PlayerController"
local GameCamera = require "Game/GameCamera"

GameHandle = {};
this = GameHandle;

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

function this.OnDestroy()
	PlatformSpawner:Clear()
	PlayerController:Clear()
	GameCamera:Clear()
end