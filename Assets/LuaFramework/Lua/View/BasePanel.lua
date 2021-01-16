BasePanel = {};

--BasePanel.__index = BasePanel
function BasePanel:New() 
    local o = {};
    setmetatable(o, self);
    self.__index = self
    return o;
end

--启动事件--
function BasePanel:Init(obj)
	self.gameObject = obj;
	self.transform = obj.transform;
	self:InitPanel();
	logWarn("Awake lua--->>"..self.gameObject.name);
end

--初始化面板--
function BasePanel:InitPanel()
end

--单击事件--
function BasePanel:Clear()
	local ctrl = CtrlManager.GetCtrl(string.sub(self.gameObject.name, 1, -6))
	ctrl:OnDestroy()
	self.gameObject = nil
	self.transform = nil
end

