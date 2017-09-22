#version 330 core

in vec2 fragCoord;
out vec4 fragColor;

void main() {
  vec2 uv = fragCoord.xy / iResolution.xy;
  fragColor = vec4(uv, 0.5 + 0.5 * sin(iTime), 1.0);
}
