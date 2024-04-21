shader_type canvas_item;

uniform float time;

void fragment() {
    // Sample the texture
    vec4 texColor = texture(TEXTURE, SCREEN_UV);

    // Simulate underwater color tint
    texColor.rgb = vec3(0.2, 0.5, 0.8);  // Set a consistent blue color tint

    // Apply the final color
    COLOR = texColor;
}