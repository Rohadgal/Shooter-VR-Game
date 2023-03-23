using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Health : MonoBehaviour
{
    const int initialHealth = 20;
    
    int currentHealth = initialHealth;

    public ParticleSystem m_ParticleSystem;

    public AudioSource hitMarker;

    public Color hitColor;
    public Color normalColor;
    public GameObject avion;

    public void Start()
    {
        //Destroy(gameObject, 5f);

    }
    private void OnTriggerEnter(Collider collider)
    {
        if(collider.CompareTag("Bullet"))
        {
           // GetComponent<MeshRenderer>().material.color = hitColor;
            currentHealth -= 10;
            hitMarker.volume = 0.5f;
            hitMarker.Play();
            //GetComponent<MeshRenderer>().material.color = normalColor;

        }
       
        
        Debug.Log(currentHealth);

        if (currentHealth <= 0)
        {
            if(m_ParticleSystem != null)
            {
            m_ParticleSystem.Play();
            }
            Debug.Log("THIS EXPLODED!");          
            StartCoroutine(DestroyObject());
        }
    }
    IEnumerator DestroyObject()
    {
        yield return new WaitForSeconds(5);
        Destroy(gameObject);
    }

}
