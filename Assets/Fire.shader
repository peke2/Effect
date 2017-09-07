Shader "Effect/Fire"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_FluctTex ("Fluct", 2D) = "white" {}
		_StrengthTex ("Strength", 2D) = "white" {}
		_UvOffset ("Offset", Vector) = (0,0,0,0)

	}
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		BlendOp Add
		ZWrite Off
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
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

			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _FluctTex;
			sampler2D _StrengthTex;

			float4 _UvOffset;


			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv = v.uv;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				//fixed4 col = tex2D(_MainTex, i.uv);

				float2 uv = i.uv;
				uv.xy += _UvOffset.xy;
				float4 fluct = tex2D(_FluctTex, uv);

				float4 strength = tex2D(_StrengthTex, i.uv);

				float2 colUv = i.uv;
				colUv.y += (-fluct.a + 0.7f) * strength.a * 0.8f;
				//colUv.y += fluct.a;
				colUv.y = clamp(colUv.y, 0, 1);

				fixed4 col = tex2D(_MainTex, colUv);

				return col;
			}
			ENDCG
		}
	}
}
