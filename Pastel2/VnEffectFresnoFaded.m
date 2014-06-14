//
//  VnEffectFresnoFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectFresnoFaded.h"

@implementation VnEffectFresnoFaded

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdFresnoFaded;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"ax001"];
    
    self.startFilter = self.endFilter = curveFilter;
}


@end
