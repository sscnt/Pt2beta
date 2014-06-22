//
//  PtEdViewControllerAdjustment.m
//  Pastel2
//
//  Created by SSC on 2014/06/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewControllerAdjustment.h"
#import "PtViewControllerEditor.h"

@interface PtEdViewControllerAdjustment ()

@end

@implementation PtEdViewControllerAdjustment

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
    _navigationBar = [[PtFtViewNavigationBar alloc] initWithFrame:CGRectMake(0.0f, self.view.height - [PtSharedApp bottomNavigationBarHeight], self.view.width, [PtSharedApp bottomNavigationBarHeight])];
    [self.view addSubview:_navigationBar];
    
    //// Navigation Button
    _cancelButton = [[PtFtButtonNavigation alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [PtSharedApp bottomNavigationBarHeight], [PtSharedApp bottomNavigationBarHeight])];
    _cancelButton.type = PtFtButtonNavigationTypeCancel;
    [_cancelButton addTarget:self action:@selector(navigationCancelDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addCancelButton:_cancelButton];
    _doneButton = [[PtFtButtonNavigation alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [PtSharedApp bottomNavigationBarHeight], [PtSharedApp bottomNavigationBarHeight])];
    _doneButton.type = PtFtButtonNavigationTypeDone;
    [_doneButton addTarget:self action:@selector(navigationDoneDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addDoneButton:_doneButton];
}

- (void)applyFiltersToOriginalImage
{
    self.view.userInteractionEnabled = NO;
    self.blurView.isBlurred = YES;
    self.progressView.hidden = NO;
    [self.progressView resetProgress];
    
    [self.editorController deallocImage];
    
    __block __weak PtEdViewControllerAdjustment* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            _self.originalImageParts = [PtUtilImage splitImageIn25Parts:[PtSharedApp instance].imageToProcess];
            [PtSharedApp instance].imageToProcess = nil;
            _self.previewImage = nil;
            _self.originalPreviewImage = nil;
            _self.previewImageView.image = nil;
        }
        dispatch_async(q_main, ^{
            [_self.progressView setProgress:0.10f];
            [_self applyCurrentFiltersToOriginalImage];
        });
    });
    
}

#pragma mark navigation

- (void)navigationCancelDidTouchUpInside:(PtFtButtonNavigation *)button
{
    [PtFtSharedQueueManager instance].canceled = YES;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)navigationDoneDidTouchUpInside:(PtFtButtonNavigation *)button
{
    [self applyFiltersToOriginalImage];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
