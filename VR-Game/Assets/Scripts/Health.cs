using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Health : MonoBehaviour
{
    const int initialHealth = 20;
    
    int currentHealth = initialHealth;

    public ParticleSystem m_ParticleSystem;

    public void Start()
    {
        
        
    }
    private void OnTriggerEnter(Collider collider)
    {
        if(collider.CompareTag("Bullet"))
        currentHealth -= 10;
        
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
