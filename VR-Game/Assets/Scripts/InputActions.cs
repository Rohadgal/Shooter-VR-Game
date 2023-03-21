using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;

public class InputActions : MonoBehaviour
{

    private InputDevice target;
    private InputDevice target2;
    void Start()
    {
        List<InputDevice> controllers = new List<InputDevice>();
        InputDevices.GetDevices(controllers);

        foreach (var item in controllers)
        {
            Debug.Log(item.name + item.characteristics);
        }

        target = controllers[0]; 
    }

    // Update is called once per frame
    void Update()
    {
        target.TryGetFeatureValue(CommonUsages.trigger, out float triggerValue);
        if (triggerValue != 0) { }
            //tomar objeto
            //Debug.Log("interaccion");


            target.TryGetFeatureValue(CommonUsages.primaryButton,out bool primaryButtonValue);
    }
}
