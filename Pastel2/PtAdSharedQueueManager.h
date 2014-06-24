//
//  PtFtSharedQueueManagerAdjustment.h
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtAdObjectProcessQueue.h"
#import "VnImageFilter.h"
#import "VnImageNormalBlendFilter.h"
#import "VnFilterPassThrough.h"

#import "VnFilterLevels.h"
#import "VnFilterGammaCorection.h"
#import "VnAdjustmentLayerKelvin.h"
#import "VnFilterShadows.h"

@class PtAdViewController;

@protocol PtAdSharedQueueManagerDelegate
- (void)queueDidFinished:(PtAdObjectProcessQueue*)queue;
- (void)dispatchPreviewprogress:(float)progress;
@end

@interface PtAdSharedQueueManager : NSObject
{
    NSMutableArray* _queueList;
}

@property (nonatomic, weak) PtAdViewController<PtAdSharedQueueManagerDelegate>* delegate;
@property (nonatomic, assign) BOOL processing;
@property (nonatomic, assign) BOOL canceled;
@property (nonatomic, weak) UIImage* originalImage;
@property (nonatomic, weak) UIImage* previewImage;
@property (nonatomic, strong) VnImageFilter* startFilter;
@property (nonatomic, strong) VnImageFilter* endFilter;


+ (PtAdSharedQueueManager*)instance;

- (PtAdObjectProcessQueue*)shiftQueue;
- (void)addQueue:(PtAdObjectProcessQueue*)queue;

- (void)processQueue;
- (void)processQueueTypePreview:(PtAdObjectProcessQueue*)queue;
- (void)processQueueTypeOriginal:(PtAdObjectProcessQueue*)queue;

- (void)didFinishProcessingQueue:(PtAdObjectProcessQueue*)queue;
- (void)cancelAllQueue;
- (void)commonInit;

- (void)setAdjustmentFilterWithQueue:(PtAdObjectProcessQueue*)queue;

@end
