using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Audio : MonoBehaviour
{
    public AudioSource audioSource1;
    public AudioClip clip1;
    public AudioSource audioSource2;
    public AudioClip clip2;
    // Start is called before the first frame update
    void Start()
    {
        audioSource1.clip = clip1;
        audioSource2.clip = clip2;

    }

    public void PlaySound()
    {
        audioSource1.Play();
    }

    public void BackgroundMusic()
    {
        audioSource2.Play();
    }

    public void StopMusic()
    {
        audioSource2.Pause();
    }
}

