//
//  VnFilterPassThrough.m
//  Pastel2
//
//  Created by SSC on 2014/06/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnFilterPassThrough.h"

NSString *const kVnFilterPassThroughFragmentShaderString = SHADER_STRING
(
 precision lowp float;
 
 varying highp vec2 textureCoordinate;
 uniform sampler2D inputImageTexture;
 
 void main()
 {
     gl_FragColor = texture2D(inputImageTexture, textureCoordinate);
 }
 );

@implementation VnFilterPassThrough

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kGPUImagePassthroughFragmentShaderString]))
    {
		return nil;
    }
    return self;
}

@end
