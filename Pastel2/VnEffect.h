//
//  VnEffect.h
//  Pastel2
//
//  Created by SSC on 2014/05/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"
#import "VnAdjustmentLayerGradientColorFill.h"
#import "VnAdjustmentLayerColorBalance.h"
#import "VnAdjustmentLayerSelectiveColor.h"
#import "VnAdjustmentLayerGradientMap.h"
#import "VnAdjustmentLayerChannelMixerFilter.h"
#import "VnAdjustmentLayerHueSaturation.h"
#import "VnAdjustmentLayerPhotoFilter.h"

#import "VnFilterLensBlur.h"
#import "VnFilterLevels.h"
#import "VnFilterBrightness.h"
#import "VnFilterTemperature.h"
#import "VnFilterToneCurve.h"
#import "VnFilterSolidColor.h"
#import "VnFilterDuplicate.h"

@interface VnEffect : NSObject

@property (nonatomic, weak) UIImage* imageToProcess;
@property (nonatomic, assign) VnEffectId effectId;
@property (nonatomic, assign) CGFloat defaultOpacity;
@property (nonatomic, assign) CGFloat faceOpacity;
@property (nonatomic, strong) VnImageFilter* startFilter;
@property (nonatomic, strong) VnImageFilter* endFilter;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) float multiplierX;
@property (nonatomic, assign) float multiplierY;
@property (nonatomic, assign) float addingX;
@property (nonatomic, assign) float addingY;
@property (nonatomic, assign) float transformX;
@property (nonatomic, assign) float transformY;

+ (UIImage*)processImage:(UIImage*)image WithStartFilter:(VnImageFilter*)startFilter EndFilter:(VnImageFilter*)endFilter;

- (void)makeFilterGroup;

@end
