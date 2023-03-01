using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShootLogic : MonoBehaviour
{
    public Transform destino;
    public Transform origen;
    public int tiempo;
    public int totalSegmentos;
   // public GameObject bolaPrefab;
    private LineRenderer lineRenderer;
    private Vector3 puntoParabola;
    private Vector3 velocidadInicial;
    private bool estoyDisparando = false;


    void Start()
    {
        lineRenderer= GetComponent<LineRenderer>();
    }

    void Update()
    {
        if (estoyDisparando == false)
        {
            lineRenderer.positionCount = totalSegmentos * tiempo;
            velocidadInicial = VelocidadInicialCalculo(destino.position, origen.transform.position, tiempo);
            DibujarLinea(velocidadInicial, tiempo);
            RotarDireccion();

        }
    }

    private Vector3 VelocidadInicialCalculo(Vector3 destino, Vector3 origen, float tiempo)
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

    private void RotarDireccion()
    {
        Vector3 direccion = puntoParabola - (Vector3) origen.transform.position;
        float angulo = Mathf.Atan2(direccion.x, direccion.y) * Mathf.Rad2Deg;
        origen.transform.rotation = Quaternion.AngleAxis(angulo, Vector3.forward);
    }
}
