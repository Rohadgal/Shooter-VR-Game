using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeColor : MonoBehaviour
{
    Material normalMaterial;
    public Material materialRed;
    Transform airplaneBody;
    private void Start() 
    {
        airplaneBody = gameObject.transform.Find("Spitfire_body");
        normalMaterial = airplaneBody.GetComponent<MeshRenderer>().material;    
    }
    // Update is called once per frame
    private void OnTriggerEnter(Collider other) 
    {
        if(other.CompareTag("Bullet"))
        {
            if(airplaneBody!=null)
            airplaneBody.GetComponent<MeshRenderer>().material = materialRed;
            StartCoroutine(RestoreHitColor());
            //this.GetComponent<MeshRenderer>().material.color = materialRed.color;  
            //GetComponentInChildren<MeshRenderer>().material; 
        }
    }

        IEnumerator RestoreHitColor()
    {
        yield return new WaitForSeconds(1);
        airplaneBody.GetComponent<MeshRenderer>().material = normalMaterial;
    }
}
