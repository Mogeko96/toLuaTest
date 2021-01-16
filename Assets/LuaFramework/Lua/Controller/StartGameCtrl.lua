require "Controller/BaseCtrl"
StartGameCtrl = BaseCtrl:New(PanelNames.StartGame, PanelForm.NORMAL);
local this = StartGameCtrl;

--启动事件--
--如果面板只是隐藏了，不执行（就执行一次）
function StartGameCtrl:Init()
	this.mono:AddClick(StartGamePanel.btnClose, this.OnClick);
end

function StartGameCtrl:InitPanel()
end

--单击事件--
function StartGameCtrl.OnClick(go)
	this:Close()
	OpenPanel(PanelNames.Prompt, nil)
end