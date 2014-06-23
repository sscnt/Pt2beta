//
//  GPUImageHueSaturationFilter.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/17.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "VnAdjustmentLayerHueSaturation.h"

@implementation VnAdjustmentLayerHueSaturation

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kGPUImageHueSaturationFilterFragmentShaderString = SHADER_STRING
(
 precision highp float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 
 uniform int colorize;
 uniform int vibrance;
 uniform mediump float hue;
 uniform mediump float saturation;
 uniform mediump float lightness;

 
 vec3 blend2(vec3 left, vec3 right, float pos){
     return vec3(left.r * (1.0 - pos) + right.r * pos,
                 left.g * (1.0 - pos) + right.g * pos,
                 left.b * (1.0 - pos) + right.b * pos);
 }
 
 vec3 blend3(vec3 left, vec3 main, vec3 right, float pos){
     if(pos < 0.0){
         return blend2(left, main, pos + 1.0);
     }
     if(pos > 0.0){
         return blend2(main, right, pos);
     }
     return main;
 }
 
 float round(float a){
     float b = floor(a);
     b = floor((a - b) * 10.0);
     if(int(b) < 5){
         return floor(a);
     }
     return ceil(a);
 }
 
 
 void main()
 {
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;

     if(colorize == 1){
         mediump vec3 hsv = rgb2hsv(pixel.rgb);
         mediump vec3 hueRGB = hsv2rgb(vec3(hue, 1.0, 1.0));
         mediump vec3 color = blend2(vec3(0.5, 0.5, 0.5), hueRGB, saturation);
         if(lightness <= -1.0){
             rs = vec4(0.0);
         }else if(lightness >= 1.0){
             rs = vec4(1.0);
         }else if(lightness >= 0.0){
             rs.rgb = blend3(vec3(0.0), color, vec3(1.0), 2.0 * (1.0 - lightness) * (hsv.z - 1.0) + 1.0);
         }else{
             rs.rgb = blend3(vec3(0.0), color, vec3(1.0), 2.0 * (1.0 + lightness) * (hsv.z) - 1.0);
         }
     } else {
         mediump vec3 hsl = rgb2hsv(pixel.rgb);
         hsl.x += hue;
         if(saturation > 0.0){
             mediump vec2 p = vec2(hsl.y - 0.5, hsl.z);
             mediump float weight = sqrt((p.x - 0.5) * (p.x - 0.5) + (p.y - 0.5) * (p.y - 0.5));
             weight = 1.0 - weight * 2.0;
             weight = (1.0 / pow((hsl.y + 0.3), 2.0)) / 10.0 - 0.1;
             weight = min(max(weight, 0.0), 1.0);
             weight = 1.0 - hsl.z - weight;
             weight = min(max(weight, 0.0), 1.0);
             hsl.y += saturation * weight;
             //rs.rgb = vec3(weight);
         }else{
             hsl.y *= 1.0 + saturation;
         }
         rs.rgb = hsv2rgb(hsl);
         if(vibrance == 1 && saturation > 0.0){

         }else{
             
         }
     }
     
     if(lightness > 0.0){
         rs.rgb = rs.rgb * (1.0 - lightness) + lightness;
     }else{
         rs.rgb = rs.rgb * (1.0 + lightness);
     }

     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );

#else
#endif


- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageHueSaturationFilterFragmentShaderString]))
    {
        return nil;
    }

    hueUniform = [filterProgram uniformIndex:@"hue"];
    self.hue = 0.0f;
    
    saturationUniform = [filterProgram uniformIndex:@"saturation"];
    self.saturation = 0.0f;
    
    lightnessUniform = [filterProgram uniformIndex:@"lightness"];
    self.lightness = 0.0f;
    
    colorizeUniform = [filterProgram uniformIndex:@"colorize"];
    self.colorize = NO;
    
    vibranceUniform = [filterProgram uniformIndex:@"vibrance"];
    self.vibrance = NO;
    
    return self;
}

- (void)setColorize:(BOOL)colorize
{
    _colorize = colorize;
    [self setInteger:_colorize forUniform:colorizeUniform program:filterProgram];
}

- (void)setVibrance:(BOOL)vibrance
{
    _vibrance = vibrance;
    [self setInteger:_vibrance forUniform:vibranceUniform program:filterProgram];
}

- (void)setSaturation:(float)saturation
{
    _saturation = saturation / 100.0f;
    _saturation = MAX(-1.0f, MIN(1.0f, _saturation));
    [self setFloat:_saturation forUniform:saturationUniform program:filterProgram];
}

- (void)setLightness:(float)lightness
{
    _lightness = lightness / 100.0f;
    _lightness = MAX(-1.0f, MIN(1.0f, _lightness));
    [self setFloat:_lightness forUniform:lightnessUniform program:filterProgram];
}

- (void)setHue:(float)hue
{
    _hue = hue / 360.0f;
    _hue = MAX(0.0f, MIN(1.0f, _hue));
    [self setFloat:_hue forUniform:hueUniform program:filterProgram];
}

@end
