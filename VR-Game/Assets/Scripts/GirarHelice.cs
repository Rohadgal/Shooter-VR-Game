using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GirarHelice : MonoBehaviour
{
    public Vector3 localAxis = new Vector3 (0,1,0);
    public float angleVelocity = 1f;
    public float angle = 1f;
    void Update()
    {
        transform.Rotate(localAxis*angle*angleVelocity*Time.deltaTime);
    }
}
