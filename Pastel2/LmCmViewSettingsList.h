//
//  LmCmViewSettingsList.h
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmButtonSettingsItem.h"

@protocol LmCmViewSettingsListDelegate <NSObject>

- (void)settingItemDidEnabled:(LmCmViewSettingsListItem)item;
- (void)settingItemDidDisabled:(LmCmViewSettingsListItem)item;

@end

@interface LmCmViewSettingsList : UIView

@property (nonatomic, weak) id<LmCmViewSettingsListDelegate> delegate;

- (void)didSelectItem:(LmCmButtonSettingsItem*)item;

@end
