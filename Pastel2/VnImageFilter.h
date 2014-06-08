//
//  VnImageFilter.h
//  Pastel2
//
//  Created by SSC on 2014/05/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "GPUImageFilter.h"

extern NSString* const kVnImageFilterFragmentShaderString;

@interface VnImageFilter : GPUImageFilter
{
    GLint topLayerOpacityUniform;
    GLint blendingModeUniform;
}

@property (nonatomic, assign) float topLayerOpacity;
@property (nonatomic, assign) VnBlendingMode blendingMode;
@property (nonatomic, assign) int tag;

@end
