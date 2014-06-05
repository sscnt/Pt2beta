//
//  LmCmButtonSettingsItem.h
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LmCmButtonSettingsItem : UIButton

@property (nonatomic, assign) LmCmViewSettingsListItem item;
@property (nonatomic, strong) VnViewLabel* label;
@property (nonatomic, assign) BOOL active;

- (void)adjustLabelSize;

@end

