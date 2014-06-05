//
//  UIView+Gravy.m
//  Gravy_1.0
//
//  Created by SSC on 2013/10/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIView+extend.h"

@implementation UIView (extend)

+ (float)angleByDeviceOrientation:(UIDeviceOrientation)orientation
{
    switch (orientation) {
        case UIDeviceOrientationFaceUp:
            break;
        case UIDeviceOrientationUnknown:
            break;
        case UIDeviceOrientationFaceDown:
            break;
        case UIDeviceOrientationPortrait:
            break;
        case UIDeviceOrientationLandscapeLeft:
            return M_PI/2.0f;
            break;
        case UIDeviceOrientationLandscapeRight:
            return -M_PI/2.0f;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            return M_PI;
            break;
        default:
            break;
    }
    return 0.0f;
}

- (float)height
{
    return self.bounds.size.height;
}

- (float)width
{
    return self.bounds.size.width;
}

-(float)bottom
{
    return self.frame.origin.y + self.bounds.size.height;
}
-(float)right
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setShadow
{
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0 + 1.0, 0 + 4.0, self.frame.size.width, self.frame.size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6.0, 6.0)];
    [roundedRectanglePath closePath];
    
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:1.0].CGColor;
    self.layer.shadowPath = [roundedRectanglePath CGPath];
    self.layer.shadowRadius = 1.5;
    self.layer.shadowOpacity = 0.15;
}

-(void)setX:(float)x
{
    self.frame = CGRectMake( x, self.frame.origin.y, self.frame.size.width, self.frame.size.height );
}

- (void)setY:(float)y
{
    self.frame = CGRectMake( self.frame.origin.x, y, self.frame.size.width, self.frame.size.height );
}
- (void)setCenterX:(float)x
{
    self.center = CGPointMake(x, self.center.y);
}

-(void) setCenterY:(float)y
{
    self.center = CGPointMake(self.center.x, y);
}

- (void)setWidth:(float)width
{
    self.frame = CGRectMake( self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height );
}

- (void)setHeight:(float)height
{
    self.frame = CGRectMake( self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height );
}

- (void)setOrigin:(CGPoint)point
{
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (void)setViewSizeHalf:(UIView*)view
{
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width/2, view.frame.size.height/2);
}

- (UIImage *) imageByRenderingViewOpaque:(BOOL)opaque Rect:(CGRect)rect {
    UIImage *capture;
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    capture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capture;
}

- (UIImage *) imageByRenderingView{
    return [self imageByRenderingViewOpaque:NO Rect:self.bounds];
}

- (UIImage *) imageByRenderingViewWithRect:(CGRect)rect{
    return [self imageByRenderingViewOpaque:NO Rect:rect];
}

@end
