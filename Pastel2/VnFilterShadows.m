//
//  VnFilterShadows.m
//  Pastel2
//
//  Created by SSC on 2014/06/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnFilterShadows.h"

NSString *const kVnFilterShadowsFragmentShaderString = SHADER_STRING
(
 precision mediump float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform mediump float shadows;
 
 void main()
 {
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;
     if(shadows > 0.0){
         rs.rgb = log(exp(4.0 * pixel.rgb * (1.0 + brightness * 1.3) / 4.0));
     }else{
         rs.rgb = log(exp(4.0 * pixel.rgb * (1.0 + brightness) / 4.0));
     }
     mediump float lum = rs.r * 0.299 + rs.g * 0.587 + rs.b * 0.114;
     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );

@implementation VnFilterShadows

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnFilterShadowsFragmentShaderString]))
    {
        return nil;
    }
    self.shadows = 0.0f;
    return self;
}

- (void)setShadows:(float)shadows
{
    [self setFloat:shadows forUniformName:@"shadows"];
}


@end
