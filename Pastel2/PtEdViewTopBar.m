//
//  PtViewTopBar.m
//  Pastel2
//
//  Created by SSC on 2014/05/30.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewTopBar.h"

@implementation PtEdViewTopBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PtEdConfig topBarColor];
    }
    return self;
}

- (void)addCamerarollButton:(PtEdViewBarButton *)button
{
    float x = button.width / 2.0f * 1.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}
- (void)addInstagramButton:(PtEdViewBarButton *)button
{
    float x = button.width / 2.0f * 3.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}
- (void)addTwitterButton:(PtEdViewBarButton *)button
{
    float x = button.width / 2.0f * 5.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}
- (void)addFacebookButton:(PtEdViewBarButton *)button
{
    float x = button.width / 2.0f * 7.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}
- (void)addOtherButton:(PtEdViewBarButton *)button
{
    float x = button.width / 2.0f * 9.0f;
    button.center = CGPointMake(x, self.height / 2.0f);
    [self addSubview:button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
