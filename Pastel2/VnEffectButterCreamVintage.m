//
//  VnEffectButterCreamVintage.m
//  Pastel2
//
//  Created by SSC on 2014/06/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectButterCreamVintage.h"

@implementation VnEffectButterCreamVintage

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdButterCreamVintage;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"ab001"];
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation2 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation2.hue = 0.0f;
    hueSaturation2.saturation = -15;
    hueSaturation2.lightness = 10.0f;
    hueSaturation2.colorize = NO;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:28.0f/255.0f green:34.0f/255.0f blue:74.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.35f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Fill Layer
    VnFilterSolidColor* solidColor2 = [[VnFilterSolidColor alloc] init];
    [solidColor2 setColorRed:91.0f/255.0f green:39.0f/255.0f blue:84.0f/255.0 alpha:1.0f];
    solidColor2.topLayerOpacity = 0.27f;
    solidColor2.blendingMode = VnBlendingModeScreen;
    
    // Fill Layer
    VnFilterSolidColor* solidColor3 = [[VnFilterSolidColor alloc] init];
    [solidColor3 setColorRed:111.0f/255.0f green:73.0f/255.0f blue:6.0f/255.0 alpha:1.0f];
    solidColor3.topLayerOpacity = 0.25f;
    solidColor3.blendingMode = VnBlendingModeColor;
    
    // Fill Layer
    VnFilterSolidColor* solidColor4 = [[VnFilterSolidColor alloc] init];
    [solidColor4 setColorRed:151.0f/255.0f green:208.0f/255.0f blue:248.0f/255.0 alpha:1.0f];
    solidColor4.topLayerOpacity = 0.20f;
    solidColor4.blendingMode = VnBlendingModeColorBurn;
    
    // Fill Layer
    VnFilterSolidColor* solidColor5 = [[VnFilterSolidColor alloc] init];
    [solidColor5 setColorRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0 alpha:1.0f];
    solidColor5.topLayerOpacity = 0.20f;
    solidColor5.blendingMode = VnBlendingModeSoftLight;
    
    // Contrast
    VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
    VnImageNormalBlendFilter* inputMerge = [[VnImageNormalBlendFilter alloc] init];
    inputMerge.topLayerOpacity = 0.10f;
    inputMerge.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = inputFilter;
    [inputFilter addTarget:curveFilter1];
    [inputFilter addTarget:inputMerge atTextureLocation:1];
    [curveFilter1 addTarget:hueSaturation2];
    [hueSaturation2 addTarget:solidColor1];
    [solidColor1 addTarget:solidColor2];
    [solidColor2 addTarget:solidColor3];
    [solidColor3 addTarget:solidColor4];
    [solidColor4 addTarget:solidColor5];
    [solidColor5 addTarget:inputMerge atTextureLocation:0];
    self.endFilter = inputMerge;
}

@end
