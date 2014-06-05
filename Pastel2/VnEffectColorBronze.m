//
//  VnEffectColorBronze.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorBronze.h"

@implementation VnEffectColorBronze

- (id)init
{
    self = [super init];
    if(self){
        self.faceOpacity = 0.45f;
        self.defaultOpacity = 0.45f;
        self.effectId = VnEffectIdColorBronze;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    VnFilterLevels* levelsFilter = [[VnFilterLevels alloc] init];
    [levelsFilter setRedMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(20.0f) maxOut:s255(255.0f)];
    [levelsFilter setGreenMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(230.0f)];
    [levelsFilter setBlueMin:s255(0.0f) gamma:1.00f max:s255(255.0f) minOut:s255(0.0f) maxOut:s255(195.0f)];
    
    self.startFilter = self.endFilter = levelsFilter;
    
}

@end
