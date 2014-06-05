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

@property (nonatomic, assign) float topLayerOpacity;
@property (nonatomic, assign) VnBlendingMode blendingMode;

@end
