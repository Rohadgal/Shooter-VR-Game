// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VaxKun/WaterShaderTesselation"
{
	Properties
	{
		_DepthColor0("DepthColor0", Color) = (0.254902,0.7450981,0.7137255,1)
		_DepthColor1("DepthColor1", Color) = (0.2862745,0.4470589,0.7176471,1)
		_DepthColor2("DepthColor2", Color) = (0.1803922,0.2078432,0.4352942,1)
		_ColorPosition0("ColorPosition0", Float) = 1
		_ColorPosition1("ColorPosition1", Float) = 1
		_FresnelColor("FresnelColor", Color) = (0.4862745,0.8980393,0.8705883,1)
		_FresnelExponent("FresnelExponent", Range( 0 , 10)) = 8.4
		[Toggle(_VERTEXOFFSET_ON)] _VertexOffset("VertexOffset", Float) = 0
		_WavesAmplitude("WavesAmplitude", Range( 0 , 10)) = 1
		_WavesIntensity("WavesIntensity", Float) = 1
		_WavesSpeed("Waves Speed", Float) = 1
		[Toggle(_MAINFOAMPOWER_ON)] _MainFoamPower("MainFoamPower", Float) = 0
		_FoamColor("FoamColor", Color) = (1,1,1,1)
		_MainFoamDistance("Main Foam Distance", Range( 0 , 10)) = 7.4
		_MainFoamOpacity("MainFoamOpacity", Range( 0 , 1)) = 0.92
		_MainFoamScale("MainFoamScale", Float) = 5
		_MainFoamSpeed("MainFoamSpeed", Float) = 0.2
		_SecondaryFoamIntensity("SecondaryFoamIntensity", Range( 0 , 1)) = 0.3
		_SecondaryFoamDistance("SecondaryFoamDistance", Range( 0 , 10)) = 2
		_SecondaryFoamScale("SecondaryFoamScale", Float) = 5
		_SecondaryFoamSpeed("SecondaryFoamSpeed", Float) = 0.2
		_ReflectionsIntensity("ReflectionsIntensity", Range( 0 , 3)) = 1
		[Toggle(_REALTIMEREFLECTIONS_ON)] _RealtimeReflections("RealtimeReflections", Float) = 0
		_LightColorIntensity("LightColorIntensity", Range( 0 , 1)) = 0.75
		_TurbulenceScale("TurbulenceScale", Float) = 1
		_TurbulenceDistortionIntensity("Turbulence Distortion Intensity", Range( 0 , 6)) = 0.8
		_WaveDistortionIntensity("Wave Distortion Intensity", Range( 0 , 4)) = 0.6
		_SpecularExponent("SpecularExponent", Range( 0 , 1)) = 0.18
		_SpecularIntensity("SpecularIntensity", Range( 0 , 1)) = 1
		[Toggle(_NORMALS_ON)] _Normals("Normals", Float) = 0
		_NormalsIntensity("NormalsIntensity", Range( 0 , 5)) = 0
		_NormalsScale("NormalsScale", Float) = 1
		[Toggle(_ISSPECULARNORMALINTENSITY_ON)] _isSpecularNormalIntensity("isSpecularNormalIntensity", Float) = 0
		_Opacity("Opacity", Range( 0 , 1)) = 0.95
		_DepthOpacity("DepthOpacity", Float) = 5
		[Normal]_WavesNormal("WavesNormal", 2D) = "bump" {}
		_ReflectionTex("ReflectionTex", 2D) = "black" {}
		_FoamTexture("FoamTexture", 2D) = "white" {}
		_RefractionIntensity("RefractionIntensity", Float) = 1
		[Toggle(_LIGHTS_ON)] _Lights("Lights", Float) = 0
		[Toggle]_ProceduralFoam("Procedural  Foam", Float) = 0
		_ProceduralDistance("Procedural Distance", Float) = 1
		_ProceduralFoamSpeed("ProceduralFoamSpeed", Float) = 0.5
		_ProceduralTiling("ProceduralTiling", Float) = 10
		_MinimumFoamDistance("MinimumFoamDistance", Float) = 2
		_MinimumFoamIntensity("MinimumFoamIntensity", Range( 0 , 1)) = 1
		_ProceduralDepthOpacity("ProceduralDepthOpacity", Float) = 1
		_Tesselation("Tesselation", Float) = 1
		[Toggle]_ProceduralFoam("ProceduralFoamShadows", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma shader_feature_local _VERTEXOFFSET_ON
		#pragma shader_feature_local _REALTIMEREFLECTIONS_ON
		#pragma shader_feature _NORMALS_ON
		#pragma shader_feature_local _ISSPECULARNORMALINTENSITY_ON
		#pragma shader_feature_local _MAINFOAMPOWER_ON
		#pragma shader_feature_local _LIGHTS_ON
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha noshadow exclude_path:deferred nolightmap  nodirlightmap vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _WavesSpeed;
		uniform sampler2D _WavesNormal;
		uniform float4 _WavesNormal_ST;
		uniform float _WavesAmplitude;
		uniform float _WavesIntensity;
		uniform sampler2D _ReflectionTex;
		uniform float _WaveDistortionIntensity;
		uniform float _TurbulenceScale;
		uniform float _TurbulenceDistortionIntensity;
		uniform float _ReflectionsIntensity;
		uniform float4 _DepthColor0;
		uniform float4 _DepthColor1;
		uniform float4 _DepthColor2;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _ColorPosition0;
		uniform float _ColorPosition1;
		uniform float4 _FresnelColor;
		uniform float _FresnelExponent;
		uniform float _MainFoamSpeed;
		uniform float _NormalsScale;
		uniform float _SpecularIntensity;
		uniform float _NormalsIntensity;
		uniform float _ProceduralFoam;
		uniform float4 _FoamColor;
		uniform sampler2D _FoamTexture;
		uniform float _MainFoamScale;
		uniform float _MainFoamDistance;
		uniform float _MainFoamOpacity;
		uniform float _SecondaryFoamDistance;
		uniform float _SecondaryFoamSpeed;
		uniform float _SecondaryFoamScale;
		uniform float _SecondaryFoamIntensity;
		uniform float _MinimumFoamDistance;
		uniform float _MinimumFoamIntensity;
		uniform float _ProceduralDistance;
		uniform float _ProceduralFoamSpeed;
		uniform float _ProceduralTiling;
		uniform float _ProceduralDepthOpacity;
		uniform float _LightColorIntensity;
		uniform float _SpecularExponent;
		uniform float _Opacity;
		uniform float _DepthOpacity;
		uniform float _RefractionIntensity;
		uniform float _Tesselation;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			float4 temp_cast_1 = (_Tesselation).xxxx;
			return temp_cast_1;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 temp_cast_0 = (0.0).xxx;
			float3 ase_vertexNormal = v.normal.xyz;
			float2 uv_WavesNormal = v.texcoord * _WavesNormal_ST.xy + _WavesNormal_ST.zw;
			float temp_output_71_0 = sin( ( ( _Time.y * _WavesSpeed ) - ( UnpackNormal( tex2Dlod( _WavesNormal, float4( uv_WavesNormal, 0, 0.0) ) ).b * ( _WavesAmplitude * 30.0 ) ) ) );
			float temp_output_67_0 = ( temp_output_71_0 * _WavesIntensity );
			#ifdef _VERTEXOFFSET_ON
				float3 staticSwitch62 = ( ase_vertexNormal * temp_output_67_0 );
			#else
				float3 staticSwitch62 = temp_cast_0;
			#endif
			v.vertex.xyz += staticSwitch62;
		}

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 uv_WavesNormal = i.uv_texcoord * _WavesNormal_ST.xy + _WavesNormal_ST.zw;
			float temp_output_71_0 = sin( ( ( _Time.y * _WavesSpeed ) - ( UnpackNormal( tex2D( _WavesNormal, uv_WavesNormal ) ).b * ( _WavesAmplitude * 30.0 ) ) ) );
			float screenDepth163 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth163 = abs( ( screenDepth163 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( ( (0.2 + (temp_output_71_0 - 0.0) * (0.3 - 0.2) / (1.0 - 0.0)) * ( tex2D( _FoamTexture, ( ( _MainFoamSpeed * _Time.y ) + ( i.uv_texcoord * _MainFoamScale ) ) ).r * _MainFoamDistance ) ) ) );
			float clampResult208 = clamp( distanceDepth163 , 0.0 , 1.0 );
			float clampResult160 = clamp( pow( clampResult208 , 15.0 ) , 0.0 , 1.0 );
			#ifdef _MAINFOAMPOWER_ON
				float staticSwitch159 = clampResult160;
			#else
				float staticSwitch159 = clampResult208;
			#endif
			float temp_output_156_0 = ( ( 1.0 - staticSwitch159 ) * _MainFoamOpacity );
			float screenDepth191 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth191 = abs( ( screenDepth191 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _SecondaryFoamDistance ) );
			float clampResult207 = clamp( distanceDepth191 , 0.0 , 1.0 );
			float temp_output_185_0 = ( ( 1.0 - clampResult207 ) * ( tex2D( _FoamTexture, ( ( _SecondaryFoamSpeed * _Time.y ) + ( i.uv_texcoord * _SecondaryFoamScale ) ) ).r * _SecondaryFoamIntensity ) );
			float FoamMask187 = ( temp_output_156_0 + temp_output_185_0 );
			float screenDepth131 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth131 = abs( ( screenDepth131 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthOpacity ) );
			float clampResult206 = clamp( distanceDepth131 , 0.0 , 1.0 );
			float clampResult127 = clamp( ( (( _ProceduralFoam )?( 0.0 ):( FoamMask187 )) + _Opacity + clampResult206 ) , 0.0 , 1.0 );
			float4 temp_cast_11 = (0.0).xxxx;
			float4 temp_cast_12 = (0.0).xxxx;
			float2 appendResult31 = (float2(( ase_screenPosNorm.x + 0.01 ) , ( ase_screenPosNorm.y + 0.01 )));
			float temp_output_67_0 = ( temp_output_71_0 * _WavesIntensity );
			float Waves68 = temp_output_67_0;
			float2 panner40 = ( 1.0 * _Time.y * float2( 0.01,0.01 ) + ( i.uv_texcoord * _TurbulenceScale ));
			float temp_output_32_0 = ( ( Waves68 * _WaveDistortionIntensity ) + ( UnpackNormal( tex2D( _WavesNormal, panner40 ) ).g * _TurbulenceDistortionIntensity ) );
			float4 lerpResult24 = lerp( ase_screenPosNorm , float4( appendResult31, 0.0 , 0.0 ) , temp_output_32_0);
			#ifdef _REALTIMEREFLECTIONS_ON
				float4 staticSwitch19 = ( tex2D( _ReflectionTex, lerpResult24.xy ) * _ReflectionsIntensity );
			#else
				float4 staticSwitch19 = temp_cast_12;
			#endif
			float screenDepth146 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth146 = abs( ( screenDepth146 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( ( _ColorPosition0 + _ColorPosition1 ) ) );
			float clampResult211 = clamp( distanceDepth146 , 0.0 , 1.0 );
			float4 lerpResult142 = lerp( _DepthColor1 , _DepthColor2 , clampResult211);
			float screenDepth152 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth152 = abs( ( screenDepth152 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _ColorPosition0 ) );
			float clampResult210 = clamp( distanceDepth152 , 0.0 , 1.0 );
			float4 lerpResult140 = lerp( _DepthColor0 , lerpResult142 , clampResult210);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV136 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode136 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV136, _FresnelExponent ) );
			float clampResult209 = clamp( fresnelNode136 , 0.0 , 1.0 );
			float2 temp_cast_16 = (_MainFoamSpeed).xx;
			float2 panner49 = ( 1.0 * _Time.y * temp_cast_16 + ( i.uv_texcoord * _NormalsScale ));
			float3 tex2DNode50 = UnpackNormal( tex2D( _WavesNormal, panner49 ) );
			float SpecularIntensity124 = _SpecularIntensity;
			#ifdef _ISSPECULARNORMALINTENSITY_ON
				float staticSwitch54 = _NormalsIntensity;
			#else
				float staticSwitch54 = SpecularIntensity124;
			#endif
			float4 appendResult57 = (float4(( (tex2DNode50).xy * staticSwitch54 ) , 1.0 , 0.0));
			#ifdef _NORMALS_ON
				float4 staticSwitch59 = appendResult57;
			#else
				float4 staticSwitch59 = float4( float3(0,0,1) , 0.0 );
			#endif
			float4 Normals61 = staticSwitch59;
			float clampResult260 = clamp( ( clampResult209 * Normals61.x ) , 0.0 , 1.0 );
			float4 lerpResult133 = lerp( lerpResult140 , _FresnelColor , clampResult260);
			float4 blendOpSrc14 = staticSwitch19;
			float4 blendOpDest14 = lerpResult133;
			float screenDepth305 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth305 = abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _MinimumFoamDistance ) );
			float clampResult307 = clamp( distanceDepth305 , 0.0 , 1.0 );
			float smoothstepResult310 = smoothstep( 0.0 , 1.0 , ( 1.0 - clampResult307 ));
			float screenDepth299 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth299 = abs( ( screenDepth299 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _ProceduralDistance ) );
			float clampResult324 = clamp( ( 1.0 - distanceDepth299 ) , 0.0 , 1.0 );
			float clampResult331 = clamp( sin( ( ( clampResult324 + ( _ProceduralFoamSpeed * _Time.y ) ) * _ProceduralTiling ) ) , 0.0 , 1.0 );
			float screenDepth380 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth380 = abs( ( screenDepth380 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _ProceduralDepthOpacity ) );
			float clampResult300 = clamp( distanceDepth380 , 0.0 , 1.0 );
			float temp_output_330_0 = ( clampResult331 - clampResult300 );
			float3 temp_cast_17 = (temp_output_330_0).xxx;
			float3 newWorldNormal215 = (WorldNormalVector( i , tex2DNode50 ));
			float clampResult334 = clamp( reflect( temp_cast_17 , newWorldNormal215 ).x , 0.0 , 1.0 );
			float clampResult341 = clamp( ( clampResult334 - tex2D( _FoamTexture, ( i.uv_texcoord * ( _MainFoamScale * 0.6 ) ) ).r ) , 0.0 , 1.0 );
			float ProceduralFoam291 = clampResult341;
			float4 temp_cast_18 = (ProceduralFoam291).xxxx;
			float3 temp_cast_19 = (1.0).xxx;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 lerpResult7 = lerp( temp_cast_19 , ase_lightColor.rgb , _LightColorIntensity);
			float3 normalizeResult232 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult108 = dot( reflect( -normalizeResult232 , newWorldNormal215 ) , ase_worldlightDir );
			float Turbulence33 = temp_output_32_0;
			float3 clampResult120 = clamp( ( ( pow( dotResult108 , exp( (0.0 + (_SpecularExponent - 0.0) * (20.0 - 0.0) / (1.0 - 0.0)) ) ) * ase_lightColor.rgb ) * Turbulence33 ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float3 CustomLightning125 = ( clampResult120 * _SpecularIntensity );
			float4 temp_output_3_0 = ( ( ( ( saturate( ( blendOpSrc14 + blendOpDest14 ) )) + (( _ProceduralFoam )?( temp_cast_18 ):( ( ( _FoamColor * temp_output_156_0 ) + ( _FoamColor * temp_output_185_0 ) + ( smoothstepResult310 * _MinimumFoamIntensity ) ) )) ) * float4( lerpResult7 , 0.0 ) ) + float4( CustomLightning125 , 0.0 ) );
			float3 lerpResult90 = lerp( float3( ( ( 0.01 * _RefractionIntensity ) * ( Turbulence33 * i.uv_texcoord ) ) ,  0.0 ) , ( ase_lightColor.rgb * ase_lightAtten ) , ( 1.0 - ase_lightAtten ));
			float4 lerpResult96 = lerp( temp_output_3_0 , float4( lerpResult90 , 0.0 ) , 1.0);
			#ifdef _LIGHTS_ON
				float4 staticSwitch99 = lerpResult96;
			#else
				float4 staticSwitch99 = temp_cast_11;
			#endif
			c.rgb = staticSwitch99.rgb;
			c.a = clampResult127;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float4 temp_cast_0 = (0.0).xxxx;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult31 = (float2(( ase_screenPosNorm.x + 0.01 ) , ( ase_screenPosNorm.y + 0.01 )));
			float2 uv_WavesNormal = i.uv_texcoord * _WavesNormal_ST.xy + _WavesNormal_ST.zw;
			float temp_output_71_0 = sin( ( ( _Time.y * _WavesSpeed ) - ( UnpackNormal( tex2D( _WavesNormal, uv_WavesNormal ) ).b * ( _WavesAmplitude * 30.0 ) ) ) );
			float temp_output_67_0 = ( temp_output_71_0 * _WavesIntensity );
			float Waves68 = temp_output_67_0;
			float2 panner40 = ( 1.0 * _Time.y * float2( 0.01,0.01 ) + ( i.uv_texcoord * _TurbulenceScale ));
			float temp_output_32_0 = ( ( Waves68 * _WaveDistortionIntensity ) + ( UnpackNormal( tex2D( _WavesNormal, panner40 ) ).g * _TurbulenceDistortionIntensity ) );
			float4 lerpResult24 = lerp( ase_screenPosNorm , float4( appendResult31, 0.0 , 0.0 ) , temp_output_32_0);
			#ifdef _REALTIMEREFLECTIONS_ON
				float4 staticSwitch19 = ( tex2D( _ReflectionTex, lerpResult24.xy ) * _ReflectionsIntensity );
			#else
				float4 staticSwitch19 = temp_cast_0;
			#endif
			float screenDepth146 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth146 = abs( ( screenDepth146 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( ( _ColorPosition0 + _ColorPosition1 ) ) );
			float clampResult211 = clamp( distanceDepth146 , 0.0 , 1.0 );
			float4 lerpResult142 = lerp( _DepthColor1 , _DepthColor2 , clampResult211);
			float screenDepth152 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth152 = abs( ( screenDepth152 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _ColorPosition0 ) );
			float clampResult210 = clamp( distanceDepth152 , 0.0 , 1.0 );
			float4 lerpResult140 = lerp( _DepthColor0 , lerpResult142 , clampResult210);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV136 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode136 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV136, _FresnelExponent ) );
			float clampResult209 = clamp( fresnelNode136 , 0.0 , 1.0 );
			float2 temp_cast_4 = (_MainFoamSpeed).xx;
			float2 panner49 = ( 1.0 * _Time.y * temp_cast_4 + ( i.uv_texcoord * _NormalsScale ));
			float3 tex2DNode50 = UnpackNormal( tex2D( _WavesNormal, panner49 ) );
			float SpecularIntensity124 = _SpecularIntensity;
			#ifdef _ISSPECULARNORMALINTENSITY_ON
				float staticSwitch54 = _NormalsIntensity;
			#else
				float staticSwitch54 = SpecularIntensity124;
			#endif
			float4 appendResult57 = (float4(( (tex2DNode50).xy * staticSwitch54 ) , 1.0 , 0.0));
			#ifdef _NORMALS_ON
				float4 staticSwitch59 = appendResult57;
			#else
				float4 staticSwitch59 = float4( float3(0,0,1) , 0.0 );
			#endif
			float4 Normals61 = staticSwitch59;
			float clampResult260 = clamp( ( clampResult209 * Normals61.x ) , 0.0 , 1.0 );
			float4 lerpResult133 = lerp( lerpResult140 , _FresnelColor , clampResult260);
			float4 blendOpSrc14 = staticSwitch19;
			float4 blendOpDest14 = lerpResult133;
			float screenDepth163 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth163 = abs( ( screenDepth163 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( ( (0.2 + (temp_output_71_0 - 0.0) * (0.3 - 0.2) / (1.0 - 0.0)) * ( tex2D( _FoamTexture, ( ( _MainFoamSpeed * _Time.y ) + ( i.uv_texcoord * _MainFoamScale ) ) ).r * _MainFoamDistance ) ) ) );
			float clampResult208 = clamp( distanceDepth163 , 0.0 , 1.0 );
			float clampResult160 = clamp( pow( clampResult208 , 15.0 ) , 0.0 , 1.0 );
			#ifdef _MAINFOAMPOWER_ON
				float staticSwitch159 = clampResult160;
			#else
				float staticSwitch159 = clampResult208;
			#endif
			float temp_output_156_0 = ( ( 1.0 - staticSwitch159 ) * _MainFoamOpacity );
			float screenDepth191 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth191 = abs( ( screenDepth191 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _SecondaryFoamDistance ) );
			float clampResult207 = clamp( distanceDepth191 , 0.0 , 1.0 );
			float temp_output_185_0 = ( ( 1.0 - clampResult207 ) * ( tex2D( _FoamTexture, ( ( _SecondaryFoamSpeed * _Time.y ) + ( i.uv_texcoord * _SecondaryFoamScale ) ) ).r * _SecondaryFoamIntensity ) );
			float screenDepth305 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth305 = abs( ( screenDepth305 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _MinimumFoamDistance ) );
			float clampResult307 = clamp( distanceDepth305 , 0.0 , 1.0 );
			float smoothstepResult310 = smoothstep( 0.0 , 1.0 , ( 1.0 - clampResult307 ));
			float screenDepth299 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth299 = abs( ( screenDepth299 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _ProceduralDistance ) );
			float clampResult324 = clamp( ( 1.0 - distanceDepth299 ) , 0.0 , 1.0 );
			float clampResult331 = clamp( sin( ( ( clampResult324 + ( _ProceduralFoamSpeed * _Time.y ) ) * _ProceduralTiling ) ) , 0.0 , 1.0 );
			float screenDepth380 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth380 = abs( ( screenDepth380 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _ProceduralDepthOpacity ) );
			float clampResult300 = clamp( distanceDepth380 , 0.0 , 1.0 );
			float temp_output_330_0 = ( clampResult331 - clampResult300 );
			float3 temp_cast_5 = (temp_output_330_0).xxx;
			float3 newWorldNormal215 = (WorldNormalVector( i , tex2DNode50 ));
			float clampResult334 = clamp( reflect( temp_cast_5 , newWorldNormal215 ).x , 0.0 , 1.0 );
			float clampResult341 = clamp( ( clampResult334 - tex2D( _FoamTexture, ( i.uv_texcoord * ( _MainFoamScale * 0.6 ) ) ).r ) , 0.0 , 1.0 );
			float ProceduralFoam291 = clampResult341;
			float4 temp_cast_6 = (ProceduralFoam291).xxxx;
			float3 temp_cast_7 = (1.0).xxx;
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 lerpResult7 = lerp( temp_cast_7 , ase_lightColor.rgb , _LightColorIntensity);
			float3 normalizeResult232 = normalize( ( _WorldSpaceCameraPos - ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult108 = dot( reflect( -normalizeResult232 , newWorldNormal215 ) , ase_worldlightDir );
			float Turbulence33 = temp_output_32_0;
			float3 clampResult120 = clamp( ( ( pow( dotResult108 , exp( (0.0 + (_SpecularExponent - 0.0) * (20.0 - 0.0) / (1.0 - 0.0)) ) ) * ase_lightColor.rgb ) * Turbulence33 ) , float3( 0,0,0 ) , float3( 1,1,1 ) );
			float3 CustomLightning125 = ( clampResult120 * _SpecularIntensity );
			float4 temp_output_3_0 = ( ( ( ( saturate( ( blendOpSrc14 + blendOpDest14 ) )) + (( _ProceduralFoam )?( temp_cast_6 ):( ( ( _FoamColor * temp_output_156_0 ) + ( _FoamColor * temp_output_185_0 ) + ( smoothstepResult310 * _MinimumFoamIntensity ) ) )) ) * float4( lerpResult7 , 0.0 ) ) + float4( CustomLightning125 , 0.0 ) );
			o.Emission = temp_output_3_0.rgb;
		}

		ENDCG
	}
	CustomEditor "WaterShaderTesselationEditor"
}
/*ASEBEGIN
Version=18300
-1733;16;1686;995;824.6954;176.2274;1;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;45;-5323.367,414.431;Float;True;Property;_WavesNormal;WavesNormal;35;1;[Normal];Create;True;0;0;False;0;False;8322b723f17dc4a4a8a5dbddb0f787c7;8322b723f17dc4a4a8a5dbddb0f787c7;True;bump;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;81;-2193.291,901.2341;Float;False;Constant;_Float5;Float 5;16;0;Create;True;0;0;False;0;False;30;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-2294.291,811.2341;Float;False;Property;_WavesAmplitude;WavesAmplitude;8;0;Create;True;0;0;False;0;False;1;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;75;-2039.515,400.6252;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;78;-2111.515,613.6252;Inherit;True;Property;_TextureSample2;Texture Sample 2;15;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-1945.291,829.2341;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-2037.515,501.6252;Float;False;Property;_WavesSpeed;Waves Speed;10;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-1788.515,463.6252;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-1740.515,615.6252;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;278;232.5391,-1372.262;Inherit;False;Property;_ProceduralDistance;Procedural Distance;41;0;Create;True;0;0;False;0;False;1;0.47;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-4998.976,-388.5247;Float;False;Property;_MainFoamScale;MainFoamScale;15;0;Create;True;0;0;False;0;False;5;30;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;299;534.3668,-1375.153;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;180;-4880.681,-632.9241;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;182;-5036.676,-514.6248;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;177;-4867.679,-713.5248;Float;False;Property;_MainFoamSpeed;MainFoamSpeed;16;0;Create;True;0;0;False;0;False;0.2;0.025;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;72;-1501.515,573.6252;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;-4621.982,-604.3256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-5284.952,1608.499;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;326;789.3246,-1270.682;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;176;-4620.677,-502.925;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;290;848.7443,-1650.966;Inherit;False;Property;_ProceduralFoamSpeed;ProceduralFoamSpeed;42;0;Create;True;0;0;False;0;False;0.5;-0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;71;-1298.515,562.6252;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-5182.377,1791.062;Float;False;Property;_NormalsScale;NormalsScale;31;0;Create;True;0;0;False;0;False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;281;887.3408,-1545.522;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;173;-4366.744,-156.6506;Float;True;Property;_FoamTexture;FoamTexture;37;0;Create;True;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;288;1086.485,-1599.365;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;324;1022.028,-1275.245;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;174;-4352.886,-552.3251;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-4970.377,1639.062;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;169;-1211.08,514.7059;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;2061.214,-114.085;Float;False;Property;_SpecularIntensity;SpecularIntensity;28;0;Create;True;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;2437.214,17.91504;Float;False;SpecularIntensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;282;1198.854,-1134.473;Inherit;False;Property;_ProceduralTiling;ProceduralTiling;43;0;Create;True;0;0;False;0;False;10;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;49;-4727.316,1657.943;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;172;-4043.435,-370.5266;Float;False;Property;_MainFoamDistance;Main Foam Distance;13;0;Create;True;0;0;False;0;False;7.4;7;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;170;-4115.717,-592.0656;Inherit;True;Property;_TextureSample3;Texture Sample 3;32;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;328;1259.944,-1279.568;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;168;-3800.806,-433.6835;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;166;-3653.554,-735.7533;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.2;False;4;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-4440.554,2168.644;Float;False;Property;_NormalsIntensity;NormalsIntensity;30;0;Create;True;0;0;False;0;False;0;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;167;-3604.554,-542.7533;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-4474.377,1666.062;Inherit;True;Property;_TextureSample1;Texture Sample 1;10;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;329;1452.76,-1269.683;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;381;269.5368,-1511.285;Inherit;False;Property;_ProceduralDepthOpacity;ProceduralDepthOpacity;46;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;245;-120.5103,-987.1094;Inherit;False;1127.454;500.4805;ViewRefl. Dir;8;215;234;242;232;231;228;230;218;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-4500.554,2029.643;Inherit;False;124;SpecularIntensity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;230;-91.84272,-939.8308;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;69;-1375.515,729.6252;Float;False;Property;_WavesIntensity;WavesIntensity;9;0;Create;True;0;0;False;0;False;1;0.02;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;380;557.5368,-1492.285;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;52;-4073.554,1739.643;Inherit;False;True;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;228;-82.55425,-796.8304;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-5076.524,-1379.788;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;333;1636.99,-1257.925;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;-3317.554,-624.7533;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-5025.524,-1221.788;Float;False;Property;_TurbulenceScale;TurbulenceScale;24;0;Create;True;0;0;False;0;False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;54;-4018.554,1982.643;Float;False;Property;_isSpecularNormalIntensity;isSpecularNormalIntensity;32;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;331;1843.337,-1301.14;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;300;1020.12,-1429.141;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-3645.554,1826.643;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DepthFade;163;-3081.554,-677.7533;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;231;220.9441,-812.9414;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-4788.524,-1339.788;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-1075.748,575.0913;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-3580.538,1985.883;Float;False;Constant;_Float3;Float 3;11;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;306;-4125.172,-1006.031;Inherit;False;Property;_MinimumFoamDistance;MinimumFoamDistance;44;0;Create;True;0;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;198;-3644.136,-87.7122;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;330;2106.298,-1449.716;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;305;-3866.296,-1012.549;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;232;407.2097,-821.3548;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;-3384.632,1835.809;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;60;-3437.538,1640.883;Float;False;Constant;_Vector0;Vector 0;12;0;Create;True;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PannerNode;40;-4567.524,-1365.788;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;199;-3630.237,-221.5122;Float;False;Property;_SecondaryFoamSpeed;SecondaryFoamSpeed;20;0;Create;True;0;0;False;0;False;0.2;0.025;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;215;504.2562,-661.2971;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;200;-3726.035,48.78766;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;208;-2806.62,-830.0146;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;162;-2912.554,-485.7533;Float;False;Constant;_Float9;Float 9;32;0;Create;True;0;0;False;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-791.7476,681.0913;Float;False;Waves;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-3680.537,176.1876;Float;False;Property;_SecondaryFoamScale;SecondaryFoamScale;19;0;Create;True;0;0;False;0;False;5;30;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;59;-3146.538,1810.883;Float;False;Property;_Normals;Normals;29;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-3038.936,-356.929;Float;False;Property;_SecondaryFoamDistance;SecondaryFoamDistance;18;0;Create;True;0;0;False;0;False;2;1.35;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;307;-3618.452,-1012.31;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ReflectOpNode;336;2218.095,-1355.529;Inherit;False;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-3987.667,-1530.362;Float;False;Property;_WaveDistortionIntensity;Wave Distortion Intensity;26;0;Create;True;0;0;False;0;False;0.6;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;512.0109,-313.4598;Float;False;Property;_SpecularExponent;SpecularExponent;27;0;Create;True;0;0;False;0;False;0.18;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-3989.529,-1183.788;Float;False;Property;_TurbulenceDistortionIntensity;Turbulence Distortion Intensity;25;0;Create;True;0;0;False;0;False;0.8;1.11;0;6;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;-3324.336,30.58777;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-3947.667,-1654.363;Inherit;False;68;Waves;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;345;2001.824,-952.2046;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-3328.235,-104.6122;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-3659.871,-1878.354;Float;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-4317.224,-1416.088;Inherit;True;Property;_TextureSample0;Texture Sample 0;7;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;149;-3138.618,-1271.519;Float;False;Property;_ColorPosition1;ColorPosition1;4;0;Create;True;0;0;False;0;False;1;2.14;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;161;-2700.554,-549.7533;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;348;2159.755,-789.7043;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-3138.612,-1170.014;Float;False;Property;_ColorPosition0;ColorPosition0;3;0;Create;True;0;0;False;0;False;1;2.09;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;26;-3749.871,-2206.354;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;242;584.5654,-803.6061;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;160;-2497.554,-570.7533;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-3348.871,-2008.354;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;104;930.2136,-262.085;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-2741.132,-1074.492;Float;False;Property;_FresnelExponent;FresnelExponent;6;0;Create;True;0;0;False;0;False;8.4;8.35;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;109;752.2136,-477.085;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ReflectOpNode;234;757.4669,-779.4959;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;311;-3488.668,-919.4952;Inherit;False;Constant;_MinFoamDistance;MinFoamDistance;45;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;-2847.538,1840.883;Float;False;Normals;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;338;2464.659,-1501.15;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;195;-3122.837,-89.01219;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DepthFade;191;-2697.633,-376.1268;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;346;2332.754,-877.3829;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;312;-3494.671,-844.4532;Inherit;False;Constant;_MaxFoamDistance;MaxFoamDistance;46;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;-3350.871,-1876.354;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-3671.667,-1607.363;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-3647.529,-1361.788;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;308;-3472.069,-1012.473;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;147;-2911.491,-1321.769;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;108;1122.214,-535.085;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;-1863.466,-1084.721;Inherit;False;61;Normals;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;193;-2811.749,-224.0244;Inherit;True;Property;_TextureSample4;Texture Sample 4;38;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;310;-3207.511,-1001.541;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;159;-2343.554,-737.7533;Float;False;Property;_MainFoamPower;MainFoamPower;11;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-3142.871,-1959.354;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;207;-2396.567,-361.3667;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;344;2700.285,-1166.108;Inherit;True;Property;_TextureSample6;Texture Sample 6;46;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;334;2777.689,-1450.461;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;146;-2774.137,-1435.059;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ExpOpNode;106;1171.214,-261.085;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;136;-2293.339,-1128.579;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;315;-2957.988,-910.7134;Inherit;False;Property;_MinimumFoamIntensity;MinimumFoamIntensity;45;0;Create;True;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;194;-2360.65,-120.0245;Float;False;Property;_SecondaryFoamIntensity;SecondaryFoamIntensity;17;0;Create;True;0;0;False;0;False;0.3;0.3;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-3390.667,-1504.363;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;145;-2760.743,-1664.472;Float;False;Property;_DepthColor2;DepthColor2;2;0;Create;True;0;0;False;0;False;0.1803922,0.2078432,0.4352942,1;0,0.0627451,0.2509804,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;24;-2706.871,-2085.354;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;189;-2184.633,-404.1268;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;152;-2706.605,-1292.094;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;107;1370.214,-441.085;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;144;-2762.754,-1836.327;Float;False;Property;_DepthColor1;DepthColor1;1;0;Create;True;0;0;False;0;False;0.2862745,0.4470589,0.7176471,1;0.05882353,0.1960784,0.4627451,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;-2017.633,-295.1268;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;209;-2030.435,-1138.831;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;157;-1929.416,-693.1175;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;339;-1666.466,-1102.721;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;-3162.915,-1529.423;Float;False;Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-2050.775,-605.9428;Float;False;Property;_MainFoamOpacity;MainFoamOpacity;14;0;Create;True;0;0;False;0;False;0.92;0.77;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;313;-2634.539,-960.581;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;343;3229.909,-1434.312;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;211;-2494.394,-1464.822;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;116;1378.214,-182.085;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;118;1648.214,-150.085;Inherit;False;33;Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-2386.871,-2098.354;Inherit;True;Property;_ReflectionTex;ReflectionTex;36;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;1649.214,-303.085;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;155;-1860.042,-997.7468;Float;False;Property;_FoamColor;FoamColor;12;0;Create;True;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;210;-2376.094,-1317.921;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;341;3559.012,-1431.1;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;259;-1819.772,-1235.442;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-2377.685,-1881.683;Float;False;Property;_ReflectionsIntensity;ReflectionsIntensity;21;0;Create;True;0;0;False;0;False;1;0.55;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;-1623.072,-756.7065;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;141;-2347.697,-1800.149;Float;False;Property;_DepthColor0;DepthColor0;0;0;Create;True;0;0;False;0;False;0.254902,0.7450981,0.7137255,1;0.1058824,0.5960785,0.6196079,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;309;-2030.876,-857.5002;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;185;-1818.727,-368.5162;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;142;-2287.393,-1576.034;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1971.485,-2019.332;Float;False;Constant;_Float1;Float 1;3;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;1903.214,-286.085;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;135;-2069.5,-1398.473;Float;False;Property;_FresnelColor;FresnelColor;5;0;Create;True;0;0;False;0;False;0.4862745,0.8980393,0.8705883,1;0.4861605,0.8962264,0.8699822,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;314;-1524.702,-796.8218;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;140;-2013.032,-1602.163;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;184;-1362.633,-490.6458;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-1245.794,-979.9147;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;260;-1663.16,-1333.597;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;291;3788.823,-1435.317;Inherit;False;ProceduralFoam;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-2021.485,-1865.332;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;133;-1616.25,-1561.82;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;275;-1186.446,-757.9761;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;19;-1680.485,-1887.332;Float;False;Property;_RealtimeReflections;RealtimeReflections;22;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;292;-1192.557,-539.7162;Inherit;False;291;ProceduralFoam;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;120;2141.214,-285.085;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,1,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;277;-957.2673,-603.0385;Inherit;False;Property;_ProceduralFoam;Procedural  Foam;40;0;Create;True;0;0;False;0;False;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;2396.214,-283.085;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1098.688,-115.8476;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1224.688,88.15237;Float;False;Property;_LightColorIntensity;LightColorIntensity;23;0;Create;True;0;0;False;0;False;0.75;0.54;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;14;-1264.485,-1754.333;Inherit;False;LinearDodge;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;10;-1113.688,-35.8476;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-744,-593;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-681.9951,784.5074;Float;False;Constant;_Float6;Float 6;17;0;Create;True;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;2823.759,-231.3859;Float;False;CustomLightning;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;7;-765.6876,-79.84756;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;88;-731.9951,1040.507;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;86;-717.9951,867.5074;Float;False;Property;_RefractionIntensity;RefractionIntensity;38;0;Create;True;0;0;False;0;False;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;89;-717.9951,950.5074;Inherit;False;33;Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-441.9951,933.5074;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-502,-347;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;94;-191.4401,1197.152;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;4;-589,10;Inherit;False;125;CustomLightning;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;93;-131.5181,1040.951;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-445.9951,797.5074;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;186;-1643.727,-478.5162;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-263.207,831.5944;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;95;141.5599,1201.152;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-1579.408,254.7001;Float;False;Property;_DepthOpacity;DepthOpacity;34;0;Create;True;0;0;False;0;False;5;7.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;163.5819,1000.652;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;187;-1429.727,-310.5162;Float;False;FoamMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-161,9;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;-875.1089,32.69398;Inherit;False;187;FoamMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;90;405.9619,915.1597;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;98;126.5946,498.9397;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;97;507.7087,1059.912;Float;False;Constant;_Float7;Float 7;17;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;131;-1196.766,253.5187;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;378;-693.7245,82.9503;Inherit;False;Property;_ProceduralFoam;ProceduralFoamShadows;48;0;Create;False;0;0;False;0;False;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-910.7166,186.5902;Float;False;Property;_Opacity;Opacity;33;0;Create;True;0;0;False;0;False;0.95;0.83;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;206;-738.9683,264.5795;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;693.7333,630.5979;Float;False;Constant;_Float8;Float 8;18;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;66;-1184.748,380.0913;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;96;672.7087,738.9124;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-803.7476,517.0913;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;128;-475.3323,194.6422;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-820.7476,396.0913;Float;False;Constant;_Float4;Float 4;13;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;99;909.7333,663.5979;Float;False;Property;_Lights;Lights;39;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;349;209.47,414.8818;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;218;127.2061,-714.956;Inherit;True;Property;_TextureSample5;Texture Sample 5;40;0;Create;True;0;0;False;0;False;-1;None;8322b723f17dc4a4a8a5dbddb0f787c7;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;358;2264.268,-1517.925;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;127;-172.4997,230.3543;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;62;-458.7476,480.0913;Float;False;Property;_VertexOffset;VertexOffset;7;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;382;-0.6954346,493.7726;Inherit;False;Property;_Tesselation;Tesselation;47;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;203;261.7999,4.39999;Float;False;True;-1;6;WaterShaderTesselationEditor;0;0;CustomLighting;VaxKun/WaterShaderTesselation;False;False;False;False;False;False;True;False;True;False;False;False;False;False;True;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;246;532.2274,96.04295;Inherit;False;516.9629;252.819;HELLO IM A HUGE COMMENT :D;1;247;HEHE;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;247;596.9984,181.0547;Inherit;False;358.0717;100;HAVE A GOOD DEV!;0;;1,1,1,1;0;0
WireConnection;78;0;45;0
WireConnection;79;0;80;0
WireConnection;79;1;81;0
WireConnection;73;0;75;0
WireConnection;73;1;76;0
WireConnection;77;0;78;3
WireConnection;77;1;79;0
WireConnection;299;0;278;0
WireConnection;72;0;73;0
WireConnection;72;1;77;0
WireConnection;175;0;177;0
WireConnection;175;1;180;0
WireConnection;326;0;299;0
WireConnection;176;0;182;0
WireConnection;176;1;183;0
WireConnection;71;0;72;0
WireConnection;288;0;290;0
WireConnection;288;1;281;0
WireConnection;324;0;326;0
WireConnection;174;0;175;0
WireConnection;174;1;176;0
WireConnection;47;0;46;0
WireConnection;47;1;48;0
WireConnection;169;0;71;0
WireConnection;124;0;123;0
WireConnection;49;0;47;0
WireConnection;49;2;177;0
WireConnection;170;0;173;0
WireConnection;170;1;174;0
WireConnection;328;0;324;0
WireConnection;328;1;288;0
WireConnection;168;0;169;0
WireConnection;166;0;168;0
WireConnection;167;0;170;1
WireConnection;167;1;172;0
WireConnection;50;0;45;0
WireConnection;50;1;49;0
WireConnection;329;0;328;0
WireConnection;329;1;282;0
WireConnection;380;0;381;0
WireConnection;52;0;50;0
WireConnection;333;0;329;0
WireConnection;165;0;166;0
WireConnection;165;1;167;0
WireConnection;54;1;55;0
WireConnection;54;0;56;0
WireConnection;331;0;333;0
WireConnection;300;0;380;0
WireConnection;53;0;52;0
WireConnection;53;1;54;0
WireConnection;163;0;165;0
WireConnection;231;0;230;0
WireConnection;231;1;228;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;67;0;71;0
WireConnection;67;1;69;0
WireConnection;330;0;331;0
WireConnection;330;1;300;0
WireConnection;305;0;306;0
WireConnection;232;0;231;0
WireConnection;57;0;53;0
WireConnection;57;2;58;0
WireConnection;40;0;42;0
WireConnection;215;0;50;0
WireConnection;208;0;163;0
WireConnection;68;0;67;0
WireConnection;59;1;60;0
WireConnection;59;0;57;0
WireConnection;307;0;305;0
WireConnection;336;0;330;0
WireConnection;336;1;215;0
WireConnection;197;0;200;0
WireConnection;197;1;201;0
WireConnection;196;0;199;0
WireConnection;196;1;198;0
WireConnection;39;0;45;0
WireConnection;39;1;40;0
WireConnection;161;0;208;0
WireConnection;161;1;162;0
WireConnection;348;0;183;0
WireConnection;242;0;232;0
WireConnection;160;0;161;0
WireConnection;27;0;26;1
WireConnection;27;1;29;0
WireConnection;104;0;103;0
WireConnection;234;0;242;0
WireConnection;234;1;215;0
WireConnection;61;0;59;0
WireConnection;338;0;336;0
WireConnection;195;0;196;0
WireConnection;195;1;197;0
WireConnection;191;0;192;0
WireConnection;346;0;345;0
WireConnection;346;1;348;0
WireConnection;28;0;26;2
WireConnection;28;1;29;0
WireConnection;34;0;36;0
WireConnection;34;1;35;0
WireConnection;37;0;39;2
WireConnection;37;1;38;0
WireConnection;308;0;307;0
WireConnection;147;0;150;0
WireConnection;147;1;149;0
WireConnection;108;0;234;0
WireConnection;108;1;109;0
WireConnection;193;0;173;0
WireConnection;193;1;195;0
WireConnection;310;0;308;0
WireConnection;310;1;311;0
WireConnection;310;2;312;0
WireConnection;159;1;208;0
WireConnection;159;0;160;0
WireConnection;31;0;27;0
WireConnection;31;1;28;0
WireConnection;207;0;191;0
WireConnection;344;0;173;0
WireConnection;344;1;346;0
WireConnection;334;0;338;0
WireConnection;146;0;147;0
WireConnection;106;0;104;0
WireConnection;136;3;137;0
WireConnection;32;0;34;0
WireConnection;32;1;37;0
WireConnection;24;0;26;0
WireConnection;24;1;31;0
WireConnection;24;2;32;0
WireConnection;189;0;207;0
WireConnection;152;0;150;0
WireConnection;107;0;108;0
WireConnection;107;1;106;0
WireConnection;188;0;193;1
WireConnection;188;1;194;0
WireConnection;209;0;136;0
WireConnection;157;0;159;0
WireConnection;339;0;340;0
WireConnection;33;0;32;0
WireConnection;313;0;310;0
WireConnection;313;1;315;0
WireConnection;343;0;334;0
WireConnection;343;1;344;1
WireConnection;211;0;146;0
WireConnection;23;1;24;0
WireConnection;115;0;107;0
WireConnection;115;1;116;1
WireConnection;210;0;152;0
WireConnection;341;0;343;0
WireConnection;259;0;209;0
WireConnection;259;1;339;0
WireConnection;156;0;157;0
WireConnection;156;1;158;0
WireConnection;309;0;313;0
WireConnection;185;0;189;0
WireConnection;185;1;188;0
WireConnection;142;0;144;0
WireConnection;142;1;145;0
WireConnection;142;2;211;0
WireConnection;117;0;115;0
WireConnection;117;1;118;0
WireConnection;314;0;309;0
WireConnection;140;0;141;0
WireConnection;140;1;142;0
WireConnection;140;2;210;0
WireConnection;184;0;155;0
WireConnection;184;1;185;0
WireConnection;153;0;155;0
WireConnection;153;1;156;0
WireConnection;260;0;259;0
WireConnection;291;0;341;0
WireConnection;21;0;23;0
WireConnection;21;1;22;0
WireConnection;133;0;140;0
WireConnection;133;1;135;0
WireConnection;133;2;260;0
WireConnection;275;0;153;0
WireConnection;275;1;184;0
WireConnection;275;2;314;0
WireConnection;19;1;20;0
WireConnection;19;0;21;0
WireConnection;120;0;117;0
WireConnection;277;0;275;0
WireConnection;277;1;292;0
WireConnection;121;0;120;0
WireConnection;121;1;123;0
WireConnection;14;0;19;0
WireConnection;14;1;133;0
WireConnection;12;0;14;0
WireConnection;12;1;277;0
WireConnection;125;0;121;0
WireConnection;7;0;8;0
WireConnection;7;1;10;1
WireConnection;7;2;11;0
WireConnection;87;0;89;0
WireConnection;87;1;88;0
WireConnection;5;0;12;0
WireConnection;5;1;7;0
WireConnection;84;0;85;0
WireConnection;84;1;86;0
WireConnection;186;0;156;0
WireConnection;186;1;185;0
WireConnection;83;0;84;0
WireConnection;83;1;87;0
WireConnection;95;0;94;0
WireConnection;91;0;93;1
WireConnection;91;1;94;0
WireConnection;187;0;186;0
WireConnection;3;0;5;0
WireConnection;3;1;4;0
WireConnection;90;0;83;0
WireConnection;90;1;91;0
WireConnection;90;2;95;0
WireConnection;98;0;3;0
WireConnection;131;0;132;0
WireConnection;378;0;129;0
WireConnection;206;0;131;0
WireConnection;96;0;98;0
WireConnection;96;1;90;0
WireConnection;96;2;97;0
WireConnection;64;0;66;0
WireConnection;64;1;67;0
WireConnection;128;0;378;0
WireConnection;128;1;130;0
WireConnection;128;2;206;0
WireConnection;99;1;100;0
WireConnection;99;0;96;0
WireConnection;349;0;99;0
WireConnection;218;0;45;0
WireConnection;358;0;330;0
WireConnection;127;0;128;0
WireConnection;62;1;63;0
WireConnection;62;0;64;0
WireConnection;203;2;3;0
WireConnection;203;9;127;0
WireConnection;203;13;349;0
WireConnection;203;11;62;0
WireConnection;203;14;382;0
ASEEND*/
//CHKSM=38E6B572E63D3727C244821CE108F7EDAFB48F1B