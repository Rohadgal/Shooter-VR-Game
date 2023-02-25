using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckEastLimit : MonoBehaviour
{
    private Vector3 EastLimit;

    public Vector3 GetEastLimit
    {
        get { return EastLimit; }
    }
    
    // Start is called before the first frame update
    void Start()
    {
        Vector3 EastLimit = this.transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
