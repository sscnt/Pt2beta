//
//  VnEffectBrannanFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectBrannanFaded.h"

@implementation VnEffectBrannanFaded

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdBrannanFaded;
    }
    return self;
}

- (void)makeFilterGroup
{    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"ai001"];
    
    self.startFilter = self.endFilter = curveFilter;
}


@end
