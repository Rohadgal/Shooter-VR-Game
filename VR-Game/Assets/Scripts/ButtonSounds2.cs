using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonSounds2 : MonoBehaviour
{
    public AudioSource audioSource1;
    public AudioClip clip1;
    public AudioSource audioSource2;
    public AudioClip clip2;

    public AudioSource victoryMusic;
    // Start is called before the first frame update
    void Start()
    {
        audioSource1.clip = clip1;
        audioSource2.clip = clip2;

    }

    // Se encargo de los sonidos de los botones en el canvas
    public void PlaySound()
    {
        audioSource1.Play();
    }

    // Música de fondo para el juego
    public void BackgroundMusic()
    {
        audioSource2.Play();
    }

    public void PlayVictoryMusic()
    {
        audioSource2 = victoryMusic;
        audioSource2.Play();
    }

    /*public void StopMusic()
    {
        audioSource2.Pause();
    }*/
    // public AudioClip PlayVictoryMusic()
    // {
    //     AudioClip musicaDeVictoria;
    //     musicaDeVictoria = victoryMusic.GetComponent<AudioClip>();
    //     return musicaDeVictoria;
    // }
}

