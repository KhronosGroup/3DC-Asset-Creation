<p align="center">
  <img width="460" src="https://www.khronos.org/assets/images/api_logos/3dcommerce.svg">
</p>

<header> 
    <h1>Real-time Asset Creation Guidelines</h1> 
</header> 

*Version 1.0.0*\
Last Updated: May 15, 2020

<header> 
    <h2>Content</h2> 
</header>

Real-time Asset Creation Guidelines Summary
* [Executive summary](#executive-summary)
* [File Formats and Asset Structure Summary](#file-formats-and-asset-structure-summary)
* [Coordinate Systems and Scale Summary](#coordinate-systems-and-scale-summary)
* [Geometry Summary](#geometry-summary)
* [UV Coordinates Summary](#uv-coordinates-summary)
* [Materials Summary](#materials-summary)
* [Textures Summary](#textures-summary)
* [Lighting Summary](#lighting-summary)
* [Publishing Targets Summary](#publishing-targets-summary)


<header>
    <h2>Asset Creation Guidelines Summary</h2>
</header>

<header>
    <h3>Executive Summary</h3>
</header>
<hr>

These guidelines are intended for 3D artists who are already familiar with polygonal 3D workflows but who may not be familiar with web/mobile delivery. For true-geometry CAD, additional CAD-to-polygon workflow will be required.

These are guidelines and best practices that explain the modeling standards that a 3D model needs to meet, on behalf of a merchant for real-time rendering. This document highlights some common tips to achieve high-quality, efficient and performant content. The generated content supports experiences in augmented reality (AR), virtual reality (VR), product configurators, and web-based 3d marketing tools optimized for real-time. These guidelines are designed to be DCC-agnostic (Digital Content Creation software) as the principles should be applicable across 3D software. For different industry-vertical and software specific workflows, please refer to the Asset Creation Workflows (Links available soon). 

The goal of the guidelines is to reduce the number of iterations between content creator and merchant and streamline the content creation process.


<header> 
    <h3>File Formats and Asset Structure Summary</h3>
</header>
<hr>

<ins>Link to full version</ins> (Coming soon) 

For building your 3D product models, it is important to set up content correctly with file formats and structures taken into consideration.  Below are some best practices for setting up your 3D environments to ensure that your project is off to a good start.

* We recommend exporting final models in glTF or binary GLB format, and USDZ for iOS devices. Even though the guidelines are glTF centric, USDZ is covered as part of the holistic ecosystem consideration. Note that some glTF features are not compatible nor translatable to USDZ.
* We recommend producing content with the smallest file size possible, to reduce download time and create smoother guest experience. See the section of  publishing targets.
* Most assets should be placed so the center bottom is at world `0,0,0`. For animated and other assets, some pivots need to be placed for movement consideration. 
* Use valid character sets for asset and file naming: `a-z`, `_`, `-`, `0–9`. 
    * Start names with a lowercase letter, avoid numeric or capital letters.
    * Use underscore `_` or hyphen `-` to separate different words.

<header> 
    <h3>Coordinate Systems and Scale Summary</h3> 
</header>
<hr>

<ins>Link to full version</ins> (Coming soon)

Different 3D DCC software comes with varied coordinate systems and measurement units. It is important to understand the differences between modeling coordinates and normal vector coordinates.

* For **modeling coordinates**, both glTF and USDZ use the right-handed coordinate system, with `+Y` as world up, and the front of the asset facing `+Z`. Positive rotation is counterclockwise.
* For **normal vector coordinates**, glTF and USDZ use OpenGL conventions where `+X` is right, `+Y` is up, and `+Z` points toward the viewer
* Scale: use 1 unit as 1 meter when possible. If you use non meter-based units, applying appropriate multipliers would be necessary. Eg. 1 inch = 0.0254 meter

<header> 
    <h3>Geometry Summary</h3> 
</header>
<hr>

<ins>Link to full version</ins> (Coming soon) 

Ideally, it is best to design 3D models with high accuracy and quality, which can be tailored for product rendering, and later optimized as real-time assets for real-time experiences. To function on the web and on mobile devices, it is important that your model loads quickly and is highly optimized with the following characteristics.

* The model should look identical to the reference photos and built to real-world scale.  
* The model should only have as much geometry as necessary to keep a high level of realism. Additional details can be baked onto normal maps. See publishing target for triangle count details. 
* Avoid nGons when possible. We recommend using quads (4-sided mesh) for your source models and leaving triangulation for the final step in the modeling optimization process. Be sure to keep your non-triangulated mesh to make future revisions to the model more easily. 
* Avoid single vertex points that have a large number of edges connected to them when possible (i.e. high valence vertices, 10+ edged connected to a single point).
* Make sure there are no shading errors on the model. Shading errors are a sign that something has gone wrong with the model, such as two faces overlapping or normals need to be recalculated.
* Smooth edges or bevels can bring smooth edge transitions that are more realistic and aesthetically pleasing. A common practice is to add extra polygon edge loops, or use normal maps to achieve similar effect.
* There should not be any obvious holes, unintentional visible gaps, or non-manifold geometry in the model.
* For opaque and transparent components, use separate meshes and materials for better rendering results.
* Clear transform data, construction history data, and any modifier stacks to avoid future discrepancies.

<header> 
    <h3>UV Coordinates Summary</h3> 
</header>
<hr>

<ins>Link to full version</ins> (Coming soon)

UV layout / UV mapping is a process by which an artist takes their 3D model and creates flattened 2D representations of its various surfaces so that texture maps can be accurately projected onto it. This resulting 2D representation is considered an unwrapped UV Map.  In order for a model to be effective for web and mobile experiences it should have fully unwrapped UVs for all parts. Below are some best practices for creating UV maps for real-time rendering purposes. Some exceptions may apply to UVs built for Ambient Occlusion.

* Ideally, the UV shells for the model are mapped onto a single texture map. Sometimes using multiple textures may be required to keep reasonable quality.
* UVs are in the atlased layout and all the UV shells are positioned within 0-1 space.  
* Fill as much of the UV space as possible, reduce wasted empty areas, ideally without shattered UV shells.
* Make sure that detailed pieces, like zippers and logos, are easy to see and not blurry by making them larger on the UV map, ensuring they have more resolution.
* All the UV shells should be normalized in scale so that texture density is even across the entire model except where extra detail is needed (e.g. logos, zippers)
* Ideally, none of the UV shells should overlap. 
* UV seams should be placed on natural breaks within the real world version of the model or hidden in non visible areas. Visible seams can be jarring and break the realistic appearance of a model.
* Artists should endeavor to eliminate visible texture stretching or warping

<header> 
    <h3>Materials Summary</h3> 
</header>
<hr>

<ins>Link to full version</ins> (Coming soon)

When creating materials with real time usage in mind you should use as few textures as possible to keep your file size low.  Typically materials make up a larger percentage of the model file size than geometry. To achieve this it is recommended that textures are exported using a physically-based rendering (PBR) workflow. PBR materials allow for a wide range of surface types, are easy to use and understand, keeps file sizes smaller for downloads, and uses less memory when rendering.

* PBR materials in Metallic-Roughness format.
* Semitransparent or Alpha Test materials parts should always use a separate material from opaque parts. Where transparency can be realized without requiring any texture, recommend use a separate, untextured material instead.
* No texture blending or layering. In each characteristic of a material use only one texture.
* When appropriate try to limit the number of materials that you use.

<header> 
    <h3>Textures Summary</h3> 
</header>
<hr>

<ins>Link to full version</ins> (Coming soon)

Textures are often the cause of large files sizes which can increase load time and make the overall customer experience slow and frustrating. To optimize the user experience follow these basic suggestions.

* Use sRGB color space for albedo and emissive, use linear color space for all other textures.
* Texture types:
  * **Albedo**: if a transparency texture is needed, use the alpha channel of albedo.
  * **ORM** (combined map for Ambient Occlusion, Roughness, Metallic): Single bitmap with ambient occlusion in red channel, roughness in green channel, metalness in blue channel.
  * **Normal** bump: Tangent-space normal maps for glTF and USDZ, use OpenGL coordinates, with red right, green up.
  * **Emissive**
* Use JPG textures as much as possible for albedo (without transparency) and emissive.
* If JPG artifacts are too extreme, use PNG texture format. 
* Use a PNG for albedo when a material requires transparency. Transparency texture is always stored in albedo alpha channel.
* Textures should be as small as possible without losing detail. See publishing target section below for target sizing. 


<header> 
    <h3>Lighting Summary</h3> 
</header>
<hr>

<ins>Link to full version</ins> (Coming soon)

When using lights in a real-time rendered scene it is best to use Image-based lighting (IBL) to confirm accuracy but not to use dynamic lighting (i.e. Direct, Spot, and Point lights) in an asset. Oftentimes, 3D content creators will use a single ambient color light to light a scene, but we recommend against illuminating a scene in this way. Ambient lights are not physically based, and in general we recommend using a consistent Image based lighting setup to test the accuracy of your models, materials and textures. **The final model export should not include any lighting set up**.

* **Image-based Lighting (IBL)** is a panoramic environment image, used for both specular reflections (glossy surfaces) and soft diffuse lighting (rough surfaces). IBLs can be created from panoramic high-dynamic range photography or rendered from a computer graphics scene. Click here to link to the standard [<ins>Khronos sample GLTF viewer</ins>][link-id-gltfviewer]. Link [<ins>here</ins>](https://www.google.com) with common IBLs.
* **Emissive Mapping** - usually do not cast light onto other surfaces.  Emissive maps are used to make surfaces glow, as if they are lit internally. Emissive maps usually do not cast light onto other surfaces and can be a texture or just a solid color value.
* **Baking Lighting/Shadow** - We recommend not baking lighting as it doesn’t support a PBR workflow.

<header> 
    <h3>Publishing Targets Summary</h3> 
</header>
<hr>

<ins>Link to full version</ins> (Coming soon)

In order to best make certain decisions when authoring 3D Models, one must have an idea about the intended hardware and software where assets will ultimately be rendered for consumer visualization. Visual fidelity must be balanced with real-time performance and tested on the desired rendering platform. While the output target should be based on object design and complexity, the following list specifies general guidelines for common publishing targets, aiming at the lowest common denominators.

* Web for Desktop and Mobile AR (for a single item)
    * File Size = Ideally less than 5MB for glTF/ GLB/ USDZ*
    * Triangle Count = 100k or less
    * Textures = power of 2 textures, square not required; 2k albedo/transparency; 1k ORM/normal/emissive
    * Draw calls = fewer the better (e.g. consolidate meshes, fewer use of total materials to increase asset performance)

    **Note**: \
    \* File size recommendations will change as new texture compression formats such as glTF Universal Textures using the KTX2 container and geometry compression using Draco, with higher compression, become the new mainstream standard.  To learn more about [<ins>KTX2</ins>][link-id-ktx2] and [<ins>Draco</ins>][link-id-draco].



[link-id-001]:./detail-version/FileFormatsAndAssetStructure.md
[link-id-002]:./detail-version/CoordinateSystemandScaleUnit.md
[link-id-gltfviewer]:https://github.com/KhronosGroup/glTF-Sample-Viewer
[link-id-draco]:https://github.com/KhronosGroup/glTF/tree/master/extensions/2.0/Khronos/KHR_draco_mesh_compression
[link-id-ktx2]:https://github.com/KhronosGroup/KTX-Software
