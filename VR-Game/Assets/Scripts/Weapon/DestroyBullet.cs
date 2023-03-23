using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyBullet : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        OnDestroy();
    }
    private void OnTriggerEnter(Collider other) 
    {
        if(other.CompareTag("Player"))
        Destroy(gameObject);    
    }

    public void OnDestroy()
    {
        Destroy(this.gameObject,4);
    }
}
