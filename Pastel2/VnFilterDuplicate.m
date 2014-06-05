//
//  VnFilterNormal.m
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnFilterDuplicate.h"

NSString *const kVnFilterNormalFragmentShaderString = SHADER_STRING
(
 precision lowp float;
 
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     mediump vec4 textureColor = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 rs = textureColor;
     gl_FragColor = blendWithBlendingMode(textureColor, vec4(rs.r, rs.g, rs.b, topLayerOpacity), blendingMode);
 }
 );
@implementation VnFilterDuplicate

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnFilterNormalFragmentShaderString]))
    {
		return nil;
    }    
    return self;
}

@end
