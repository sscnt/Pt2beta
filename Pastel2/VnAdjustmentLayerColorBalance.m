//
//  GPUImageColorBalanceFilter.m
//  Gravy_1.0
//
//  Created by SSC on 2013/11/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//
#import "VnAdjustmentLayerColorBalance.h"

NSString *const kGPUImageColorBalanceFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform mediump vec3 shadowsShift;
 uniform mediump vec3 midtonesShift;
 uniform mediump vec3 highlightsShift;
 uniform int preserveLuminosity;
 
 /* Color space conversion functions by:
  ** http://mouaif.wordpress.com/2009/01/05/photoshop-math-with-glsl-shaders/
  ** Photoshop & misc math
  ** Blending modes, RGB/HSL/Contrast/Desaturate, levels control
  **
  ** Romain Dura | Romz
  ** Blog: http://blog.mouaif.org
  ** Post: http://blog.mouaif.org/?p=94
  */
 
 mediump vec3 RGBToHSL(mediump vec3 color)
 {
     mediump vec3 hsl; // init to 0 to avoid warnings ? (and reverse if + remove first part)
     
     mediump float fmin = min(min(color.r, color.g), color.b);    //Min. value of RGB
     mediump float fmax = max(max(color.r, color.g), color.b);    //Max. value of RGB
     mediump float delta = fmax - fmin;             //Delta RGB value
     
     hsl.z = (fmax + fmin) / 2.0; // Luminance
     
     if (delta == 0.0)		//This is a gray, no chroma...
     {
         hsl.x = 0.0;	// Hue
         hsl.y = 0.0;	// Saturation
     }
     else                                    //Chromatic data...
     {
         if (hsl.z < 0.5)
             hsl.y = delta / (fmax + fmin); // Saturation
         else
             hsl.y = delta / (2.0 - fmax - fmin); // Saturation
         
         mediump float deltaR = (((fmax - color.r) / 6.0) + (delta / 2.0)) / delta;
         mediump float deltaG = (((fmax - color.g) / 6.0) + (delta / 2.0)) / delta;
         mediump float deltaB = (((fmax - color.b) / 6.0) + (delta / 2.0)) / delta;
         
         if (color.r == fmax )
             hsl.x = deltaB - deltaG; // Hue
         else if (color.g == fmax)
             hsl.x = (1.0 / 3.0) + deltaR - deltaB; // Hue
         else if (color.b == fmax)
             hsl.x = (2.0 / 3.0) + deltaG - deltaR; // Hue
         
         if (hsl.x < 0.0)
             hsl.x += 1.0; // Hue
         else if (hsl.x > 1.0)
             hsl.x -= 1.0; // Hue
     }
     
     return hsl;
 }
 
 mediump float HueToRGB(mediump float f1, mediump float f2, mediump float hue)
 {
     if (hue < 0.0)
         hue += 1.0;
     else if (hue > 1.0)
         hue -= 1.0;
     mediump float res;
     if ((6.0 * hue) < 1.0)
         res = f1 + (f2 - f1) * 6.0 * hue;
     else if ((2.0 * hue) < 1.0)
         res = f2;
     else if ((3.0 * hue) < 2.0)
         res = f1 + (f2 - f1) * ((2.0 / 3.0) - hue) * 6.0;
     else
         res = f1;
     return res;
 }
 
 mediump vec3 HSLToRGB(mediump vec3 hsl)
 {
     mediump vec3 rgb;
     
     if (hsl.y == 0.0)
         rgb = vec3(hsl.z); // Luminance
     else
     {
         mediump float f2;
         
         if (hsl.z < 0.5)
             f2 = hsl.z * (1.0 + hsl.y);
         else
             f2 = (hsl.z + hsl.y) - (hsl.y * hsl.z);
         
         mediump float f1 = 2.0 * hsl.z - f2;
         
         rgb.r = HueToRGB(f1, f2, hsl.x + (1.0/3.0));
         rgb.g = HueToRGB(f1, f2, hsl.x);
         rgb.b= HueToRGB(f1, f2, hsl.x - (1.0/3.0));
     }
     
     return rgb;
 }
 
 mediump float RGBToL(mediump vec3 color)
 {
     mediump float fmin = min(min(color.r, color.g), color.b);    //Min. value of RGB
     mediump float fmax = max(max(color.r, color.g), color.b);    //Max. value of RGB
     
     return (fmax + fmin) / 2.0; // Luminance
 }
 
 void main()
 {
     mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;
     
     // Alternative way:
     //mediump vec3 lightness = RGBToL(textureColor.rgb);
     mediump vec3 lightness = textureColor.rgb;
     
     const mediump float a = 0.25;
     const mediump float b = 0.333;
     const mediump float scale = 0.7;
     
     mediump vec3 shadows = shadowsShift * (clamp((lightness - b) / -a + 0.5, 0.0, 1.0) * scale);
     mediump vec3 midtones = midtonesShift * (clamp((lightness - b) / a + 0.5, 0.0, 1.0) *
                                           clamp((lightness + b - 1.0) / -a + 0.5, 0.0, 1.0) * scale);
     mediump vec3 highlights = highlightsShift * (clamp((lightness + b - 1.0) / a + 0.5, 0.0, 1.0) * scale);
     
     mediump vec3 newColor = textureColor.rgb + shadows + midtones + highlights;
     newColor = clamp(newColor, 0.0, 1.0);
     
     if (preserveLuminosity != 0) {
         mediump vec3 newHSL = RGBToHSL(newColor);
         mediump float oldLum = RGBToL(textureColor.rgb);
         rs.rgb = HSLToRGB(vec3(newHSL.x, newHSL.y, oldLum));
     } else {
         rs = vec4(newColor.rgb, textureColor.w);
     }
     gl_FragColor = blendWithBlendingMode(textureColor, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );


@implementation VnAdjustmentLayerColorBalance

@synthesize shadows = _shadows;
@synthesize midtones = _midtones;
@synthesize highlights = _highlights;
@synthesize preserveLuminosity = _preserveLuminosity;

#pragma mark -
#pragma mark Initialization

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImageColorBalanceFragmentShaderString]))
    {
		return nil;
    }
    
    shadowsUniform = [filterProgram uniformIndex:@"shadowsShift"];
    midtonesUniform = [filterProgram uniformIndex:@"midtonesShift"];
    highlightsUniform = [filterProgram uniformIndex:@"highlightsShift"];
    preserveLuminosityUniform = [filterProgram uniformIndex:@"preserveLuminosity"];
    self.shadows = (GPUVector3){ 0.0, 0.0, 0.0 };
    self.midtones = (GPUVector3){ 0.0, 0.0, 0.0 };
    self.highlights = (GPUVector3){ 0.0, 0.0, 0.0 };
    self.preserveLuminosity = YES;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setShadows:(GPUVector3)newValue
{
    _shadows = newValue;
    [self setVec3:newValue forUniform:shadowsUniform program:filterProgram];
}

- (void)setMidtones:(GPUVector3)newValue
{
    _midtones = newValue;
    [self setVec3:newValue forUniform:midtonesUniform program:filterProgram];
}

- (void)setHighlights:(GPUVector3)newValue
{
    _highlights = newValue;
    [self setVec3:newValue forUniform:highlightsUniform program:filterProgram];
}

- (void)setPreserveLuminosity:(BOOL)newValue
{
    _preserveLuminosity = newValue;
    [self setInteger:newValue forUniform:preserveLuminosityUniform program:filterProgram];
}

@end