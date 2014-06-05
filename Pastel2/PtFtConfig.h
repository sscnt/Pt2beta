//
//  PtConfigFilter.h
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PtFtConfig : NSObject

+ (CGSize)toolBarButtonSize;
+ (CGSize)colorLayerButtonSize;
+ (CGSize)artisticLayerButtonSize;
+ (CGSize)overlayLayerButtonSize;

+ (CGRect)presetImageBounds;
+ (CGSize)presetBaseImageSize;

+ (float)toolBarHeight;
+ (float)colorBarHeight;
+ (float)artisticBarHeight;
+ (float)overlayBarHeight;

+ (UIColor*)toolBarBgColor;
+ (UIColor*)colorBarBgColor;
+ (UIColor*)artisticBarBgColor;
+ (UIColor*)overlayBarBgColor;

+ (float)colorLayerButtonMaskRadius;
+ (float)artisticLayerButtonMaskRadius;
+ (float)overlayLayerButtonMaskRadius;

@end
