require "View/BasePanel"

MessagePanel = BasePanel:New();
local this = MessagePanel;

--启动事件--
function MessagePanel.Awake(obj)
	this:Init(obj)
end

--初始化面板--
function MessagePanel:InitPanel()
	this.btnClose = this.transform:Find("Panel/Button").gameObject;
	this.label = this.transform:Find("Panel/Label"):GetComponent("Text")
	this.itemIcon = this.transform:Find("Panel/ItemIcon"):GetComponent("Image")
end

function MessagePanel:SetLabel(text)
	this.label.text = text
end

function MessagePanel.OnDestroy()
	this.btnClose = nil
	this.label = nil
	this.itemIcon = nil
	this:Clear()
	logWarn("OnDestroy---->>>");
end