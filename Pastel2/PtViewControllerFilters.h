//
//  PtViewControllerFilters.h
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtCoViewControllerProcessing.h"
#import "PtFtViewManagerFilters.h"
#import "PtFtViewManagerSliders.h"
#import "PtFtViewManagerNavigation.h"

@class PtViewControllerEditor;

@interface PtViewControllerFilters : PtCoViewControllerProcessing <PtFtSharedQueueManagerDelegate>

@property (nonatomic, strong) PtFtViewManagerFilters* filtersManager;
@property (nonatomic, strong) PtFtViewManagerSliders* slidersManager;
@property (nonatomic, strong) PtFtViewManagerNavigation* navigationManager;
@property (nonatomic, strong) NSMutableArray* presetQueuePool;
@property (nonatomic, strong) UIImage* presetOriginalImage;
@property (nonatomic, assign) BOOL faceDetected;
@property (nonatomic, assign) BOOL firstPresetFinished;

- (void)initPresetQueuePool;
- (PtFtObjectProcessQueue*)shiftQueueFromPool;

- (void)filterButtonDidTouchUpInside:(PtFtButtonLayerBar*)button;
- (void)applyFiltersToOriginalImage;

- (void)didFinishProcessingOriginalImage;
- (void)deallocImages;

@end
