//
//  VnFilterContrast.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnFilterExposure.h"

NSString *const kVnFilterExposureFragmentShaderString = SHADER_STRING
(
 precision mediump float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform mediump float exposure;
 uniform mediump float offset;
 uniform mediump float gamma;
 
 void main()
 {
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;
     
     // exposure
     rs.r = pixel.r * pow(2.0, exposure);
     rs.g = pixel.g * pow(2.0, exposure);
     rs.b = pixel.b * pow(2.0, exposure);
     
     // offset
     rs.r += sqrt(offset) * (1.0 - rs.r);
     rs.g += sqrt(offset) * (1.0 - rs.g);
     rs.b += sqrt(offset) * (1.0 - rs.b);
     
     // gamma
     rs.r = pow(rs.r, 1.0 / gamma);
     rs.g = pow(rs.g, 1.0 / gamma);
     rs.b = pow(rs.b, 1.0 / gamma);
              
     //rs.r = pow((pixel.r * (pow(2.0, exposure))) + (offset * (1.0 - pixel.r) * 1.2), 1.0 / gamma);
     //rs.g = pow((pixel.g * (pow(2.0, exposure))) + (offset * (1.0 - pixel.g) * 1.2), 1.0 / gamma);
     //rs.b = pow((pixel.b * (pow(2.0, exposure))) + (offset * (1.0 - pixel.b) * 1.2), 1.0 / gamma);
     
     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );

@implementation VnFilterExposure

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnFilterExposureFragmentShaderString]))
    {
        return nil;
    }
    self.exposure = 0.0f;
    self.offset = 0.0f;
    self.gamma = 1.0f;
    return self;
}

- (void)setExposure:(float)exposure
{
    [self setFloat:exposure forUniformName:@"exposure"];
}

- (void)setOffset:(float)offset
{
    [self setFloat:offset forUniformName:@"offset"];
}

- (void)setGamma:(float)gamma
{
    [self setFloat:gamma forUniformName:@"gamma"];
}

@end
