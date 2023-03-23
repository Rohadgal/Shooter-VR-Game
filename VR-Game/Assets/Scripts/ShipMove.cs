using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipMove : MonoBehaviour
{
    public Transform[] Casillas;
   // public int index;
    public GameObject shipMove;
    public float speed;
    public float rotateSpeed;
    //bool timeisrunning;
    //public float timer = 2f;
    int current = 0;
    float cRadius = 1;


    void Start()
    {
       //timeisrunning = true;
    }

    // Update is called once per frame
    void Update()
    {
        /*if (timeisrunning)
        {
            timer -= Time.deltaTime;
        }


        if (timer <= 0)
        {
           index++;
           timer = 5.5f;          
        }

        float step = speed * Time.deltaTime;
        shipMove.transform.position = Vector3.MoveTowards(shipMove.transform.position, Casillas[index].transform.position, step);
        Quaternion rotShip = Quaternion.LookRotation(Casillas[index].transform.position - shipMove.transform.position);
        shipMove.transform.rotation = Quaternion.RotateTowards(shipMove.transform.rotation, rotShip, rotateSpeed * Time.deltaTime);

        if(index == 4)
        {
            index= 0;
        }*/

        if (Vector3.Distance(Casillas[current].transform.position, shipMove.transform.position) < cRadius) 
        {
            current++;
            if(current >= Casillas.Length)
            {
                current = 0;
            }
        }
        float step = speed * Time.deltaTime;
        shipMove.transform.position = Vector3.MoveTowards(shipMove.transform.position, Casillas[current].transform.position, step);
        Quaternion rotShip = Quaternion.LookRotation(Casillas[current].transform.position - shipMove.transform.position);
        shipMove.transform.rotation = Quaternion.Lerp(shipMove.transform.rotation, rotShip, rotateSpeed * Time.deltaTime);
    }
}

