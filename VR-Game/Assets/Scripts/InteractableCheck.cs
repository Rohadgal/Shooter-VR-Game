using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InteractableCheck : MonoBehaviour
{
    public bool grabActive=false;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    
    public void GrabCheck()
    {
        grabActive = true;  
    }

    public void DeactivateGrab()
    {
        grabActive = false;
    }
}
