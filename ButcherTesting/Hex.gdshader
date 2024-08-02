shader_type canvas_item;

uniform vec2 size = vec2(32.0, 28.0);
// If you intend to read from mipmaps with `textureLod()` LOD values greater than `0.0`,
// use `filter_nearest_mipmap` instead. This shader doesn't require it.
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
        vec2 norm_size = size * SCREEN_PIXEL_SIZE;
        bool half = mod(SCREEN_UV.y / 2.0, norm_size.y) / norm_size.y < 0.5;
        vec2 uv = SCREEN_UV + vec2(norm_size.x * 0.5 * float(half), 0.0);
        vec2 center_uv = floor(uv / norm_size) * norm_size;
        vec2 norm_uv = mod(uv, norm_size) / norm_size;


		float lx = (1.0/20.0) / (1152.0/648.0);
		float ly = (1.0/20.0);
		float valueX = floor((1.0/(lx))*SCREEN_UV.x)*lx;
		float valueY = floor((1.0/(ly))*SCREEN_UV.y)*ly;
		COLOR = vec4(valueX, valueY, 0, 1);
		//COLOR = vec4(SCREEN_UV.x, SCREEN_UV.y, 0, 1);
        COLOR = texture (screen_texture, vec2(valueX, valueY), 0.0);
		//COLOR = texture (screen_texture, SCREEN_UV, 0.0);
		// #textureLod(screen_texture, center_uv, 0.0);
}