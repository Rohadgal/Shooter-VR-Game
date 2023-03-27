using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HealthEnemy : MonoBehaviour
{
   public int initialHealth;
    public int enemyDamage = 10;

    static public GameObject self;

    int currentHealth;
    //public ParticleSystem m_ParticleSystem;

    //public AudioSource audioSourceDamageTaken;

    private void Start() 
    {
        //currentHealth = initialHealth;
        currentHealth =  Mathf.Clamp(initialHealth, 0, 100);  
        Debug.Log("Start health ENEMY: " + currentHealth);

    }
    private void OnTriggerEnter(Collider collider)
    {
  
        if(collider.CompareTag("Bullet"))
        {
            if(currentHealth > 0) 
            {
                currentHealth -= enemyDamage/2;
                Debug.Log("Se llamó Enemy's Health.");
            }
        }
            
        
        // Enemy's health
        
        Debug.Log("ENEMY HEALTH: "+currentHealth);

        if (currentHealth <= 0)
        {   
            Debug.Log("THIS EXPLODED!");
            StartCoroutine(DestroyObject());
        }
    }
    IEnumerator DestroyObject()
    {
        yield return new WaitForSeconds(.5f);
        Destroy(gameObject);
    }
}
