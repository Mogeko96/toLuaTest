require "Controller/BaseCtrl"
local event = require "events"

DeskTopCtrl = BaseCtrl:New(PanelNames.DeskTop, PanelForm.FIXED);
local this = DeskTopCtrl;

--启动事件--
--如果面板只是隐藏了，不执行（就执行一次）
function DeskTopCtrl:Init()
	this.mono:AddClick(DeskTopPanel.left_btn, this.OnLeft);
	this.mono:AddClick(DeskTopPanel.right_btn, this.OnRight);
end

function DeskTopCtrl:InitPanel()
end

function DeskTopCtrl.OnLeft(go)
	event.Brocast("Left")
end

function DeskTopCtrl.OnRight(go)
	event.Brocast("Right")
end