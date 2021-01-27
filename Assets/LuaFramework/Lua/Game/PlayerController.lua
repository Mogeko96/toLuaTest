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
end

function PlayerController.TurnLeft()
	if this.playerInfo.CanJump then
		this:Jump(-1)
		event.Brocast("SpawnPlatform")
		local targetPos = Vector3.New(this.playerInfo.CollisionObj.transform.localPosition.x-GameSetting.x, 
			this.playerInfo.CollisionObj.transform.localPosition.y+GameSetting.y, 0)
		event.Brocast("CameraFollow", targetPos)
	end
end

function PlayerController.TurnRight()
	if this.playerInfo.CanJump then
		this:Jump(1)
		event.Brocast("SpawnPlatform")
		local targetPos = Vector3.New(this.playerInfo.CollisionObj.transform.localPosition.x+GameSetting.x, 
			this.playerInfo.CollisionObj.transform.localPosition.y+GameSetting.y, 0)
		event.Brocast("CameraFollow", targetPos)
	end
end

function PlayerController:Jump(index)
	this.player.transform.localScale = Vector3.New(index, 1, 1)
	this.playerInfo.transform:DOMoveY(this.playerInfo.CollisionObj.transform.localPosition.y+GameSetting.y+0.8, 0.1)
	this.playerInfo.transform:DOMoveX(this.playerInfo.CollisionObj.transform.localPosition.x+index*GameSetting.x, 0.15)
end

function PlayerController:Clear()
	this.player = nil
	this.playerInfo = nil
	event.RemoveListener("Left", this.TurnLeft)
	event.RemoveListener("Right", this.TurnRight)
end

return this