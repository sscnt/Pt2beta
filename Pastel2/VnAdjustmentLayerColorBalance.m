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
         mediump vec3 hsv = rgb2hsv(textureColor.rgb);
         mediump float lum = hsv.z;
         hsv = rgb2hsv(newColor.rgb);
         hsv.z = lum;
         rs.rgb = hsv2rgb(hsv);
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