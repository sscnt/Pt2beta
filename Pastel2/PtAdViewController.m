//
//  PtEdViewControllerAdjustment.m
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdViewController.h"
#import "PtViewControllerEditor.h"

@interface PtAdViewController ()

@end

@implementation PtAdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [PtEdConfig bgColor];
    
    //// Navigation Bar
    _navigationBar = [[PtCoViewNavigationBar alloc] initWithFrame:CGRectMake(0.0f, self.view.height - [PtSharedApp bottomNavigationBarHeight], self.view.width, [PtSharedApp bottomNavigationBarHeight])];
    [self.view addSubview:_navigationBar];
    
    //// Navigation Button
    _cancelButton = [[PtCoViewNavigationButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [PtSharedApp bottomNavigationBarHeight], [PtSharedApp bottomNavigationBarHeight])];
    _cancelButton.type = PtCoViewNavigationButtonTypeCancel;
    [_cancelButton addTarget:self action:@selector(navigationCancelDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addCancelButton:_cancelButton];
    _doneButton = [[PtCoViewNavigationButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [PtSharedApp bottomNavigationBarHeight], [PtSharedApp bottomNavigationBarHeight])];
    _doneButton.type = PtCoViewNavigationButtonTypeDone;
    [_doneButton addTarget:self action:@selector(navigationDoneDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addDoneButton:_doneButton];
    
    _sliderBar = [[PtAdViewSliderBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self.view width], [PtAdConfig sliderBarHeight])];
    [_sliderBar setY:[self.view height] - [PtSharedApp bottomNavigationBarHeight] - [_sliderBar height]];
    _sliderBar.slider.zeroPointAtCenter = YES;
    _sliderBar.slider.value = 0.0f;
    [self.view addSubview:_sliderBar];
    
    _percentageBar = [[PtAdViewPercentage alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self.view width], [PtAdConfig percentageBarHeight])];
    [_percentageBar setY:_sliderBar.frame.origin.y - [_percentageBar height]];
    _percentageBar.percentage = 0.0f;
    [self.view addSubview:_percentageBar];
    

}

- (void)applyFiltersToOriginalImage
{
    self.view.userInteractionEnabled = NO;
    self.blurView.isBlurred = YES;
    self.progressView.hidden = NO;
    [self.progressView resetProgress];
    
    [self.editorController deallocImage];
    
    __block __weak PtAdViewController* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            _self.originalImageParts = [PtUtilImage splitImageIn25Parts:[PtSharedApp instance].imageToProcess];
            [PtSharedApp instance].imageToProcess = nil;
            _self.previewImage = nil;
            _self.originalPreviewImage = nil;
            _self.previewImageView.image = nil;
            dispatch_async(q_main, ^{
                [_self.progressView setProgress:0.10f];
                [_self applyCurrentFiltersToOriginalImage];
            });
        }
    });
    
}


- (void)queueDidFinished:(PtAdObjectProcessQueue *)queue
{
    LOG(@"Queue did finished.");
    switch (queue.type) {
        case PtAdProcessQueueTypePreview:
        {
            self.previewImageView.image = queue.image;
            self.previewImage = queue.image;
            self.progressView.hidden = YES;
            self.blurView.isBlurred = NO;
        }
            break;
            
        case PtAdProcessQueueTypeOriginal:
        {
            [self didFinishProcessingOriginalImage];
        }
            break;
        default:
            break;
    }
}
- (void)didResizeImage
{
    [PtAdSharedQueueManager instance].delegate = self;
    self.progressView.hidden = YES;
    self.previewImageView.image = self.originalPreviewImage;
    self.view.userInteractionEnabled = YES;
    _sliderBar.delegate = self;
}

- (void)sliderDidTouchUpInside
{
    [self registerQueue];
}

#pragma mark navigation

- (void)navigationCancelDidTouchUpInside:(PtCoViewNavigationButton *)button
{
    [PtFtSharedQueueManager instance].canceled = YES;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)navigationDoneDidTouchUpInside:(PtCoViewNavigationButton *)button
{
    [self applyFiltersToOriginalImage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
