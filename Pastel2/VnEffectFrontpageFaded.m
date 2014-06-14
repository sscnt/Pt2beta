//
//  VnEffectFrontpageFaded.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectFrontpageFaded.h"

@implementation VnEffectFrontpageFaded

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdFrontpageFaded;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"au001"];
    
    self.startFilter = self.endFilter = curveFilter;
}

@end
