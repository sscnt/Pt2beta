//
//  PtEdViewControllerAdjustment.h
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtAdViewSliderBar.h"
#import "PtAdViewPercentage.h"
#import "PtCoViewControllerProcessing.h"
#import "PtCoViewNavigationBar.h"
#import "PtFtObjectProcessQueue.h"
#import "PtFtViewBlur.h"
#import "PtFtViewTapRecognizer.h"

@class PtViewControllerEditor;

@interface PtAdViewController : PtCoViewControllerProcessing <PtAdSharedQueueManagerDelegate, PtFtViewTapRecognizerDelegate, PtAdViewSliderBarDelegate, PtAdSharedQueueManagerDelegate>

@property (nonatomic, strong) UIImageView* previewImageView;
@property (nonatomic, strong) UIImage* previewImage;
@property (nonatomic, strong) UIImage* originalPreviewImage;
@property (nonatomic, strong) VnViewProgress* progressView;
@property (nonatomic, strong) PtFtViewBlur* blurView;
@property (nonatomic, strong) NSMutableArray* originalImageParts;
@property (nonatomic, weak) PtViewControllerEditor* editorController;
@property (nonatomic, strong) PtFtViewTapRecognizer* tapRecognizerView;

@property (nonatomic, strong) PtCoViewNavigationBar* navigationBar;
@property (nonatomic, strong) PtCoViewNavigationButton* cancelButton;
@property (nonatomic, strong) PtCoViewNavigationButton* doneButton;

@property (nonatomic, strong) PtAdViewSliderBar* sliderBar;
@property (nonatomic, strong) PtAdViewPercentage* percentageBar;

- (void)applyFiltersToOriginalImage;
- (void)applyCurrentFiltersToOriginalImage;

- (void)navigationDoneDidTouchUpInside:(PtCoViewNavigationButton*)button;
- (void)navigationCancelDidTouchUpInside:(PtCoViewNavigationButton*)button;

- (void)registerQueue;

@end
