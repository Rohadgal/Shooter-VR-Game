using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HitSound : MonoBehaviour
{
    public AudioSource audioSource;

    private void OnTriggerEnter(Collider ohter)
    {
       if(audioSource!=null)
       {
            //double clipLength = audioSource.clip.samples / audioSource.clip.frequency;
            audioSource.Play();
       }
    }
}
