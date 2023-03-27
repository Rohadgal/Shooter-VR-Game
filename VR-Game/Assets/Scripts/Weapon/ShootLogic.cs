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

    int shotCounter = 0;

    public AudioSource audioSource;

   // public int coolInt;
    //public int sumaDisparo=10;


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

        cooldownTimer = Mathf.Clamp(cooldownTimer,0f, 7f);
         
    }

    void Update()
    {
        cooldownTimer = Mathf.Clamp(cooldownTimer,0f, 7f);
        if (estoyDisparando == false)
        {
           // if(lineRenderer)
            //lineRenderer.positionCount = totalSegmentos * tiempo;
            //DibujarLinea(velocidadInicial, tiempo);
            velocidadInicial = VelocidadInicialCalculo(destino.transform.position, origen.transform.position, tiempo);

        }

        if (shootEnabled == false)
        {

            test = true;
            isShooting = false;

        }

        if (cooldownTimer >= 7)
        {
            isShooting = false;
            shootEnabled = false;
            test = true;
            cooldownTimer -= Time.deltaTime;
            print("aqui test se pasa a true y deberia bajar");
            RefreshSlider();
        }

        if(isShooting==false)
        {
            test=true;
            cooldownTimer -= Time.deltaTime;
            Debug.LogWarning("se paso a falso y empezo a bajar");
             RefreshSlider();
        }
    }
    public void Shoot(ActivateEventArgs arg)
    {
 if(shootEnabled == true)
        {
        cooldownTimer++;
        timer += Time.deltaTime;
        //Debug.LogError("aqui esta sumando");
        isShooting = true;
        //Debug.Log("isShooting es true");
        GameObject bola = Instantiate(bolaPrefab, origen.transform.position, Quaternion.identity);
        audioSource.Play();
        //audioSource.Stop();
        bola.GetComponent<Rigidbody>().velocity = velocidadInicial;
        timer = 0;
        isShooting = false;
        //Debug.Log("isShooting cambio a false y ya no deberia sumar");

        RefreshSlider();
        shotCounter++;
        }

        if (cooldownTimer <= 0)
        {
            test = false;
            shootEnabled = true;
        }


        if (isShooting == true)

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

    public int GetshotCounter()
    {
        return shotCounter;
    }

}
