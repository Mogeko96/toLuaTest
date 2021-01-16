using LuaFramework;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameHandle : MonoBehaviour {
    protected void Awake()
    {
        Util.CallMethod("GameHandle", "Awake", gameObject);
    }
    protected void Start()
    {
        Util.CallMethod("GameHandle", "Start");
    }

    protected void OnDestroy()
    {
        Util.CallMethod("GameHandle", "OnDestroy");
    }
}
