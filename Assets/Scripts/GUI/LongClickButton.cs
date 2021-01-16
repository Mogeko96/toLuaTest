using System;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;
using UnityEngine.UI;

[AddComponentMenu("UI/LongClickButton")]
public class LongClickButton : Button{
    [Serializable]
    public class LongClickEvent : UnityEvent { }
    public class LongClickOutEvent : UnityEvent { }

    [SerializeField]
    private LongClickEvent m_onLongClick = null;

    [SerializeField]
    private LongClickEvent m_outLongClick = null;

    public LongClickEvent onLongClick
    {
        get { return m_onLongClick; }
        set { m_onLongClick = value; }
    }

    public LongClickEvent outLongClick
    {
        get { return m_outLongClick; }
        set { m_outLongClick = value; }
    }

    //private DateTime m_firstTime = default(DateTime);
    //private DateTime m_secondTime = default(DateTime);

    private void Press()
    {
        if (null != onLongClick)
            onLongClick.Invoke();
        //resetTime();
    }

    private void Up()
    {
        if (null != outLongClick)
            outLongClick.Invoke();
    }

    public override void OnPointerDown(PointerEventData eventData)
    {
        base.OnPointerDown(eventData);
        //if (m_firstTime.Equals(default(DateTime)))
        //    m_firstTime = DateTime.Now;
        Press();
    }
    public override void OnPointerEnter(PointerEventData eventData)
    {
        base.OnPointerEnter(eventData);
    }

    public override void OnPointerUp(PointerEventData eventData)
    {
        base.OnPointerUp(eventData);
        // 在鼠标抬起的时候进行事件触发，时差大于600ms触发
        //if (!m_firstTime.Equals(default(DateTime)))
        //    m_secondTime = DateTime.Now;
        //if (!m_firstTime.Equals(default(DateTime)) && !m_secondTime.Equals(default(DateTime)))
        //{
        //    var intervalTime = m_secondTime - m_firstTime;
        //    int milliSeconds = intervalTime.Seconds * 1000 + intervalTime.Milliseconds;
        //    if (milliSeconds > 600) Press();
        //    else resetTime();
        //}
        Up();
    }

    public override void OnPointerExit(PointerEventData eventData)
    {
        base.OnPointerExit(eventData);
        //resetTime();
        Up();
    }

    private void resetTime()
    {
        //m_firstTime = default(DateTime);
        //m_secondTime = default(DateTime);
    }
}
