require "View/BasePanel"

DeskTopPanel = BasePanel:New();
local this = DeskTopPanel;

--启动事件--
function DeskTopPanel.Awake(obj)
	this:Init(obj)
end

--初始化面板--
function DeskTopPanel:InitPanel()
	this.left_btn = this.transform:Find("Controller/Left").gameObject
	this.right_btn = this.transform:Find("Controller/Right").gameObject
end

--单击事件--
function DeskTopPanel.OnDestroy()
	this:Clear()
	logWarn("OnDestroy---->>>");
end