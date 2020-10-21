# glTF & USDZ

*Version 1.0.0*\
Last Updated: October 20, 2020

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](./asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)

<br>

## glTF 2.0 Features / Extensions & USDZ Comparison


### Official Extensions 
Link to details on [glTF extension](https://github.com/KhronosGroup/glTF/blob/master/extensions/README.md)

<br>

|Description|Official Extensions|USDZ|
|--- |--- |--- |
|Draco compression|[KHR_draco_mesh_compression](https://github.com/KhronosGroup/glTF/blob/master/extensions/2.0/Khronos/KHR_draco_mesh_compression/README.md)|No|
|Punctual Light support|[KHR_lights_punctual](https://github.com/KhronosGroup/glTF/blob/master/extensions/2.0/Khronos/KHR_lights_punctual/README.md)|No|
|PBR specular glossiness|[KHR_materials_pbrSpecularGlossiness](https://github.com/KhronosGroup/glTF/blob/master/extensions/2.0/Khronos/KHR_materials_pbrSpecularGlossiness/README.md)|No|
|Unlit material|[KHR_materials_unlit](https://github.com/KhronosGroup/glTF/blob/master/extensions/2.0/Khronos/KHR_materials_unlit/README.md)|No|
|Repeatable, scalable UV|[KHR_texture_transform](https://github.com/KhronosGroup/glTF/blob/master/extensions/2.0/Khronos/KHR_texture_transform/README.md)|No|
|Clearcoat|[KHR_materials_clearcoat](https://github.com/KhronosGroup/glTF/tree/master/extensions/2.0/Khronos/KHR_materials_clearcoat)|Yes (equivalent)|

<br>

### glTF 2.0 Features and USDZ Parity

Link to details on [glTF specification](https://github.com/KhronosGroup/glTF/tree/master/specification/2.0)

<br>

|Description|Features|USDZ|
|--- |--- |--- |
|At least 2+ UV Sets|TEXCOORD_0, TEXCOORD_1|Yes|
|Vertex Color|COLOR_0|No|
|Alpha Coverage|Alpha Coverage: OPAQUE|Yes|
|Alpha Coverage|Alpha Coverage: MASK, alphaCutoff|No|
|Alpha Coverage|Alpha Coverage: BLEND|Yes|
|Double-sidedness|doubleSided|Yes|
|Animation interpolation|linear, step, cubic spline|Yes|
|Morph targets|Morph target|No|
|Rotation animations|rotation|Yes|
|Translation animation|translation|Yes|
|Scale animation|scale|Yes|
|Joint and skin|[Animated joints and skins](https://github.com/KhronosGroup/glTF/pull/1747)|Yes|


<br><br>

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](./asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)