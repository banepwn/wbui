#pragma language glsl3
vec4 effect(vec4 color, sampler2D tex, vec2 texture_coords, vec2 screen_coords)
{
	return vec4(1., 1., 1., texture(tex, texture_coords).w) * color;
}
