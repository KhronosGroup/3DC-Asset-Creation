# File Structure

_Version 2.0.0_\
Last Updated: August 2025

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](/asset-creation-guidelines/RealtimeAssetCreationGuidelines.md#file-structure-summary)

** <strong>This is a work in progress.</strong> ** Please refer to the [working Google Doc](https://docs.google.com/document/d/1EttaYOomLhp7K0g0KIPNiRH7l23hNf6BuNXEQqWw54o/edit?usp=sharing) or the [1.0 Guidelines](../../../asset-creation-guidelines-1.0/full-version/sec01_FileFormatsAndAssetStructure/FileFormatsAndAssetStructure.md)

## File Formats

These guidelines focus on the delivery asset of 3D models for use in eCommerce. There is an emphasis on the glTF file format, as it is produced by Khronos, but it is also important to note that these best practices are applicable to other delivery formats, such as Apple’s USDZ implementation.

3D assets are authored in a Digital Content Creation (DCC) application, such as Blender or 3ds Max. Those applications typically store their data in a native authoring format, which is often proprietary. These files contain the highest flexibility in making adjustments and modifications to the content, but can be large and complex. Some of these files, especially those from CAD software, may store data parametrically (such as dimensions, radii, and bevels) rather than with vertices, lines, and triangles.

The third category of 3D files are in interchange formats, which are used to pass data between different DCC applications. OpenUSD is the most modern interchange file type and is the recommended choice for storing 3D data at the authoring level. FBX is a common interchange file that has been around since 1996, and while it does have a high amount of support in DCCs, it is no longer recommended as it has security issues and is being phased out. glTF is sometimes used as an interchange format, simply because it is a well-designed format with a lot of support in DCCs, however it is not ideal for interchange as it is limited to only supporting triangles, and vertices are single-indexed (split wherever there are UV/normal/material splits).

## glTF and USDZ

Both glTF and USDZ are delivery formats, designed to provide a 3D model to the end user for use in real-time rendering while minimizing file size and maximizing GPU performance.

glTF can be viewed on any device running a web browser, using technologies such as OpenGL and WebXR/OpenXR. Many native applications, such as Windows 3D Viewer, can also view these files.

USDZ is predominantly used in Apple’s ecosystem and is natively supported on MacOS, iOS, and Safari. Quick Look, which is available on Apple devices, provides a native augmented reality experience for USDZ files.

Although Apple users can view glTF files in the browser, the format is not currently natively supported in Quick Look and therefore cannot be used in augmented reality as easily. Therefore, it is common for the same asset to be delivered as both glTF and USDZ.

These guidelines are focused on the 3D Commerce use case and most companies want to reach as many users as possible, therefore most of the time the same asset needs to be created in both glTF and USDZ. This matrix shows which features are currently available in both formats and which are only available in one.

## Single vs Multiple Files

The glTF file format supports delivery as either a collection of files (.gltf + .bin + textures) or a single file (.glb). When provided as separate files, the .gltf is human readable JSON and describes the structure and links to the other external files. The .bin contains binary data, typically geometry and animation. The textures can be any image format supported by glTF: core support is for .jpg and .png, and .webp and .ktx2 are available with extensions.

For most commerce applications, single .glb file is often preferred instead of tracking multiple files. However, separate files may help to facilitate a visual review of the textures and be more efficient when using a configurator that swaps individual textures instead of the entire model.

## File Structure

A glTF 3D model is composed of scenes, nodes, meshes and primitives. A scene is a collection of nodes, which hold information about position, rotation, and scale for a collection of their own children. Meshes are attached to nodes and contain one or more primitives that contain the geometry as vertices. Each primitive has one material. Materials can contain multiple textures and use Physically Based Rendering (PBR) to provide accuracy and photo-realism so that the 3D model can match the visual appearance of a physical product.

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](/asset-creation-guidelines/RealtimeAssetCreationGuidelines.md#file-structure-summary)
