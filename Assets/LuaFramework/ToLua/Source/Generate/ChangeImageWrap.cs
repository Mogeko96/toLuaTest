﻿//this source code was auto-generated by tolua#, do not modify it
using System;
using LuaInterface;

public class ChangeImageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChangeImage), typeof(UnityEngine.MonoBehaviour));
		L.RegFunction("Change", Change);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int Change(IntPtr L)
	{
		try
		{
			int count = LuaDLL.lua_gettop(L);

			if (count == 3)
			{
				ChangeImage obj = (ChangeImage)ToLua.CheckObject<ChangeImage>(L, 1);
				string arg0 = ToLua.CheckString(L, 2);
				string arg1 = ToLua.CheckString(L, 3);
				obj.Change(arg0, arg1);
				return 0;
			}
			else if (count == 4)
			{
				ChangeImage obj = (ChangeImage)ToLua.CheckObject<ChangeImage>(L, 1);
				string arg0 = ToLua.CheckString(L, 2);
				string arg1 = ToLua.CheckString(L, 3);
				LuaFunction arg2 = ToLua.CheckLuaFunction(L, 4);
				obj.Change(arg0, arg1, arg2);
				return 0;
			}
			else
			{
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChangeImage.Change");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallbackAttribute(typeof(LuaCSFunction))]
	static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object arg0 = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object arg1 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool o = arg0 == arg1;
			LuaDLL.lua_pushboolean(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}

