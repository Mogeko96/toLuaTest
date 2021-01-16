local event = require "events"

PlayerController = {};
local this = PlayerController;

function PlayerController:Init()
	event.AddListener("Left", this.TurnLeft)
	event.AddListener("Right", this.TurnRight)

	--生成玩家
	this.player = newObject(resMgr:LoadPrefab("prefabs", "Player"))
	this.player.transform.localPosition = Vector3.New(0,-1.88, 0)
	this.playerCtrl = this.player:GetComponent('PlayerInfo')
end

function PlayerController.TurnLeft()
	if this.playerCtrl:CanJump() then 
		logError("向左边")
	end
end

function PlayerController.TurnRight()
	if this.playerCtrl:CanJump() then 
		logError("向右边")
	end
end

function PlayerController:Clear()
	this.player = nil
	event.RemoveListener("Left", this.TurnLeft)
	event.RemoveListener("Right", this.TurnRight)
end

return this