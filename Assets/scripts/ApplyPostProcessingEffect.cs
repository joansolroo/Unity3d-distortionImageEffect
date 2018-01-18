using System;
using UnityEngine;

public class ApplyPostProcessingEffect: MonoBehaviour
{
    public Shader s;
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Material m = new Material(s);
        Graphics.Blit(source, destination,m);
    }
}