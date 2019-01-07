vec4 resultCol;
vec4 textureCol;

vec4 effect(vec4 col, Image texture, vec2 texturePos, vec2 screenPos) {
  textureCol = texture2D(texture, texturePos);
  resultCol = vec4(1.0f, 0.0f, 0.0f, textureCol.a);
  return resultCol;
}
