using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GirarHelice : MonoBehaviour
{
    [SerializeField] public Vector3 localAxis = new Vector3 (0,1,0);
    [SerializeField] public float angleVelocity = 50f;
    [SerializeField] public float angle = 1f;
    void Update()
    {
        transform.Rotate(localAxis*angle*angleVelocity*Time.deltaTime);
    }
}
