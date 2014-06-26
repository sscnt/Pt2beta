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
    float restHeight = self.view.height - [PtFtConfig toolBarHeight] - [PtFtConfig overlayBarHeight] - [PtFtConfig artisticBarHeight] - [PtFtConfig colorBarHeight] - [PtSharedApp bottomNavigationBarHeight];
    CGSize isize = [PtSharedApp instance].originalImageSize;
    if (isize.height > isize.width) {
        float h = restHeight;
        float w = isize.width * h / isize.height;
        self.previewImageView.frame = CGRectMake(0.0f, 0.0f, w, h);
    }
    self.previewImageView.center = CGPointMake(self.view.width / 2.0f, restHeight / 2.0f);
    self.progressView.center = self.previewImageView.center;
    
    [_filtersManager viewDidLoad];
    [_slidersManager viewDidLoad];
    [_navigationManager viewDidLoad];
    
    [self.progressView setProgress:0.10f];
    [self resizeImage];
}

- (void)didResizeImage
{
    //_self.previewImageView.image = _self.previewImage;
    [self initPresetQueuePool];
    [PtFtSharedQueueManager instance].delegate = self;
    [[PtFtSharedQueueManager instance] addQueue:[self shiftQueueFromPool]];
    //[_self.progressView setHidden:YES];
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
            self.previewImageView.image = queue.image;
            self.previewImage = queue.image;
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
                self.previewImageView.image = self.originalPreviewImage;
                self.progressView.hidden = YES;
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
        NSData* data = [PtUtilImage mergeSplitImage25:self.originalImageParts WithSize:app.originalImageSize];
        [PtSharedApp saveOriginalImageDataToFile:data];
        [PtSharedApp instance].imageToProcess = [UIImage imageWithData:data];
    }
    self.view.userInteractionEnabled = YES;
    self.progressView.hidden = YES;
    self.blurView.isBlurred = NO;
    [self.editorController initPreview];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark filter button

- (void)filterButtonDidTouchUpInside:(PtFtViewLayerBarButton *)button
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
            dispatch_async(q_main, ^{
                [_self.progressView setProgress:0.10f];
                PtFtObjectProcessQueue* queue = [[PtFtObjectProcessQueue alloc] init];
                queue.type = PtFtProcessQueueTypeOriginal;
                [[PtFtSharedQueueManager instance] addQueue:queue];
            });
        }
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
