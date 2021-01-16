require "Controller/BaseCtrl"
LoadingCtrl = BaseCtrl:New(PanelNames.Loading, PanelForm.NORMAL);
local this = LoadingCtrl;

--启动事件--
--如果面板只是隐藏了，不执行（就执行一次）
function LoadingCtrl:Init()
	this.mono:AddClick(LoadingPanel.btn_start, this.OnClick);
end

function LoadingCtrl:InitPanel()
	ChangeSprite(LoadingPanel.bg, "bg", "bg1")
end

--单击事件--
function LoadingCtrl.OnClick(go)
	resMgr:LoadScene("Game")
end