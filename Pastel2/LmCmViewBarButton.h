//
//  LmCmViewBarButton.h
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef NS_ENUM(NSInteger, LmCmViewBarButtonType){
    LmCmViewBarButtonTypeCameraRoll = 1,
    LmCmViewBarButtonTypeLastPhoto,
    LmCmViewBarButtonTypeSettings,
    LmCmViewBarButtonTypeFlash,
    LmCmViewBarButtonTypeCrop,
    LmCmViewBarButtonTypeSwitchCamera,
    LmCmViewBarButtonTypeGeneralSettings
};

@interface LmCmViewBarButton : UIButton

@property (nonatomic, assign) LmCmViewBarButtonType type;
@property (nonatomic, assign) LmCmViewBarButtonFlashMode flashMode;
@property (nonatomic, strong) VnViewLabel* textLabel;
@property (nonatomic, strong) UIImageView* imgView;
@property (nonatomic, strong) ALAsset* asset;

- (id)initWithType:(LmCmViewBarButtonType)type;
- (void)applyFlashModeText;
- (void)addImage:(UIImage*)image;

@end
