local event = require "events"

GameCamera = {};
local this = GameCamera;

function GameCamera:Init(mainCamera)
	this.mainCamera = mainCamera
	this.offset = GameSetting.platformInitPos - this.mainCamera.transform.localPosition
	event.AddListener("CameraFollow", this.CameraFollow)
end

function GameCamera.CameraFollow(targetPos, speed)
	if targetPos then
		this.mainCamera.transform:DOLocalMove(targetPos - this.offset, speed, false)
	end
end

function GameCamera:Clear()
	this.mainCamera = nil
	this.offset= nil
	event.RemoveListener("CameraFollow", this.CameraFollow)
end

return this