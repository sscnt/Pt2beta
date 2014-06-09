//
//  PtFtViewTapRecognizer.m
//  Pastel2
//
//  Created by SSC on 2014/06/10.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewTapRecognizer.h"

@implementation PtFtViewTapRecognizer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate tapRecognizerDidTouchDown];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate tapRecognizerDidTouchUp];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate tapRecognizerDidTouchUp];
}

@end
