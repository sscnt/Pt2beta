//
//  VnImageNormalBlendFilter.m
//  Pastel2
//
//  Created by SSC on 2014/06/02.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageNormalBlendFilter.h"

NSString *const kVnImageNormalBlendFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 c2 = texture2D(inputImageTexture, textureCoordinate);
	 mediump vec4 c1 = texture2D(inputImageTexture2, textureCoordinate2);
     
     gl_FragColor = blendWithBlendingMode(c2, vec4(c1.rgb, topLayerOpacity), blendingMode);
 }
 );

@implementation VnImageNormalBlendFilter

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnImageNormalBlendFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
