//
//  VnEffectDeutanFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectDeutanFaded.h"

@implementation VnEffectDeutanFaded

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.90f;
        self.effectId = VnEffectIdFresnoFaded;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"aq001"];
    
    self.startFilter = self.endFilter = curveFilter;
}

@end
