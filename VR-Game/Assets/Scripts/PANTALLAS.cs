using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PANTALLAS : MonoBehaviour
{
    public GameObject pant1;//perdistess
    public GameObject pant2;//ganastes



    AudioSource audioSource;

    public AudioClip clipMilitar;

    public ButtonSounds2 backgroundMusic;

   
   public void Perdiste()
    {
        pant1.SetActive(true);
        Debug.Log("SE ACTIVO LA PANTALLA DE DERROTA");
    }

    public void Ganaste ()
    {
        pant2.SetActive(true);
        backgroundMusic.audioSource2.Stop();
        //audioSource.clip = clipMilitar;
        //audioSource.Play();
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
