//
//  VnEffectOverlayCandyHaze.m
//  Pastel
//
//  Created by SSC on 2014/05/10.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayCandyHaze.h"

@implementation VnEffectOverlayCandyHaze

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.40f;
        self.faceOpacity = 0.40f;
        self.effectId = VnEffectIdOverlayCandyHaze;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.00f max:s255(244.0f) minOut:s255(6.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(8.0f) gamma:1.00f max:s255(248.0f) minOut:s255(0.0f) maxOut:s255(240.0f)];
    [levelsFilter1 setBlueMin:s255(9.0f) gamma:1.02f max:s255(253.0f) minOut:s255(9.0f) maxOut:s255(210.0f)];
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.10f max:s255(255.0f) minOut:s255(85.0f) maxOut:s255(247.0f)];
    
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    self.endFilter = levelsFilter2;
}

@end
