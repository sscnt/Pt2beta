//
//  VnEffectOverlayRetroSun.m
//  Pastel
//
//  Created by SSC on 2014/05/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayRetroSun.h"

@implementation VnEffectOverlayRetroSun

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.55f;
        self.faceOpacity = 0.55f;
        self.effectId = VnEffectIdOverlayRetroSun;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.00f max:s255(238.0f) minOut:s255(5.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setGreenMin:s255(8.0f) gamma:1.00f max:s255(242.0f) minOut:s255(3.0f) maxOut:s255(235.0f)];
    [levelsFilter1 setBlueMin:s255(0.0f) gamma:1.04f max:s255(248.0f) minOut:s255(0.0f) maxOut:s255(209.0f)];
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(6.0f) gamma:1.19f max:s255(253.0f) minOut:s255(3.0f) maxOut:s255(254.0f)];
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    self.endFilter = levelsFilter2;
}

@end
