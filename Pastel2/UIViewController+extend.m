//
//  UIViewController+extend.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIViewController+extend.h"

@implementation UIViewController (extend)

- (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}

@end
