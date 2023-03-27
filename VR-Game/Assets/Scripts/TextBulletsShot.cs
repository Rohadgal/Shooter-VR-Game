using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class TextBulletsShot : MonoBehaviour
{
    public ShootLogic shootLogic;

    public TMP_Text numberOfShotsText;

    void Update()
    {
        numberOfShotsText.text = shootLogic.GetshotCounter().ToString();
    }
}
