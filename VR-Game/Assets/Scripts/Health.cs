using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Health : MonoBehaviour
{
    public int initialHealth;
    public int damage = 10;

    //public int enemyDamage = 10;

    static public GameObject self;

    int currentHealth;
    //public ParticleSystem m_ParticleSystem;

    public AudioSource audioSource;

    public Image[] lifeImages;
    int deleteImagesIterator;

    private void Start() 
    {
        //currentHealth = initialHealth;
        currentHealth =  Mathf.Clamp(initialHealth, 0, 100);  
        //audioSource.volume*=5f;
        Debug.Log("Start health barco: " + currentHealth); 
        Debug.Log("LENGTH: " +lifeImages.Length);
        deleteImagesIterator = lifeImages.Length -1;
    }
    private void OnTriggerEnter(Collider collider)
    {
       
        // Player's health
        if(collider.CompareTag("EnemyBullet"))
        {
            if(currentHealth > 0) 
            {
                audioSource.Play();
                currentHealth -= damage;
                Debug.Log("Se llamó Player's Health.");
                lifeImages[deleteImagesIterator].gameObject.SetActive(false);
                if(lifeImages.Length > 0) deleteImagesIterator--;
            }
            //hitMarker.volume = 0.5f;
            //hitMarker.Play();
        }
       
        
        Debug.Log("HEALTH: "+currentHealth);

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
