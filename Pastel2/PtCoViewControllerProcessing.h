//
//  PtCoViewControllerProcessing.h
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtCoViewNavigationBar.h"
#import "PtFtObjectProcessQueue.h"
#import "PtFtViewBlur.h"
#import "PtFtViewTapRecognizer.h"

@class PtViewControllerEditor;

@interface PtCoViewControllerProcessing : UIViewController <PtFtViewTapRecognizerDelegate>

@property (nonatomic, strong) UIImageView* previewImageView;
@property (nonatomic, strong) UIImage* previewImage;
@property (nonatomic, strong) UIImage* originalPreviewImage;
@property (nonatomic, strong) UIImage* presetOriginalImage;
@property (nonatomic, strong) VnViewProgress* progressView;
@property (nonatomic, strong) PtFtViewBlur* blurView;
@property (nonatomic, strong) NSMutableArray* originalImageParts;
@property (nonatomic, weak) PtViewControllerEditor* editorController;
@property (nonatomic, assign) BOOL releasePreviewImage;
@property (nonatomic, strong) PtFtViewTapRecognizer* tapRecognizerView;

- (void)resizeImage;
- (void)didResizeImage;
- (void)didFinishProcessingOriginalImage;

@end
