#version 330 core
uniform vec2 quadVertices[4] = vec2[4]( vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0), vec2(1.0, 1.0) );
void main()
{
  vec2 vert = quadVertices[gl_VertexID];
  gl_Position = vec4(vert, 0.0, 1.0);
}
