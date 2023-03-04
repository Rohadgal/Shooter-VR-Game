using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoveAroundInCircles : MonoBehaviour
{
    public Transform center;

    Formulas formulas_F = new Formulas();

    public float minSpeed = 22f;
    public float maxSpeed = 30f;
    public float speed = 1.5f;

    public float publicTimer = 3.5f;
    float timer = 3.5f;

    bool isTurningLeft = true;

   public float angle = 0f;

   Quaternion rotation;

    //Transform transform1;

    // Start is called before the first frame update
    void Start()
    {
        Transform transform = this.transform;

        Vector2 forward = transform.forward;
        Vector2 vector1 = center.position;
        Vector2 vector2 = transform.position;

        Vector2 dir = vector2 - vector1;

        angle = Mathf.Acos(Vector2.Dot(forward.normalized, dir.normalized));
    }    
    void Update()
    {
        Vector3 relativePosition = (center.position + new Vector3(0f,2.5f,0f)) - transform.position;
        rotation = Quaternion.LookRotation(relativePosition);

        Quaternion currentPosition = transform.localRotation;

        if(isTurningLeft)
        {
            transform.localRotation = Quaternion.Lerp(currentPosition, rotation, Time.deltaTime);
        }
        else
        {
            angle *= -1;
           
            rotation = Quaternion.AngleAxis(angle, new Vector3(0, 1, 0));

            transform.localRotation = Quaternion.Lerp(currentPosition, rotation, Time.deltaTime);
        }

        Timer();
        
        transform.Translate(0, 0, speed * Time.deltaTime);
    }

    void Timer()
    {
        if (timer > 0)
        {
            timer -= Time.deltaTime;
        }
        else
        {
            speed = Random.Range(minSpeed, maxSpeed);
            rotation = Quaternion.AngleAxis(angle, new Vector3(1, 0, 0));
            float randomNumber = Random.Range(1,50);

            if (randomNumber < 25)
            {
                isTurningLeft = false;
            }

            if (randomNumber > 25)
            {
                isTurningLeft = true;
            }
            timer = publicTimer;
        }
    }
}
