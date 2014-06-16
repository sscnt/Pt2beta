//
//  PtSharedEditor.h
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PtEdConfig : NSObject

+ (PtEdConfig*)instance;

+ (float)topBarHeight;
+ (float)bottomBarHeight;
+ (UIColor*)topBarColor;
+ (UIColor*)bottomBarColor;
+ (UIColor*)toolBarColor;
+ (UIColor*)bgColor;

@end
