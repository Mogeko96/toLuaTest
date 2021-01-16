require "Controller/BaseCtrl"

MessageCtrl = BaseCtrl:New(PanelNames.Message, PanelForm.POPUP);
local this = MessageCtrl;
local event = require "events"

--启动事件--
function MessageCtrl:Init()
	this.mono:AddClick(MessagePanel.btnClose, this.OnClick);
end

--打开窗口事件--
function MessageCtrl:InitPanel()
	MessagePanel:SetLabel(this.data)
end

--单击事件--
function MessageCtrl.OnClick(go)
	event.Brocast("test", "测试成功了", "!!!!")
	this:Close()
end