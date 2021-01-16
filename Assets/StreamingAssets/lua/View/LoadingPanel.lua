require "View/BasePanel"

LoadingPanel = BasePanel:New();
local this = LoadingPanel;

--启动事件--
function LoadingPanel.Awake(obj)
	this:Init(obj)
end

--初始化面板--
function LoadingPanel:InitPanel()
	this.bg = this.transform:Find("Bg").gameObject
	this.btn_start = this.transform:Find("Bg/Btn_start").gameObject;
end

--单击事件--
function LoadingPanel.OnDestroy()
	this.bg = nil
	this.btn_start = nil
	this:Clear()
	logWarn("OnDestroy---->>>");
end