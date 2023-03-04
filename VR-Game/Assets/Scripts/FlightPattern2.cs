using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlightPattern2 : MonoBehaviour
{
    //[SerializeField] float angleToRotate = 90f;
    //[SerializeField] float speed = 1f;
    [SerializeField] float height = 10f;
    [SerializeField] float advanceSpeed = 40f;
    public Vector3 publicRotation;
    Quaternion targetRotation;

    public Transform target;

    Quaternion rotation;

    public float publicTimer = 3.5f;
    float timer = 3.5f;

    bool bIsMovingAway = false;

    int changeValue = 1;

    [SerializeField] public float angleIntensity = 1f;

    //float sineValue;

    void Start()
    {
        Vector3 relativePosition = (target.position + new Vector3(0f, 5f, 0f)) - transform.position;
        rotation = Quaternion.LookRotation(relativePosition);
    }

    private void FixedUpdate()
    {
        Timer();

        Quaternion currentPosition = transform.localRotation;

       //transform.localRotation = Quaternion.Slerp(currentPosition, new Quaternion(1, 0, Mathf.PingPong(Time.time, 3),0), Time.deltaTime);

        if(!bIsMovingAway)
        {
          
            transform.localRotation = Quaternion.Slerp(currentPosition, rotation, Time.deltaTime);  
        }
        transform.Translate(0, 0, advanceSpeed * Time.deltaTime);

        // MATH PING PONG TO MAKE PLANE GO UP AND DOWN
        Vector3 relativePosition = (target.position + new Vector3(0, Quaternion.Euler(publicRotation).y * height, 0f)) - transform.position;
        rotation = Quaternion.LookRotation(relativePosition);
        //rotation *= Quaternion.AngleAxis(90, new Vector3(0, 0, 1)); 
    }

    void Timer()
    {
        if (timer > 0)
        {
            timer -= Time.deltaTime;
        }
        else
        {
            bIsMovingAway = !bIsMovingAway;
            changeValue *= -1;
            timer = publicTimer;
        }
    }
}
