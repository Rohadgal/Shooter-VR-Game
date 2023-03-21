using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShootEnemy : MonoBehaviour
{

     public Transform destino;
    public Transform origen;
    public int tiempo;
    public GameObject bolaPrefab;
    private Vector3 velocidadInicial;
    ShootLogic shootLogic;


      private void Update()
    {
        velocidadInicial = VelocidadInicialCalculo(destino.transform.position, origen.transform.position, tiempo);
    }
  public void Shoot()
    {
        GameObject bola = Instantiate(bolaPrefab, origen.transform.position, Quaternion.identity);
        bola.transform.Rotate(180, 0, 0);
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
