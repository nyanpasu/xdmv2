#version 330 core

uniform vec2 resolution;
uniform float time;

out vec4 fragColor;

void main() {
  vec4 fragCoord = gl_FragCoord;
  vec2 uv = fragCoord.xy / resolution.xy;
  fragColor = vec4(uv, 0.5 + 0.5 * sin(time), 1.0);
}
