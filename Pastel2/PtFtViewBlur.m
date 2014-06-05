//
//  PtFtViewBlur.m
//  Pastel2
//
//  Created by SSC on 2014/06/02.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewBlur.h"

@implementation PtFtViewBlur

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setIsBlurred:(BOOL)isBlurred
{
    if (isBlurred) {
        if ([UIDevice isIOS6]) {
            self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.50f];
        }else{
            if (_toolBar == nil) {
                _toolBar = [[UIToolbar alloc] initWithFrame:self.bounds];
                _toolBar.barStyle = UIBarStyleBlackTranslucent;
                [self addSubview:_toolBar];
            }
            [_toolBar setHidden:NO];
        }
    }else{
        if ([UIDevice isIOS6]) {
            self.backgroundColor = [UIColor clearColor];
        }else{
            [_toolBar setHidden:YES];
        }
    }
}

@end
