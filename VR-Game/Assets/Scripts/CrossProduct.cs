using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrossProduct : MonoBehaviour
{
    static public Vector3 CrossPct(Vector3 vect1, Vector3 vect2)
    {
        float xMult = vect1.y * vect2.z - vect1.z * vect2.y;
        float yMult = vect1.z * vect2.x - vect1.x * vect2.z;
        float zMult = vect1.x * vect2.y - vect1.y * vect2.x;
        return new Vector3(xMult, yMult, zMult);
    }
}
