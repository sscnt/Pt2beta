//
//  VnImageFilter.m
//  Pastel2
//
//  Created by SSC on 2014/05/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageFilter.h"

@implementation VnImageFilter

NSString* const kVnImageFilterFragmentShaderString = SHADER_STRING
(
 uniform int blendingMode;
 uniform mediump float topLayerOpacity;
 
 mediump float luminosity(mediump vec3 c) {
     return dot(c, vec3(0.3, 0.59, 0.11));
 }
 
 mediump vec3 clipcolor(mediump vec3 c) {
     mediump float l = luminosity(c);
     mediump float n = min(min(c.r, c.g), c.b);
     mediump float x = max(max(c.r, c.g), c.b);
     
     if (n < 0.0) {
         c.r = l + ((c.r - l) * l) / (l - n);
         c.g = l + ((c.g - l) * l) / (l - n);
         c.b = l + ((c.b - l) * l) / (l - n);
     }
     if (x > 1.0) {
         c.r = l + ((c.r - l) * (1.0 - l)) / (x - l);
         c.g = l + ((c.g - l) * (1.0 - l)) / (x - l);
         c.b = l + ((c.b - l) * (1.0 - l)) / (x - l);
     }
     
     return c;
 }
 
 mediump vec3 setlum(mediump vec3 c, mediump float l) {
     mediump float d = l - luminosity(c);
     c = c + vec3(d);
     return clipcolor(c);
 }
 
 mediump vec3 rgb2hsv(const in mediump vec3 c){
     mediump vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
     mediump vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
     mediump vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
     
     mediump float d = q.x - min(q.w, q.y);
     mediump float e = 1.0e-10;
     return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
 /*
 mediump vec3 _rgb2hsv(const in mediump vec3 color){
     mediump float max = color.r;
     if(color.r < color.g){
         max = color.g;
     }
     if(max < color.b){
         max = color.b;
     }
     mediump float min = color.r;
     if(color.r > color.g){
         min = color.g;
     }
     if(min > color.b){
         min = color.b;
     }
     mediump float h = max - min;
     if (h > 0.0) {
         if (max == color.r) {
             h = (color.g - color.b) / h;
             if (h < 0.0) {
                 h += 6.0;
             }
         } else if (max == color.g) {
             h = 2.0 + (color.b - color.r) / h;
         } else {
             h = 4.0 + (color.r - color.b) / h;
         }
     }
     h /= 6.0;
     mediump float s = (max - min);
     if (max != 0.0){
         s /= max;
     }
     mediump float v = max;
     return vec3(h, s, v);
 }
  */
 
 mediump vec3 hsv2rgb(mediump vec3 c){
     if(c.x > 1.0){
         c.x -= 1.0;
     }else if(c.x < 0.0){
         c.x += 1.0;
     }
     c.y = max(min(c.y, 1.0), 0.0);
     c.z = max(min(c.z, 1.0), 0.0);

     mediump vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
     mediump vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
     return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
 /*
 mediump vec3 _hsv2rgb(mediump vec3 color){
     if(color.x > 1.0){
         color.x -= 1.0;
     }else if(color.x < 0.0){
         color.x += 1.0;
     }
     if(color.y > 1.0){
         color.y = 1.0;
     }else if(color.y < 0.0){
         color.y = 0.0;
     }
     if(color.z > 1.0){
         color.z = 1.0;
     }else if(color.z < 0.0){
         color.z = 0.0;
     }
     mediump float r = color.z;
     mediump float g = color.z;
     mediump float b = color.z;
     if(color.y > 0.0){
         mediump float f = color.x * 6.0;
         int hi = int(f);
         f = f - float(hi);
         if(hi == 0){
             g *= 1.0 - color.y * (1.0 - f);
             b *= 1.0 - color.y;
         } else if(hi == 1){
             r *= 1.0 - color.y * f;
             b *= 1.0 - color.y;
         } else if(hi == 2){
             r *= 1.0 - color.y;
             b *= 1.0 - color.y * (1.0 - f);
         } else if(hi == 3){
             r *= 1.0 - color.y;
             g *= 1.0 - color.y * f;
         } else if(hi == 4){
             r *= 1.0 - color.y * (1.0 - f);
             g *= 1.0 - color.y;
         } else if(hi == 5){
             g *= 1.0 - color.y;
             b *= 1.0 - color.y * f;
         }
         return vec3(g, 0.0, 0.0);
     }
     return vec3(r, g, b);
 }
 */

 // Normal
 mediump vec4 blendNormal(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     return vec4(top.rgb * top.a + (1.0 - top.a) * bottom.rgb, 1.0);
 }
 // Darken
 mediump vec4 blendDarken(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     return mediump vec4(min(top.rgb, bottom.rgb) * top.a + (1.0 - top.a) * bottom.rgb, 1.0);
 }
 // Multiply
 mediump vec4 blendMultiply(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     return mediump vec4(bottom.rgb * top.rgb * top.a + (1.0 - top.a) * bottom.rgb, 1.0);
 }
 // Screen
 mediump vec4 blendScreen(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     rs.r = (1.0 - ((1.0 - bottom.r) * (1.0 - top.r))) * top.a + bottom.r * (1.0 - top.a);
     rs.g = (1.0 - ((1.0 - bottom.g) * (1.0 - top.g))) * top.a + bottom.g * (1.0 - top.a);
     rs.b = (1.0 - ((1.0 - bottom.b) * (1.0 - top.b))) * top.a + bottom.b * (1.0 - top.a);
     return rs;
 }
 // SoftLight
 mediump vec4 blendSoftLight(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     
     if(overlay.r  < 0.5){
         rs.r = 2.0 * overlay.r * base.r + base.r * base.r * (1.0 - 2.0 * overlay.r);
     } else{
         rs.r = 2.0 * base.r * (1.0 - overlay.r) + sqrt(base.r) * (2.0 * overlay.r - 1.0);
     }
     
     if(overlay.g  < 0.5){
         rs.g = 2.0 * overlay.g * base.g + base.g * base.g * (1.0 - 2.0 * overlay.g);
     } else{
         rs.g = 2.0 * base.g * (1.0 - overlay.g) + sqrt(base.g) * (2.0 * overlay.g - 1.0);
     }
     
     if(overlay.b  < 0.5){
         rs.b = 2.0 * overlay.b * base.b + base.b * base.b * (1.0 - 2.0 * overlay.b);
     } else{
         rs.b = 2.0 * base.b * (1.0 - overlay.b) + sqrt(base.b) * (2.0 * overlay.b - 1.0);
     }
     rs.rgb = rs.rgb * overlay.a + base.rgb * (1.0 - overlay.a);
     return rs;
 }
 // Lighten
 mediump vec4 blendLighten(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = max(bottom, top);
     rs = rs * top.a + (1.0 - top.a) * bottom;
     rs.a = 1.0;
     return rs;
 }
 // HardLight
 mediump vec4 blendHardLight(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     if (overlay.r < 0.5) {
         rs.r = base.r * overlay.r * 2.0;
     } else {
         rs.r = 2.0 * (base.r + overlay.r - base.r * overlay.r) - 1.0;
     }
     if (overlay.g < 0.5) {
         rs.g = base.g * overlay.g * 2.0;
     } else {
         rs.g = 2.0 * (base.g + overlay.g - base.g * overlay.g) - 1.0;
     }
     if (overlay.b < 0.5) {
         rs.b = base.b * overlay.b * 2.0;
     } else {
         rs.b = 2.0 * (base.b + overlay.b - base.b * overlay.b) - 1.0;
     }
     
     rs.r = rs.r * overlay.a + (1.0 - overlay.a) * base.r;
     rs.g = rs.g * overlay.a + (1.0 - overlay.a) * base.g;
     rs.b = rs.b * overlay.a + (1.0 - overlay.a) * base.b;
     return rs;
 }
 // VividLight
 mediump vec4 blendVividLight(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     if (overlay.r < 0.5) {
         if(overlay.r == 0.0){
             rs.r = 0.0;
         } else {
             rs.r = 1.0 - (1.0 - base.r) / (2.0 * overlay.r);
         }
     } else {
         if(overlay.r == 1.0){
             rs.r = 1.0;
         } else {
             rs.r = base.r / (2.0 * (1.0 - overlay.r));
         }
     }
     if (overlay.g < 0.5) {
         if(overlay.g == 0.0){
             rs.g = 0.0;
         } else {
             rs.g = 1.0 - (1.0 - base.g) / (2.0 * overlay.g);
         }
     } else {
         if(overlay.g == 1.0){
             rs.g = 1.0;
         } else {
             rs.g = base.g / (2.0 * (1.0 - overlay.g));
         }
     }
     if (overlay.b < 0.5) {
         if(overlay.b == 0.0){
             rs.b = 0.0;
         } else {
             rs.b = 1.0 - (1.0 - base.b) / (2.0 * overlay.b);
         }
     } else {
         if(overlay.b == 1.0){
             rs.b = 1.0;
         } else {
             rs.b = base.b / (2.0 * (1.0 - overlay.b));
         }
     }
     
     rs.r = min(1.0, max(0.0, rs.r));
     rs.g = min(1.0, max(0.0, rs.g));
     rs.b = min(1.0, max(0.0, rs.b));
     
     rs.r = rs.r * overlay.a + (1.0 - overlay.a) * base.r;
     rs.g = rs.g * overlay.a + (1.0 - overlay.a) * base.g;
     rs.b = rs.b * overlay.a + (1.0 - overlay.a) * base.b;
     return rs;
 }
 // Overlay
 mediump vec4 blendOverlay(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     if(base.r < 0.5){
         rs.r = (base.r * overlay.r * 2.0) * overlay.a + (1.0 - overlay.a) * base.r;
     } else{
         rs.r = (2.0 * (base.r + overlay.r - base.r * overlay.r) - 1.0) * overlay.a + (1.0 - overlay.a) * base.r;
     }
     if(base.g < 0.5){
         rs.g = (base.g * overlay.g * 2.0) * overlay.a + (1.0 - overlay.a) * base.g;
     } else{
         rs.g = (2.0 * (base.g + overlay.g - base.g * overlay.g) - 1.0) * overlay.a + (1.0 - overlay.a) * base.g;
     }
     if(base.b < 0.5){
         rs.b = (base.b * overlay.b * 2.0) * overlay.a + (1.0 - overlay.a) * base.b;
     } else{
         rs.b = (2.0 * (base.b + overlay.b - base.b * overlay.b) - 1.0) * overlay.a + (1.0 - overlay.a) * base.b;
     }
     return rs;
 }
 // ColorDodge
 mediump vec4 blendColorDodge(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     mediump vec3 baseOverlayAlphaProduct = vec3(overlay.a * base.a);
     mediump vec3 rightHandProduct = overlay.rgb * (1.0 - base.a) + base.rgb * (1.0 - overlay.a);
     mediump vec3 firstBlendColor = baseOverlayAlphaProduct + rightHandProduct;
     mediump vec3 overlayRGB = clamp((overlay.rgb / clamp(overlay.a, 0.01, 1.0)) * step(0.0, overlay.a), 0.0, 0.99);
     mediump vec3 secondBlendColor = (base.rgb * overlay.a) / (1.0 - overlayRGB) + rightHandProduct;
     mediump vec3 colorChoice = step((overlay.rgb * base.a + base.rgb * overlay.a), baseOverlayAlphaProduct);
     mediump vec4 rs = vec4(mix(firstBlendColor, secondBlendColor, colorChoice), 1.0);
     rs.rgb = rs.rgb * overlay.a + (1.0 - overlay.a) * base.rgb;
     return rs;
 }
 // Difference
 mediump vec4 blendDifference(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = vec4(top.rgb - bottom.rgb, 1.0);
     rs.rgb = rs.rgb * top.a + (1.0 - top.a) * bottom.rgb;
     return rs;
 }
 // LinearDodge
 mediump vec4 blendLinearDodge(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = bottom + top;;
     rs.r = min(rs.r, 1.0);
     rs.g = min(rs.g, 1.0);
     rs.b = min(rs.b, 1.0);
     rs.a = 1.0;
     rs.rgb = rs.rgb * top.a + (1.0 - top.a) * bottom.rgb;
     return rs;
 }
 // LinearLight
 mediump vec4 blendLinearLight(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = bottom + 2.0 * top - 1.0;
     rs.r = max(0.0, min(rs.r, 1.0));
     rs.g = max(0.0, min(rs.g, 1.0));
     rs.b = max(0.0, min(rs.b, 1.0));
     rs.rgb = rs.rgb * top.a + (1.0 - top.a) * bottom.rgb;
     return rs;
 }
 // Color
 mediump vec4 blendColor(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     return mediump vec4(base.rgb * (1.0 - overlay.a) + setlum(overlay.rgb, luminosity(base.rgb)) * overlay.a, 1.0);
 }
 // DarkerColor
 mediump vec4 blendDarkerColor(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     mediump vec4 rs = vec4(base.rgb, 1.0);
     if(overlay.r < base.r){
         rs.r = overlay.r;
     }
     if(overlay.g < base.g){
         rs.g = overlay.g;
     }
     if(overlay.b < base.b){
         rs.b = overlay.b;
     }
     return rs;
 }
 // Exclusion
 mediump vec4 blendExclusion(const in mediump vec4 base, const in mediump vec4 overlay)
 {
     mediump vec4 rs = (base + overlay - 2.0 * base * overlay) * overlay.a + (1.0 - overlay.a) * base;
     rs.a = 1.0;
     return rs;
 }
 // ColorBurn
 mediump vec4 blendColorBurn(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 whiteColor = vec4(1.0);
     mediump vec4 rs = whiteColor - (whiteColor - bottom) / top;
     rs.rgb = rs.rgb * top.a + (1.0 - top.a) * bottom.rgb;
     rs.a = 1.0;
     return rs;
 }
 // Hue
 mediump vec4 blendHue(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     rs.xyz = rgb2hsv(bottom.rgb);
     mediump vec3 overlayHsv = rgb2hsv(top.rgb);
     rs.x = overlayHsv.x;
     rs.rgb = hsv2rgb(rs.rgb);
     rs.rgb = rs.rgb * top.a + (1.0 - top.a) * bottom.rgb;
     return rs;
 }
 // Saturation
 mediump vec4 blendSaturation(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     rs.xyz = rgb2hsv(bottom.rgb);
     mediump vec3 overlayHsv = rgb2hsv(top.rgb);
     rs.y = overlayHsv.y;
     rs.rgb = hsv2rgb(rs.rgb);
     rs.rgb = rs.rgb * top.a + (1.0 - top.a) * bottom.rgb;
     return rs;
 }
 // Luminosity
 mediump vec4 blendLuminosity(const in mediump vec4 bottom, const in mediump vec4 top)
 {
     mediump vec4 rs = vec4(1.0, 1.0, 1.0, 1.0);
     rs.xyz = rgb2hsv(bottom.rgb);
     mediump vec3 overlayHsv = rgb2hsv(top.rgb);
     rs.z = overlayHsv.z;
     rs.rgb = hsv2rgb(rs.rgb);
     rs.rgb = rs.rgb * top.a + (1.0 - top.a) * bottom.rgb;
     return rs;
 }
 // Common
 mediump vec4 blendWithBlendingMode(const in mediump vec4 bottom, const in mediump vec4 top, int mode)
 {
     if(mode == 1){
         return blendNormal(bottom, top);
     }
     if(mode == 2){
         return blendDarken(bottom, top);
     }
     if(mode == 3){
         return blendScreen(bottom, top);
     }
     if(mode == 4){
         return blendMultiply(bottom, top);
     }
     if(mode == 5){
         return blendDarkerColor(bottom, top);
     }
     if(mode == 6){
         return blendLighten(bottom, top);
     }
     if(mode == 7){
         return blendSoftLight(bottom, top);
     }
     if(mode == 8){
         return blendHardLight(bottom, top);
     }
     if(mode == 9){
         return blendVividLight(bottom, top);
     }
     if(mode == 10){
         return blendOverlay(bottom, top);
     }
     if(mode == 11){
         return blendExclusion(bottom, top);
     }
     if(mode == 12){
         return blendColorBurn(bottom, top);
     }
     if(mode == 13){
         return blendColor(bottom, top);
     }
     if(mode == 14){
         return blendColorDodge(bottom, top);
     }
     if(mode == 15){
         return blendLinearDodge(bottom, top);
     }
     if(mode == 16){
         return blendLinearLight(bottom, top);
     }
     if(mode == 17){
         return blendHue(bottom, top);
     }
     if(mode == 18){
         return blendSaturation(bottom, top);
     }
     if(mode == 19){
         return blendLuminosity(bottom, top);
     }
     if(mode == 20){
         return blendDifference(bottom, top);
     }
     if(mode == 0){
         return vec4(1.0, 1.0, 0.0, 1.0);
         
     }
     return vec4(1.0, 0.0, 0.0, 1.0);
 }
 );

- (id)initWithFragmentShaderFromString:(NSString *)fragmentShaderString
{
    /*
    kVnImageFilterFragmentShaderString = [kVnImageFilterFragmentShaderString stringByReplacingOccurrencesOfString:@";" withString:@";\n"];
    kVnImageFilterFragmentShaderString = [kVnImageFilterFragmentShaderString stringByReplacingOccurrencesOfString:@"}" withString:@"}\n"];
    kVnImageFilterFragmentShaderString = [kVnImageFilterFragmentShaderString stringByReplacingOccurrencesOfString:@"{" withString:@"{\n"];
     */
    NSString* shader = [NSString stringWithFormat:@"%@%@", kVnImageFilterFragmentShaderString, fragmentShaderString];
    //LOG(@"%@", shader);
    self = [super initWithFragmentShaderFromString:shader];
    if (self) {
        topLayerOpacityUniform = [filterProgram uniformIndex:@"topLayerOpacity"];
        blendingModeUniform = [filterProgram uniformIndex:@"blendingMode"];
        self.blendingMode = VnBlendingModeNormal;
        self.topLayerOpacity = 1.0f;
    }
    return self;
}

- (void)setTopLayerOpacity:(float)topLayerOpacity
{
    //topLayerOpacityUniform = [filterProgram uniformIndex:@"topLayerOpacity"];
    _topLayerOpacity = topLayerOpacity;
    //[self setFloat:topLayerOpacity forUniform:topLayerOpacityUniform program:filterProgram];
    [self setFloat:topLayerOpacity forUniformName:@"topLayerOpacity"];
}

- (void)setBlendingMode:(VnBlendingMode)blendingMode
{
    //blendingModeUniform = [filterProgram uniformIndex:@"blendingMode"];
    _blendingMode = blendingMode;
    //[self setInteger:blendingMode forUniform:blendingModeUniform program:filterProgram];
    //LOG(@"uniform: %d", blendingModeUniform);
    [self setInteger:blendingMode forUniformName:@"blendingMode"];
}



@end
