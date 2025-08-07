<!--
    Copyright 2025 The Khronos Group, Inc.

    SPDX-License-Identifier: CC-BY-4.0
-->

![](https://www.khronos.org/assets/images/api_logos/3dcommerce.svg)

# Real-time Asset Creation Guidelines

This document, created by the Khronos Group's 3D Commerce working group, guides 3D artists in producing high-quality 3D models for the web, apps, games, and XR devices. These guidelines are valuable for anyone developing photorealistic, real-time 3D content, especially for creating digital twins of physical products.

Each section covers a specific topic and includes suggestions for best practices, as well as interactive 3D models to demonstrate the principles described.

Please share your feedback/suggestions/updates by [opening an issue](https://github.com/KhronosGroup/3DC-Asset-Creation/issues).

<br>

_Version 2.0.0_\
Last Updated: August 2025

<!-- Start License -->

[![CC4](https://licensebuttons.net/l/by/3.0/88x31.png)](https://creativecommons.org/licenses/by/4.0/)

This work is licensed under a CC BY 4.0 license.

Copyright 2025 The Khronos® Group Inc.

<!-- End License -->

## Editors and Alumni

Listed in alphabetical order of company names

**Version 2.0**\
Matthew MacFarquhar, Amazon\
Eric Chadwick, DDG\
Daniel Frith, London Dynamics\
Mike Festa, SuperDnaX

<br>

**Version 1.0 Alumni**\
Sam De Lara, 3XR\
Mike Festa, 3XR\
Brent Scannell, Autodesk\
Max Limper, DGG\
Nathaniel Hunter, DreamView\
Mike Badillo, Samsung\
Boaz Ashkenazy, Simply Augmented\
Thomas Huang, Target\
Jagdishwar Jaman Jyothi, Target\
Beau Perschall, TurboSquid\
Eric Chadwick, Wayfair

<br>

# Table of Contents

- [File Structure](#file-structure-summary) ( [<ins>full version</ins>](./full-version/sec01_FileStructure/FileStructure.md) )
- [Geometry](#geometry-summary) ( [<ins>full version</ins>](./full-version/sec02_Geometry/Geometry.md) )
- [UV Coordinates](#uv-coordinates-summary) ( [<ins>full version</ins>](./full-version/sec03_UVCoordinates/UVCoordinates.md) )
- [Materials](#materials-summary) ( [<ins>full version</ins>](./full-version/sec04_Materials/Materials.md) )
- [Textures and Shaders](#textures-and-shaders-summary) ( [<ins>full version</ins>](./full-version/sec05_TexturesAndShaders/TexturesAndShaders.md) )
- [Lighting](#lighting-summary) ( [<ins>full version</ins>](./full-version/sec06_Lighting/Lighting.md) )
- [Animation](#lighting-summary) ( [<ins>full version</ins>](./full-version/sec07_Animation/Animation.md) )
- [Levels of Detail](#levels-of-detail-summary) ( [<ins>full version</ins>](./full-version/sec08_LevelsOfDetail/LevelsOfDetail.md) )
- [Publishing Targets](#publishing-targets-summary) ( [<ins>full version</ins>](./full-version/sec09_PublishingTargets/PublishingTargets.md) )
- [Performance & Optimization](#performance--optimization-summary) ( [<ins>full version</ins>](./full-version/sec10_PerformanceAndOptimization/PerformanceAndOptimization.md) )
- [Source of Content](#source-of-content-summary) ( [<ins>full version</ins>](./full-version/sec11_SourceOfContent/SourceofContent.md) )
- [Future Developments](#future-developments-summary) ( [<ins>full version</ins>](./full-version/sec12_FutureDevelopments/FutureDevelopments.md) )

## Section Summaries

### File Structure Summary

[<ins>Link to full version</ins>](./full-version/sec01_FileStructure/FileStructure.md)

<strong>File Formats</strong> - differences between delivery formats (glTF and USDZ), interchange formats (USD, fbx, obj), and native authoring formats (such as .blend).

<strong>Single vs Multiple Files</strong> - glTF can be a single file (.glb) or have separate textures and binary data. Using a single file is generally preferred, but there are some exceptions.

<strong>Structure</strong> - A 3D model is composed of scenes, nodes, meshes, and primitives. It has materials, which follow physically based lighting (PBR) standards that may use 2D textures.

<strong>Extensions</strong> - glTF has an extension system to allow it to evolve as technology improves. Khronos maintains a set of [<ins>ratified extensions</ins>](https://github.com/KhronosGroup/glTF/tree/main/extensions#ratified-khronos-extensions-for-gltf-20) that are widely supported.

<strong>Naming Conventions</strong> - It’s important to name your elements in a logical way. Common characters should be used when naming asset files: a-z, _, -, 0–9. It is best to start the file name with a letter as the first character. Use underscore _ or hyphen - to separate words within a file name, rather than using spaces.

---

### Geometry Summary

[<ins>Link to full version</ins>](./full-version/sec02_Geometry/Geometry.md)

<strong>Coordinate Systems</strong> - The position and orientation of the 3D model is especially important when it is a product for eCommerce. The product should be positioned upright and forward for the best presentation. Both glTF and USDz use the <strong>right-handed coordinate system</strong>.

<strong>Scale</strong> - The size of the model must be <strong>1:1 the size of the real item</strong>. In glTF <strong>1 unit = 1 meter</strong>.

<strong>Origin Location</strong> - The general recommendation is for the bottom center of the product to be placed at 0,0,0. Different origins may be appropriate depending on the product category and where it should be anchored in the real world, for example top-center for a ceiling-mounted product.

<strong>Triangles</strong> - glTF stores mesh data as triangles only and unlike authoring formats, does not support quads or ngons.

<strong>Vertices</strong> - glTF stores meshes as single-indexed data; vertices are split on export if they contain more than one of each type of mesh data (texture coordinates, normals, materials, etc.).

<strong>Vertex Normals</strong> - Can be edited to control whether triangle edges appear sharp, and face-weighted normals can be used to improve the look of rounded edges such as bevels.

<strong>Mesh Instancing</strong> - Elements within a model that share the same geometry, such as wheels on a car, can reference a single copy of that data, improving performance. There are some considerations to be aware of, such as conflicting baked ambient occlusion values.

<strong>Triangle Count and Complexity</strong> - 3D assets should be modeled with highly accurate geometry to mimic the details of the physical product. That can often result in a large number of triangles, which is often at odds with delivering a small file with good performance in real-time rendering. There are automated tools that can take a large 3D model and reduce its geometry based on different settings.

### UV Coordinates Summary

[<ins>Link to full version</ins>](./full-version/sec03_UVCoordinates/UVCoordinates.md)

<strong>UV vs XYZ</strong> - The UV coordinate system is a 2D location on an image texture that corresponds to a 3D point on the triangles of the model. If a material is using one or more textures, the UV map is used by the rendering engine to know what color pixel to paint on each pixel of the screen.

<strong>Multiple UV Maps</strong> - Some applications support glTF's ability to use more than one UV map, for example a tiled fabric texture and non-repeating ambient occlusion. However, because it is not universally available and not fully supported by USDZ renderers, it is generally <strong>not recommended</strong>.

<strong>UV Island Margins and MIP Mapping</strong> - UV maps have groups of connected triangles called islands, which share pixels. If two islands are directly touching each other, the pixels at the edge may bleed over from one island to the other, resulting in visual artifacts and seams that do not look correct. This is especially pronounced when the resolution of a texture is automatically reduced with distance. This automatic texture reduction is called MIP Mapping.

<strong>Atlasing (0 to 1 UV space)</strong> - For textures that do not repeat and are unique to every triangle on the model, all of the UV coordinates should be between 0 and 1. This is important for ambient occlusion so that the baked lighting is unique and not repeated.

<strong>Tiling (repeating)</strong> - UV values that are above 1 or below 0 will loop around on the texture. This is useful to repeat a pattern on a model, which can be common on products such as those made out of cloth. Repeating a texture allows for a lower resolution image texture to be used while retaining the ability to zoom in and still see a lot of detail.

<strong>Overlapping UVs</strong> - In general, overlapping UVs should be avoided, but there are cases where it may be beneficial. Overlapping will look the same and may be useful for a product that has copies of a logo or decal in multiple places on the model.

<strong>Texel Density</strong> - Each texture has a fixed number of pixels that is referred to as the resolution, however when drawn on the screen, those pixels may end up being much larger or smaller based on how much surface area they cover.

### Materials Summary

---

[<ins>Link to full version</ins>](./full-version/sec04_Materials/Materials.md)

<strong>Metallic-Roughness</strong> - The glTF PBR and USDPreviewSurface material models use the Metallic-Roughness workflow, which stores reflection information as three main variables: Base Color, Metallic, and Roughness. Specular-Glossy workflow is not recommended due to requiring more textures.

<strong>Single Textures in PBR Materials</strong> - When materials are authored in digital content creation software (DCC) they often use multiple nodes to blend or layer various effects. To deploy these materials, these nodes need to be baked down into bitmap textures.

<strong>Channel Packing in Textures</strong> - Some PBR textures use channel-packing to store multiple textures into one bitmap file. This helps reduce file sizes, and allows multiple textures to reuse the same space in memory during rendering.

<strong>Emissive or Unlit</strong> - glTF offers an extension which increases the emissive strength beyond 100%, which renderers can then use to enable a glow effect. The Unlit extension disables all lighting calculations for a surface, and uses the color values from the Base Color, which can be useful for user interface graphics or for special effects animations.

<strong>Alpha Transparency</strong> - Alpha can be used to control the visibility of a surface. Two modes are available in glTF: alphaMode:Mask and alphaMode:Blend. Mask creates on/off coverage and is commonly used to simulate geometry such as tree leaves or wire fencing, while Blend offers soft gradations of visibility such as fur or smoke.

<strong>Transmission for Glass</strong> - To more accurately represent refractive and reflective materials in real-time renderers, glTF can use the Transmission and Volume extensions to simulate refraction.

<strong>Optimizing Transparency</strong> - Transparency in real-time rendering is often difficult to represent accurately, and can significantly impact rendering performance. If done incorrectly, transparency can lead to visual bugs and this section helps avoid common pitfalls.

<strong>Extensions</strong> - Both glTF and USDZ offer a number of material and texture features that can increase the realism of your model. This section identifies, showcases, and compares the available extensions.

### Textures and Shaders Summary

---

[<ins>Link to full version</ins>](./full-version/sec05_TexturesAndShaders/TexturesAndShaders.md)

Textures are 2D image files that define a material's appearance and enhance a model's photorealism. Shaders are a combination of 2D texture images that determine how objects respond to light, color, and texture, and are crucial for creating realistic or stylized visual effects.

<strong>Base Color</strong> - Base Color, also known as albedo or diffuse, controls non-reflective surface detail for non-metallic surfaces, e.g. wood grain, brick color, fabric prints, etc. When a surface is metallic, the Base Color handles the reflection color, such as gold, copper, or brass.

<strong>Alpha Coverage</strong> - Alpha Coverage controls the visibility of pixels in a material and can be either Mask mode for on/off or Blend mode for gradations of opacity.

<strong>Metallic</strong> - Metallic controls how the surface reflects light, either as raw metal or as a non-metallic (dielectric) surface. Pixels should be either white (metal) or black (non-metal). Gray values should only be used for anti-aliasing.

<strong>Roughness</strong> - Roughness defines micro-surface bumpiness, which essentially controls how blurry or sharp reflections will be.

<strong>Ambient Occlusion</strong> - Ambient occlusion is used to simulate soft shadows where a model has intersections or crevices. For best results, use a ray/path traced renderer to precalculate occlusion and store this in an Occlusion texture.

<strong>Emission</strong> - Emissive controls the color and intensity of light being emitted by a material. The KHR_materials_emissive_strength extension adds a Strength scalar factor to enable the upper limit of emissive strength to be increased per material, and can act as a hint to renderers to enable bloom post-processing effects.

<strong>Normal</strong> - A normal texture is used for macro-scale bumpiness, adding variation in surface direction to simulate grooves, pits, fibers, etc from a 2D image. It can be generated by baking curvature from a higher-detail model, allowing a lower-resolution model to look like it has more smoothness or detail.

<strong>Texture File Formats</strong> - glTF files can use 2D images in these formats: png, jpg, webp or ktx2. They each have trade-offs in quality, file size, and GPU performance. It's recommended to author lossless png files and use automated tools to generate the other files based on the intended use case.

### Lighting Summary

---

[<ins>Link to full version</ins>](./full-version/sec06_Lighting/Lighting.md)

This summary is coming soon. Please refer to the [working Google Doc](https://docs.google.com/document/d/1EttaYOomLhp7K0g0KIPNiRH7l23hNf6BuNXEQqWw54o/edit?usp=sharing) or the [1.0 Guidelines](../asset-creation-guidelines-1.0/full-version/sec06_RenderingAndLighting/RenderingAndLighting.md).

### Animation Summary

---

[<ins>Link to full version</ins>](./full-version/sec07_Animation/Animation.md)

Animations are a great way to bring products to life and to show off functionality. Both glTF and USDZ have some support for animation, but achieving the desired results can be challenging. Note that animation data can sometimes greatly increase the file size and should be removed from the file if the animation is unused or unnecessary.

<strong>Scaling</strong> - A fundamental transformation in glTF animations, allowing for effects like growth, shrinkage, or pulsation.

<strong>Keyframes</strong> - Keyframes define specific values for properties like translation, rotation, and scale at certain times. Each animation channel targets a node and a specific property, using accessors for input (timestamps) and output (values). Interpolation methods such as STEP, LINEAR, or CUBICSPLINE determine how values transition between keyframes.

<strong>Optimization</strong> - Optimizing animations is crucial for performance and file size reduction. Redundant keyframes and unnecessary data can bloat glTF files and should be excluded from files when not used.

<strong>Tracks</strong> - In glTF, an animation consists of multiple channels, each targeting a node's property (translation, rotation, or scale). These channels can be thought of as tracks that collectively define the animation.

<strong>Ambient Occlusion and Moving Meshes</strong> - Ambient Occlusion (AO) maps simulate soft shadows in crevices and are typically baked into static models. When mesh components move, these pre-baked AO maps may no longer accurately represent the lighting, and can lead to visual inconsistencies.

<strong>Bones, Skinning, and Morphing</strong> - Advanced animations in glTF involve skeletal structures (bones), skinning, and morph targets. They can group vertexes together with weighted strength to achieve more natural deformations.

<strong>Looping Animations</strong> - Looping behavior is typically controlled by the application or engine that plays the glTF animation. When you define an animation using keyframes and time values, it's implicitly treated as a one-shot animation unless the playback system specifies looping behavior. In practice, it is important to ensure your start and end keyframes line up if you intend the glTF model animation to loop seamlessly.

<strong>Blending Multiple Animations</strong> - In complex scenes, a model may have multiple animations—such as "walk", "run", "idle", and "jump"—defined in the same glTF file. These animations are distinct, and blending between them is not defined in the glTF file itself. In practice engines will blend animations using crossfading, additive blending or allowing manual blending.

### Levels of Detail Summary

---

[<ins>Link to full version</ins>](./full-version/sec08_LevelsOfDetail/LevelsOfDetail.md)

This summary is coming soon. Please refer to the [working Google Doc](https://docs.google.com/document/d/1EttaYOomLhp7K0g0KIPNiRH7l23hNf6BuNXEQqWw54o/edit?usp=sharing) or the [1.0 Guidelines](../asset-creation-guidelines-1.0/full-version/sec07_LevelsofDetail/LevelsofDetail.md).

### Publishing Targets Summary

---

[<ins>Link to full version</ins>](./full-version/sec09_PublishingTargets/PublishingTargets.md)

This summary is coming soon. Please refer to the [working Google Doc](https://docs.google.com/document/d/1EttaYOomLhp7K0g0KIPNiRH7l23hNf6BuNXEQqWw54o/edit?usp=sharing) or the [1.0 Guidelines](../asset-creation-guidelines-1.0/full-version/sec99_PublishingTargets/PublishingTargets.md).

### Performance & Optimization Summary

---

[<ins>Link to full version</ins>](./full-version/sec10_PerformanceAndOptimization/PerformanceAndOptimization.md)

<strong>Useful Links</strong> - Tools that you can use to optimize your models.

<strong>Polygon Count</strong> - Models should only have as much geometry as necessary to keep a high level of realism. The more triangles, the more calculations that need to be computed when rendering. Normal map textures (see materials section) should be used to capture small details that may be modeled in a base asset in order to reduce the triangle count while retaining visual fidelity.

<strong>Scene Graph Culling and Occlusion</strong> - Dividing models into smaller, distinct parts allows the rendering engine to perform frustum culling and occlusion culling more effectively. This means the engine can determine which parts of the model are not within the viewer's perspective or are hidden behind other objects, thereby avoiding the unnecessary processing of those unseen geometry, significantly improving runtime performance and frame rates, especially in complex scenes.

<strong>Mesh Instancing</strong> - Reusing a single mesh in multiple nodes is more efficient than duplicating mesh geometry for each node. This approach reduces file size as the mesh data (vertices, triangles, UVs) is stored only once.

<strong>Texture Optimization</strong> - Textures can be optimized for over the wire latency by reducing its memory footprint using established image formats, or compressed using a GPU compressed texture to reduce size transported and reduce VRAM usage once on the renderer.

<strong>Mesh Optimization</strong> - Mesh optimization beyond simple polycount reduction can reduce the overall model file size, consume less memory on the client side and overall lead to a smoother more performant 3D experience. glTF has extensions for Draco and MeshOpt.

### Source of Content Summary

---

[<ins>Link to full version</ins>](./full-version/sec11_SourceofContent/SourceOfContent.md)

This summary is coming soon. Please refer to the [working Google Doc](https://docs.google.com/document/d/1EttaYOomLhp7K0g0KIPNiRH7l23hNf6BuNXEQqWw54o/edit?usp=sharing)

### Future Developments Summary

---

[<ins>Link to full version</ins>](./full-version/sec12_FutureDevelopments/FutureDevelopments.md)

<strong>Interactivity</strong> - Assets can include self-contained behaviors.

<strong>MaterialX</strong> - A node graph for procedural materials and textures.

<strong>Node Visibility</strong> - Turn on and off different parts of the model, especially useful when used with the interactivity extension.

<strong>Subsurface Scattering</strong> - Diffuse Transmission and Volumetric Scattering can mimic how light is scattered through materials such as skin or wax.

<strong>Gaussian Splatting</strong> - A way of displaying point clouds with view-dependant properties that stretch and elongate each point. They can provide a photo-realistic representation of a product with features that are traditionally hard to represent with triangles and PBR textures, such as thin features and fur.
