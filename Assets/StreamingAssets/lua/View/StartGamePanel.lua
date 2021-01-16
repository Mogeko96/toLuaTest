require "View/BasePanel"

StartGamePanel = BasePanel:New();
local this = StartGamePanel;

--启动事件--
function StartGamePanel.Awake(obj)
	this:Init(obj)
end

--初始化面板--
function StartGamePanel:InitPanel()
	this.btnClose = this.transform:Find("Button").gameObject;
	this.btnClose.transform:DOLocalMoveX(200, 0.5):SetLoops(-1, DG.Tweening.LoopType.Yoyo)
end

function StartGamePanel.OnDestroy()
	this.btnClose = nil
	this:Clear()
	logWarn("OnDestroy---->>>");
end