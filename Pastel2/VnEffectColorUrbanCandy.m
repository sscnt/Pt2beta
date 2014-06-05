//
//  VnEffectColorUrbanCandy.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorUrbanCandy.h"

@implementation VnEffectColorUrbanCandy

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdColorUrbanCandy;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(6.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(3.0f) gamma:0.97f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(253.0f)];
    [levelsFilter1 setBlueMin:s255(16.0f) gamma:0.80f max:s255(253.0f) minOut:s255(82.0f) maxOut:s255(245.0f)];
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(15.0f) gamma:1.14f max:s255(248.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    
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
    highlights.one = s255(0.0f);
    highlights.two = s255(0.0f);
    highlights.three = s255(-10.0f);
    [colorBalance setHighlights:highlights];
    colorBalance.preserveLuminosity = YES;
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    [levelsFilter2 addTarget:colorBalance];
    self.endFilter = colorBalance;
}

@end
