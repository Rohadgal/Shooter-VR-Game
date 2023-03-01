using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Health : MonoBehaviour
{
    const int initialHealth = 100;
    
    int currentHealth = initialHealth;

    private void OnTriggerEnter(Collider collider)
    {
        if(collider.name == "Bullet")
        currentHealth -= 10;
        
        Debug.Log(currentHealth);
    }
}
