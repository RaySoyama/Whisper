﻿Shader "Custom/ChromaShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}

		
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

            fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				
				
				if (col.r <= col.g && col.r <= col.b)
				{
					col = col.r;
				}

				else if (col.g <= col.r && col.g <= col.b)
				{
					col = col.g;
				}

				else if (col.b <= col.r && col.b <= col.g)
				{
					col = col.b;
				}
				//col.rgb = (col.r + col.g + col.b) / 3;
				//col = 1.5;

				return col;
			}
            ENDCG
        }
    }
}
