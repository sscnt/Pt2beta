//
//  UISliderThumbVIew.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmCmViewSliderThumb : UIView
{
    CGFloat _radius;
}

@property (nonatomic, assign) BOOL locked;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, strong) UIColor* strokeColor;

- (id)initWithRadius:(CGFloat)radius;

@end
