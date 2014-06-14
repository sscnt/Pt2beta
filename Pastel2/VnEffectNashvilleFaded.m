//
//  VnEffectNashvilleFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectNashvilleFaded.h"

@implementation VnEffectNashvilleFaded

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdNashvilleFaded;
    }
    return self;
}

- (void)makeFilterGroup
{
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"bl001"];
    
    self.startFilter = self.endFilter = curveFilter;
}

@end
