//
//  UIScreen+Gravy.m
//  Gravy_1.0
//
//  Created by SSC on 2013/10/14.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIScreen+extend.h"

@implementation UIScreen (extend)

+ (CGSize)screenSize
{
    CGSize size = [[self mainScreen] bounds].size;
    if ([UIDevice isiPad]) {
        size = CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
    }
    return size;
}

+ (CGRect)screenRect
{
    return CGRectMake([[self mainScreen] bounds].origin.x, [[self mainScreen] bounds].origin.y, [[self mainScreen] bounds].size.width, [[self mainScreen] bounds].size.height);
}
+ (CGFloat)height
{
    return [self screenSize].height;
}
+(CGFloat)width
{
    return [self screenSize].width;
}
+ (UIImage *)screenCapture:(UIView *)view {
    UIImage *capture;
    UIGraphicsBeginImageContextWithOptions(view.frame.size , NO , 1.0 );
    
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    } else {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    capture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capture;
}

+ (UIImage *)screenCaptureWithView:(UIView *)view rect:(CGRect)rect{
    UIImage *capture;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    if ([view respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [view drawViewHierarchyInRect:view.frame afterScreenUpdates:YES];
    } else {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    capture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capture;
}

@end
