using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectEnemy : MonoBehaviour
{
    public GameObject Ship;
    float distance;
    public float fireDistance = 10f;
    public GameObject Bomb;

    void Start()
    {
        distance = Formulas.Distance(Ship.transform.position, this.transform.position);
        
    }
    // Update is called once per frame
    void Update()
    {
        distance = Formulas.Distance(Ship.transform.position, this.transform.position);
      
        //if (distance < fireDistance)
        if(CanSeeTarget(Ship.transform, 45, 60))
        {
            Debug.Log(distance);
            Debug.Log("El enemigo está cerca.");
           Destroy( Instantiate(Bomb, this.transform.position, Quaternion.identity), 2f);
            
        }
        
    }

    bool CanSeeTarget(Transform target, float viewAngle, float viewRange)
    {
        //float angle = Formulas.Angle(transform.worldToLocalMatrix.MultiplyVector(transform.forward), Ship.transform.position);
        //Debug.Log("Angle: " + angle);
        //return angle;
        Vector3 toTarget = target.position - transform.position;
        if(Vector3.Angle(transform.forward, toTarget) <= viewAngle)
        {
            if(Physics.Raycast(transform.position, toTarget, out RaycastHit raycastHit, viewRange ))
            {
                if(raycastHit.transform.root == target)
                {
                    return true;
                }
            }
        }
        return false;
    }

    
}
