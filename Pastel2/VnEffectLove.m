//
//  VnEffectLove.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectLove.h"

@implementation VnEffectLove

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdLove;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:1.04 max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.blendingMode = VnBlendingModeScreen;
    levelsFilter1.topLayerOpacity = 0.20f;
    
    // Contrast
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(67.0f) gamma:1.70 max:s255(215.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.topLayerOpacity = 0.50f;
    
    // Fill Layer
    VnAdjustmentLayerGradientColorFill* gradientColor2 = [[VnAdjustmentLayerGradientColorFill alloc] initWithEffectObj:self];
    [gradientColor2 setStyle:GradientStyleRadial];
    [gradientColor2 setAngleDegree:0.0f];
    [gradientColor2 setScalePercent:150];
    [gradientColor2 setOffsetX:0.0f Y:0.0f];
    [gradientColor2 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:0.0f Location:0 Midpoint:50];
    [gradientColor2 addColorRed:8.0f Green:8.0f Blue:8.0f Opacity:100.0f Location:4096 Midpoint:50];
    gradientColor2.blendingMode = VnBlendingModeOverlay;
    gradientColor2.topLayerOpacity = 0.30f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setRedMin:s255(0.0f) gamma:1.0 max:s255(239.0f)];
    [levelsFilter3 setGreenMin:0.0f gamma:0.97f max:1.0f];
    [levelsFilter3 setBlueMin:0.0f gamma:1.11 max:1.0f];
    levelsFilter3.topLayerOpacity = 0.60f;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation2 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation2.hue = 0.0f;
    hueSaturation2.saturation = 10;
    hueSaturation2.lightness = 0;
    hueSaturation2.colorize = NO;
    
    // Gradient Map
    VnAdjustmentLayerGradientMap* gradientMap1 = [[VnAdjustmentLayerGradientMap alloc] init];
    [gradientMap1 addColorRed:115.0f Green:108.0f Blue:91.0 Opacity:100.0f Location:0 Midpoint:50];
    [gradientMap1 addColorRed:232.0 Green:226.0 Blue:207 Opacity:100.0f Location:4096 Midpoint:50];
    gradientMap1.topLayerOpacity = 0.15f;
    gradientMap1.blendingMode = VnBlendingModeColor;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:252.0f/255.0f green:223.0f/255.0f blue:182.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.20f;
    solidColor1.blendingMode = VnBlendingModeMultiply;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:gradientColor2];
    [gradientColor2 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:hueSaturation2];
    [hueSaturation2 addTarget:gradientMap1];
    [gradientMap1 addTarget:solidColor1];
    self.endFilter = solidColor1;
    
    
    

}

@end
