//
//  VnImageShadowsBlendFilter.m
//  Pastel2
//
//  Created by SSC on 2014/06/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageMaskBlendFilter.h"

NSString *const kVnImageMaskBlendFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 c2 = texture2D(inputImageTexture, textureCoordinate);
	 mediump vec4 c1 = texture2D(inputImageTexture2, textureCoordinate2);
     
     gl_FragColor = vec4(c2.rgb, c1.r);
 }
 );

@implementation VnImageMaskBlendFilter

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnImageMaskBlendFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
