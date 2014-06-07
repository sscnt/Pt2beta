//
//  VnEffectXPro2Faded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectXPro2Faded.h"

@implementation VnEffectXPro2Faded

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdXPro2Faded;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"xp2fd"];
    
    self.startFilter = self.endFilter = curveFilter;
}

@end
