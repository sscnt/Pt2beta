//
//  ViewController.h
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "LmCmCamera.h"
#import "LmCmViewPreviewOverlay.h"
#import "LmCmViewPreviewLayer.h"
#import "LmCmButtonShutter.h"
#import "LmCmViewTopBar.h"
#import "LmCmViewBottomBar.h"
#import "LmCmViewManagerZoom.h"
#import "LmCmViewManagerPreview.h"
#import "LmCmViewManagerTools.h"
#import "LmCmViewCropBlackRect.h"
#import "PtViewControllerEditor.h"
#import "PtViewControllerSettings.h"

typedef NS_ENUM(NSInteger, LmCmViewControllerState){
    LmCmViewControllerStateDefault = 1,
    LmCmViewControllerStatePhotoLibraryIsOpening,
    LmCmViewControllerStatePresentedEditorController
};


@interface LmCmViewController : UIViewController <LmCmCameraDelegate, UIGestureRecognizerDelegate, LmCmViewManagerZoomDelegate, LmCmViewManagerPreviewDelegate, LmCmViewManagerToolsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    float initialVolume;
}

@property (nonatomic, assign) LmCmViewControllerState state;
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, assign) BOOL isCameraInitializing;
@property (nonatomic, assign) BOOL isKeepingDisabled;

@property (nonatomic, strong) LmCmCamera* cameraManager;
@property (nonatomic, strong) LmCmViewPreviewLayer* cameraPreview;
@property (nonatomic, strong) LmCmViewPreviewOverlay* cameraPreviewOverlay;
@property (nonatomic, strong) LmCmButtonShutter* shutterButton;
@property (nonatomic, strong) LmCmViewTopBar* topBar;
@property (nonatomic, strong) LmCmViewBottomBar* bottomBar;
@property (nonatomic, strong) LmCmViewCropBlackRect* blackRectView;
@property (nonatomic, strong) PtFtViewBlur* blackoutView;

@property (nonatomic, strong) LmCmViewManagerZoom* zoomViewManager;
@property (nonatomic, strong) LmCmViewManagerPreview* previewManager;
@property (nonatomic, strong) LmCmViewManagerTools* toolsManager;

@property (nonatomic, strong) ALAssetsLibrary* assetLibrary;
@property (nonatomic, strong) ALAsset* lastAsset;

@property (nonatomic, strong) UIImage* loadedImageFromPickerController;

- (void)initCameraManager;
- (void)didShutterButtonTouchUpInside:(id)sender;
- (void)didShutterButtonTouchCancel:(id)sender;
- (void)orientationDidChange;
- (void)loadLastPhoto;
- (void)lastAssetDidLoad:(ALAsset*)asset;
- (void)flashScreen;

- (void)layoutViews;

- (void)presetnToSettings;

- (void)presentEditorViewControllerFromLastAsset;
- (void)presentEditorViewControllerWithImage:(UIImage*)image;

- (void)imageDidSave:(ALAsset*)alAsset;

- (void)initVolumeHandling;

- (void)enableCamera;
- (void)disableCamera;

@end
