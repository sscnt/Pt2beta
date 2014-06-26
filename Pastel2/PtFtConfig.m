//
//  PtConfigFilter.m
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtConfig.h"

@implementation PtFtConfig

#pragma mark sizes


+ (CGSize)toolBarButtonSize
{
    return CGSizeMake(54.0f, [self toolBarHeight]);
}

+ (CGSize)colorLayerButtonSize
{
    return CGSizeMake(54.0f, [self colorBarHeight]);
}

+ (CGSize)artisticLayerButtonSize
{
    return CGSizeMake(60.0f, [self artisticBarHeight]);
}

+ (CGSize)overlayLayerButtonSize
{
    return CGSizeMake(54.0f, [self overlayBarHeight]);
}

#pragma mark preset

+ (CGRect)presetImageBounds
{
    return CGRectMake(0.0f, 0.0f, [self artisticBarHeight] - 20.0f, [self artisticBarHeight] - 20.0f);
}

+ (CGSize)presetBaseImageSize
{
    CGRect bounds = [self presetImageBounds];
    return CGSizeMake(bounds.size.width * [[UIScreen mainScreen] scale], bounds.size.height * [[UIScreen mainScreen] scale]);
}

#pragma mark color


+ (UIColor *)toolBarBgColor
{
    return [self artisticBarBgColor];
}

+ (UIColor *)colorBarBgColor
{
    return [UIColor colorWithWhite:0.12f alpha:1.0f];
}

+ (UIColor *)artisticBarBgColor
{
    return [UIColor colorWithWhite:0.06f alpha:1.0f];
}

+ (UIColor *)overlayBarBgColor
{
    return [UIColor colorWithWhite:0.12f alpha:1.0f];
}

#pragma mark height

+ (float)toolBarHeight
{
    return 44.0f;
}

+ (float)colorBarHeight
{
    return 44.0f;
}

+ (float)artisticBarHeight
{
    return 70.0f;
}

+ (float)overlayBarHeight
{
    return 44.0f;
}

#pragma mark mask

+ (float)colorLayerButtonMaskRadius
{
    return 8.0f;
}

+ (float)artisticLayerButtonMaskRadius
{
    return 20.0f;
}

+ (float)overlayLayerButtonMaskRadius
{
    return 10.0f;
}

@end
