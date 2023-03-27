using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class GameManager : MonoBehaviour
{
   [SerializeField] public GameObject user;
   [SerializeField] public List<GameObject> machine = new List<GameObject>();

    public TextMeshProUGUI cantidadEnemigosRestantes;

    public TextMeshProUGUI tiempoJugando;
    public PANTALLAS pANTALLAS;

    int enemiesDestroyedCounter;
    int enemiesInList;

    public GameObject HUD;

    float timePlaying;

    bool isPlaying = true;

    bool gameIsOver;

    public AudioSource victoryMusic;
    private void Start() 
    {
        timePlaying = 0;
        if(machine != null) enemiesInList = machine.Count;

       // enemiesDestroyedCounter = enemiesInList;
        Debug.Log("ENEMIES: "+ enemiesInList);
    }
    private void Update() 
    {
        if(isPlaying) timePlaying += Time.deltaTime;

        TimePlayingGame();
        
        if(gameIsOver)
        {
            victoryMusic.PlayDelayed(1f);
        }
        
        WinOrLose(machine);
        cantidadEnemigosRestantes.text = enemiesDestroyedCounter.ToString(); 
    }

   void WinOrLose(List<GameObject> enemies)
   {
     int counter = 0;
        foreach(GameObject gameObject in machine)
        {
            //cantidadEnemigosRestantess.text=enemies.Count.ToString();
            if(gameObject == null)
            {
                counter++;
                Debug.Log("cOUNTER: "+ counter);
            }
        }

        enemiesDestroyedCounter = enemiesInList - counter;

        if(counter >= enemies.Count)
        {
            Debug.LogWarning("YOU WIN");
            pANTALLAS.Ganaste();
            isPlaying = false;
            gameIsOver = true;
            timePlaying = 0;
            StartCoroutine(DeactivateHud());
        }

        if(user == null)
        {
            Debug.LogWarning("YOU LOSE");
            pANTALLAS.Perdiste();
            isPlaying = false;
            gameIsOver = true;
            timePlaying = 0;
            StartCoroutine(DeactivateHud());
        }
   } 

   IEnumerator DeactivateHud()
   {
        yield return new WaitForSeconds(.3f);
        HUD.SetActive(false);
        Debug.Log("Se desactivo el hud");
   }

   void TimePlayingGame()
   {
        float minutes = Mathf.FloorToInt(timePlaying / 60);
        float seconds = Mathf.FloorToInt(timePlaying % 60);
        tiempoJugando.text = string.Format("{0:00} : {1:00}", minutes, seconds);
   }


}
