using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SpringGUIDefaultControls{
    public static GameObject CreateLongClickButton()
    {
        GameObject lcButton = new GameObject("LongClickButton");
        RectTransform rectTransform = lcButton.AddComponent<RectTransform>();
        Vector2 defaultVector = new Vector2(0.5f, 0.5f);
        rectTransform.anchorMin = defaultVector;
        rectTransform.anchorMax = defaultVector;
        rectTransform.sizeDelta = new Vector2(250, 100);
        AddText(lcButton);
        lcButton.AddComponent<Image>();
        lcButton.AddComponent<LongClickButton>();
        return lcButton;
    }


    private static void AddText(GameObject parentObj)
    {
        GameObject text = new GameObject("Text");
        text.transform.SetParent(parentObj.transform);
        RectTransform rectTransform = text.AddComponent<RectTransform>();
        rectTransform.anchorMin = Vector2.zero;
        rectTransform.anchorMax = Vector2.one;
        rectTransform.sizeDelta = Vector2.zero;
        Text textComponent =  text.AddComponent<Text>();
        textComponent.text = parentObj.name;
        textComponent.alignment = TextAnchor.MiddleCenter;
        textComponent.color = Color.black;
        textComponent.fontSize = 30;
    }
}
