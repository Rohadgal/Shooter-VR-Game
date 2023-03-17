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

    public Transform destino;
    public Transform origen;
    public int tiempo;
    public GameObject bolaPrefab;
    private Vector3 velocidadInicial;
    ShootLogic shootLogic;
    public float timer;

    void Start()
    {
        distance = Formulas.Distance(Ship.transform.position, this.transform.position);
    }

    private void Update()
    {
        velocidadInicial = VelocidadInicialCalculo(destino.transform.position, origen.transform.position, tiempo);
    }
    void FixedUpdate()
    {
        distance = Formulas.Distance(Ship.transform.position, this.transform.position);
        if(CanSeeTarget(Ship.transform, viewAngle, viewRange))
        {
            if(timer > 0.2)
            {
            ShootEnemy();
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
                    //Debug.Log("disparo");
                    return true;
                }
            }
        }
        return false;
    }
    public void ShootEnemy()
    {
        GameObject bola = Instantiate(bolaPrefab, origen.transform.position, Quaternion.identity);
        bola.GetComponent<Rigidbody>().velocity = velocidadInicial;
    }

    public Vector3 VelocidadInicialCalculo(Vector3 destino, Vector3 origen, float tiempo)
    {
        Vector3 distancia = destino - origen;
        float viX = distancia.x / tiempo;
        float viY = distancia.y / tiempo + 0.5f * Mathf.Abs(Physics2D.gravity.y) * tiempo;
        float viZ = distancia.z / tiempo;

        Vector3 velocidadInicial = new Vector3(viX, viY, viZ);
        //print(velocidadInicial);
        return velocidadInicial;
    }
}
