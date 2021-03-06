//
//  VnEffectAmaroFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectAmaroFaded.h"

@implementation VnEffectAmaroFaded

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.60f;
        self.effectId = VnEffectIdAmaroFaded;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"af001"];
    
    
    self.startFilter = self.endFilter = curveFilter;
}

@end
