local event = require "events"

PlayerController = {};
local this = PlayerController;

function PlayerController:Init()
	--生成玩家
	this.player = newObject(resMgr:LoadPrefab("prefabs", "Player"))
	this.player.transform.localPosition = Vector3.New(0,-1.88, 0)
	this.playerInfo = this.player:GetComponent('PlayerInfo')

	--注册事件
	event.AddListener("Left", this.TurnLeft)
	event.AddListener("Right", this.TurnRight)
	this.pressTime = os.time()
end

function PlayerController.TurnLeft()
	if this.playerInfo.CanJump then
		this.player.transform.localScale = Vector3.New(-1, 1, 1)
		event.Brocast("SpawnPlatform")
		local targetPos = Vector3.New(this.playerInfo.CollisionObj.transform.localPosition.x-GameSetting.x, 
			this.playerInfo.CollisionObj.transform.localPosition.y+GameSetting.y, 0)
		this:Jump(targetPos)
	end
end

function PlayerController.TurnRight()
	if this.playerInfo.CanJump then
		this.player.transform.localScale = Vector3.New(1, 1, 1)
		event.Brocast("SpawnPlatform")
		local targetPos = Vector3.New(this.playerInfo.CollisionObj.transform.localPosition.x+GameSetting.x, 
			this.playerInfo.CollisionObj.transform.localPosition.y+GameSetting.y, 0)
		this:Jump(targetPos)
	end
end

function PlayerController:Jump(targetPos)
	local nowPressTime = os.time()
	local speed = nowPressTime - this.pressTime >= 1 and GameSetting.slowSpeed or GameSetting.quickSpeed
	this.pressTime = nowPressTime

	this.playerInfo.transform:DOMoveY(targetPos.y+0.8, speed-0.05)
	this.playerInfo.transform:DOMoveX(targetPos.x, speed)
	event.Brocast("CameraFollow", targetPos, speed)
end

function PlayerController:Clear()
	this.player = nil
	this.playerInfo = nil
	this.pressTime = nil
	event.RemoveListener("Left", this.TurnLeft)
	event.RemoveListener("Right", this.TurnRight)
end

return this