//
//  PtViewControllerFilters.h
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewNavigationBar.h"
#import "PtFtViewManagerFilters.h"
#import "PtFtViewManagerSliders.h"
#import "PtFtViewManagerNavigation.h"
#import "PtFtObjectProcessQueue.h"
#import "PtFtViewBlur.h"

@class PtViewControllerEditor;

@interface PtViewControllerFilters : UIViewController <PtFtSharedQueueManagerDelegate>

@property (nonatomic, strong) PtFtViewManagerFilters* filtersManager;
@property (nonatomic, strong) PtFtViewManagerSliders* slidersManager;
@property (nonatomic, strong) PtFtViewManagerNavigation* navigationManager;
@property (nonatomic, strong) UIImageView* previewImageView;
@property (nonatomic, strong) NSMutableArray* presetQueuePool;
@property (nonatomic, strong) UIImage* previewImage;
@property (nonatomic, strong) UIImage* presetOriginalImage;
@property (nonatomic, strong) VnViewProgress* progressView;
@property (nonatomic, strong) PtFtViewBlur* blurView;
@property (nonatomic, assign) BOOL faceDetected;
@property (nonatomic, assign) BOOL firstPresetFinished;
@property (nonatomic, strong) NSMutableArray* originalImageParts;
@property (nonatomic, weak) PtViewControllerEditor* editorController;
@property (nonatomic, assign) BOOL releasePreviewImage;

- (void)initPresetQueuePool;
- (PtFtObjectProcessQueue*)shiftQueueFromPool;

- (void)filterButtonDidTouchUpInside:(PtFtButtonLayerBar*)button;
- (void)applyFiltersToOriginalImage;

- (void)didFinishProcessingOriginalImage;
- (void)deallocImages;

@end
