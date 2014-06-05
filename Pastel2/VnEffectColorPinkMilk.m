//
//  VnEffectColorPinkMilk.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorPinkMilk.h"

@implementation VnEffectColorPinkMilk

- (id)init
{
    self = [super init];
    if(self){
        self.faceOpacity = 0.50f;
        self.defaultOpacity = 0.50f;
        self.effectId = VnEffectIdColorPinkMilk;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setRedMin:s255(29.0f) gamma:1.22f max:s255(253.0f) minOut:s255(72.0f) maxOut:s255(250.0f)];
    [levelsFilter1 setGreenMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setBlueMin:s255(30.0f) gamma:1.08f max:s255(251.0f) minOut:s255(65.0f) maxOut:s255(235.0f)];
    
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(19.0f) gamma:1.20f max:s255(253.0f) minOut:s255(29.0f) maxOut:s255(255.0f)];

    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    self.endFilter = levelsFilter2;

}

@end
