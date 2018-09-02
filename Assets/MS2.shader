Shader "Custom/MS2"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Color("Shadow Color", Color) = (0, 0, 0, 0.6)
	}

	CGINCLUDE
	#include "UnityCG.cginc"
	#include "AutoLight.cginc"
	struct v2f_shadow {
		float4 pos : SV_POSITION;
		LIGHTING_COORDS(0, 1)
	};
	half4 _Color;
	v2f_shadow vert_shadow(appdata_full v)
	{
		v2f_shadow o;
		o.pos = UnityObjectToClipPos(v.vertex);
		TRANSFER_VERTEX_TO_FRAGMENT(o);
		return o;
	}
	half4 frag_shadow(v2f_shadow IN) : SV_Target
	{
		half atten = LIGHT_ATTENUATION(IN);
		return half4(_Color.rgb, lerp(_Color.a, 0, atten));
	}
	ENDCG


	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdadd_fullshadows
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				float4 screenPos : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.screenPos = ComputeScreenPos(o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				float2 screenUV = i.screenPos.xy / i.screenPos.w;
				// sample the texture
				fixed4 col = tex2D(_MainTex, screenUV);
				return col;
			}
			ENDCG
		}

		// Forward base pass
		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert_shadow
			#pragma fragment frag_shadow
			#pragma multi_compile_fwdbase
			ENDCG
		}
	}
	FallBack "Diffuse"

}
