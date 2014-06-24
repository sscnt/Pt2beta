//
//  VnFilterContrast.m
//  Pastel2
//
//  Created by SSC on 2014/06/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnFilterContrast.h"

NSString *const kVnFilterContrastFragmentShaderString = SHADER_STRING
(
 precision mediump float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform mediump float contrast;
 
 void main()
 {
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;
     rs.rgb = (pixel.rgb - 0.5) * (1.0 + contrast) + 0.5;
     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );

@implementation VnFilterContrast

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnFilterContrastFragmentShaderString]))
    {
        return nil;
    }
    
    self.contrast = 0.0f;
    return self;
}

- (void)setContrast:(CGFloat)contrast
{
    [self setFloat:contrast forUniformName:@"contrast"];
}

@end
