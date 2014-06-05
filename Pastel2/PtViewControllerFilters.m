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
    _blurView = [[PtFtViewBlur alloc] initWithFrame:_previewImageView.bounds];
    _blurView.center = _previewImageView.center;
    [self.view addSubview:_blurView];
    
    //// Progress
    _progressView = [[VnViewProgress alloc] initWithFrame:_previewImageView.frame Radius:16.0f];
    _progressView.center = _previewImageView.center;
    [_progressView resetProgress];
    [self.view addSubview:_progressView];
    
    [_filtersManager viewDidLoad];
    [_slidersManager viewDidLoad];
    [_navigationManager viewDidLoad];
    
    [_progressView setProgress:0.10f];
    
    __block __weak PtViewControllerFilters* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            UIImage* image = [PtSharedApp instance].imageToProcess;
            CGSize size = CGSizeMake(_self.previewImageView.width * [[UIScreen mainScreen] scale], _self.previewImageView.height * [[UIScreen mainScreen] scale]);
            //image = [image resizedImage:size interpolationQuality:kCGInterpolationHigh];
            //image = [image resizeImageAndConvertJpeg:size];
            image = [UIImage resizedImageUrl:[PtSharedApp originalImageUrl] ToSize:size];
            _self.previewImage = image;
        }
        dispatch_async(q_main, ^{
            [_self.progressView setProgress:0.60f];
        });
        @autoreleasepool {
            UIImage* image = _self.previewImage;
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
            _self.previewImageView.image = _self.previewImage;
            [_self initPresetQueuePool];
            [PtFtSharedQueueManager instance].delegate = self;
            [[PtFtSharedQueueManager instance] addQueue:[_self shiftQueueFromPool]];
            [_self.progressView setHidden:YES];
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
            self.progressView.hidden = YES;
            self.blurView.isBlurred = NO;
            self.view.userInteractionEnabled = YES;
        }
            break;
        case PtFtProcessQueueTypePreset:
        {
            [_filtersManager setPresetImage:queue.image ToEffect:queue.effectId];
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
        app.imageToProcess = [UIImage mergeSplitImage9:self.originalImageParts WithSize:app.sizeOfImageToProcess];
        [self.originalImageParts removeAllObjects];
    }
    self.view.userInteractionEnabled = YES;
    self.progressView.hidden = YES;
    self.blurView.isBlurred = NO;
    [self.editorController initPreview];
    [self.navigationController popViewControllerAnimated:NO];
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
    queue.image = self.previewImage;
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
            _self.originalImageParts = [UIImage splitImageIn9Parts:[PtSharedApp instance].imageToProcess];
            [PtSharedApp instance].imageToProcess = nil;
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
