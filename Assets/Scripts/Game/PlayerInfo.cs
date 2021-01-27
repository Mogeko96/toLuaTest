using LuaFramework;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerInfo : MonoBehaviour {
    private bool canJump = false;
    private GameObject collisionObj = null;
    public bool CanJump{get{return canJump;}}

    public GameObject CollisionObj { get { return collisionObj; } }

    private void OnTriggerEnter2D(Collider2D collision)
    {
        canJump = true;
        collisionObj = collision.gameObject;
    }
    private void OnTriggerExit2D(Collider2D collision)
    {
        canJump = false;
    }
}
