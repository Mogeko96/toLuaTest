
-- CtrlNames = {
-- 	Prompt = "PromptCtrl",
-- 	Message = "MessageCtrl",
-- 	StartGame = "StartGameCtrl"
-- }

PanelNames = {
	Prompt = "Prompt",	
	Message = "Message",
	StartGame = "StartGame",
	Detail = "Detail",
	Loading = "Loading",
	DeskTop = "DeskTop",
}

PanelForm = {
	NORMAL = 0,
	FIXED = 1,
	POPUP = 2,
}
--协议类型--
ProtocalType = {
	BINARY = 0,
	PB_LUA = 1,
	PBC = 2,
	SPROTO = 3,
}
--当前使用的协议类型--
TestProtoType = ProtocalType.SPROTO;

Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();
poolMgr = LuaHelper.GetObjectPoolManager();

WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;