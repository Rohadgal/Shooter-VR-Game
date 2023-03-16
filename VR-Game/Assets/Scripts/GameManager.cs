using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
   [SerializeField] public GameObject user;
   [SerializeField] public List<GameObject> machine = new List<GameObject>();

    private void Update() 
    {
        WinOrLose(machine);
        
    }

   void WinOrLose(List<GameObject> enemies)
   {
     
    if(!user)
    {
        Debug.LogWarning("YOU LOSE");
    }
    else 
    if(machine.Count == 0)
    {
        Debug.LogWarning("YOU WIN");
    }
    Debug.Log("AKI TOY");
   } 
}
