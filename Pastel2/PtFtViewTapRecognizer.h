//
//  PtFtViewTapRecognizer.h
//  Pastel2
//
//  Created by SSC on 2014/06/10.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PtFtViewTapRecognizerDelegate <NSObject>
- (void)tapRecognizerDidTouchDown;
- (void)tapRecognizerDidTouchUp;
@end

@interface PtFtViewTapRecognizer : UIView

@property (nonatomic, weak) id<PtFtViewTapRecognizerDelegate> delegate;

@end
