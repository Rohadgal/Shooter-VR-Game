using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Menu : MonoBehaviour
{
    public GameObject mainMenu;
    // Start is called before the first frame update
    public void StartGEIM()
    {
        
        SceneManager.LoadScene("LevelGame", LoadSceneMode.Additive);
        StartCoroutine(deactivateMENU());
    }

    // Update is called once per frame
    public void ExitGeim()
    {
        Application.Quit();
    }

    IEnumerator deactivateMENU()
    {
        yield return new WaitForSeconds(.2f);
        mainMenu.SetActive(false);
    }
}

