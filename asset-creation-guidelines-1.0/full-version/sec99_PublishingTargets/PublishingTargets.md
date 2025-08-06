# Publishing Targets

*Version 1.0.0*\
Last Updated: October 20, 2020

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](/asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)


## PBR Base Asset

The basis for all asset variants used for publishing is a high-resolution real-time 3D “Base Asset” (sometimes also referred to as “Source Asset”) that typically has a long lifetime and provides the high-quality, “ground truth” version for all published variants. This asset should be stored in an uncompressed (loss-free) way, and in high resolution. For the materials to be ready for real-time rendering applications, they should already be in a matching format, concretely speaking in a PBR format (recommended: metalness/roughness).

<img src="./figures/PublishingTargets_001.jpg" alt="Image credit: DGG3D" width="800px"/>

    (C)2020, DGG. License: CC BY 4.0 International
    Figure 99.1: published variants


## Understanding where the 3D assets are going

In order to best make certain decisions when authoring 3D Models, one must have an idea about the intended hardware and software where assets will ultimately be rendered for consumer visualization. Visual fidelity must be balanced with streaming requirements and real-time rendering performance, and often the same asset should not be used for offline frame rendering as well as augmented reality on a mobile device, for example. The specifics of each software-hardware combination where assets will be rendered are constantly evolving and may vary, therefore it is recommended to discuss and even test 3D Assets with the desired rendering platform. Nevertheless, a publishing target should be considered during asset creation and should be specified in the asset metadata. The following table specifies general guidelines for various common publishing targets.


## 3D Commerce Publishing Guidelines v1.0

These specifications are likely to change rapidly as new hardware is adopted more widely.


|Publishing Target|Max. Target File Size|Max. Target Triangle Count|Target (Max) Number of Draw Calls|Max. Target Bitmap resolution, to meet bandwidth requirements (JPG)|
|--- |--- |--- |--- |--- |
|Single-Item Mobile AR or 3D Web Catalogue View|3MB|150,000|<20 (500)|2K|
|Banner Ad View|500KB|30,000|<5 (100)|512|
|Web-based Planning Tool (recommendations for one out of multiple items)|1MB|40,000|<5 (50)|1K|
|Single-Item Desktop 3D Web View|3MB|250,000|<100 (800)|2K|
|Offline Rendering|No Limit|No Limit|No Limit|No Limit|


In the following, the reasoning behind the different maximum numbers and other constraints is outlined more in detail:


### Maximum Target File Size

This aspect is especially important in the context of Web-based streaming. Ideally, assets for e-commerce should be loaded and displayed to the user in less than 3 seconds. A good internet connection speed to conservatively assume in practice may be around [10Mb/s](https://en.wikipedia.org/wiki/List_of_countries_by_Internet_connection_speeds) (1.25MB/s), which would mean that, to load within 3 seconds, an asset should not be larger than 3.75MB. Note that this number does not account yet for auxiliary files to be loaded, such as the 3D viewer's JavaScript files or other media on the product’s page. For their “3D posts” feature, facebook used 3MB as upload limit for .glb files, which confirms this order of magnitude as a sensible target for everything that should be transmitted over the Web and be instantly displayed. Therefore, 3MB is used as recommended maximum file size for the Desktop- and mobile 3D Web views, as well as for single-item mobile AR.

Banner ad views should be displayed even more quickly, since the user is not expected to wait for the content at all, but rather to discover it very quickly when casually scrolling over a page. Therefore, the maximum recommended target file size for this use case is 1MB, although the size of ad content should generally be as small as possible. 

For Web-based planning tools, the case is a bit different: on the one hand, the user already shows a certain level of engagement when starting an online planning tool (such as a kitchen planner), and it is likely that loading times of more than 3 seconds will still be accepted. On the other hand, however, planning tools usually show not only one item, but many different ones - therefore, the recommended maximum target file size for this setting is 1MB per item (and even lower values can make sense, depending on the concrete tool and scenario).


### Maximum Number of Draw Calls and Triangles

Although real-time engines are able to perform several operations at loading time in order to reduce the number of draws used to render an asset, it is recommended to perform a batching of draw calls during asset creation wherever possible. Usually, different draws correspond to separated logical parts of a 3D model. Each model part typically causes a new draw call. Parts are treated separately during rendering to allow for dynamic display or hiding of individual components, or to allow back-to-front sorting for transparent objects.
A proper setup of materials can help to significantly reduce the number of draw calls - see the [material section](../sec05_MaterialsAndTextures/MaterialsAndTextures.md#multiple-materials) for further details.

Similarly, the number of polygons needs to be kept at a moderate level.

For both of these numbers - number of draw calls, and number of polygons - it is important to consider the whole application, instead of just looking at a single asset. For example, an isolated 3D catalogue view for single items may use the full budget for draws and polygons, while the same item should be much more optimized when being displayed along with many other ones within a VR scene or within a Web-based floor planning tool.

For 3D Web and AR renderers, we assume a conservative amount of 500 draw calls and 150K triangles at maximum, above which we expect the frame rate of real-time rendering engines to likely decrease, for most client devices. For Desktop-based renderers, a slightly higher number of 800 draws and 250K triangles is the recommended maximum. For other cases where an item is usually displayed along with other page content, such as banner ad views or Web-based planning tools, smaller maximum numbers of 100 draws and 60K triangles (banner ad) and 50 draws and 40K triangles (Web-based planner) draws are recommended. This is to account for 	the fact that multiple assets will be displayed, sharing the same overall budget for draw calls.


### Reducing Material Complexity for Previews and Low-End Devices

A typical compact asset for publication will contain the following texture maps:
* Base Color
* ORM (Occlusion / Roughness / Metallic))
* Normals
* Emissive

With standard material models evolving further, additional maps may be used as well. For low-end devices and preview versions, however, it may be necessary to reduce the amount of texture maps when simplifying the asset. For example, a 100KB preview version of a typical 3D commerce asset will not usually not contain a normal map, but instead use the existing file size budget rather for a low-resolution base color texture and a simplified mesh.

The [glTF 2.0 specification](https://github.com/KhronosGroup/glTF/blob/master/specification/2.0/README.md#materials) provides hints about the priorities (descending from top to bottom) of the normal map, occlusion map and emissive map, as well as a description of the impact of dropping a specific map: 


|Map|Rendering impact when map is not supported|
|--- |--- |
|Normal|Geometry will appear less detailed than authored.|
|Occlusion|Model will appear brighter in areas that should be darker.|
|Emissive|Model with lights will not be lit. For example, the headlights of a car model will be off instead of on.|


<br>

Following these hints, we suggest the following priorities (descending) of the different maps for 3D commerce assets:
1. Base Color
2. ORM
3. Normals
4. Emissive

To create fast-loading, ultra-compact assets, optimization pipelines can therefore drop the maps in reverse order of their priorities, to satisfy a requirement for a desired maximum target file size.


## Creating Target Specific Assets

While there are various techniques available to create optimized 3D models for certain targets, a common approach is to author assets in a derivative approach based on a high density, high quality base model - [the 3D Base Asset](#pbr-base-asset).
Automated workflows can then be used to produce optimized, low-poly variants for different publishing targets.
In contrast to the 3D base asset, which is usually supposed to be authored by human 3D artists, the optimized variants for publishing typically don’t need to be editable and can therefore contain highly adaptive, irregular triangle meshes (instead of quad meshes) to exploit the GPU’s polygon budget as efficiently as possible, for example.
Furthermore, optimized assets may rely on texture atlases (especially for non-tiled texture content), in order to reduce the amount of textures to be transmitted and rendered to a necessary minimum.
This entire process can be performed by automated tools, such as DGG RapidCompact or Microsoft Simplygon.
For further details on the different aspects of optimization, see the sections on [mesh optimization](../sec03_Geometry/Geometry.md#topology-mesh-optimization) and [creation of normal maps](../sec05_MaterialsAndTextures/MaterialsAndTextures.md#normal-texture), for example, as well as the section on [LOD ](../sec07_LevelsofDetail/LevelsofDetail.md))creation.

<br>

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](/asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)
