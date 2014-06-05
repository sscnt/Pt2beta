//
//  LmCmViewCropBlackRect.h
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmCmViewCropBlackRect : UIView
{
    UIDeviceOrientation _orientation;
    LmCmViewCropSize _cropSize;
}

- (void)setRectWithCropSize:(LmCmViewCropSize)size;

@end
