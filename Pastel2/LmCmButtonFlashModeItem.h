//
//  LmCmButtonFlashModeItem.h
//  Lumina
//
//  Created by SSC on 2014/05/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmCmButtonFlashModeItem : UIButton

@property (nonatomic, assign) LmCmViewBarButtonFlashMode mode;
@property (nonatomic, strong) VnViewLabel* label;

@end
