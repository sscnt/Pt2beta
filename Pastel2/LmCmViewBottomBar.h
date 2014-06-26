//
//  LmViewCameraBottomBar.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmButtonShutter.h"
#import "LmCmViewBarButton.h"

@interface LmCmViewBottomBar : UIView

@property (nonatomic, assign) BOOL transparent;
@property (nonatomic, weak) LmCmViewBarButton* settingsButton;
@property (nonatomic, weak) LmCmViewBarButton* camerarollButton;
@property (nonatomic, weak) LmCmViewBarButton* lastPhotoButton;
@property (nonatomic, weak) LmCmViewBarButton* generalButton;

- (void)addShutterButton:(LmCmButtonShutter*)button;
- (void)addSettingsButton:(LmCmViewBarButton*)button;
- (void)addCamerarollButton:(LmCmViewBarButton*)button;
- (void)addLastPhotoButton:(LmCmViewBarButton*)button;
- (void)addGeneralSettingsButton:(LmCmViewBarButton*)button;

- (void)layoutViews;

@end
