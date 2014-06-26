//
//  ViewController.m
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewController.h"

@interface LmCmViewController ()

@end

@implementation LmCmViewController

- (void)initCameraManager
{
    self.view.userInteractionEnabled = NO;
    _blackoutView.isBlurred = YES;
    _isCameraInitializing = YES;
    if (_cameraManager) {
        [_cameraManager deallocCamera];
        _cameraManager = nil;
    }
    self.cameraPreview.layer.sublayers = nil;
    self.cameraManager = [[LmCmCamera alloc] init];
    self.cameraManager.delegate = self;
    [self.cameraManager setPreview:self.cameraPreview];
    self.isCameraInitializing = NO;
    _blackoutView.isBlurred = NO;
    self.view.userInteractionEnabled = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVolumeHandling];
    if (![UIDevice isCurrentLanguageJapanese]) {
        [LmCmSharedCamera instance].soundEnabled = YES;
    }
    [MotionOrientation initialize];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationDidChange) name:@"MotionOrientationChangedNotification" object:nil];
    
    _zoomViewManager = [[LmCmViewManagerZoom alloc] init];
    _zoomViewManager.view = self.view;
    _zoomViewManager.delegate = self;
    _previewManager = [[LmCmViewManagerPreview alloc] init];
    _previewManager.view = self.view;
    _previewManager.delegate = self;
    _toolsManager = [[LmCmViewManagerTools alloc] init];
    _toolsManager.delegate = self;
    _toolsManager.view = self.view;
    
    //// Preview
    CGRect previewFrame;
    if ([UIDevice underIPhone5]) {
        previewFrame = self.view.bounds;
    }else{
        previewFrame = CGRectMake(0.0f, [LmCmSharedCamera topBarHeight], [UIScreen width], [UIScreen height] - [LmCmSharedCamera topBarHeight] - [LmCmSharedCamera bottomBarHeight]);
    }
    _cameraPreview = [[LmCmViewPreviewLayer alloc] initWithFrame:previewFrame];
    [self.view addSubview:_cameraPreview];
    
    //// camera
    [self initCameraManager];
    
    //// Blackout
    _blackoutView = [[PtFtViewBlur alloc] initWithFrame:self.view.bounds];
    _blackoutView.isBlurred = NO;
    [self.view addSubview:_blackoutView];
    
    //// Black rect
    _blackRectView = [[LmCmViewCropBlackRect alloc] initWithFrame:_cameraPreview.frame];
    [_blackRectView setRectWithCropSize:[LmCmSharedCamera instance].cropSize];
    [self.view addSubview:_blackRectView];
    
    //// Overlay
    _cameraPreviewOverlay = [[LmCmViewPreviewOverlay alloc] initWithFrame:_cameraPreview.frame];
    [self.view addSubview:_cameraPreviewOverlay];
        
    //// Bar
    _topBar = [[LmCmViewTopBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [LmCmSharedCamera topBarHeight])];
    [self.view addSubview:_topBar];
    _bottomBar = [[LmCmViewBottomBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [LmCmSharedCamera bottomBarHeight])];
    [_bottomBar setY:[UIScreen height] - [_bottomBar height]];
    [self.view addSubview:_bottomBar];
    if ([UIDevice underIPhone5]) {
        _topBar.transparent = YES;
        _bottomBar.transparent = YES;
    }
    
    //// Shutter
    _shutterButton = [[LmCmButtonShutter alloc] initWithFrame:[LmCmSharedCamera shutterButtonRect]];
    _shutterButton.soundEnabled = [LmCmSharedCamera instance].soundEnabled;
    [_shutterButton addTarget:self action:@selector(didShutterButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_shutterButton addTarget:self action:@selector(didShutterButtonTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [_bottomBar addShutterButton:_shutterButton];
    
    //// View did load
    [_zoomViewManager viewDidLoad];
    [_previewManager viewDidLoad];
    [_toolsManager viewDidLoad];
    
    [self layoutViews];    
    [self loadLastPhoto];
}

- (void)layoutViews
{
    [_zoomViewManager layoutViews];
    [_toolsManager layoutViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.isPresenting = NO;
    
    __block __weak LmCmViewController* _self = self;
    if (_cameraManager.isRunning == NO && _state != LmCmViewControllerStatePhotoLibraryIsOpening) {
        self.view.userInteractionEnabled = NO;
        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{
            @autoreleasepool {
                [_self.cameraManager enableCamera];
                dispatch_async(q_main, ^{
                    _self.blackoutView.isBlurred = NO;
                    [_self loadLastPhoto];
                    _self.view.userInteractionEnabled = YES;
                });
            }
        });
    }else if(_state != LmCmViewControllerStatePhotoLibraryIsOpening){
        _blackoutView.isBlurred = NO;
        self.view.userInteractionEnabled = YES;
    }
    _state = LmCmViewControllerStateDefault;
}

#pragma mark shutter

- (void)shootingDidCancel
{
    _shutterButton.shooting = NO;
}

- (void)didShutterButtonTouchUpInside:(id)sender
{
    if (_isCameraInitializing) {
        return;
    }
    self.view.userInteractionEnabled = NO;
    _shutterButton.holding = NO;
    _shutterButton.shooting = YES;
    if ([LmCmSharedCamera instance].soundEnabled) {
        [self flashScreen];
    }
    [_cameraManager takeOnePicture];
}

- (void)didShutterButtonTouchCancel:(id)sender
{
    _shutterButton.holding = NO;
    self.view.userInteractionEnabled = YES;
}

#pragma mark delegate

#pragma makr camera delegate
- (void)singleImageNoSoundDidTakeWithAsset:(LmCmImageAsset *)lmAsset
{
    [self performSelectorOnMainThread:@selector(flashScreen) withObject:nil waitUntilDone:NO];
    if (lmAsset.image) {
        [lmAsset applyZoom];
        [lmAsset fixRotationToNoSoundImage];
        [lmAsset crop];
    }
    [self singleImageDidTakeWithAsset:lmAsset];
}

- (void)singleImageByNormalCameraDidTakeWithAsset:(LmCmImageAsset *)lmAsset
{
    if (lmAsset.image) {
        [lmAsset applyZoom];
        [lmAsset crop];
    }
    [self singleImageDidTakeWithAsset:lmAsset];
}

- (void)singleImageDidTakeWithAsset:(LmCmImageAsset *)asset
{
    __block LmCmViewController* _self = self;
    
    [self.assetLibrary writeImageToSavedPhotosAlbum:asset.image.CGImage orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
            LOG(@"%@", error);
            switch (error.code) {
                case -3311:
                    [self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"no_access_to_your_photos", nil)];
                    break;
                default:
                    [self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"Couldn't save your photo", nil)];
                    break;
            };
            return;
        }
        [_self.assetLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            _self.cameraManager.processingToConvert = NO;
            [_self lastAssetDidLoad:asset];
            [_self imageDidSave:asset];
            _self.shutterButton.shooting = NO;
            _self.view.userInteractionEnabled = YES;
        } failureBlock:^(NSError *error) {
            
        }];
    }];
}

- (void)imageDidSave:(ALAsset *)alAsset
{
    self.lastAsset = alAsset;
}

- (void)flashScreen
{
    [self.cameraPreviewOverlay flash];
}

#pragma mark present

- (void)presentEditorViewControllerWithImage:(UIImage *)image
{
    if (self.isPresenting) {
        return;
    }
    if (self.isCameraInitializing) {
        return;
    }
    if (image == nil) {
        _blackoutView.isBlurred = NO;
        return;
    }
    self.isPresenting = YES;
    _blackoutView.isBlurred = YES;
    __block __weak LmCmViewController* _self = self;
    
    if ([PtSharedApp instance].useFullResolutionImage) {
        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(q_global, ^{
            @autoreleasepool {
                [_self disableCamera];
            }
        });
        [PtSharedApp instance].imageToProcess = image;
        PtViewControllerEditor* con = [[PtViewControllerEditor alloc] init];
        [self.navigationController pushViewController:con animated:NO];
        _state = LmCmViewControllerStatePresentedEditorController;
    }else{
        __block UIImage* _image = image;
        dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t q_main = dispatch_get_main_queue();
        dispatch_async(q_global, ^{
            @autoreleasepool {
                [_self disableCamera];
                if ([PtSharedApp instance].useFullResolutionImage == NO) {
                    float length = MAX(_image.size.width, _image.size.height);
                    if (length > 1920.0f) {
                        float scale = _image.size.width / 1920.0f;
                        if (_image.size.height > _image.size.width) {
                            scale = image.size.height / 1920.0f;
                        }
                        _image = [_image resizedImage:CGSizeMake(_image.size.width / scale, _image.size.height / scale) interpolationQuality:kCGInterpolationHigh];
                    }
                }
                [PtSharedApp instance].imageToProcess = _image;
                dispatch_async(q_main, ^{
                    PtViewControllerEditor* con = [[PtViewControllerEditor alloc] init];
                    [_self.navigationController pushViewController:con animated:NO];
                    _self.state = LmCmViewControllerStatePresentedEditorController;
                });
                
            }
        });
    }
    
    
}

- (void)presentEditorViewControllerFromLastAsset
{
    if (self.lastAsset == nil) {
        return;
    }
    if (self.isPresenting) {
        return;
    }
    if (self.isCameraInitializing) {
        return;
    }
    _blackoutView.isBlurred = YES;
    __block __weak LmCmViewController* _self = self;
    __block UIImage* image;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            ALAssetRepresentation *rep = [self.lastAsset defaultRepresentation];
            Byte *buffer = (Byte*)malloc(rep.size);
            NSUInteger buffered = [rep getBytes:buffer fromOffset:0 length:rep.size error:nil];
            NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
            [PtSharedApp saveOriginalImageDataToFile:data];
            image = [UIImage imageWithContentsOfFile:[PtSharedApp originalImageUrl].path];
            
            
            /*
            UIImage* rawImage = [UIImage imageWithCGImage:[rep fullResolutionImage]
                                        scale:[rep scale]
                                  orientation:[rep orientation]];
            NSData* data = UIImageJPEGRepresentation(rawImage, 0.99f);
            [PtSharedApp saveOriginalImageDataToFile:data];
            image = [UIImage imageWithData:data];
            image = rawImage;
            Byte *buffer = (Byte*)malloc(rep.size);
            NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
            NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
            [PtSharedApp saveOriginalImageDataToFile:data];
             */
            dispatch_async(q_main, ^{
                [_self presentEditorViewControllerWithImage:image];
            });
        }
        
    });
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    self.loadedImageFromPickerController = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL* url = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    UIImage* imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.loadedImageFromPickerController = imageOriginal;
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(imageOriginal, nil, nil, nil);
    }
    
    __block __weak LmCmViewController* _self = self;
    [self.assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
        if(_self.loadedImageFromPickerController){            
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            
            @autoreleasepool {
                Byte *buffer = (Byte*)malloc(rep.size);
                NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
                NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                [PtSharedApp saveOriginalImageDataToFile:data];
            }
            
            //// Do your stuff
            [_self presentEditorViewControllerWithImage:_self.loadedImageFromPickerController];
        }
    } failureBlock:^(NSError *error) {
        [_self showAlertViewWithTitle:NSLocalizedString(@"Error", nil) Message:NSLocalizedString(@"Coudn't open the photo.", nil)];
    }];
}

#pragma mark camera roll


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([[[viewController class] description] isEqualToString:@"PUUIAlbumListViewController"]) {
        self.toolsManager.camerarollButton.selected = NO;
    }
    if ([[[viewController class] description] isEqualToString:@"PLUIAlbumListViewController"]) {
        self.toolsManager.camerarollButton.selected = NO;
    }
}

- (void)openCameraRoll
{
    _blackoutView.isBlurred = YES;
    _state = LmCmViewControllerStatePhotoLibraryIsOpening;
    _toolsManager.camerarollButton.selected = NO;
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    _state = LmCmViewControllerStateDefault;
    _isKeepingDisabled = NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)orientationDidChange
{
    UIDeviceOrientation o = [MotionOrientation sharedInstance].deviceOrientation;
    
    __block LmCmViewController* _self = self;
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_main, ^{
        [_self.blackRectView setRectWithCropSize:[LmCmSharedCamera instance].cropSize];
        [_self.cameraPreviewOverlay setNeedsDisplay];
        [_self.toolsManager orientationDidChangeTo:o];
    });
    
    
}

#pragma mark photo

- (void)loadLastPhoto
{
    __block LmCmViewController* _self = self;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _self.assetLibrary = [[ALAssetsLibrary alloc] init];
    });
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q_global, ^{
        @autoreleasepool
        {
            [_self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup* group, BOOL* stop){
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                int numberOfAssets = (int)[group numberOfAssets];
                LOG(@"Assets: %d", numberOfAssets);
                if (numberOfAssets > 0) {
                    [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:numberOfAssets - 1] options:0 usingBlock:^(ALAsset* asset, NSUInteger index, BOOL* stop) {
                        if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                            [self performSelectorOnMainThread:@selector(lastAssetDidLoad:) withObject:asset waitUntilDone:nil];
                        }
                    }];
                }
            } failureBlock:^(NSError* error){
                
            }];
        }
    });
}

- (void)lastAssetDidLoad:(ALAsset *)asset
{
    self.lastAsset = asset;
    [self.toolsManager lastPhotoButtonSetAsset:asset];
}

#pragma mark settings

- (void)presetnToSettings
{
    PtViewControllerSettings* con = [[PtViewControllerSettings alloc] init];
    [self.navigationController pushViewController:con animated:NO];
}


#pragma mark volume

- (void)initVolumeHandling
{
    return;
    [self setVolumeNotification];
    
    //MPVolumeViewをオフスクリーンに。
    CGRect frame = CGRectMake(-100, -100, 100, 100);
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:frame];
    [volumeView sizeToFit];
    [self.view addSubview:volumeView];
    
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    UInt32 category = kAudioSessionCategory_AmbientSound;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
    AudioSessionSetActive(true);
    
    initialVolume = [MPMusicPlayerController applicationMusicPlayer].volume;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [center addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

- (void)setVolumeNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(volumeChanged:)
     name:@"AVSystemController_SystemVolumeDidChangeNotification"
     object:nil];
}

- (void)volumeChanged:(NSNotification *)notification{
    //明示的にボリューム変更がされた時のみ
    if ([[[notification userInfo]objectForKey:@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"]isEqualToString:@"ExplicitVolumeChange"]) {
        
        //ここで撮影をおこなうメソッド等を呼ぶ
        if ([LmCmSharedCamera instance].volumeSnapEnabled) {
            [self didShutterButtonTouchUpInside:_shutterButton];
        }
        
        //一旦NSNotificationCenterからAVSystemController_SystemVolumeDidChangeNotificationを外して、ボリュームを元に戻す
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
        [MPMusicPlayerController applicationMusicPlayer].volume = initialVolume;
        [self performSelector:@selector(setVolumeNotification) withObject:nil afterDelay:0.2];
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    AudioSessionSetActive(false);
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    initialVolume = [MPMusicPlayerController applicationMusicPlayer].volume;
    [self setVolumeNotification];
    AudioSessionSetActive(true);
}

- (void)enableCamera
{
    [self.cameraManager enableCamera];
}

- (void)disableCamera
{
    [self.cameraManager disableCamera];
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

@end
