shader_type canvas_item;

uniform vec2 size = vec2(32.0, 28.0);
uniform vec3 colorA;
uniform vec3 colorB;

// If you intend to read from mipmaps with `textureLod()` LOD values greater than `0.0`,
// use `filter_nearest_mipmap` instead. This shader doesn't require it.
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D ASCII_texture: source_color;

void fragment() {
		float pixCount = 100.0;
		float lx = (1.0/pixCount) / (1152.0/648.0);
		float ly = (1.0/pixCount);
		float valueX = floor((1.0/(lx))*SCREEN_UV.x)*lx;
		float valueY = floor((1.0/(ly))*SCREEN_UV.y)*ly;
		
		float disX = SCREEN_UV.x - valueX;
		float disY = SCREEN_UV.y - valueY;
		vec2 localUV = vec2((disX * pixCount) / 10.0, disY * pixCount); // Gets local uv of each cell 
		//COLOR.rgb = vec3(localUV.x, localUV.y,   0);
		
		// floor(lum * charCount)
		vec4 tex_color = texture (screen_texture, vec2(valueX, valueY), 0.0);
		vec3 reducedColor = mix(vec3(dot(tex_color.rgb, vec3(0.299, 0.587, 0.114))), tex_color.rgb, 0.0);
		
		
		float charCount = 20.0;
		float lum = (0.2126*tex_color.r + 0.7152*tex_color.g + 0.0722*tex_color.b);
		float sectionedLum = floor(lum * charCount) / charCount;
		//COLOR.rgb = vec3(sectionedLum, sectionedLum, sectionedLum);
		
		localUV.x += (sectionedLum);
		COLOR.rgb =  mix(colorA / 256.0, colorB / 256.0, texture(ASCII_texture, localUV).r) ;
		//COLOR.rgb = vec3(localUV.x, localUV.y, 0.0);
		
		//COLOR = vec4(valueX, valueY, 0, 1);
		//COLOR = vec4(SCREEN_UV.x, SCREEN_UV.y, 0, 1);
		//COLOR = texture (ASCII_texture, vec2(valueX, valueY), 0.0);
		//COLOR = texture (screen_texture, SCREEN_UV, 0.0);
		// #textureLod(screen_texture, center_uv, 0.0);
}