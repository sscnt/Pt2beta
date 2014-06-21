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
        _processing = NO;
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
                _self.processing = NO;
                return;
            }
            [_self didFinishProcessingQueue:queue];
        });
    });
}

- (void)processQueueTypePreset:(PtFtObjectProcessQueue *)queue
{
    VnEffectId eid = queue.effectId;
    if (queue.effectId == VnEffectIdNone) {
        return;
    }
    VnEffect* effect = [PtFtSharedFilterManager effectByEffectId:queue.effectId];
    if (effect) {
        queue.image = [PtFtSharedFilterManager applyEffect:queue.effectId ToImage:queue.image WithOpacity:effect.defaultOpacity];
    }
}

- (void)processQueueTypePreview:(PtFtObjectProcessQueue *)queue
{
    CGSize imageSize = queue.image.size;
    float tx = 1.0f;
    float ty = 1.0f;
    if (imageSize.width > imageSize.height) {
        tx = imageSize.width / imageSize.height;
    }
    if (imageSize.height > imageSize.width) {
        ty = imageSize.height / imageSize.width;
    }
    float rm = imageSize.width / [PtSharedApp instance].sizeOfImageToProcess.width;
    [self setStartAndEndFiltersWithQueue:queue Multipliers:CGPointMake(1.0f, 1.0f) Adding:CGPointMake(0.0f, 0.0f) ImageSize:imageSize Transform:CGPointMake(tx, ty) RadiusMultiplier:rm];
    dispatch_queue_t q_main = dispatch_get_main_queue();
    __block __weak PtViewControllerFilters* _con = self.delegate;
    dispatch_async(q_main, ^{
        [_con.progressView setProgress:0.60f];
    });
    if (self.startFilter && self.endFilter) {
        queue.image = [VnEffect processImage:queue.image WithStartFilter:self.startFilter EndFilter:self.endFilter];
    }
    self.startFilter = nil;
    self.endFilter = nil;
    dispatch_async(q_main, ^{
        [_con.progressView setProgress:0.80f];
    });
}

- (void)processQueueTypeOriginal:(PtFtObjectProcessQueue *)queue
{
    CGSize imageSize = [PtSharedApp instance].sizeOfImageToProcess;
    float tx = 1.0f;
    float ty = 1.0f;
    if (imageSize.width > imageSize.height) {
        tx = imageSize.width / imageSize.height;
    }
    if (imageSize.height > imageSize.width) {
        ty = imageSize.height / imageSize.width;
    }
    __block __weak PtViewControllerFilters* _con = self.delegate;
    dispatch_queue_t q_main = dispatch_get_main_queue();
    NSMutableArray* parts = self.delegate.originalImageParts;
    for (int i = 0; i < parts.count; i++) {
        @autoreleasepool {
            UIImage* image = [parts objectAtIndex:i];
            CGPoint mult = [PtUtilImage multiplierAtIndex:i];
            CGPoint add = [PtUtilImage addingAtIndex:i];
            [self setStartAndEndFiltersWithQueue:queue Multipliers:mult Adding:add ImageSize:imageSize Transform:CGPointMake(tx, ty) RadiusMultiplier:1.0f];
            if (self.startFilter == nil) {
                continue;
            }
            if (image) {
                image = [VnEffect processImage:image WithStartFilter:self.startFilter EndFilter:self.endFilter];
                [parts replaceObjectAtIndex:i withObject:image];
            }
        }
        dispatch_async(q_main, ^{
            [_con.progressView setProgress:1.0 / parts.count + _con.progressView.progress];
        });
        if ([PtSharedApp instance].sizeOfImageToProcess.width > 3500.0f || [PtSharedApp instance].sizeOfImageToProcess.height > 3500.0f) {
            [NSThread sleepForTimeInterval:0.25f];
        }
    }
    self.startFilter = nil;
    self.endFilter = nil;
}

- (void)setStartAndEndFiltersWithQueue:(PtFtObjectProcessQueue *)queue Multipliers:(CGPoint)mult Adding:(CGPoint)add ImageSize:(CGSize)imageSize Transform:(CGPoint)transform RadiusMultiplier:(float)radiusMultiplier
{
    VnImageFilter* startFilter;
    VnImageFilter* endFilter;
    PtFtViewManagerFilters* fm = self.delegate.filtersManager;
    PtFtViewManagerSliders* sm = self.delegate.slidersManager;
    
    if (fm.currentColorButton) {
        PtFtButtonLayerBar* button = fm.currentColorButton;
        VnEffect* effect = [PtFtSharedFilterManager effectByEffectId:button.effectId];
        if (effect) {
            effect.multiplierX = mult.x;
            effect.multiplierY = mult.y;
            effect.addingX = add.x;
            effect.addingY = add.y;
            effect.imageSize = imageSize;
            effect.transformX = transform.x;
            effect.transformY = transform.y;
            effect.radiusMultiplier = radiusMultiplier;
            [effect makeFilterGroup];
            VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
            VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
            [inputFilter addTarget:blendFilter];
            [inputFilter addTarget:effect.startFilter];
            [effect.endFilter addTarget:blendFilter atTextureLocation:1];
            blendFilter.topLayerOpacity = sm.colorOpacity;
            startFilter = inputFilter;
            endFilter = blendFilter;
            
        }
    }
    
    if (fm.currentArtisticButton) {
        PtFtButtonLayerBar* button = fm.currentArtisticButton;
        VnEffect* effect = [PtFtSharedFilterManager effectByEffectId:button.effectId];
        if (effect) {
            effect.multiplierX = mult.x;
            effect.multiplierY = mult.y;
            effect.addingX = add.x;
            effect.addingY = add.y;
            effect.imageSize = imageSize;
            effect.transformX = transform.x;
            effect.transformY = transform.y;
            effect.radiusMultiplier = radiusMultiplier;
            [effect makeFilterGroup];
            if (startFilter) {
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [endFilter addTarget:blendFilter];
                [endFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter];
                blendFilter.topLayerOpacity = sm.artisticOpacity;
                endFilter = blendFilter;
            }else{
                VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [inputFilter addTarget:blendFilter];
                [inputFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter atTextureLocation:1];
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
            effect.multiplierX = mult.x;
            effect.multiplierY = mult.y;
            effect.addingX = add.x;
            effect.addingY = add.y;
            effect.imageSize = imageSize;
            effect.transformX = transform.x;
            effect.transformY = transform.y;
            effect.radiusMultiplier = radiusMultiplier;
            [effect makeFilterGroup];
            if (startFilter) {
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [endFilter addTarget:blendFilter];
                [endFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter];
                blendFilter.topLayerOpacity = sm.overlayOpacity;
                endFilter = blendFilter;
            }else{
                VnFilterPassThrough* inputFilter = [[VnFilterPassThrough alloc] init];
                VnImageNormalBlendFilter* blendFilter = [[VnImageNormalBlendFilter alloc] init];
                [inputFilter addTarget:blendFilter];
                [inputFilter addTarget:effect.startFilter];
                [effect.endFilter addTarget:blendFilter atTextureLocation:1];
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
        [_queueList removeAllObjects];
    }
    return _canceled;
}


@end
