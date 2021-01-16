using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.UI;

public class SpringGUIMenuOptions{

    [MenuItem("GameObject/UI/Buttons/LongClickButton", false, 2066)]
    public static void AddLongClickButton(MenuCommand menuCommand)
    {
        GameObject parent = menuCommand.context as GameObject;
        GameObject longBtn = SpringGUIDefaultControls.CreateLongClickButton();
        longBtn.transform.SetParent(parent.transform);
        longBtn.transform.localPosition = Vector3.zero;
    }
}
