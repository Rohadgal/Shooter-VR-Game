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
    
        if(distance < fireDistance)
        {
            Debug.Log(distance);
            Debug.Log("El enemigo está cerca.");
            Instantiate(Bomb, this.transform.position, Quaternion.identity);
        }
    }


}
