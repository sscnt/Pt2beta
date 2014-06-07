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
        self.defaultOpacity = 0.80f;
        self.faceOpacity = 0.60f;
        self.effectId = VnEffectIdAmaroFaded;
    }
    return self;
}

- (UIImage*)process
{
    
    [VnCurrentImage saveTmpImage:self.imageToProcess];
    
    // Curve
    @autoreleasepool {
        VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"amrfd"];
        
        [self mergeAndSaveTmpImageWithOverlayFilter:curveFilter opacity:1.0f blendingMode:VnBlendingModeNormal];
    }
    
    return [VnCurrentImage tmpImage];
}

@end
