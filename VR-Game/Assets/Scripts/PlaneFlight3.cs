using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlaneFlight3 : MonoBehaviour
{
    // Roll_Spinning_Airplane_with_Quaternions

   [SerializeField] private Quaternion myLocalRotation;
   [SerializeField] public Vector3 axisLocal;
   [SerializeField] public float angle = 1;
   [SerializeField] public float angleVelocity = 1f;
   [SerializeField] public float forwardSpeed = 1f;

    [SerializeField] public GameObject GO_CenterOfCircunference;
    [SerializeField] private Vector3 CentreOfCircunference = new Vector3(0,0,0);
    [SerializeField] private Vector3 relativePosition;
    [SerializeField] private Quaternion rotationInWorld;
    [SerializeField] public float rotationSpeed = 1f;

    // Update is called once per frame
    void Update()
    {
        if(GO_CenterOfCircunference != null) CentreOfCircunference = GO_CenterOfCircunference.transform.position;

        relativePosition = CentreOfCircunference - relativePosition;

        rotationInWorld = new Quaternion (relativePosition.x, relativePosition.y, relativePosition.z, 1) * new Quaternion(0,1,0,1*rotationSpeed); 

        // Demostrar uso del cuaternion
        myLocalRotation = new Quaternion(axisLocal.x, axisLocal.y, axisLocal.z, Mathf.Sin(angleVelocity)+Mathf.Cos(angleVelocity));
        //Debug.Log(myLocalRotation);

        // Para girar
        transform.Rotate(axisLocal, angleVelocity*angle*Time.deltaTime);

        // Para avanzar
        transform.Rotate(0, 1*rotationSpeed, 0, Space.Self);
        transform.position += transform.TransformDirection(Vector3.forward);



    }
}
