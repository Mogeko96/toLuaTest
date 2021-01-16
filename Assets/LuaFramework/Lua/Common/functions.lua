
--输出日志--
function log(str)
    Util.Log(str);
end

--错误日志--
function logError(str) 
	Util.LogError(str);
end

--警告日志--
function logWarn(str) 
	Util.LogWarning(str);
end

--查找对象--
function find(str)
	return GameObject.Find(str);
end

function destroy(obj)
	GameObject.Destroy(obj);
end

function newObject(prefab)
	return GameObject.Instantiate(prefab);
end

--创建面板--
function createPanel(name, formType)
	PanelManager:CreatePanel(name, formType);
end

function child(str)
	return transform:FindChild(str);
end

function subGet(childNode, typeName)		
	return child(childNode):GetComponent(typeName);
end

--原框架結構
-- function findPanel(str) 
-- 	local obj = find(str);
-- 	if obj == nil then
-- 		error(str.." is null");
-- 		return nil;
-- 	end
-- 	return obj:GetComponent("BaseLua");
-- end

function OpenPanel(panelName, data)
	local ctrl = CtrlManager.GetCtrl(panelName);
    if ctrl ~= nil then
        ctrl:Awake(data);
    end
end

function ChangeSprite(obj, assetName, spriteName, func)
	local component = obj:GetComponent("ChangeImage")
	if not component then 
		component = obj:AddComponent(LuaHelper.GetType("ChangeImage"))
	end
	component:Change(assetName, spriteName, func)
end

