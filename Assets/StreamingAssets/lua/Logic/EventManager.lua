require "Common/define"

EventManager = {};
local this = EventManager;
local eventDict = {};	--控制器列表--

function EventManager.Init()
	logWarn("EventManager.Init----->>>");
	return this;
end

function EventManager.RegistListener(id, key, func)
	if eventDict[key] then
		eventDict[key][id] = func
	else
		eventDict[key] = {[id] = func}
	end
end

function EventManager.Breadcast(key, ...)
	if eventDict[key] then
		for id, func in pairs(eventDict[key]) do
			func(id, ...)
		end
	end
end

function EventManager.RemoveListener(id, key)
	if not eventDict[key] then 
		return
	end
	eventDict[key][id] = nil
end
