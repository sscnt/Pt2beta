//
//  VnEffectVSCOFresh.m
//  Pastel2
//
//  Created by SSC on 2014/06/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectVSCOFresh.h"

@implementation VnEffectVSCOFresh

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdVSCOFresh;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"cc001"];
    
    // Exposure
    VnFilterExposure* expFilter = [[VnFilterExposure alloc] init];
    expFilter.offset = 0.0288f;

    
    self.startFilter = curveFilter;
    [curveFilter addTarget:expFilter];
    self.endFilter = expFilter;
    
}

@end
