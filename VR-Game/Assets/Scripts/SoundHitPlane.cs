using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundHitPlane : MonoBehaviour
{
    public AudioSource planeHitSound;
   
   private void OnTriggerEnter(Collider bullet) 
   {
        if(bullet.CompareTag("Bullet"))
        {
            if(planeHitSound)
            {
                planeHitSound.Play();
            }
        }
   }
}
