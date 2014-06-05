//
//  PtFtSharedQueueManager.h
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PtFtObjectProcessQueue.h"
#import "VnImageFilter.h"
#import "VnImageNormalBlendFilter.h"

@class PtViewControllerFilters;

@protocol PtFtSharedQueueManagerDelegate
- (void)queueDidFinished:(PtFtObjectProcessQueue*)queue;
- (void)dispatchPreviewprogress:(float)progress;
@end

@interface PtFtSharedQueueManager : NSObject
{
    NSMutableArray* _queueList;
}

@property (nonatomic, weak) PtViewControllerFilters<PtFtSharedQueueManagerDelegate>* delegate;
@property (nonatomic, assign) BOOL processing;
@property (nonatomic, assign) BOOL canceled;
@property (nonatomic, weak) UIImage* originalImage;
@property (nonatomic, weak) UIImage* previewImage;
@property (nonatomic, weak) UIImage* presetImage;
@property (nonatomic, strong) VnImageFilter* startFilter;
@property (nonatomic, strong) VnImageFilter* endFilter;

+ (PtFtSharedQueueManager*)instance;

- (PtFtObjectProcessQueue*)shiftQueue;
- (void)addQueue:(PtFtObjectProcessQueue*)queue;

- (void)processQueue;
- (void)processQueueTypePreset:(PtFtObjectProcessQueue*)queue;
- (void)processQueueTypePreview:(PtFtObjectProcessQueue*)queue;
- (void)processQueueTypeOriginal:(PtFtObjectProcessQueue*)queue;

- (void)didFinishProcessingQueue:(PtFtObjectProcessQueue*)queue;

- (void)setStartAndEndFiltersWithQueue:(PtFtObjectProcessQueue*)queue;
- (void)commonInit;
- (void)cancelAllQueue;

@end
