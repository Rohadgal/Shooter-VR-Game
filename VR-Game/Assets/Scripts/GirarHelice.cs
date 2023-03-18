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
        // Vector3 vectorTemp = Formulas.RotacionDeMatrizY(this.transform.localPosition, (angle));
        // Quaternion res = new Quaternion(vectorTemp.x, vectorTemp.y, vectorTemp.z, 1);

        // transform.rotation = res;
    }
}
