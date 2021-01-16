require "View/BasePanel"

PromptPanel = BasePanel:New();
local this = PromptPanel;

--启动事件--
function PromptPanel.Awake(obj)
	this:Init(obj)
end

--初始化面板--
function PromptPanel:InitPanel()
	this.btnOpen = this.transform:Find("Open").gameObject;
	this.gridParent = this.transform:Find('ScrollView/Grid');
end

--单击事件--
function PromptPanel.OnDestroy()
	this.btnOpen = nil
	this.gridParent = nil
	this:Clear()
	logWarn("OnDestroy---->>>");
end