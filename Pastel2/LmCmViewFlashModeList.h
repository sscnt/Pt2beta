//
//  LmCmViewFlashModeList.h
//  Lumina
//
//  Created by SSC on 2014/05/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmButtonFlashModeItem.h"

@protocol LmCmViewFlashModeListDelegate <NSObject>

- (void)flashModeDidSelect:(LmCmViewBarButtonFlashMode)mode;

@end

@interface LmCmViewFlashModeList : UIView

@property (nonatomic, weak) id<LmCmViewFlashModeListDelegate> delegate;
@property (nonatomic, assign) LmCmViewBarButtonFlashMode currentMode;
@property (nonatomic, strong) LmCmButtonFlashModeItem* onButton;
@property (nonatomic, strong) LmCmButtonFlashModeItem* offButton;
@property (nonatomic, strong) LmCmButtonFlashModeItem* autoButton;

- (void)didSelectMode:(LmCmButtonFlashModeItem*)item;
- (void)layoutButtons;

@end
