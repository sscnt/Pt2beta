//
//  PtFtSharedQueueManagerAdjustment.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdSharedQueueManager.h"
#import "PtEdViewControllerAdjustment.h"

@implementation PtAdSharedQueueManager

static PtAdSharedQueueManager* sharedPtAdSharedQueueManager = nil;

+ (PtAdSharedQueueManager*)instance {
	@synchronized(self) {
		if (sharedPtAdSharedQueueManager == nil) {
			sharedPtAdSharedQueueManager = [[self alloc] init];
		}
	}
	return sharedPtAdSharedQueueManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedPtAdSharedQueueManager == nil) {
			sharedPtAdSharedQueueManager = [super allocWithZone:zone];
			return sharedPtAdSharedQueueManager;
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

- (void)addQueue:(PtAdObjectProcessQueue *)queue
{
    [_queueList addObject:queue];
    if (_processing == NO) {
        [self processQueue];
    }
}

- (PtAdObjectProcessQueue *)shiftQueue
{
    if ([_queueList count] == 0) {
        return nil;
    }
    PtAdObjectProcessQueue* queue = [_queueList objectAtIndex:0];
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
    __block PtAdSharedQueueManager* _self = self;
    __block PtAdObjectProcessQueue* queue;
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            queue = [_self shiftQueue];
            if (queue) {
                switch (queue.type) {
                    case PtAdProcessQueueTypePreview:
                        [_self processQueueTypePreview:queue];
                        break;
                    case PtAdProcessQueueTypeOriginal:
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

- (void)processQueueTypePreview:(PtAdObjectProcessQueue *)queue
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
    dispatch_queue_t q_main = dispatch_get_main_queue();
    __block __weak PtEdViewControllerAdjustment* _con = self.delegate;
    dispatch_async(q_main, ^{
        [_con.progressView setProgress:0.60f];
    });

    //// Process
    [self setAdjustmentFilterWithQueue:queue];
    
    if (self.startFilter) {
        queue.image = [VnEffect processImage:queue.image WithStartFilter:self.startFilter EndFilter:self.endFilter];
    }

    dispatch_async(q_main, ^{
        [_con.progressView setProgress:0.80f];
    });
    self.startFilter = self.endFilter = nil;
}

- (void)processQueueTypeOriginal:(PtAdObjectProcessQueue *)queue
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
    __block __weak PtEdViewControllerAdjustment* _con = self.delegate;
    dispatch_queue_t q_main = dispatch_get_main_queue();
    NSMutableArray* parts = self.delegate.originalImageParts;
    for (int i = 0; i < parts.count; i++) {
        @autoreleasepool {
            UIImage* image = [parts objectAtIndex:i];
            CGPoint mult = [PtUtilImage multiplierAtIndex:i];
            CGPoint add = [PtUtilImage addingAtIndex:i];
            if (image) {
                //// Process
                [self setAdjustmentFilterWithQueue:queue];
                if (self.startFilter) {
                    image = [VnEffect processImage:image WithStartFilter:self.startFilter EndFilter:self.endFilter];
                }
                
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
}

- (void)didFinishProcessingQueue:(PtAdObjectProcessQueue *)queue
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

- (void)setAdjustmentFilterWithQueue:(PtAdObjectProcessQueue *)queue
{
    switch (queue.adjustmentType) {
        case PtAdProcessQueueAdjustmentTypeBrightness:
        {
            VnFilterLevels* filter = [[VnFilterLevels alloc] init];
            float gamma;
            //// -1.0 <-> +1.0
            if (queue.strength < 0.0) {
                gamma = 1.0 + 0.445 * queue.strength;
            }else{
                gamma = queue.strength * 0.899 + 1.0;
            }
            [filter setMin:0.0f gamma:gamma max:1.0];
                        
            self.startFilter = filter;
            self.endFilter = filter;
            
        }
            
        default:
            break;
    }
}


@end
