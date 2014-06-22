//
//  VnFilterLocalContrast.h
//  Pastel2
//
//  Created by SSC on 2014/06/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnImageTwoPassTextureSamplingFilter.h"

@interface VnFilterLocalContrast : VnImageTwoPassTextureSamplingFilter
{
    BOOL shouldResizeBlurRadiusWithImageSize;
    CGFloat _blurRadiusInPixels;
}

/** A multiplier for the spacing between texels, ranging from 0.0 on up, with a default of 1.0. Adjusting this may slightly increase the blur strength, but will introduce artifacts in the result.
 */
@property (readwrite, nonatomic) CGFloat texelSpacingMultiplier;

/** A radius in pixels to use for the blur, with a default of 2.0. This adjusts the sigma variable in the Gaussian distribution function.
 */
@property (readwrite, nonatomic) CGFloat blurRadiusInPixels;

/** Setting these properties will allow the blur radius to scale with the size of the image
 */
@property (readwrite, nonatomic) CGFloat blurRadiusAsFractionOfImageWidth;
@property (readwrite, nonatomic) CGFloat blurRadiusAsFractionOfImageHeight;

/// The number of times to sequentially blur the incoming image. The more passes, the slower the filter.
@property(readwrite, nonatomic) NSUInteger blurPasses;
@property(readwrite, nonatomic) float contrast;
@property(readwrite, nonatomic) float opacity;

+ (NSString *)vertexShaderForStandardBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma;
+ (NSString *)fragmentShaderForStandardBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma;
+ (NSString *)vertexShaderForOptimizedBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma;
+ (NSString *)fragmentShaderForOptimizedBlurOfRadius:(NSUInteger)blurRadius sigma:(CGFloat)sigma contrast:(float)contrast opacity:(float)opacity;

- (void)switchToVertexShader:(NSString *)newVertexShader fragmentShader:(NSString *)newFragmentShader;

- (void)createShader;


@end
