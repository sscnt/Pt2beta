//
//  VnEffectColorSerenity.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorSerenity.h"

@implementation VnEffectColorSerenity

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.65f;
        self.faceOpacity = 0.65f;
        self.effectId = VnEffectIdColorSerenity;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.10f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(0.0f) gamma:1.0f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setBlueMin:s255(8.0f) gamma:1.21f max:s255(253.0f) minOut:s255(54.0f) maxOut:s255(246.0f)];
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(18.0f) gamma:1.02f max:s255(255.0f) minOut:s255(22.0f) maxOut:s255(255.0f)];
    
    
    // Color Balance
    
    VnAdjustmentLayerColorBalance* colorBalance = [[VnAdjustmentLayerColorBalance alloc] init];
    GPUVector3 shadows;
    shadows.one = s255(0.0f);
    shadows.two = s255(0.0f);
    shadows.three = s255(0.0f);
    [colorBalance setShadows:shadows];
    GPUVector3 midtones;
    midtones.one = s255(0.0f);
    midtones.two = s255(0.0f);
    midtones.three = s255(0.0f);
    [colorBalance setMidtones:midtones];
    GPUVector3 highlights;
    highlights.one = s255(5.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(-10.0f);
    [colorBalance setHighlights:highlights];
    colorBalance.preserveLuminosity = YES;
    colorBalance.topLayerOpacity = 0.50f;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:colorBalance];
    self.endFilter = colorBalance;
    
    
}

@end
