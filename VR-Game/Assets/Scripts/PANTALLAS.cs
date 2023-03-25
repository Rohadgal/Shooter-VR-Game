using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PANTALLAS : MonoBehaviour
{
    public GameObject pant1;//perdistess
    public GameObject pant2;//ganastes



    //AudioSource audioSource;
    public ButtonSounds2 backgroundMusic;

    public AudioClip clipMilitar;
    public AudioClip clipDerrota;
    public AudioSource AudioS1;
    public AudioSource AudioS2;


    void Start()
    {
        AudioS1.clip = clipMilitar;
        AudioS2.clip = clipDerrota;
    }


    public void Perdiste()
    {
        pant1.SetActive(true);
        AudioS2.Play();
        Debug.Log("SE ACTIVO LA PANTALLA DE DERROTA");
    }

    public void Ganaste ()
    {
        pant2.SetActive(true);
        backgroundMusic.audioSource2.Stop();
        //audioSource.clip = clipMilitar;
        AudioS1.Play();
        Debug.Log("SE ACTIVO LA PANTALLA DE VICTORIA");
    }

    public void MENUAgn()

    {
        SceneManager.LoadScene(0);
    }

    public void Again()
    {
        //Corregir esto
        SceneManager.UnloadSceneAsync("LevelGame");
        SceneManager.LoadScene(1);
    }

}
