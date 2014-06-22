//
//  VnFilterGammaCorection.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnFilterGammaCorection.h"

NSString *const kVnFilterGammaCorectionFragmentShaderString = SHADER_STRING
(
 precision mediump float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform mediump float gamma;
 
 void main()
 {
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;
          
     // gamma
     rs.r = pow(pixel.r, 1.0 / gamma);
     rs.g = pow(pixel.g, 1.0 / gamma);
     rs.b = pow(pixel.b, 1.0 / gamma);
     
     //rs.r = pow((pixel.r * (pow(2.0, exposure))) + (offset * (1.0 - pixel.r) * 1.2), 1.0 / gamma);
     //rs.g = pow((pixel.g * (pow(2.0, exposure))) + (offset * (1.0 - pixel.g) * 1.2), 1.0 / gamma);
     //rs.b = pow((pixel.b * (pow(2.0, exposure))) + (offset * (1.0 - pixel.b) * 1.2), 1.0 / gamma);
     
     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );

@implementation VnFilterGammaCorection

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnFilterGammaCorectionFragmentShaderString]))
    {
        return nil;
    }
    self.gamma = 1.0f;
    return self;
}

- (void)setGamma:(float)gamma
{
    _gamma = gamma;
    [self setFloat:gamma forUniformName:@"gamma"];
}


@end
