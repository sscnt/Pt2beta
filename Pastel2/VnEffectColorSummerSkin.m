//
//  VnEffectColorSummerSkin.m
//  Pastel
//
//  Created by SSC on 2014/05/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectColorSummerSkin.h"

@implementation VnEffectColorSummerSkin

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.70;
        self.faceOpacity = 0.70f;
        self.effectId = VnEffectIdColorSummerSkin;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    
    // Curve
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"al001"];

    self.startFilter = curveFilter;
    self.endFilter = curveFilter;    
}

@end
