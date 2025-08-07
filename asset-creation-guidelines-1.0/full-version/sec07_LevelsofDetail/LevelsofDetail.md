# Levels of Detail

*Version 1.0.0*\
Last Updated: October 20, 2020


[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](/asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)

In computer graphics, accounting for Level of detail (LOD) involves decreasing the complexity of a 3D model representation as it moves away from the viewer or according to other metrics such as object importance, viewpoint-relative speed or position. Level of detail techniques increase the efficiency of rendering by decreasing the workload on graphics pipeline stages, usually vertex transformations. The reduced visual quality of the model is often unnoticed because of the small effect on object appearance when distant or moving fast.[^1]

It should be mentioned that LODs differ from assets authored for specific publication targets. A single asset created for desktop web viewing may actually include several LODs designed to be swapped out based on logic embedded in the viewer. The number of LODs required and the reduction of complexity associated with each LOD must consider the switching logic of the viewer, and these guidelines make no strict recommendations regarding LOD configuration at this time. This is a discussion that should be had with the downstream consumer of the 3D content. By default, the most detailed version of a specific asset for a publishing target shall be considered LOD0, and decreasing levels of complexity shall be referred to as LOD1, LOD2, etc.

[^1]: https://en.wikipedia.org/wiki/Level_of_detail


<br></br>

[<ins>Return to <em>Asset Creation Guidelines Summary</em></ins>](/asset-creation-guidelines/RealtimeAssetCreationGuidelines.md)
