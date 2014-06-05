//
//  VnEffectColorWarmHaze.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorWarmHaze.h"

@implementation VnEffectColorWarmHaze

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdColorWarmHaze;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Levels
    VnFilterLevels* levelsFilter1 = [[VnFilterLevels alloc] init];
    [levelsFilter1 setMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(255.0f)];
    [levelsFilter1 setRedMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(40.0f) maxOut:s255(255.0f)];
    
    // Levels
    VnFilterLevels* levelsFilter2 = [[VnFilterLevels alloc] init];
    [levelsFilter2 setMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(25.0f) maxOut:s255(255.0f)];
    
    self.startFilter = levelsFilter1;
    [levelsFilter1 addTarget:levelsFilter2];
    self.endFilter = levelsFilter2;
}

@end
