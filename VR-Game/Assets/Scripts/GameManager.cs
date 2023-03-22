using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class GameManager : MonoBehaviour
{
   [SerializeField] public GameObject user;
   [SerializeField] public List<GameObject> machine = new List<GameObject>();

    public TextMeshProUGUI enemigos;


    private void Update() 
    {
        WinOrLose(machine);
        
    }

   void WinOrLose(List<GameObject> enemies)
   {
     int counter = 0;
     
    
    foreach(GameObject gameObject in machine)
    {
         enemigos.text=enemies.Count.ToString();
        if(gameObject == null)
        {
            counter++;
        }
    }

    if(counter >= enemies.Count)
    {
        Debug.LogWarning("YOU WIN");
    }

    if(user == null)
    {
        Debug.LogWarning("YOU LOSE");
    }
   } 
}
