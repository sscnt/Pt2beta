//
//  PtAdObjectProcessQueue.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdObjectProcessQueue.h"

@implementation PtAdObjectProcessQueue

- (id)init
{
    self = [super init];
    if (self) {
        _radiusMultiplier = 1.0f;
        _opacity = 1.0f;
        _strength = 1.0f;
    }
    return self;
}

@end
