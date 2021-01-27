local event = require "events"
PlatformSpawner = {};
local this = PlatformSpawner;
this.lastPlatform = nil

function PlatformSpawner:Init()
	--Pool名字， 初始化预制体数， 最大生成预制体数(不明), 预制体
	poolMgr:CreatePool("Platform", 50, 100, resMgr:LoadPrefab("prefabs", "Platform"))
	poolMgr:CreatePool("PWO_Normal", 30, 100, resMgr:LoadPrefab("prefabs", "PWO_Normal"))
	this:InitPlatform()
	event.AddListener("SpawnPlatform", this.SpawnPlatform)
end

--初始化平台
function PlatformSpawner:InitPlatform()
	for i=1, 6 do
		if i == 1 then
			local platform = poolMgr:Get("Platform")
			platform.transform.localPosition = GameSetting.platformInitPos
			local PlatformCom =  platform:GetComponent("Platform")
			PlatformCom:Init(5, nil)
			PlatformCom:StartTimer()
			this.lastPlatform = platform
		else
			this.SpawnPlatform()
		end
	end
end

--随机生成平台
function PlatformSpawner.SpawnPlatform()
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
	local index = math.random(0, 1)
	local list = {}
	if index == 0 then 
		index = -1
	end
	local count = math.random(1, 3)
	for i=1, count do
		local platform, isPlatformWithObstacle = this:SwitchPlatform()
		if not platform then return end 
		platform.transform.localPosition = Vector3.New(this.lastPlatform.transform.localPosition.x + GameSetting.x*index,
													this.lastPlatform.transform.localPosition.y + GameSetting.y, 0)
		platform:GetComponent("Platform"):Init(1, function()
			coroutine.start(function( ... )
				coroutine.wait(2)
				local poolName = isPlatformWithObstacle and "PWO_Normal" or "Platform"
				poolMgr:Release(poolName, platform.gameObject)
			end)
		end)
		this.lastPlatform:GetComponent("Platform").NextPlatform = platform
		this.lastPlatform = platform
		if isPlatformWithObstacle then 
			if i == count then
				this:SetPlatformWithObstacle({platform}, index, true)
			else
				table.insert(list, platform)
			end
		end
	end
	this:SetPlatformWithObstacle(list, index, false)
end

function PlatformSpawner:SwitchPlatform() 
	local index = math.random(0, 9)
	if index < 8 then 
		return poolMgr:Get("Platform"), false
	else
		return poolMgr:Get("PWO_Normal"), true
	end
end

function PlatformSpawner:SetPlatformWithObstacle(PlatformList, index, isLast)
	if next(PlatformList) == nil then
		return
	end
	local isRight = index == 1
	for i= #PlatformList,1,-1 do
		local right = PlatformList[i].transform:Find("Right").gameObject
		local left = PlatformList[i].transform:Find("Left").gameObject
		right:SetActive(isRight)
		left:SetActive(not isRight)
		local obj = isRight and right or left
		local showIndex = math.random(0,2)
		if not isLast then 
			for j=0, 1 do
				local obstacle = obj.transform:GetChild(j).gameObject
				obstacle:SetActive(showIndex == 2 and true or j== showIndex)
				obstacle:GetComponent("BoxCollider2D").enabled = false
			end
		else
			obj.transform:GetChild(0).gameObject:SetActive(false)
			obj.transform:GetChild(1).gameObject:SetActive(true)
		end
	end 
end

function PlatformSpawner:Clear()
	this.lastPlatform = nil
	event.RemoveListener("SpawnPlatform", this.SpawnPlatform)
end

return this