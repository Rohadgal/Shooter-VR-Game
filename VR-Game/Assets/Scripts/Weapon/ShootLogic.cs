using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.UI;
using UnityEngine.XR;
using UnityEngine.XR.Interaction.Toolkit;

public class ShootLogic : MonoBehaviour
{
    public Image slider;
    public Transform destino;
    public Transform origen;
    public int tiempo;
    public int totalSegmentos;
    public GameObject bolaPrefab;
    private LineRenderer lineRenderer;
    private Vector3 puntoParabola;
    private Vector3 velocidadInicial;
    private bool estoyDisparando = false;
    public bool shootEnabled = true;
    public bool test;
    public bool isShooting;
    public float timer = 1;
    public float cooldownTimer;
    public float maxCooldown = 7;


   // public InteractableCheck interactableCheck;
    //private InputAction.CallbackContext context;


    //public InputDevice target;


    //public InputActionReference 


    void Start()
    {
        lineRenderer = GetComponent<LineRenderer>();
        shootEnabled = true;

        XRGrabInteractable grabble = GetComponent<XRGrabInteractable>();
        grabble.activated.AddListener(Shoot);
         
    }

    void Update()
    {
        if (estoyDisparando == false)
        {
            lineRenderer.positionCount = totalSegmentos * tiempo;
            velocidadInicial = VelocidadInicialCalculo(destino.transform.position, origen.transform.position, tiempo);
            DibujarLinea(velocidadInicial, tiempo);

        }

        /*if(shootEnabled == true)
        {
            Shoot();
        }*/



        if (test == true)
        {
            cooldownTimer -= Time.deltaTime;
        }

        if (shootEnabled == false)
        {
            test = true;
            isShooting = false;
        }

        if (cooldownTimer <= 0)
        {
            test = false;
            shootEnabled = true;
        }

        RefreshSlider();

        /*if (interactableCheck.grabActive == true)
        {
            shootEnabled = true;

           
        }
        else
            shootEnabled = false;*/

    }



    public void Shoot(ActivateEventArgs arg)
    {

        //if (Input.GetMouseButton(0) && timer >= 0.5f)

                isShooting = true;
                GameObject bola = Instantiate(bolaPrefab, origen.transform.position, Quaternion.identity);
                bola.GetComponent<Rigidbody>().velocity = velocidadInicial;
                timer = 0;
            

        //triggerValue !=0
        //if (Input.GetMouseButton(0))


        if (isShooting == true)

        {
            timer += Time.deltaTime;
            cooldownTimer += Time.deltaTime;
            test = false;
        }
        else
        {
            test = true;
        }

        if (cooldownTimer >= 7)
        {
            isShooting = false;
            shootEnabled = false;
        }

        if (cooldownTimer <= 0)
        {
            test = false;
        }
    }

    public void CheckTimer()
    {
        if (isShooting == true)
        {
            timer += Time.deltaTime;
            cooldownTimer += Time.deltaTime;
            test = false;
        }
        else
        {
            test = true;
        }
    }

    public void cooldownRefresh()
    {

        cooldownTimer -= Time.deltaTime;

    }
    /*public void ShootCooldown()
    {
        if(Input.GetMouseButton(0) && cooldownTimer >= 0)
        {
            cooldownTimer += Time.deltaTime;
        }

    }*/

    public void RefreshSlider()
    {
        slider.fillAmount = cooldownTimer / maxCooldown;
    }
    private Vector3 VelocidadInicialCalculo(Vector3 destino, Vector3 origen, float tiempo)
    {
        Vector3 distancia = destino - origen;
        float viX = distancia.x / tiempo;
        float viY = distancia.y / tiempo + 0.5f * Mathf.Abs(Physics2D.gravity.y) * tiempo;
        float viZ = distancia.z / tiempo;

        Vector3 velocidadInicial = new Vector3(viX, viY, viZ);
        //print(velocidadInicial);
        return velocidadInicial;
    }

    private Vector3 PosicionEnElTiempo(Vector3 velocidadInicial, float tiempo)
    {
        Vector3 posicionEnElTiempo = new Vector3(origen.transform.position.x + velocidadInicial.x * tiempo, (-0.5f * Mathf.Abs(Physics2D.gravity.y) * (tiempo * tiempo)) + (velocidadInicial.y * tiempo) + origen.transform.position.y, origen.transform.position.z + velocidadInicial.z * tiempo);
        return posicionEnElTiempo;
    }

    private void DibujarLinea(Vector3 velocidadInicial, float tiempo)
    {
        for (int i = 0; i < totalSegmentos * tiempo; i++)
        {
            Vector3 posicionTemporal = PosicionEnElTiempo(velocidadInicial, (i / (totalSegmentos * tiempo)) * tiempo);
            lineRenderer.SetPosition(i, posicionTemporal);

            if (i == 5)
            {
                puntoParabola = posicionTemporal;
            }
        }
    }

}
