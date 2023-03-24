using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Health : MonoBehaviour
{
    const int initialHealth = 60;
    
    int currentHealth = Mathf.Clamp(initialHealth, 0, 100);

    //public PANTALLAS pANTALLAS;
    //public GameObject GeimOvr;

    // public ParticleSystem m_ParticleSystem;

    // public AudioSource hitMarker;

    // public Color hitColor;
    // public Color normalColor;

    private void Start() 
    {
        currentHealth =  Mathf.Clamp(initialHealth, 0, 100);   
    }
    private void OnTriggerEnter(Collider collider)
    {
        if(collider.CompareTag("Bullet"))
        {
           // GetComponent<MeshRenderer>().material.color = hitColor;
            if(currentHealth > 0) currentHealth -= 60;//regresar a 10 cuando termines Gil
            // hitMarker.volume = 0.5f;
            // hitMarker.Play();
            //GetComponent<MeshRenderer>().material.color = normalColor;

        }
       
        
        Debug.Log(currentHealth);

        if (currentHealth <= 0)
        {
            // if(m_ParticleSystem != null)
            // {
            // m_ParticleSystem.Play();
            // }
            Debug.Log("THIS EXPLODED!");
            //StartCoroutine(DestroyObject());
            Destroy(gameObject);
            //gameObject.SetActive(true);
            //pANTALLAS.Activate1();
            //Debug.Log("SE ACTIVO LA PANTALLA DE DERROTA");
        }
    }
    IEnumerator DestroyObject()
    {
        yield return new WaitForSeconds(1);
        Destroy(gameObject);
    }

}
