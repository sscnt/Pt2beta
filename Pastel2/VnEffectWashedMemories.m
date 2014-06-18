//
//  VnEffectWashedMemories.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectWashedMemories.h"

@implementation VnEffectWashedMemories

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdThorn;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation1 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation1.hue = 0.0f;
    hueSaturation1.saturation = -100;
    hueSaturation1.lightness = 12;
    hueSaturation1.colorize = NO;
    hueSaturation1.blendingMode = VnBlendingModeSoftLight;
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(42.0f) gamma:0.56 max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter1.blendingMode = VnBlendingModeSoftLight;
    levelsFilter1.topLayerOpacity = 0.16f;
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.27f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter2.blendingMode = VnBlendingModeOverlay;
    levelsFilter2.topLayerOpacity = 0.34f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(0.0f) gamma:1.27f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    levelsFilter3.blendingMode = VnBlendingModeScreen;
    levelsFilter3.topLayerOpacity = 0.60f;
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0 alpha:1.0f];
    solidColor1.topLayerOpacity = 0.25f;
    solidColor1.blendingMode = VnBlendingModeExclusion;
    
    // Hue / Saturation
    VnAdjustmentLayerHueSaturation* hueSaturation2 = [[VnAdjustmentLayerHueSaturation alloc] init];
    hueSaturation2.hue = 0.0f;
    hueSaturation2.saturation = 20;
    hueSaturation2.lightness = 0;
    hueSaturation2.colorize = NO;
    
    // Levels
    VnFilterLevels* levelsFilter4 = [[VnFilterLevels alloc] init];
    [levelsFilter4 setMin:s255(0.0f) gamma:0.53f max:s255(255.0f) minOut:s255(50.0f) maxOut:s255(255.0f)];
    levelsFilter4.blendingMode = VnBlendingModeSoftLight;
    levelsFilter4.topLayerOpacity = 0.12f;
    
    self.startFilter = hueSaturation1;
    [hueSaturation1 addTarget:levelsFilter1];
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:levelsFilter3];
    [levelsFilter3 addTarget:solidColor1];
    [solidColor1 addTarget:hueSaturation2];
    [hueSaturation2 addTarget:levelsFilter4];
    self.endFilter = levelsFilter4;

}

@end
