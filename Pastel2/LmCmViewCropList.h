//
//  LmCmViewCropList.h
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmButtonCropListItem.h"

@protocol LmCmViewCropListDelegate <NSObject>

- (void)cropSizeSelected:(LmCmViewCropSize)size;

@end

@interface LmCmViewCropList : UIView

@property (nonatomic, weak) id<LmCmViewCropListDelegate> delegate;
@property (nonatomic, assign) LmCmViewCropSize currentSize;

- (void)didSelectSize:(LmCmButtonCropListItem*)item;
- (void)clearAllButtonSelection;

@end
