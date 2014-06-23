//
//  VnAdjustmentLayerKelvin.m
//  Pastel2
//
//  Created by SSC on 2014/06/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnAdjustmentLayerKelvin.h"

NSString *const kVnKelvinFragmentShaderString = SHADER_STRING
(
 precision highp float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform mediump float kelvin;
 uniform mediump float strength;

 void main()
 {
     // Sample the input pixel
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec3 hsv = rgb2hsv(pixel.rgb);
     mediump float lum = hsv.z;
     
     mediump float r = 0.0;
     mediump float g = 0.0;
     mediump float b = 0.0;
     
     // Calc red
     if(kelvin <= 66.0){
         r = 255.0;
     }else{
         r = kelvin - 60.0;
         r = 329.698727446 * pow(r, -0.1332047592);
     }
     if(r < 0.0){
         r = 0.0;
     }
     if(r > 255.0){
         r = 255.0;
     }
     
     // Calc green
     if(kelvin <= 66.0){
         g = kelvin;
         g = 99.4708025861 * log(g) - 161.1195681661;
     }else{
         g = kelvin - 60.0;
         g = 288.1221695283 * pow(g, -0.0755148492);
     }
     if(g < 0.0){
         g = 0.0;
     }
     if(g > 255.0){
         g = 255.0;
     }
     
     
     // Calc blue
     if(kelvin >= 66.0){
         b = 255.0;
     }else{
         if(kelvin <= 19.0){
             b = 0.0;
         }else{
             b = kelvin - 10.0;
             b = 138.5177312231 * log(b) - 305.0447927307;
         }
     }
     if(b < 0.0){
         b = 0.0;
     }
     if(b > 255.0){
         b = 255.0;
     }
     
     mediump vec4 rs;
     
     rs.r = (1.0 - strength) * pixel.r + r * 0.00392156862 * strength;
     rs.g = (1.0 - strength) * pixel.g + g * 0.00392156862 * strength;
     rs.b = (1.0 - strength) * pixel.b + b * 0.00392156862 * strength;

     hsv = rgb2hsv(rs.rgb);
     hsv.z = lum;
     rs.rgb = hsv2rgb(hsv);
     
     
     // Save the result
     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );


@implementation VnAdjustmentLayerKelvin

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnKelvinFragmentShaderString]))
    {
        return nil;
    }
    
    self.kelvin = 0;
    self.strength = 100.0f;
    return self;
}

- (void)setKelvin:(float)kelvin
{
    if(kelvin < 1000.0){
        kelvin = 1000.0f;
    }
    if(kelvin > 40000.0f){
        kelvin = 40000.0f;
    }
    kelvin /= 100.0f;
    [self setFloat:kelvin forUniformName:@"kelvin"];
}

- (void)setStrength:(float)strength
{
    if(strength > 100.0f){
        strength = 100.0f;
    }
    if(strength < 0.0f){
        strength = 0.0f;
    }
    strength /= 100.0f;
    [self setFloat:strength forUniformName:@"strength"];
}

@end
