//
//  VnEffectVintageFilm.m
//  Pastel2
//
//  Created by SSC on 2014/06/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVintageFilm.h"

@implementation VnEffectVintageFilm

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVintageFilm;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"vf1"];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation.hue = 25.0f;
    hueSaturation.saturation = 25.0f;
    hueSaturation.lightness = 0.0f;
    hueSaturation.colorize = YES;
    hueSaturation.topLayerOpacity = 0.50f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:236.0f/255.0f green:0.0f/255.0f blue:140.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.10f;
    solidColor1.blendingMode = VnBlendingModeScreen;
   
    self.startFilter = curveFilter;
    [curveFilter addTarget:hueSaturation];
    [hueSaturation addTarget:solidColor1];
    self.endFilter = solidColor1;
}

@end
