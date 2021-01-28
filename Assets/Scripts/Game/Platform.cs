using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Platform : MonoBehaviour {
    private float exitTime = 5f;
    private SpriteRenderer skin;
    private Rigidbody2D rigidbody;
    private bool isStartTimer = false;
    private GameObject nextPlatform = null;
    private LuaFunction luaFunc = null;

    public GameObject NextPlatform {set { nextPlatform = value; } }

    private float timer = 0;

    private void Awake()
    {
        skin = GetComponent<SpriteRenderer>();
        rigidbody = GetComponent<Rigidbody2D>();
    } 
    private void OnEnable()
    {
        rigidbody.bodyType = RigidbodyType2D.Static;
    }
    // Use this for initialization
    void Start () {
    }

    //exitTime相对于前一个物体的存活时间
    public void Init(float exitTime, LuaFunction func)
    {
        //this.skin.sprite= skin;
        this.exitTime = exitTime;
        luaFunc = func;
    }

    public void StartTimer()
    {
        isStartTimer = true;
    }

    // Update is called once per frame
    void Update () {
        if (isStartTimer)
        {
            timer += Time.deltaTime;
            if (timer >= exitTime)
            {
                timer = 0;
                isStartTimer = false;
                rigidbody.bodyType = RigidbodyType2D.Dynamic;
                nextPlatform.GetComponent<Platform>().StartTimer();
                if (luaFunc != null)
                {
                    luaFunc.Call();
                    luaFunc = null;
                }
            }
        }
    }
}
