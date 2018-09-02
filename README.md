
# Unity Matte Shadow Shader

this is a little test of a simple shader which simulates the classic static camera with the add-on of shadows (RE Remake, Alone in the dark new nightmare, etc)

With this shader the 3d models can move around in a prerendered scene and can be occluded by occluder meshes which cast shadows dynamically


## How to use it

You need the rendered scene as the background texture, and the scene mesh with the camera imported.
1 - Set the rendered texture on the MatteShader material, after that select a shadow color.
2 - Apply the MatteShader on all the prerendered assets (Ocludders)

## Example Images 


![Config Options](https://github.com/mjFer/MatteShadowShader/blob/master/img/example.jpg)

![Config Options](https://github.com/mjFer/MatteShadowShader/blob/master/img/material.png)
