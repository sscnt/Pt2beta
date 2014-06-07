//
//  VnEffectFixieFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectFixieFaded.h"

@implementation VnEffectFixieFaded

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFixieFaded;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"fxifd"];
    
    self.startFilter = self.endFilter = curveFilter;
}


@end
