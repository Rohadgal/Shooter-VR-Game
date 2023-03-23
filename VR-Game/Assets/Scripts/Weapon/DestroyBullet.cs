using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DestroyBullet : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        OnDestroy();
    }

    public void OnDestroy()
    {
        Destroy(this.gameObject,4);
    }
}
