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
    public PANTALLAS pANTALLAS;

    int enemiesDestroyedCounter;
    int enemiesInList;

    public GameObject HUD;

    private void Start() 
    {
        if(machine != null) enemiesInList = machine.Count;

       // enemiesDestroyedCounter = enemiesInList;
        Debug.Log("ENEMIES: "+ enemiesInList);
    }
    private void Update() 
    {
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
                StartCoroutine(DeactivateHud());
            }

        if(user == null)
        {
            Debug.LogWarning("YOU LOSE");
            pANTALLAS.Perdiste();
            StartCoroutine(DeactivateHud());
        }
   } 

   IEnumerator DeactivateHud()
   {
        yield return new WaitForSeconds(.3f);
        HUD.SetActive(false);
   }
}
