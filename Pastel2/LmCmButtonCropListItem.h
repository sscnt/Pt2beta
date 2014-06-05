//
//  LmCmButtonCropListItem.h
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmCmButtonCropListItem : UIButton

@property (nonatomic, assign) LmCmViewCropSize cropSize;
@property (nonatomic, strong) VnViewLabel* label;
@property (nonatomic, assign) BOOL active;

@end
