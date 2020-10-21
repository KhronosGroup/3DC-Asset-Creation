# Rendering & Lighting

*Version 1.0.0*\
Last Updated: October 20, 2020


[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](./asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)

# Lighting
For best results use an IBL and add Emissive if the product has internal lighting.

<img src="./figures/sec06_fig04_lighting_methods.png" alt="Image credit: Wayfair" width="800px"/>

    (C)2020, Wayfauir. License: CC BY 4.0 International
    Figure 6.4: Comparison of lighting methods

## Image-based lighting (IBL)

This is a panoramic environment image, used for both specular reflections (glossy surfaces) and soft diffuse lighting (rough surfaces). IBLs can be created from panoramic high-dynamic range photography or rendered from a computer graphics scene.

## Analytical Lights

These are lights that can be moved and rotated in the scene. These create clear delineation on the edges of the model, react well with Normal Bump textures, and can cast real-time shadows. 

Analytical lights are also called Analytical, Dynamic, or Punctual. Common types are Direct, Spot, and Point. 

## Emissive

Parts of the surface can be made to glow, as if lit internally. Emissive usually does not cast light onto other surfaces, it only makes the current surface appear to glow. Emissive is not affected by lighting; it is shown full-bright on the model, and it’s additive. Emissive can be a texture or just a solid color value.

## Ambient

A single ambient color lighting value is available, but we recommend against using it. It is not physically based, and flattens out the model. We recommend using IBL to provide ambient lighting with directionality and higher fidelity.

## Shadows

It is not recommended to add a pre-baked drop shadow underneath a product model, except when a specific situation calls for it. 

Viewers may create shadows dynamically. If there’s a shadow plane included in the model file, this can cause a visual conflict of doubled shadows, or flickering. When creating a 3D Commerce asset, it’s best not to include a shadow plane, so the model can be re-used in many different viewers.

One example where a shadow plane can be added to the model is for use in a Facebook AR Effect. The drop shadow plane helps indicate when an asset is being lifted to move it across the floor. https://sparkar.facebook.com/ar-studio/learn/articles/3D/simple-shadows#choosing-an-occluder-object

<img src="./figures/sec06_fig05_shadow_spark-ar-studio.png " alt="Image credit: Wayfair" width="800px"/>

    (C)2020, Wayfauir. License: CC BY 4.0 International
    Figure 6.5: A shadow plane is added in Facebook’s Spark AR Studio (left). How it will display in AR on the user’s device (right). 

## Ambient Occlusion

Currently we suggest pre-computing the ambient occlusion and storing it in a texture in the material. (see the Materials section)

As devices become more powerful, it will become feasible to use real-time ambient occlusion. There are many types of real-time dynamic occlusion, for example screen-space ambient occlusion (SSAO). At this time however, mobile and AR and VR devices are not powerful enough to create dynamic occlusion while keeping the frame rate at sufficient interactive speeds.

# Drawcalls

Generally, the less separate parts on a model, the faster it will render. Optimizing the number of materials is an important task for content creators. See the section on Publishing Targets for drawcall limits.

A “drawcall” is how the graphics processing unit (GPU) renders 3D models. Batches of vertices that share the same material are loaded and rendered together. If there are too many drawcalls, the rendering API cannot re-use the same model state between drawcalls, and the frame rate slows down. 

Note however the overhead of each drawcall varies from API to API (eg OpenGL vs Vulkan). To evaluate the allowable limits for your application, you will need to assess performance on a case-by-case basis.


<img src="./figures/sec06_fig01_chair.png" alt="Image credit: Wayfair" width="800px"/>

    (C)2020, Wayfair. License: CC BY 4.0 International
    Figure 6.1: A chair using four materials

In the chair example above, four materials are being used. This works fine on most real-time devices. If you need to render the model on a slow device with limited memory or a slow GPU, then a single material for the whole model may be required.

<img src="./figures/sec06_fig02_chair_materials.png" alt="Image credit: Wayfair" width="800px"/>

    (C)2020, Wayfair. License: CC BY 4.0 International
    Figure 6.2: Four materials (left) have been combined into a single material (right)



There are benefits and drawbacks to using a single material. You must compare the trade-offs with your situation to figure out how best to proceed: 

1. Combining several materials into one material will generally improve the rendering speed for your model, and decrease the file size, decreasing wait times for the consumer.

2. Combining into a single material tends to cause blurrier textures. There is less texture space for each part, and you cannot use tiling on combined textures. The model may still look OK on smaller devices.

3. Material variants do not work well with combined materials. If a chair has different fabric colors, it is generally more efficient to swap materials that only contain the fabric change, than to swap larger multi-surface materials. If material variations can be represented by solid colors or values, instead of changing the textures, this is even better since the file size can be very small, and download speed can be improved. Separate materials are required for per-part changes to values or colors.

4. The complexity increases exponentially if multiple parts have their own variants. For example if a chair has materials for fabric, wood, and metal, and each has its own set of variants then a large number of combined materials would need to be generated, one for each combination of variants.

## Drawcalls and Over Draws

For each mesh on the object and for each material on that mesh, the renderer has to calculate the visible triangles to turn them into pixels for the screen, which is referred to as a drawcall. For each drawcall, the triangles and material have to be loaded and processed, although this may differ based on API implementation. It happens with WebGL and GLES, but is different for Vulkan or later versions of DirectX. The cost of overhead is greatly reduced by a command structure and removal of check in drivers for these newer API implementations. However, there is always some overhead in the loading process, which makes joining more meshes into a single object more efficient. 

The exception where there should be multiple meshes is for transparent components. You can think of each drawcall like a layer in Photoshop. If a single mesh has some transparency, a single drawcall will not show anything behind the transparent areas. If that transparent part is a separate mesh, the renderer will draw one on top of the other and the transparent part will layer over the solid mesh, allowing it to be seen through the material.

## Mesh Count and Performance

Our recommendation for static assets is to separate all solid meshes from all transparent meshes when possible to simplify your model and reduce the amount of artifacting that may be seen in the viewer. You may join all solid meshes into a single object if there is a need to simplify your overall model. All transparent meshes can be separated into one or more separate objects as need be.

<img src="./figures/sec06_fig03_draw_calls.png" alt="Image credit: Wayfair" width="800px"/>

    (C)2020, Khronos. License: CC BY 4.0 International
    Figure 6.3: 149 drawcalls for the Buggy sample model, in the BabylonJS sandbox

The picture above shows the [Buggy glTF file](https://github.com/KhronosGroup/glTF-Sample-Models/tree/master/2.0/Buggy), rendered inside the [Babylon.js Sandbox](https://sandbox.babylonjs.com/) web application. As shown in the panel on the right, within this rendering engine this asset results in 149 drawcalls. 

The amount of draws can be significantly reduced during asset creation by batching several parts together, especially if the run-time application does not need to have them separated (for example, to allow hiding / showing parts individually)

# Color Space

The sRGB color space is commonly used to store and display color images, such as Base Color and Emissive textures which are often derived from photographs. Colors are stored using a non-linear value curve, similar to the 2.2 gamma response curve of a computer display, and similar to the way the human visual system responds to color values. Values are biased using a curve to better store and display human-discernable light levels.

All the other textures should be saved using linear values. To save in sRGB linear use a gamma value of 1.0. This stores the values in a purely linear progression of values, with no curve involved, which helps preserve the original mathematical progression of the source content. sRGB linear should be used to store textures that control purely mathematical features, such as Alpha Coverage, Metalness, Roughness, Normal, and Occlusion. 

Base Color and Emissive textures should always be saved in sRGB color space. All other textures should be saved in sRGB linear. Linear textures should always be created, edited, and used in sRGB linear, or else image and rendering errors will occur.

Most real-time shaders, materials, and viewers will take care of this for you. However, many of the content creation software tools do not handle color spaces correctly.


<br></br>

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](./asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)