using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShootLogic : MonoBehaviour
{
    public Transform destino;
    public Transform origen;
    public int tiempo;
    public int totalSegmentos;
    public GameObject bolaPrefab;
    private LineRenderer lineRenderer;
    private Vector3 puntoParabola;
    private Vector3 velocidadInicial;
    private bool estoyDisparando = false;
    public float timer = 1;





    void Start()
    {
        lineRenderer= GetComponent<LineRenderer>();
    }

    void Update()
    {
        if (estoyDisparando == false)
        {
            lineRenderer.positionCount = totalSegmentos * tiempo;
            velocidadInicial = VelocidadInicialCalculo(destino.transform.position, origen.transform.position, tiempo);
            DibujarLinea(velocidadInicial, tiempo);

        }

        Shoot();
    }

    public void Shoot()
    {
        if (Input.GetMouseButton(0) && timer == 1)
        {
            GameObject bola = Instantiate(bolaPrefab, origen.transform.position, Quaternion.identity);
            bola.GetComponent<Rigidbody>().velocity = velocidadInicial;
            timer = 0;

        }

        if (Input.GetMouseButton(0))
        {
            timer += Time.deltaTime;
        }
    }
    private Vector3 VelocidadInicialCalculo(Vector3 destino,Vector3 origen, float tiempo)
    {
        Vector3 distancia = destino - origen;
        float viX = distancia.x / tiempo;
        float viY = distancia.y / tiempo + 0.5f * Mathf.Abs(Physics2D.gravity.y) * tiempo;
        float viZ = distancia.z / tiempo;

        Vector3 velocidadInicial = new Vector3(viX, viY, viZ);
        print(velocidadInicial);
        return velocidadInicial;
    }

    private Vector3 PosicionEnElTiempo(Vector3 velocidadInicial, float tiempo)
    {
        Vector3 posicionEnElTiempo = new Vector3(origen.transform.position.x + velocidadInicial.x * tiempo, (-0.5f * Mathf.Abs(Physics2D.gravity.y) * (tiempo * tiempo)) + (velocidadInicial.y * tiempo) + origen.transform.position.y, origen.transform.position.z + velocidadInicial.z * tiempo);
        return posicionEnElTiempo;
    }

    private void DibujarLinea(Vector3 velocidadInicial, float tiempo)
    {
        for(int i = 0; i < totalSegmentos * tiempo; i++)
        {
            Vector3 posicionTemporal = PosicionEnElTiempo(velocidadInicial, (i/(totalSegmentos* tiempo)) * tiempo);
            lineRenderer.SetPosition(i, posicionTemporal);

            if(i == 5)
            {
                puntoParabola = posicionTemporal;
            }
        }
    }


    IEnumerator DelayShoot()
    {
        yield return new WaitForSeconds(3);
        GameObject bola = Instantiate(bolaPrefab, origen.transform.position, Quaternion.identity);
        bola.GetComponent<Rigidbody>().velocity = velocidadInicial;
    }

}
