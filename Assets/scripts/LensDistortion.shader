Shader "Effect/LensDistortion"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		k1 ("k1",Float) = 0
		k2 ("k2",Float) = 0
		k3 ("t1",Float) = 0
		k4 ("t2",Float) = 0
		k5 ("k5",Float) = 0
		
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			float k1;
			float k2;
			float k5;

			float k3;
			float k4;
			// Distortion equations taken from http://www.vision.caltech.edu/bouguetj/calib_doc/htmls/parameters.html
			fixed4 frag (v2f i) : SV_Target
			{
				float2 uv = float2(i.uv.x,i.uv.y);
				uv = uv*2-1;					//Using normalized [-1,1] coordinates
				float r2 = uv.x*uv.x+uv.y*uv.y; //distance from the center

				float radial = uv*(k1*r2+k2*(r2*r2)+k5*(r2*r2*r2));
				float2 tangential = float2(
					2*k3*uv.x*uv.y+ k4*(r2+2*uv.x*uv.x),
					2*k4*uv.x*uv.y+ k3*(r2+2*uv.y*uv.y)
					);
				uv = uv + radial + tangential;	// APPLY
				
				uv = uv*0.5f+0.5f;  			//revert to normalized [0,1] coordinates

				//fixed4 output = fixed4(uv.x,uv.y,0,1);
				fixed4 col = tex2D(_MainTex, uv);
				fixed4 output = col;
				if(uv.x<0 || uv.x>1 || uv.y <0 || uv.y>1)
					return float4(0,0,0,0);
				else
					return output;
			}
			ENDCG
		}
	}
}
