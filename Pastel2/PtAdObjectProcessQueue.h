//
//  PtAdObjectProcessQueue.h
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PtAdProcessQueueType){
    PtAdProcessQueueTypePreview = 1,
    PtAdProcessQueueTypeOriginal
};

typedef NS_ENUM(NSInteger, PtAdProcessQueueAdjustmentType){
    PtAdProcessQueueAdjustmentTypeBrightness = 1
};


@interface PtAdObjectProcessQueue : NSObject

@property (nonatomic, assign) PtAdProcessQueueType type;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) PtAdProcessQueueAdjustmentType adjustmentType;
@property (nonatomic, assign) float opacity;
@property (nonatomic, assign) float strength;
@property (nonatomic, assign) float radiusMultiplier;


@end
