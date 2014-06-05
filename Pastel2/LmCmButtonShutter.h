//
//  LmButtonShutter.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmCmButtonShutter : UIButton

@property (nonatomic, assign) BOOL holding;
@property (nonatomic, assign) BOOL soundEnabled;
@property (nonatomic, assign) UIDeviceOrientation orientation;
@property (nonatomic, assign) BOOL shooting;

@end
