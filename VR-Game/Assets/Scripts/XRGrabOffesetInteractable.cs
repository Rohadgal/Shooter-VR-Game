using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit;

public class XRGrabOffesetInteractable : XRGrabInteractable
{
    private Vector3 initialLocalPos;
    private Quaternion initialRotation;
    // Start is called before the first frame update
    void Start()
    {
        if(!attachTransform)
        {
            GameObject attachPoint = new GameObject("offset Grab pivot");
            attachPoint.transform.SetParent(transform,false);
            attachTransform = attachPoint.transform;
        }
        else
        {
            initialLocalPos = attachTransform.localPosition;
            initialRotation = attachTransform.localRotation;
        }
    }

    protected override void OnSelectEntered(SelectEnterEventArgs args)
    {
        if(args.interactorObject is XRDirectInteractor)
        {
            attachTransform.position = args.interactorObject.transform.position;
            attachTransform.position = args.interactorObject.transform.position;
        }
        else
        {
            attachTransform.localPosition = initialLocalPos;
            attachTransform.localRotation = initialRotation; 
        }
        base.OnSelectEntered(args);
    }

   
}
