//
//  VnFilterBrightness.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnFilterBrightness.h"

NSString *const kVnFilterBrightnessFragmentShaderString = SHADER_STRING
(
 precision mediump float;
 varying vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 uniform mediump float brightness;
 
 void main()
 {
     mediump vec4 pixel   = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs;
     if(brightness > 0.0){
         rs.rgb = log(exp(4.0 * pixel.rgb * (1.0 + brightness * 1.3) / 4.0));
     }else{
         rs.rgb = log(exp(4.0 * pixel.rgb * (1.0 + brightness) / 4.0));
     }
     gl_FragColor = blendWithBlendingMode(pixel, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );

@implementation VnFilterBrightness

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnFilterBrightnessFragmentShaderString]))
    {
        return nil;
    }

    self.brightness = 0.0f;
    return self;
}

- (void)setBrightness:(CGFloat)brightness
{
    [self setFloat:brightness forUniformName:@"brightness"];
}

@end
