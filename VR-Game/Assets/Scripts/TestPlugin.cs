using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using LibraryPhysics;

public class TestPlugin : MonoBehaviour
{
    PhysicsFormula physicsFormula = new PhysicsFormula();

    // Start is called before the first frame update
    void Start()
    {
        physicsFormula.Sum(2, 4);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
