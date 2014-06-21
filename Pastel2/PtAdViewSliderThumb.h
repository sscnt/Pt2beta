//
//  PtAdViewSliderThumb.h
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PtAdViewSliderThumb : UIView
{
    CGFloat _radius;
}

@property (nonatomic, assign) BOOL locked;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, strong) UIColor* strokeColor;

- (id)initWithRadius:(CGFloat)radius;


@end
