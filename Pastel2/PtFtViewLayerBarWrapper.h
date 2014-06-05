//
//  VnViewEditorLayerBarWrapper.h
//  Pastel
//
//  Created by SSC on 2014/05/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PtFtViewLayerBar.h"
#import "PtFtViewSlider.h"

@protocol PtFtViewLayerBarWrapperDelegate
- (void)wrapperDidSlideUp;
- (void)wrapperDidSlideDown;
@end

@interface PtFtViewLayerBarWrapper : UIView

@property (nonatomic, strong) UIView* view;
@property (nonatomic, weak) PtFtViewLayerBar* bar;
@property (nonatomic, weak) PtFtViewSlider* layerSlider;
@property (nonatomic, assign) BOOL sliding;
@property (nonatomic, weak) id<PtFtViewLayerBarWrapperDelegate> delegate;

- (void)slideUp;
- (void)slideDown;

@end
