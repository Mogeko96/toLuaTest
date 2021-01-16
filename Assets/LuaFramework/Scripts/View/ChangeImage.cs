using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using LuaFramework;
using LuaInterface;
using UnityEngine.U2D;

public class ChangeImage : MonoBehaviour {
    private Image image;
    private void Awake()
    {
        image = this.GetComponent<Image>();
    }
    public void Change(string assetName, string spriteName, LuaFunction func = null)
    {
        StartCoroutine(HandleSprite(assetName, spriteName, func));
    }
    private IEnumerator HandleSprite(string assetName, string spriteName, LuaFunction func)
    {
        Sprite sprite = LuaHelper.GetResManager().LoadAsset<Sprite>(assetName, spriteName);
        if (sprite)
        {
            if (sprite) image.sprite = sprite;
            if (func != null) func.Call();
            yield return null;
        }
    }
}
