shader_type canvas_item;

uniform float speed = 2.0;
uniform float amplitude = 0.1;
uniform float frequency = 5.0;

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;
    float dist = length(uv);

    if (dist > 1.0) {
        COLOR = vec4(0.0);
    } else {
        float wave = sin(TIME * speed + dist * frequency) * amplitude;
        vec2 offset = uv * wave;
        vec2 distorted_uv = UV + offset;

        COLOR = texture(TEXTURE, distorted_uv);
    }
}