using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//using UnityEngine.InputSystem;
using UnityEngine.XR;

public class RotateTurret : MonoBehaviour
{
    private InputDevice target;
    private InputDevice target2;
    public static InputFeatureUsage<bool> primaryTouch;

    public bool interactable=false;

    //public  interactable;

    //public InputActionReference toggleReference=null;
    private bool right;
    private bool left;


    void Update()
    {    
        
            RotateGunLeft();
            RotateGunRight();
               
    }

    public void RotateGunRight()
    {
        if (target.TryGetFeatureValue(CommonUsages.primaryButton, out bool primaryButtonValue))
            transform.Rotate(new Vector3(0f, 30f, 0f) * Time.deltaTime);


    }
    public void RotateGunLeft()
    {
        if(target.TryGetFeatureValue(CommonUsages.secondaryButton, out bool SecondaryButtonValue))
        transform.Rotate(new Vector3(0f, -30f, 0f) * Time.deltaTime);
        //if (Input.GetKey(KeyCode.Space))
    }

    public void BlockRotation()
    {
        right = false;
        left = false;
    }
}
