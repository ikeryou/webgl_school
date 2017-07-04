uniform sampler2D tDiffuse;
uniform float time;
uniform float contrastR;
uniform float contrastG;
uniform float contrastB;
uniform float brightness;
uniform float lineScaleR;
uniform float lineScaleG;
uniform float lineScaleB;
uniform float discardAlpha;

varying vec2 vUv;

float contrast(float src, float c) {
  src = (src - 0.5) / (1.0 - c * 0.01) + 0.5;
  // src = clamp(src, 0.0, 1.0);
  return src;
}

float line(float src, vec2 v, float scale) {
  if(scale > 1.0) {
    src = src * (sin(v.x + v.y) + scale * 0.01);
  }
  return src;
}

void main(void) {

  vec4 dest = texture2D(tDiffuse, vUv);

  dest.r = contrast(dest.r, contrastR);
  dest.g = contrast(dest.g, contrastG);
  dest.b = contrast(dest.b, contrastB);



  if(dest.a > 0.0) {
    dest.r = line(dest.r, gl_FragCoord.xy * lineScaleR * 0.01, lineScaleR);
    dest.g = line(dest.g, gl_FragCoord.xy * lineScaleG * 0.01, lineScaleG);
    dest.b = line(dest.b, gl_FragCoord.xy * lineScaleB * 0.01, lineScaleB);
  }

  dest.rgb += brightness * 0.01;

  if(dest.a <= discardAlpha * 0.01) {
    discard;
  }

  // if(dest.r < 1.0) {
  //   dest.r = line(dest.r, gl_FragCoord.yx * lineScaleR * 0.01, lineScaleR);
  // }
  //
  // if(dest.g < 1.0) {
  //   dest.g = line(dest.g, gl_FragCoord.xy * lineScaleG * 0.01, lineScaleG);
  // }
  //
  // if(dest.b < 1.0) {
  //   dest.b = line(dest.b, gl_FragCoord.yx * lineScaleB * 0.01, lineScaleB);
  // }

  // if(dest.r >= 0.5) {
  //   vec2 v = gl_FragCoord.xy * lineScale1 * 0.01;
  //   float f = sin(v.x + v.y);
  //
  //   dest.r = dest.r * (f + lineScale2 * 0.01);
  // } else {
  //   discard;
  // }




  gl_FragColor = dest;

}
