using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LensDistortion : MonoBehaviour
{

    public float t1, t2;
    public float k1, k2,k5;
    public Shader s;
    Material m;

    private void Start()
    {
        m = new Material(s);
    }
    private void Update()
    {
        m.SetFloat("k1", k1);
        m.SetFloat("k2", k2);
        m.SetFloat("t1", t1);
        m.SetFloat("t2", t2);
        m.SetFloat("k5", k5);
    }
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, m);
    }
}
