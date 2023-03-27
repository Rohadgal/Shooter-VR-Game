using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectEnemy : MonoBehaviour
{
    public ShootEnemy shootEnemy;
    public GameObject Ship;
    float distance;
    //public float fireDistance = 10f;
    public GameObject Bomb;
    public float viewAngle = 45;
    public float viewRange = 60;

   
    float timer;

    void Start()
    {
        distance = Formulas.Distance(Ship.transform.position, this.transform.position);
    }

  
    void FixedUpdate()
    {
        if(Ship!=null) distance = Formulas.Distance(Ship.transform.position, this.transform.position);
        
        if(CanSeeTarget(Ship.transform, viewAngle, viewRange))
        {
            // El número permite dar una pausa entre los disparos
            if(timer > 0.4)
            {
            shootEnemy.Shoot();
            timer =0;
            }
            timer += Time.deltaTime;
            //Destroy( Instantiate(Bomb, this.transform.position, Quaternion.identity), 2f);   
        }
    }

    bool CanSeeTarget(Transform shipTarget, float viewAngle, float viewRange)
    {
        Vector3 toTarget = shipTarget.position - transform.position;
        float angle = Formulas.Angle(transform.forward, toTarget);
        if (angle <= viewAngle)
        {
           // Debug.LogError("angulo: "+ Vector3.Angle(transform.forward, toTarget));
            if (Physics.Raycast(transform.position, toTarget, out RaycastHit raycastHit, viewRange ))
            {

                //Debug.LogError("Casi Disparo.");
                if (raycastHit.transform == shipTarget)  
                {                
                    Debug.Log("disparo");
                    return true;
                }
            }
        }
        return false;
    }
   
}
