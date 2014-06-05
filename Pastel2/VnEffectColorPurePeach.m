//
//  VnEffectColorPurePeach.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorPurePeach.h"

@implementation VnEffectColorPurePeach

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdColorPurePeach;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(5.0f) gamma:1.00f max:s255(255.0f) minOut:s255(30.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(0.0f) gamma:0.90f max:s255(255.0f) minOut:s255(10.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setBlueMin:s255(0.0f) gamma:0.90f max:s255(255.0f) minOut:s255(30.0f) maxOut:s255(230.0f)];
    
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(10.0f) gamma:1.00f max:s255(255.0f) minOut:s255(25.0f) maxOut:s255(250.0f)];
    
    
    // Fill Layer
    VnFilterSolidColor* solidColor = [[VnFilterSolidColor alloc] init];
    [solidColor setColorRed:s255(255.0f) green:s255(205.0f) blue:s255(183.0f) alpha:1.0f];
    solidColor.topLayerOpacity = 0.53f * 0.35f;
    solidColor.blendingMode = VnBlendingModeSoftLight;
    
    
    // Color Balance
    VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(15.0f);
    midtones.two = s255(-1.0f);
    midtones.three = s255(-16.0f);
    [colorBalance setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(11.0f);
    highlights.two = s255(-1.0f);
    highlights.three = s255(-10.0f);
    [colorBalance setHighlights:highlights];
    colorBalance.preserveLuminosity = YES;
    colorBalance.topLayerOpacity = 0.04f;
    
    // Levels
    VnFilterLevels* levelsFilter3 = [[VnFilterLevels alloc] init];
    [levelsFilter3 setMin:s255(75.0f) gamma:1.40f max:s255(254.0f) minOut:s255(0.0f) maxOut:s255(209.0f)];
    levelsFilter3.topLayerOpacity = 0.35f;
    levelsFilter3.blendingMode = VnBlendingModeSoftLight;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:solidColor];
    [solidColor addTarget:colorBalance];
    [colorBalance addTarget:levelsFilter3];
    self.endFilter = levelsFilter3;
}

@end
