using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PANTALLAS : MonoBehaviour
{
    public GameObject pant1;//perdistess
    public GameObject pant2;//ganastes

   
   public void Activate1()
    {
        pant1.SetActive(true);
        Debug.Log("SE ACTIVO LA PANTALLA DE DERROTA");
    }

    public void Activate2 ()
    {
        pant2.SetActive(true);
        Debug.Log("SE ACTIVO LA PANTALLA DE VICTORIA");
    }

    public void MENUAgn()

    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 1);
    }

    public void Again()
    {
        Debug.Log("Reload scene");
    }

}
