//
//  VnEffectThorn.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectThorn.h"

@implementation VnEffectThorn

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdThorn;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve
    VnFilterToneCurve* curveFilter1 = [[VnFilterToneCurve alloc] initWithACV:@"co001"];
    
    self.startFilter = self.endFilter = curveFilter1;
}

@end
