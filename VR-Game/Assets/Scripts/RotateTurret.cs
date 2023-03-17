using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class RotateTurret : MonoBehaviour
{

    public InputActionReference toggleReference=null;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        RotateGunLeft();
    }

    public void RotateGunRight()
    {
        if(Input.GetKey(KeyCode.Space))
        transform.Rotate(new Vector3(0f,30f,0f)*Time.deltaTime);    
    }
    public void RotateGunLeft()
    {
        if (Input.GetKey(KeyCode.Space))
            transform.Rotate(new Vector3(0f, -30f, 0f) * Time.deltaTime);
    }
}
