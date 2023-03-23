using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TransformPosition : MonoBehaviour
{
    public Transform Avion;

    void Update()
    {
        transform.position = Avion.transform.position;
        transform.rotation = Avion.transform.rotation;
    }
}
