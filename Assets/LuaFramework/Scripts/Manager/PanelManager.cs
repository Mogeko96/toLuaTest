using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using LuaInterface;

namespace LuaFramework {
    public class PanelManager : Manager {
        private Transform parent;
        private Transform normalForm;
        private Transform fixedForm;
        private Transform popUpForm;
        private Dictionary<string, GameObject> panelList = new Dictionary<string, GameObject>();

        Transform Parent {
            get {
                if (parent == null) {
                    GameObject go = GameObject.Find("UIRoot");
                    if (go != null) parent = go.transform;
                }
                return parent;
            }
        }

        Transform NormalForm
        {
            get
            {
                if (normalForm == null)
                {
                    Transform trans = Parent.transform.Find("Normal");
                    if (trans != null) normalForm = trans;
                }
                return normalForm;
            }
        }

        Transform FixedForm
        {
            get
            {
                if (fixedForm == null)
                {
                    Transform trans = Parent.transform.Find("Fixed");
                    if (trans != null) fixedForm = trans;
                }
                return fixedForm;
            }
        }

        Transform PopUpForm
        {
            get
            {
                if (popUpForm == null)
                {
                    Transform trans = Parent.transform.Find("PopUp");
                    if (trans != null) popUpForm = trans;
                }
                return popUpForm;
            }
        }

        /// <summary>
        /// ������壬������Դ������
        /// </summary>
        /// <param name="type"></param>
        public void CreatePanel(string name, int formType, LuaFunction func1 = null, LuaFunction func2 = null) {
            string assetName = name + "Panel";
            string abName = name.ToLower() + AppConst.ExtName;
            if (panelList.ContainsKey(name))
            {
                GameObject panel;
                panelList.TryGetValue(name, out panel);
                if (panel) panel.SetActive(true);
                if (func2 != null) func2.Call();
                return;
            }

#if ASYNC_MODE
            ResManager.LoadPrefab(abName, assetName, delegate(UnityEngine.Object[] objs) {
                if (objs.Length == 0) return;
                GameObject prefab = objs[0] as GameObject;
                if (prefab == null) return;

                GameObject go = Instantiate(prefab) as GameObject;
                go.name = assetName;
                go.layer = LayerMask.NameToLayer("Default");
                go.transform.SetParent(SelectForm(formType));
                go.transform.localScale = Vector3.one;
                go.transform.localPosition = Vector3.zero;
                go.AddComponent<LuaBehaviour>();

                if (func != null) func.Call(go);
                Debug.LogWarning("CreatePanel::>> " + name + " " + prefab);
            });
#else
            GameObject prefab = ResManager.LoadAsset<GameObject>(name, assetName);
            if (prefab == null) return;
            GameObject go = Instantiate(prefab) as GameObject;
            go.name = assetName;
            go.layer = LayerMask.NameToLayer("Default");
            go.transform.SetParent(SelectForm(formType));
            go.transform.localScale = Vector3.one;
            go.transform.localPosition = Vector3.zero;
            go.GetComponent<RectTransform>().offsetMin = new Vector2(0.0f, 0.0f);
            go.GetComponent<RectTransform>().offsetMax = new Vector2(0.0f, 0.0f);
            go.AddComponent<LuaBehaviour>();
            panelList.Add(name, go);

            if (func1 != null) func1.Call(go);
            if (func2 != null) func2.Call();
            Debug.LogWarning("CreatePanel::>> " + name + " " + prefab);
#endif
        }

        private Transform SelectForm(int formType)
        {
            switch (formType)
            {
                case 1:
                    return FixedForm;
                case 2:
                    return PopUpForm;
                default:
                    return NormalForm;
            }
        }

        /// <summary>
        /// �ر����
        /// </summary>
        /// <param name="name"></param>
        public void ClosePanel(string name) {
            GameObject panel;
            panelList.TryGetValue(name, out panel);
            if (panel) panel.SetActive(false);
            //var panelName = name + "Panel";
            //var panelObj = Parent.Find(panelName);
            //if (panelObj == null) return;
            //Destroy(panelObj.gameObject);
        }
    }
}