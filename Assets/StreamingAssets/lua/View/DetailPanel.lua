require "View/BasePanel"

DetailPanel = BasePanel:New();
local this = DetailPanel;

--启动事件--
function DetailPanel.Awake(obj)
	this:Init(obj)
end

--初始化面板--
function DetailPanel:InitPanel()
	this.titleText = this.transform:Find("BG/Title/Text").gameObject
	this.content = this.transform:Find("BG/Text").gameObject
	this.bg = this.transform:Find("BG").gameObject
	logError(GameSetting.x..GameSetting.y)
end

--单击事件--
function DetailPanel.OnDestroy()
	this.titleText = nil
	this.content = nil
	this.bg = nil
	this:Clear()
	logWarn("OnDestroy---->>>");
end

function DetailPanel.SetBgPosition(btn)
	local x = btn.transform.localPosition.x
	local y = btn.transform.localPosition.y
	local posY = btn.transform:GetComponent("RectTransform").sizeDelta.y/2
	local rectTransform = this.bg:GetComponent("RectTransform")
	rectTransform.pivot = Vector2.New(x <=0 and 0 or 1, y<=0 and 0 or 1)
	rectTransform.transform.localPosition = Vector3.New(x, y<0 and y+posY or y-posY, rectTransform.transform.localPosition.z)
end