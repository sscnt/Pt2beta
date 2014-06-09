//
//  PtViewControllerEditor.m
//  Pastel2
//
//  Created by SSC on 2014/05/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtViewControllerEditor.h"

@interface PtViewControllerEditor ()

@end

@implementation PtViewControllerEditor

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [PtEdConfig bgColor];
    
    //// Bar
    _topBar = [[PtEdViewTopBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [PtEdConfig topBarHeight])];
    _bottomBar = [[PtEdViewBottomBar alloc] initWithFrame:CGRectMake(0.0f, [UIScreen height] - [PtEdConfig bottomBarHeight], [UIScreen width], [PtEdConfig bottomBarHeight])];
    
    //// Progress
    _progressView = [[VnViewProgress alloc] initWithFrame:self.view.bounds Radius:16.0f];
    _progressView.hidden = YES;
    [self.view addSubview:_progressView];
    
    //// Blur
    _blurView = [[PtFtViewBlur alloc] initWithFrame:self.view.bounds];
    _blurView.hidden = YES;
    _blurView.isBlurred = YES;
    [self.view addSubview:_blurView];
    
    [self.view addSubview:_topBar];
    [self.view addSubview:_bottomBar];
    
    //// Buttons - Top
    _camerarollButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeSaveToCameraRoll];
    [_camerarollButton addTarget:self action:@selector(buttonCamerarollDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addCamerarollButton:_camerarollButton];
    
    _instagramButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeInstagram];
    [_instagramButton addTarget:self action:@selector(buttonInstagramDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addInstagramButton:_instagramButton];
    
    _twitterButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeTwitter];
    [_twitterButton addTarget:self action:@selector(buttonTwitterDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addTwitterButton:_twitterButton];
    
    _facebookButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeFacebook];
    [_facebookButton addTarget:self action:@selector(buttonFacebookDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addFacebookButton:_facebookButton];
    
    _otherButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeOther];
    [_otherButton addTarget:self action:@selector(buttonOtherDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_topBar addOtherButton:_otherButton];
    
    //// Buttons - Bottom
    _cameraButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeBackToCamera];
    [_cameraButton addTarget:self action:@selector(buttonCameraDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar addBackToCameraButton:_cameraButton];
    
    _filtersButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeFilters];
    [_filtersButton addTarget:self action:@selector(buttonFiltersDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar addFiltersButton:_filtersButton];
    
    _slidersButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeSliders];
    [_slidersButton addTarget:self action:@selector(buttonSlidersDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar addSlidersButton:_slidersButton];
    
    //// Preview
    [self initPreview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([UIDevice isiPad]) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)reloadImage
{
    _imagePreview.image = [PtSharedApp instance].imageToProcess;
}

- (void)deallocImage
{
    [_imagePreview removeFromSuperview];
    _imagePreview.image = nil;
    _imagePreview = nil;
}

- (void)removePreview
{
    if (_imagePreview) {
        [_imagePreview removeFromSuperview];
        _imagePreview.image = nil;
        _imagePreview = nil;
    }
    
}

- (void)initPreview
{
    [self removePreview];
    __block CGSize psize;
    __block __weak PtViewControllerEditor* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            _imagePreview = [[PtEdViewImagePreview  alloc] initWithFrame:CGRectMake(0.0f, _topBar.height, [UIScreen width], [UIScreen height] - _topBar.height - _bottomBar.height)];
            float maxPixelSize = [UIScreen width] * 4.0f;
            CGSize osize = [PtSharedApp instance].sizeOfImageToProcess;
            if (maxPixelSize > osize.width) {
                maxPixelSize = osize.width;
            }
            psize = CGSizeMake(maxPixelSize, osize.height * maxPixelSize / osize.width);
        }
        dispatch_async(q_main, ^{            
            _self.imagePreview.image = [PtUtilImage resizedImageUrl:[PtSharedApp originalImageUrl] ToSize:psize];
            [_self.view addSubview:_self.imagePreview];
            [_self.view bringSubviewToFront:_self.blurView];
            [_self.view bringSubviewToFront:_self.progressView];
            [_self.view bringSubviewToFront:_self.topBar];
            [_self.view bringSubviewToFront:_self.bottomBar];
        });
    });
    
}

#pragma mark button

- (void)buttonCamerarollDidTouchUpInside:(PtEdViewBarButton *)button
{
    self.view.userInteractionEnabled = NO;
    _progressView.hidden = NO;
    _blurView.hidden = NO;
    [_progressView resetProgress];
    [_progressView setProgress:0.10f];
    UIImageWriteToSavedPhotosAlbum([PtSharedApp instance].imageToProcess, self, @selector(imageDidSaveToCameraRoll:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)buttonInstagramDidTouchUpInside:(PtEdViewBarButton *)button
{
    
}

- (void)buttonTwitterDidTouchUpInside:(PtEdViewBarButton *)button
{
    
}

- (void)buttonFacebookDidTouchUpInside:(PtEdViewBarButton *)button
{
    
}

- (void)buttonOtherDidTouchUpInside:(PtEdViewBarButton *)button
{
    
}

- (void)buttonCameraDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtSharedApp instance].imageToProcess = nil;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)buttonFiltersDidTouchUpInside:(PtEdViewBarButton *)button
{
    PtViewControllerFilters* con = [[PtViewControllerFilters alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonSlidersDidTouchUpInside:(PtEdViewBarButton *)button
{
    
}

#pragma mark events

- (void)imageDidSaveToCameraRoll:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    @autoreleasepool {
        [_progressView setProgress:1.0f];
        __block __weak PtViewControllerEditor* _self = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            _self.view.userInteractionEnabled = YES;
            _self.progressView.hidden = YES;
            _self.blurView.hidden = YES;
        });
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
