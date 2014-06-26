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
    _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoDoNothing;
    
    //// Bar
    _topBar = [[PtEdViewTopBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [PtEdConfig topBarHeight])];
    _bottomBar = [[PtEdViewBottomBar alloc] initWithFrame:CGRectMake(0.0f, [UIScreen height] - [PtEdConfig bottomBarHeight], [UIScreen width], [PtEdConfig bottomBarHeight])];
    _toolBar = [[PtEdViewToolBar alloc] initWithFrame:_bottomBar.frame];
    [_toolBar setY:_toolBar.frame.origin.y - [PtEdConfig bottomBarHeight]];
    [_toolBar setHidden:YES];
    
    //// Progress
    _progressView = [[VnViewProgress alloc] initWithFrame:self.view.bounds Radius:16.0f];
    _progressView.hidden = NO;
    [_progressView resetProgress];
    [self.view addSubview:_progressView];
    
    //// Blur
    _blurView = [[PtFtViewBlur alloc] initWithFrame:self.view.bounds];
    _blurView.hidden = YES;
    _blurView.isBlurred = YES;
    [self.view addSubview:_blurView];
    
    [self.view addSubview:_topBar];
    [self.view addSubview:_bottomBar];
    [self.view addSubview:_toolBar];
    
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
    
    //// Buttons - Tool
    _brightnessButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeBrightness];
    [_brightnessButton addTarget:self action:@selector(buttonBrightnessDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_brightnessButton];
    
    _shadowButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeShadow];
    [_shadowButton addTarget:self action:@selector(buttonShadowDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_shadowButton];
    
    _highlightButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeHighlight];
    [_highlightButton addTarget:self action:@selector(buttonHighlightDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_highlightButton];

    _saturationsButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeSaturation];
    [_saturationsButton addTarget:self action:@selector(buttonSaturationDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_saturationsButton];
    
    _clarifyButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeClarify];
    [_clarifyButton addTarget:self action:@selector(buttonContrastDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_clarifyButton];
    
    _filmButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeFilm];
    [_filmButton addTarget:self action:@selector(buttonFilmDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_filmButton];
    
    _vignetteButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeVignette];
    [_vignetteButton addTarget:self action:@selector(buttonVignetteDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_vignetteButton];
    
    _tempButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeTemp];
    [_tempButton addTarget:self action:@selector(buttonTempDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_tempButton];
        
    _exposureButton = [[PtEdViewBarButton alloc] initWithType:PtEdViewBarButtonTypeExposure];
    [_exposureButton addTarget:self action:@selector(buttonExposureDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar appendButton:_exposureButton];
    
    //// Preview
    [self initPreview];
    self.currentImageDidChange = NO;
}

- (void)setCurrentImageDidChange:(BOOL)currentImageDidChange
{
    _currentImageDidChange = currentImageDidChange;
    if (_currentImageDidChange) {
        _camerarollButton.hidden = NO;
    }else{
        _camerarollButton.hidden = YES;
    }
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
    [_progressView setProgress:0.60f];
    __block CGSize psize;
    __block __weak PtViewControllerEditor* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            _imagePreview = [[PtEdViewImagePreview  alloc] initWithFrame:CGRectMake(0.0f, _topBar.height, [UIScreen width], [UIScreen height] - _topBar.height - _bottomBar.height)];
            float maxPixelSize = [UIScreen width] * 4.0f;
            CGSize osize = [PtSharedApp instance].originalImageSize;
            if (maxPixelSize > osize.width) {
                maxPixelSize = osize.width;
            }
            psize = CGSizeMake(maxPixelSize, osize.height * maxPixelSize / osize.width);
            dispatch_async(q_main, ^{
                _self.imagePreview.image = [PtUtilImage resizedImageUrl:[PtSharedApp originalImageUrl] ToSize:psize];
                [_self.view addSubview:_self.imagePreview];
                [_self.view bringSubviewToFront:_self.blurView];
                [_self.view bringSubviewToFront:_self.progressView];
                [_self.view bringSubviewToFront:_self.topBar];
                [_self.view bringSubviewToFront:_self.toolBar];
                [_self.view bringSubviewToFront:_self.bottomBar];
                [_self.progressView setHidden:YES];
                [_self.progressView resetProgress];
            });
        }
    });
    
}

#pragma mark button

- (void)buttonCamerarollDidTouchUpInside:(PtEdViewBarButton *)button
{
    _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoDoNothing;
    [self saveImage];
}

- (void)buttonInstagramDidTouchUpInside:(PtEdViewBarButton *)button
{
    
}

- (void)buttonTwitterDidTouchUpInside:(PtEdViewBarButton *)button
{
    _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoShareOnTwitter;
    [self shareOnTwitter];
}

- (void)buttonFacebookDidTouchUpInside:(PtEdViewBarButton *)button
{
    _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoShareOnFacebook;
    [self shareOnFacebook];
}

- (void)buttonOtherDidTouchUpInside:(PtEdViewBarButton *)button
{
    _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoSendOtherApps;
    [self sendOtherApp];
}

- (void)buttonCameraDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtSharedApp instance].imageToProcess = nil;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)buttonFiltersDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtViewControllerFilters* con = [[PtViewControllerFilters alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonSlidersDidTouchUpInside:(PtEdViewBarButton *)button
{
    _toolBar.hidden = button.active;
    button.active = !button.active;
}

- (void)buttonFilmDidTouchUpInside:(PtEdViewBarButton *)button
{
    
}

- (void)buttonBrightnessDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerBrightness* con = [[PtAdViewControllerBrightness alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonSaturationDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerSaturation* con = [[PtAdViewControllerSaturation alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonContrastDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerContrast* con = [[PtAdViewControllerContrast alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonTempDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerTemp* con = [[PtAdViewControllerTemp alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonShadowDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerShadow* con = [[PtAdViewControllerShadow alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonHighlightDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerHighlight* con = [[PtAdViewControllerHighlight alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

- (void)buttonExposureDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerExposure* con = [[PtAdViewControllerExposure alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}
- (void)buttonVignetteDidTouchUpInside:(PtEdViewBarButton *)button
{
    [PtFtSharedQueueManager instance].canceled = NO;
    self.currentImageDidChange = YES;
    PtAdViewControllerVignette* con = [[PtAdViewControllerVignette alloc] init];
    con.editorController = self;
    [self.navigationController pushViewController:con animated:NO];
}

#pragma mark workflow

- (void)saveImage
{
    self.view.userInteractionEnabled = NO;
    _progressView.hidden = NO;
    _blurView.hidden = NO;
    [_progressView resetProgress];
    [_progressView setProgress:0.10f];
    UIImageWriteToSavedPhotosAlbum([PtSharedApp instance].imageToProcess, self, @selector(imageDidSaveToCameraRoll:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)didSaveImage
{
    self.currentImageDidChange = NO;
    switch (_workflowAfterSavingPhoto) {
        case PtViewControllerEditorWorkflowAfterSavingPhotoDoNothing:
            self.view.userInteractionEnabled = YES;
            break;
        case PtViewControllerEditorWorkflowAfterSavingPhotoSendOtherApps:
        {
            [self sendOtherApp];
        }
            break;
        case PtViewControllerEditorWorkflowAfterSavingPhotoShareOnTwitter:
        {
            [self shareOnTwitter];
        }
            break;
        case PtViewControllerEditorWorkflowAfterSavingPhotoShareOnFacebook:
        {
            [self shareOnFacebook];
        }
            break;
        case PtViewControllerEditorWorkflowAfterSavingPhotoShareOnInstagram:
            break;
        default:
            break;
    }
}

- (void)shareOnTwitter
{
    if (_currentImageDidChange) {
        _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoShareOnTwitter;
        [self saveImage];
        return;
    }
    if([PtSharedApp instance].imageToProcess){
        SLComposeViewController* vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (vc == nil) {
            [self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"Twitter not available", nil)];
            self.view.userInteractionEnabled = YES;
            return;
        }
        [vc setInitialText:@""];
        [vc addImage:[PtSharedApp instance].imageToProcess];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        [self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"Unexpected error occurred.", nil)];
    }
    self.view.userInteractionEnabled = YES;
}

- (void)shareOnFacebook
{
    if (_currentImageDidChange) {
        _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoShareOnFacebook;
        [self saveImage];
        return;
    }
    if([PtSharedApp instance].imageToProcess){
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        if (vc == nil) {
            [self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"Facebook not available.", nil)];
            self.view.userInteractionEnabled = YES;
            return;
        }
        [vc setInitialText:@""];
        [vc addImage:[PtSharedApp instance].imageToProcess];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        [self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"Unexpected error occurred.", nil)];
    }
    self.view.userInteractionEnabled = YES;
    
}

- (void)sendOtherApp
{
    if (_currentImageDidChange) {
        _workflowAfterSavingPhoto = PtViewControllerEditorWorkflowAfterSavingPhotoSendOtherApps;
        [self saveImage];
        return;
    }
    ShareOtherAppViewController* controller = [[ShareOtherAppViewController alloc] init];
    if (controller == nil) {
        [self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"Unexpected error occurred.", nil)];
        self.view.userInteractionEnabled = YES;
        return;
    }
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    self.view.userInteractionEnabled = YES;
}

#pragma mark events

- (void)imageDidSaveToCameraRoll:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    [_progressView setProgress:1.0f];
    __block __weak PtViewControllerEditor* _self = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        _self.progressView.hidden = YES;
        _self.blurView.hidden = YES;
        [_self didSaveImage];
    });
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
