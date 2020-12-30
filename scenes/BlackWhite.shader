shader_type canvas_item;

uniform vec4 color_base;
uniform vec4 color_outline;

void fragment() {
    vec4 curr_color = texture(TEXTURE,UV); // Get current color of pixel
    vec3 lum = vec3(0.299, 0.587, 0.114);
    COLOR = vec4( vec3(dot( curr_color.rgb, lum)), curr_color.a);
}