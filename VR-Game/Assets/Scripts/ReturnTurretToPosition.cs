using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ReturnTurretToPosition : MonoBehaviour
{
    public Transform postition;
    public GameObject turret;
    // Start is called before the first frame update
    void Start()
    {
       //Instantiate(turret, postition.transform.position, transform.rotation);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    private void OnTriggerEnter(Collider other)
    {
        //if(other.gameObject==turret)
        if(other.tag=="Gun")
        {
            Destroy(turret);
           
            //turret.transform.LookAt(postition.transform.position);
            //Instantiate(turret);
            Instantiate(turret,postition.transform.position,transform.rotation);
            print("si se hizo");
        }

        //Quaternion.identity,
    }
}
