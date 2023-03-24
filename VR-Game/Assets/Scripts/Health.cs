using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Health : MonoBehaviour
{
    public int initialHealth = 100;
    public int damage = 10;

    static public GameObject self;

    int currentHealth;
    public ParticleSystem m_ParticleSystem;

    public AudioSource audioSource;

    bool isDead;

    private void Start() 
    {
        currentHealth = initialHealth;
        currentHealth =  Mathf.Clamp(initialHealth, 0, 100);  
        //audioSource.volume*=5f;
    }
    private void OnTriggerEnter(Collider collider)
    {
        if(collider.CompareTag("Bullet"))
        {
            if(currentHealth > 0) 
            {
                currentHealth -= damage/2;
            }
            //hitMarker.volume = 0.5f;
            //hitMarker.Play();
        }
       
        
        Debug.Log(currentHealth);

        if (currentHealth <= 0)
        {   
            isDead = true;
            if(audioSource!=null && isDead) 
            {   
                Debug.Log("Antes del play");
                audioSource.Play();
                Debug.Log("Despues del play");
            }

            Debug.Log("THIS EXPLODED!");
            StartCoroutine(DestroyObject());
            //Destroy(gameObject);
        }
    }
    IEnumerator DestroyObject()
    {
        isDead = false;
        yield return new WaitForSeconds(.5f);
        Destroy(gameObject);
    }

    // IEnumerator RestoreHitColor()
    // {
    //     yield return new WaitForSeconds(1);
    //     GetComponent<MeshRenderer>().material.color = normalColor;
    // }
}
