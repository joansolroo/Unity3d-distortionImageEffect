using System;
using UnityEngine;
using UnityEngine.PostProcessing;

public class Grayscale: MonoBehaviour
{
    public Shader s;
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Material m = new Material(s);
        Graphics.Blit(source, destination,m);
    }
}