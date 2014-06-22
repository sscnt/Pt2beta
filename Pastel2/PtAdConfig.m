//
//  PtAdConfig.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdConfig.h"

@implementation PtAdConfig

+ (float)sliderBarHeight
{
    return 80.0f;
}

+ (float)percentageBarHeight
{
    return 40.0f;
}

+ (UIColor *)barBgColor
{
    return [UIColor colorWithWhite:0.12f alpha:1.0f];    
}

+ (UIColor *)percentageBarBgColor
{
    return [UIColor colorWithWhite:0.08f alpha:1.0f];
}

@end
