PlatformSpawner = {};
local this = PlatformSpawner;
this.lastPlatform = nil

function PlatformSpawner:Init()
	--Pool名字， 初始化预制体数， 最大生成预制体数(不明), 预制体
	poolMgr:CreatePool("Platform", 50, 60, resMgr:LoadPrefab("prefabs", "Platform"))
	this:InitPlatform()
end

--初始化平台
function PlatformSpawner:InitPlatform()
	for i=1, 6 do
		local platform = poolMgr:Get("Platform")
		if i == 1 then
			platform.transform.localPosition = Vector3.New(0, -2.4, 0)
		else
			platform.transform.localPosition = Vector3.New(this.lastPlatform.transform.localPosition.x + GameSetting.x,
														this.lastPlatform.transform.localPosition.y + GameSetting.y, 0)
		end
		this.lastPlatform = platform
	end
end

--随机生成平台
function PlatformSpawner:SpawnPlatform()
	local index = math.random(0, 1)
	if index == 0 then 
		index = -1
	end
	local count = math.random(2,5)
	for i=1, count do 
		local platform = poolMgr:Get("Platform")
		platform.transform.localPosition = Vector3.New(this.lastPlatform.transform.localPosition.x + GameSetting.x*index,
														this.lastPlatform.transform.localPosition.y + GameSetting.y, 0)
	end
end

function PlatformSpawner:Clear()
	this.lastPlatform = nil
end

return this