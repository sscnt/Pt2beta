//
//  VnEffectKodakPortra800.m
//  Pastel
//
//  Created by SSC on 2014/05/12.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEffectKodakPortra800.h"

@implementation VnEffectKodakPortra800

- (id)init
{
    self = [super init];
    if(self){
        self.effectId = VnEffectIdKodakPortra800;
    }
    return self;
}

- (void)makeFilterGroup
{
    
    // Curve    
    VnFilterToneCurve* curveFilter = [[VnFilterToneCurve alloc] initWithACV:@"kdptr800"];
    
    self.startFilter = self.endFilter = curveFilter;
}

@end
