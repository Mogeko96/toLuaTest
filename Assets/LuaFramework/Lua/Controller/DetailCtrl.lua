DetailCtrl = {};
local this = DetailCtrl;

local detail;
local transform;
local gameObject;

this.data = nil

function DetailCtrl.New()
	return this;
end

function DetailCtrl:Awake(data)
	this.data = data
	logWarn("DetailCtrl.Awake--->>");
	panelMgr:CreatePanel(PanelNames.Detail, PanelForm.POPUP, this.InitPanel, this.OpenPanelHandle);
end

--启动事件--
--如果面板只是隐藏了，不执行（就执行一次）
function DetailCtrl.InitPanel(obj)
	gameObject = obj;
	detail = gameObject:GetComponent('LuaBehaviour');
	logWarn("Start lua--->>"..gameObject.name);
end

function DetailCtrl.OpenPanelHandle()
	DetailPanel.SetBgPosition(this.data)
end

--关闭事件--
function DetailCtrl.Close()
	panelMgr:ClosePanel(PanelNames.Detail);
end