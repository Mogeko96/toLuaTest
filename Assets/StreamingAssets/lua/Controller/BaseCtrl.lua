BaseCtrl = {};
function BaseCtrl:New(panelName, panelForm) 
    local o = {};
    setmetatable(o, self);
    self.__index = self
    o.panelName = panelName
    o.panelForm = panelForm
    return o;
end

function BaseCtrl:Awake(data)
	self.data = data
	panelMgr:CreatePanel(self.panelName, self.panelForm, 
		function(obj)
			self.gameObject = obj;
			self.transform = obj.transform
			self.mono = self.gameObject:GetComponent('LuaBehaviour');
			self:Init()
			logWarn("Start lua--->>"..self.gameObject.name);
		end, 
		function() 
			self:InitPanel() 
		end);
	logWarn("DetailCtrl:Awake--->>");
end
--初始化(执行一次)
function BaseCtrl:Init()
end

function BaseCtrl:InitPanel()
end

function BaseCtrl:Close()
	panelMgr:ClosePanel(self.panelName);
end

function BaseCtrl:Clear()
	self.data = nil
	self.mono = nil
	self.gameObject = nil
	self.transform = nil
end

function BaseCtrl:OnDestroy()
	self:Clear()
end