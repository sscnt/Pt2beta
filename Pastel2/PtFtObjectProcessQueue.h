//
//  PtFtProcessQueue.h
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PtFtProcessQueueType){
    PtFtProcessQueueTypePreset = 1,
    PtFtProcessQueueTypePreview,
    PtFtProcessQueueTypeOriginal
};

@interface PtFtObjectProcessQueue : NSObject

@property (nonatomic, assign) PtFtProcessQueueType type;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) VnEffectId effectId;
@property (nonatomic, assign) float opacity;

@end
