//
//  VnEffectOverlayCreamHaze.m
//  Pastel2
//
//  Created by SSC on 2014/06/18.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectOverlayCreamHaze.h"

@implementation VnEffectOverlayCreamHaze

- (id)init
{
    self = [super init];
    if(self){
        self.defaultOpacity = 0.15f;
        self.effectId = VnEffectIdOverlayCreamHaze;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Fill Layer
    VnFilterSolidColor* solidColor1 = [[VnFilterSolidColor alloc] init];
    [solidColor1 setColorRed:s255(255.0f) green:s255(255.0f) blue:s255(255.0f) alpha:1.0f];
    solidColor1.blendingMode = VnBlendingModeDifference;

    self.startFilter = self.endFilter = solidColor1;
    

}
@end
