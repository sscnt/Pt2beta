//
//  PtFtSharedQueueManager.m
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtSharedQueueManager.h"
#import "PtViewControllerFilters.h"

@implementation PtFtSharedQueueManager

static PtFtSharedQueueManager* sharedPtFtSharedQueueManager = nil;

+ (PtFtSharedQueueManager*)instance {
	@synchronized(self) {
		if (sharedPtFtSharedQueueManager == nil) {
			sharedPtFtSharedQueueManager = [[self alloc] init];
		}
	}
	return sharedPtFtSharedQueueManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedPtFtSharedQueueManager == nil) {
			sharedPtFtSharedQueueManager = [super allocWithZone:zone];
			return sharedPtFtSharedQueueManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _processing = NO;
    _canceled = NO;
    _queueList = [NSMutableArray array];
}

- (void)addQueue:(PtFtObjectProcessQueue *)queue
{
    [_queueList addObject:queue];
    if (_processing == NO) {
        [self processQueue];
    }
}

- (PtFtObjectProcessQueue *)shiftQueue
{
    if ([_queueList count] == 0) {
        return nil;
    }
    PtFtObjectProcessQueue* queue = [_queueList objectAtIndex:0];
    [_queueList removeObjectAtIndex:0];
    return queue;
}

#pragma mark process

- (void)processQueue
{
    if ([_queueList count] == 0) {
        _processing = NO;
        return;
    }
    if (_canceled) {
        return;
    }
    _processing = YES;
    __block PtFtSharedQueueManager* _self = self;
    __block PtFtObjectProcessQueue* queue;
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            queue = [_self shiftQueue];
            if (queue) {
                switch (queue.type) {
                    case PtFtProcessQueueTypePreset:
                        [_self processQueueTypePreset:queue];
                        break;
                    case PtFtProcessQueueTypePreview:
                        [_self processQueueTypePreview:queue];
                        break;
                    case PtFtProcessQueueTypeOriginal:
                        [_self processQueueTypeOriginal:queue];
                        break;
                    default:
                        break;
                }
            }
        }
        dispatch_async(q_main, ^{
            if (_self.canceled) {
                return;
            }
            [_self didFinishProcessingQueue:queue];
        });
    });
}

- (void)processQueueTypePreset:(PtFtObjectProcessQueue *)queue
{
    if (queue.effectId == VnEffectIdNone) {
        return;
    }
    queue.image = [PtFtSharedFilterManager applyEffect:queue.effectId ToImage:queue.image WithOpacity:queue.opacity];
}

- (void)processQueueTypePreview:(PtFtObjectProcessQueue *)queue
{
    [self setStartAndEndFiltersWithQueue:queue];
    dispatch_queue_t q_main = dispatch_get_main_queue();
    __block __weak PtViewControllerFilters* _con = self.delegate;
    dispatch_async(q_main, ^{
        [_con.progressView setProgress:0.90f];
    });
    if (self.startFilter&&self.endFilter) {
        queue.image = [VnEffect processImage:queue.image WithStartFilter:self.startFilter EndFilter:self.endFilter];
    }
    self.startFilter = nil;
    self.endFilter = nil;
}

- (void)processQueueTypeOriginal:(PtFtObjectProcessQueue *)queue
{
    [self setStartAndEndFiltersWithQueue:queue];
    if (self.startFilter == nil) {
        return;
    }
    __block __weak PtViewControllerFilters* _con = self.delegate;
    dispatch_queue_t q_main = dispatch_get_main_queue();
    NSMutableArray* parts = self.delegate.originalImageParts;
    for (int i = 0; i < 9; i++) {
        @autoreleasepool {
            UIImage* image = [parts objectAtIndex:i];
            if (image) {
                image = [VnEffect processImage:image WithStartFilter:self.startFilter EndFilter:self.endFilter];
                [parts replaceObjectAtIndex:i withObject:image];
            }
        }
        dispatch_async(q_main, ^{
            [_con.progressView setProgress:0.10f + _con.progressView.progress];
        });
    }
    self.startFilter = nil;
    self.endFilter = nil;
}

- (void)setStartAndEndFiltersWithQueue:(PtFtObjectProcessQueue *)queue
{
    VnImageFilter* startFilter;
    VnImageFilter* endFilter;
    PtFtViewManagerFilters* fm = self.delegate.filtersManager;
    PtFtViewManagerSliders* sm = self.delegate.slidersManager;
    
    if (fm.currentColorButton) {
        PtFtButtonLayerBar* button = fm.currentColorButton;
        VnEffect* effect = [PtFtSharedFilterManager effectByEffectId:button.effectId];
        if (effect) {
            [effect makeFilterGroup];
            effect.imageSize = queue.image.size;
            VnFilterDuplicate* inputFilter = [[VnFilterDuplicate alloc] init];
            VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
            [inputFilter addTarget:blendFilter];
            [inputFilter addTarget:effect.startFilter];
            [effect.endFilter addTarget:blendFilter];
            blendFilter.topLayerOpacity = sm.colorOpacity;
            startFilter = inputFilter;
            endFilter = blendFilter;
            
        }
    }
    
    if (fm.currentArtisticButton) {
        PtFtButtonLayerBar* button = fm.currentArtisticButton;
        VnEffect* effect = [PtFtSharedFilterManager effectByEffectId:button.effectId];
        if (effect) {
            [effect makeFilterGroup];
            effect.imageSize = queue.image.size;
            if (startFilter) {
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [endFilter addTarget:blendFilter];
                [endFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter];
                blendFilter.topLayerOpacity = sm.artisticOpacity;
                endFilter = blendFilter;
            }else{
                VnFilterDuplicate* inputFilter = [[VnFilterDuplicate alloc] init];
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [inputFilter addTarget:blendFilter];
                [inputFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter];
                blendFilter.topLayerOpacity = sm.artisticOpacity;
                startFilter = inputFilter;
                endFilter = blendFilter;
            }
        }
    }
    
    if (fm.currentOverlayButton) {
        PtFtButtonLayerBar* button = fm.currentOverlayButton;
        VnEffect* effect = [PtFtSharedFilterManager effectByEffectId:button.effectId];
        if (effect) {
            [effect makeFilterGroup];
            effect.imageSize = queue.image.size;
            if (startFilter) {
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [endFilter addTarget:blendFilter];
                [endFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter];
                blendFilter.topLayerOpacity = sm.overlayOpacity;
                endFilter = blendFilter;
            }else{
                VnFilterDuplicate* inputFilter = [[VnFilterDuplicate alloc] init];
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [inputFilter addTarget:blendFilter];
                [inputFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter];
                blendFilter.topLayerOpacity = sm.overlayOpacity;
                startFilter = inputFilter;
                endFilter = blendFilter;
            }
        }
    }
    self.startFilter = startFilter;
    self.endFilter = endFilter;
}

- (void)didFinishProcessingQueue:(PtFtObjectProcessQueue *)queue
{
    [self.delegate queueDidFinished:queue];
    _processing = NO;
    if ([_queueList count] != 0) {
        if (self.canceled) {
            return;
        }
        [self processQueue];
    }
}

- (BOOL)canceled
{
    if (_canceled) {
        LOG(@"CANCELED!!!!");
    }
    return _canceled;
}


@end
