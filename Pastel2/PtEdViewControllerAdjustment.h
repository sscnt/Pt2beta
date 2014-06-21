//
//  PtEdViewControllerAdjustment.h
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewNavigationBar.h"
#import "PtFtObjectProcessQueue.h"
#import "PtFtViewBlur.h"
#import "PtFtViewTapRecognizer.h"

@class PtViewControllerEditor;

@interface PtEdViewControllerAdjustment : UIViewController <PtFtSharedQueueManagerDelegate, PtFtViewTapRecognizerDelegate>

@property (nonatomic, strong) UIImageView* previewImageView;
@property (nonatomic, strong) UIImage* previewImage;
@property (nonatomic, strong) UIImage* originalPreviewImage;
@property (nonatomic, strong) VnViewProgress* progressView;
@property (nonatomic, strong) PtFtViewBlur* blurView;
@property (nonatomic, strong) NSMutableArray* originalImageParts;
@property (nonatomic, weak) PtViewControllerEditor* editorController;
@property (nonatomic, strong) PtFtViewTapRecognizer* tapRecognizerView;

@property (nonatomic, strong) PtFtViewNavigationBar* navigationBar;
@property (nonatomic, strong) PtFtButtonNavigation* cancelButton;
@property (nonatomic, strong) PtFtButtonNavigation* doneButton;


- (void)applyFiltersToOriginalImage;

- (void)navigationDoneDidTouchUpInside:(PtFtButtonNavigation*)button;
- (void)navigationCancelDidTouchUpInside:(PtFtButtonNavigation*)button;

@end
