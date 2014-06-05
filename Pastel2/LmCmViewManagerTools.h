//
//  LmCmViewManagerTools.h
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LmCmViewBarButton.h"
#import "LmCmViewSettingsList.h"
#import "LmCmViewCropList.h"
#import "LmCmViewFlashModeList.h"

@protocol LmCmViewManagerToolsDelegate <NSObject>
- (void)openCameraRoll;
@end

@class LmCmViewController;

@interface LmCmViewManagerTools : NSObject <LmCmViewSettingsListDelegate, LmCmViewCropListDelegate, LmCmViewFlashModeListDelegate>

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) LmCmViewController<LmCmViewManagerToolsDelegate>* delegate;
@property (nonatomic, strong) LmCmViewBarButton* settingsButton;
@property (nonatomic, strong) LmCmViewBarButton* camerarollButton;
@property (nonatomic, strong) LmCmViewBarButton* cropButton;
@property (nonatomic, strong) LmCmViewBarButton* switchCameraButton;
@property (nonatomic, strong) LmCmViewBarButton* generalSettingsButton;
@property (nonatomic, strong) LmCmViewBarButton* lastPhotoButton;
@property (nonatomic, strong) LmCmViewBarButton* flashButton;
@property (nonatomic, strong) LmCmViewSettingsList* settingsList;
@property (nonatomic, strong) LmCmViewCropList* cropList;
@property (nonatomic, strong) LmCmViewFlashModeList* flashList;

- (void)viewDidLoad;
- (void)showSettingsList;
- (void)lastPhotoButtonSetAsset:(ALAsset*)asset;

- (void)settingsButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)camerarollButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)cropButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)cameraSwitchButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)flashButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)lastPhotoDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)generalSettingsButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)orientationDidChangeTo:(UIDeviceOrientation)orientation;

@end
