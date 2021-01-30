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
	local platform = poolMgr:Get("Platform")
	platform.transform.localPosition = GameSetting.platformInitPos
	local PlatformCom = platform:GetComponent("Platform")
	PlatformCom:Init(3, function()
		this.RecoveryPlatform("Platform", platform.gameObject)
	end)
	PlatformCom:StartTimer()
	this.lastPlatform = platform
	for i=1, 3 do 
		this.SpawnPlatform()
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
	local isSpecial = false
	local count = math.random(2, 3)
	for i=1, count do
		local platform, isPlatformWithObstacle = this:SwitchPlatform()
		if not platform then
			if isPlatformWithObstacle then 
				isSpecial = true
			end
			break
		end 
		platform.transform.localPosition = Vector3.New(this.lastPlatform.transform.localPosition.x + GameSetting.x*index,
													this.lastPlatform.transform.localPosition.y + GameSetting.y, 0)
		platform:GetComponent("Platform"):Init(1, function()
			local poolName = isPlatformWithObstacle and "PWO_Normal" or "Platform"
			this.RecoveryPlatform(poolName, platform.gameObject)
		end)
		this.lastPlatform:GetComponent("Platform").NextPlatform = platform
		this.lastPlatform = platform
		if i == count then 
			if isPlatformWithObstacle then isSpecial = true end
			if math.random(0, 1) == 0 then		
				this:CreateFakePath(platform, -index)
			end
		end

		if isPlatformWithObstacle then 
			table.insert(list, platform)
		end
	end
	this:SetPlatformWithObstacle(list, index, isSpecial)
end

function PlatformSpawner:SwitchPlatform()
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
	local index = math.random(0, 9)
	if index < 8 then 
		return poolMgr:Get("Platform"), false
	else
		return poolMgr:Get("PWO_Normal"), true
	end
end

function PlatformSpawner:SetPlatformWithObstacle(PlatformList, index, isSpecial)
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
		if isSpecial and i == #PlatformList then 
			obj.transform:GetChild(0).gameObject:SetActive(false)
			obj.transform:GetChild(1).gameObject:SetActive(true)
		else
			for j=0, 1 do
				local obstacle = obj.transform:GetChild(j).gameObject
				obstacle:SetActive(showIndex == 2 and true or j== showIndex)
				obstacle:GetComponent("BoxCollider2D").enabled = false
			end
		end
	end 
end

function PlatformSpawner:CreateFakePath(obj, index)
	local count = math.random(1, 9)
	local lastPlatform = obj
	for i=1, count do 
		local platform, isPlatformWithObstacle = this:SwitchPlatform()
		platform.transform.localPosition = Vector3.New(lastPlatform.transform.localPosition.x + GameSetting.x*index,
														lastPlatform.transform.localPosition.y + GameSetting.y, 0)
		platform:GetComponent("Platform"):Init(1, function()
			local poolName = isPlatformWithObstacle and "PWO_Normal" or "Platform"
			this.RecoveryPlatform(poolName, platform.gameObject)
		end)
		lastPlatform:GetComponent("Platform").NextPlatform = platform
		lastPlatform = platform
	end
end

function PlatformSpawner.RecoveryPlatform(poolName, platform)
	coroutine.start(function()
		coroutine.wait(1)
		poolMgr:Release(poolName, platform)
	end)
end

function PlatformSpawner:Clear()
	this.lastPlatform = nil
	event.RemoveListener("SpawnPlatform", this.SpawnPlatform)
end

return this