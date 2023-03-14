using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectEnemy : MonoBehaviour
{
    public GameObject Ship;
    float distance;
    //public float fireDistance = 10f;
    public GameObject Bomb;
    public float viewAngle = 45;
    public float viewRange = 60;

    void Start()
    {
        distance = Formulas.Distance(Ship.transform.position, this.transform.position);
        
    }
    void FixedUpdate()
    {
        distance = Formulas.Distance(Ship.transform.position, this.transform.position);
        if(CanSeeTarget(Ship.transform, viewAngle, viewRange))
        {
           Destroy( Instantiate(Bomb, this.transform.position, Quaternion.identity), 2f);   
        }
    }

    bool CanSeeTarget(Transform target, float viewAngle, float viewRange)
    {
        Vector3 toTarget = target.position - transform.position;
        float angle = Formulas.Angle(transform.forward, toTarget);
        if (angle <= viewAngle)
        {
            Debug.LogError("angulo: "+Formulas.Angle(transform.forward, toTarget));
            if (Physics.Raycast(transform.position, toTarget, out RaycastHit raycastHit, viewRange ))
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
