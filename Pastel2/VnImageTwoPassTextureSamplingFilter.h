//
//  VnImageTwoPassTextureSamplingFilter.h
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageTwoPassFilter.h"

@interface VnImageTwoPassTextureSamplingFilter : VnImageTwoPassFilter
{
    GLint verticalPassTexelWidthOffsetUniform, verticalPassTexelHeightOffsetUniform, horizontalPassTexelWidthOffsetUniform, horizontalPassTexelHeightOffsetUniform;
    GLfloat verticalPassTexelWidthOffset, verticalPassTexelHeightOffset, horizontalPassTexelWidthOffset, horizontalPassTexelHeightOffset;
    CGFloat _verticalTexelSpacing, _horizontalTexelSpacing;
}

// This sets the spacing between texels (in pixels) when sampling for the first. By default, this is 1.0
@property(readwrite, nonatomic) CGFloat verticalTexelSpacing, horizontalTexelSpacing;


@end
