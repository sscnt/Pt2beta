//
//  PtViewControllerFilters.m
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtViewControllerFilters.h"
#import "PtViewControllerEditor.h"

@interface PtViewControllerFilters ()

@end

@implementation PtViewControllerFilters

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [PtEdConfig bgColor];
    self.view.userInteractionEnabled = NO;
    _firstPresetFinished = NO;
    
    //// Managers
    _filtersManager = [[PtFtViewManagerFilters alloc] init];
    _filtersManager.delegate = self;
    _filtersManager.view = self.view;
    _slidersManager = [[PtFtViewManagerSliders alloc] init];
    _slidersManager.delegate = self;
    _slidersManager.view = self.view;
    _navigationManager = [[PtFtViewManagerNavigation alloc] init];
    _navigationManager.delegate = self;
    _navigationManager.view = self.view;
    
    //// Preview
    float restHeight = self.view.height - [PtFtConfig colorBarHeight] - [PtFtConfig overlayBarHeight] - [PtFtConfig artisticBarHeight] - [PtSharedApp bottomNavigationBarHeight];
    float w, h;
    UIImage* image = [PtSharedApp instance].imageToProcess;
    if (image.size.width > image.size.height) {
        w = self.view.width;
        h = image.size.height * w / image.size.width;
    }else{
        h = restHeight - 40.0f;
        w = image.size.width * h / image.size.height;
    }
    _previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, w, h)];
    _previewImageView.center = CGPointMake(self.view.width / 2.0f, restHeight / 2.0f + 20.0f);
    [self.view addSubview:_previewImageView];
    
    //// Blur
    _blurView = [[PtFtViewBlur alloc] initWithFrame:self.view.bounds];
    _blurView.center = _previewImageView.center;
    [self.view addSubview:_blurView];
    
    //// Progress
    _progressView = [[VnViewProgress alloc] initWithFrame:_previewImageView.frame Radius:16.0f];
    _progressView.center = _previewImageView.center;
    [_progressView resetProgress];
    [self.view addSubview:_progressView];
    
    //// Tap
    _tapRecognizerView = [[PtFtViewTapRecognizer alloc] initWithFrame:_previewImageView.frame];
    _tapRecognizerView.delegate = self;
    [self.view addSubview:_tapRecognizerView];
    
    [_filtersManager viewDidLoad];
    [_slidersManager viewDidLoad];
    [_navigationManager viewDidLoad];
    
    [_progressView setProgress:0.10f];
    
    __block __weak PtViewControllerFilters* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            CGSize size = CGSizeMake(_self.previewImageView.width * [[UIScreen mainScreen] scale], _self.previewImageView.height * [[UIScreen mainScreen] scale]);
            UIImage* image = [PtUtilImage resizedImageUrl:[PtSharedApp originalImageUrl] ToSize:size];
            _self.originalPreviewImage = image;
        }
        dispatch_async(q_main, ^{
            [_self.progressView setProgress:0.60f];
        });
        @autoreleasepool {
            UIImage* image = _self.originalPreviewImage;
            if (image) {
                //// for preset image
                CGSize presetImageSizeWithAspect = [PtFtConfig presetBaseImageSize];
                if (image.size.width > image.size.height) {
                    presetImageSizeWithAspect.width = image.size.width * presetImageSizeWithAspect.height / image.size.height;
                } else {
                    presetImageSizeWithAspect.height = image.size.height * presetImageSizeWithAspect.width / image.size.width;
                }
                image = [image resizedImage:presetImageSizeWithAspect interpolationQuality:kCGInterpolationHigh];
                float x = 0.0f;
                float y = 0.0f;
                CGSize presetImageSize = [PtFtConfig presetBaseImageSize];
                if (image.size.width > image.size.height) {
                    x = (image.size.width - presetImageSize.width) / 2.0f;
                } else {
                    y = (image.size.height - presetImageSize.height) / 2.0f;
                }
                image = [image croppedImage:CGRectMake(x, y, presetImageSize.width, presetImageSize.height)];
                _self.presetOriginalImage = image;
            }
        }
        dispatch_async(q_main, ^{
            [_self.progressView setProgress:0.90f];
        });
        @autoreleasepool {
            /*
            if (YES) {
                
            }else{
                //// Detect faces
                NSDictionary *options = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
                CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:options];
                CIImage *ciImage = [[CIImage alloc] initWithCGImage:_self.previewImage.CGImage];
                NSDictionary *imageOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:CIDetectorImageOrientation];
                NSArray *array = [detector featuresInImage:ciImage options:imageOptions];
                
                if([array count] > 0){
                    LOG(@"Face detected!");
                    _self.faceDetected = YES;
                }
            }
             */
        }
        dispatch_async(q_main, ^{
            //_self.previewImageView.image = _self.previewImage;
            [_self initPresetQueuePool];
            [PtFtSharedQueueManager instance].delegate = self;
            [[PtFtSharedQueueManager instance] addQueue:[_self shiftQueueFromPool]];
            //[_self.progressView setHidden:YES];
        });
    });
}

#pragma mark queue
#pragma mark pool

- (void)initPresetQueuePool
{
    _presetQueuePool = [NSMutableArray array];
    NSMutableArray* filters = [PtFtSharedFilterManager instance].artisticFilters;
    for (int i = 0; i < filters.count; i++) {
        PtFtObjectFilterItem* item = (PtFtObjectFilterItem*)[filters objectAtIndex:i];
        PtFtObjectProcessQueue* queue = [[PtFtObjectProcessQueue alloc] init];
        if (item) {
            queue.type = PtFtProcessQueueTypePreset;
            queue.effectId = item.effectId;
            queue.image = self.presetOriginalImage;
            queue.opacity = [PtFtSharedFilterManager defaultOpacityOfEffect:queue.effectId];
            if (self.faceDetected) {
                queue.opacity = [PtFtSharedFilterManager faceOpacityOfEffect:queue.effectId];
            }
            [_presetQueuePool addObject:queue];
        }
    }
}

- (PtFtObjectProcessQueue *)shiftQueueFromPool
{
    if (_presetQueuePool.count == 0) {
        return nil;
    }
    PtFtObjectProcessQueue* queue = [_presetQueuePool objectAtIndex:0];
    [_presetQueuePool removeObjectAtIndex:0];
    return queue;
}

#pragma mark delegate
#pragma mark queue

- (void)queueDidFinished:(PtFtObjectProcessQueue *)queue
{
    LOG(@"Queue did finished.");
    switch (queue.type) {
        case PtFtProcessQueueTypePreview:
        {
            _releasePreviewImage = YES;
            _previewImageView.image = queue.image;
            _previewImage = queue.image;
            self.progressView.hidden = YES;
            self.blurView.isBlurred = NO;
            self.view.userInteractionEnabled = YES;
        }
            break;
        case PtFtProcessQueueTypePreset:
        {
            [_filtersManager setPresetImage:queue.image ToEffect:queue.effectId];
            if (_firstPresetFinished == NO && queue.effectId != VnEffectIdNone) {
                _firstPresetFinished = YES;
                _previewImageView.image = _originalPreviewImage;
                _progressView.hidden = YES;
                self.view.userInteractionEnabled = YES;
            }
            PtFtObjectProcessQueue* queue = [self shiftQueueFromPool];
            if (queue) {
                [[PtFtSharedQueueManager instance] addQueue:queue];
            }
        }
            break;
        case PtFtProcessQueueTypeOriginal:
        {
            [self didFinishProcessingOriginalImage];
        }
            break;
        default:
            break;
    }
}

- (void)didFinishProcessingOriginalImage
{
    PtSharedApp* app = [PtSharedApp instance];
    @autoreleasepool {
        NSData* data = [PtUtilImage mergeSplitImage25:self.originalImageParts WithSize:app.sizeOfImageToProcess];
        [PtSharedApp saveOriginalImageDataToFile:data];
        [PtSharedApp instance].imageToProcess = [UIImage imageWithData:data];
    }
    self.view.userInteractionEnabled = YES;
    self.progressView.hidden = YES;
    self.blurView.isBlurred = NO;
    [self.editorController initPreview];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark tap

- (void)tapRecognizerDidTouchUp
{
    if (_previewImage) {
        _previewImageView.image = _previewImage;
    }
}

- (void)tapRecognizerDidTouchDown
{
    _previewImageView.image = _originalPreviewImage;
}

#pragma mark filter button

- (void)filterButtonDidTouchUpInside:(PtFtButtonLayerBar *)button
{
    PtFtViewManagerSliders* sm = self.slidersManager;
    VnEffect* effect = [PtFtSharedFilterManager effectByEffectId:button.effectId];
    switch (button.group) {
        case VnEffectGroupColor:
        {
            sm.colorOpacity = effect.defaultOpacity;
            if (self.faceDetected) {
                sm.colorOpacity = effect.faceOpacity;
            }
        }
            break;
        case VnEffectGroupEffects:
        {
            sm.artisticOpacity = effect.defaultOpacity;
            if (self.faceDetected) {
                sm.artisticOpacity = effect.faceOpacity;
            }
        }
            break;
        case VnEffectGroupOverlays:
        {
            sm.overlayOpacity = effect.defaultOpacity;
            if (self.faceDetected) {
                sm.overlayOpacity = effect.faceOpacity;
            }
        }
            break;
        default:
            break;
    }
    self.view.userInteractionEnabled = NO;
    self.blurView.isBlurred = YES;
    self.progressView.hidden = NO;
    [self.progressView resetProgress];
    PtFtObjectProcessQueue* queue = [[PtFtObjectProcessQueue alloc] init];
    queue.type = PtFtProcessQueueTypePreview;
    queue.image = self.originalPreviewImage;
    [[PtFtSharedQueueManager instance] addQueue:queue];
}

#pragma mark processing

- (void)applyFiltersToOriginalImage
{
    self.view.userInteractionEnabled = NO;
    self.blurView.isBlurred = YES;
    self.progressView.hidden = NO;
    [self.progressView resetProgress];
    
    [self.editorController deallocImage];
    
    __block __weak PtViewControllerFilters* _self = self;
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
            PtFtObjectProcessQueue* queue = [[PtFtObjectProcessQueue alloc] init];
            queue.type = PtFtProcessQueueTypeOriginal;
            [[PtFtSharedQueueManager instance] addQueue:queue];
        });
    });

}

- (void)deallocImages
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
