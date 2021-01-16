require "Common/define"
require "Common/gameSetting"
require "Controller/PromptCtrl"
require "Controller/MessageCtrl"
require "Controller/StartGameCtrl"
require "Controller/DetailCtrl"
require "Controller/LoadingCtrl"
require "Controller/DeskTopCtrl"

CtrlManager = {};
local this = CtrlManager;
local ctrlList = {};	--控制器列表--

function CtrlManager.Init()
	logWarn("CtrlManager.Init----->>>");
	ctrlList[PanelNames.Prompt] = PromptCtrl --PromptCtrl.New();
	ctrlList[PanelNames.Message] = MessageCtrl --MessageCtrl.New();
	ctrlList[PanelNames.StartGame] = StartGameCtrl --StartGameCtrl.New();
	ctrlList[PanelNames.Detail] = DetailCtrl --DetailCtrl.New();
	ctrlList[PanelNames.Loading] = LoadingCtrl
	ctrlList[PanelNames.DeskTop] = DeskTopCtrl
	return this;
end

--添加控制器--
function CtrlManager.AddCtrl(ctrlName, ctrlObj)
	ctrlList[ctrlName] = ctrlObj;
end

--获取控制器--
function CtrlManager.GetCtrl(ctrlName)
	return ctrlList[ctrlName];
end

--移除控制器--
function CtrlManager.RemoveCtrl(ctrlName)
	ctrlList[ctrlName] = nil;
end

--关闭控制器--
function CtrlManager.Close()
	logWarn('CtrlManager.Close---->>>');
end