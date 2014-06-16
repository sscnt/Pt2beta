//
//  PtViewControllerEditor.h
//  Pastel2
//
//  Created by SSC on 2014/05/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Social/Social.h>
#import "PtEdViewTopBar.h"
#import "PtEdViewBottomBar.h"
#import "PtEdViewBarButton.h"
#import "PtEdViewImagePreview.h"
#import "PtViewControllerFilters.h"
#import "PtFtViewBlur.h"
#import "ShareOtherAppViewController.h"
#import "PtViewControllerExportToInstagram.h"
#import "VnViewProgress.h"
#import "PtEdViewToolBar.h"

typedef NS_ENUM(NSInteger, PtViewControllerEditorWorkflowAfterSavingPhoto){
    PtViewControllerEditorWorkflowAfterSavingPhotoDoNothing = 1,
    PtViewControllerEditorWorkflowAfterSavingPhotoShareOnInstagram,
    PtViewControllerEditorWorkflowAfterSavingPhotoShareOnTwitter,
    PtViewControllerEditorWorkflowAfterSavingPhotoShareOnFacebook,
    PtViewControllerEditorWorkflowAfterSavingPhotoSendOtherApps
};

@interface PtViewControllerEditor : UIViewController

@property (nonatomic, assign) BOOL currentImageDidChange;
@property (nonatomic, assign) PtViewControllerEditorWorkflowAfterSavingPhoto workflowAfterSavingPhoto;
@property (nonatomic, strong) PtEdViewBottomBar* bottomBar;
@property (nonatomic, strong) PtEdViewTopBar* topBar;
@property (nonatomic, strong) PtEdViewImagePreview* imagePreview;
@property (nonatomic, strong) PtEdViewToolBar* toolBar;

@property (nonatomic, strong) PtEdViewBarButton* camerarollButton;
@property (nonatomic, strong) PtEdViewBarButton* instagramButton;
@property (nonatomic, strong) PtEdViewBarButton* twitterButton;
@property (nonatomic, strong) PtEdViewBarButton* facebookButton;
@property (nonatomic, strong) PtEdViewBarButton* otherButton;
@property (nonatomic, strong) PtEdViewBarButton* cameraButton;
@property (nonatomic, strong) PtEdViewBarButton* filtersButton;
@property (nonatomic, strong) PtEdViewBarButton* slidersButton;

@property (nonatomic, strong) PtEdViewBarButton* brightnessButton;

@property (nonatomic, strong) VnViewProgress* progressView;
@property (nonatomic, strong) PtFtViewBlur* blurView;

- (void)initPreview;
- (void)removePreview;

- (void)reloadImage;
- (void)deallocImage;

- (void)saveImage;
- (void)didSaveImage;
- (void)shareOnTwitter;
- (void)shareoOnFacebook;
- (void)sendOtherApp;

- (void)buttonCamerarollDidTouchUpInside:(PtEdViewBarButton*)button;
- (void)buttonInstagramDidTouchUpInside:(PtEdViewBarButton*)button;
- (void)buttonTwitterDidTouchUpInside:(PtEdViewBarButton*)button;
- (void)buttonFacebookDidTouchUpInside:(PtEdViewBarButton*)button;
- (void)buttonOtherDidTouchUpInside:(PtEdViewBarButton*)button;
- (void)buttonCameraDidTouchUpInside:(PtEdViewBarButton*)button;
- (void)buttonFiltersDidTouchUpInside:(PtEdViewBarButton*)button;
- (void)buttonSlidersDidTouchUpInside:(PtEdViewBarButton*)button;

- (void)imageDidSaveToCameraRoll:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo;

@end
