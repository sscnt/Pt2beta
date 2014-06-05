//
//  PtFtViewNavigationBar.m
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewNavigationBar.h"

@implementation PtFtViewNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [PtSharedApp bottomNavigationBarBgColor];
        _titleLabel = [[VnViewLabel alloc] initWithFrame:self.bounds];
        _titleLabel.fontSize = 18.0f;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)addDoneButton:(PtFtButtonNavigation *)button
{
    
    button.center = CGPointMake(self.width - button.width / 2.0f, self.height / 2.0f);
    [self addSubview:button];
}

- (void)addCancelButton:(PtFtButtonNavigation *)button
{
    button.center = CGPointMake(button.width / 2.0f, self.height / 2.0f);
    [self addSubview:button];
}

@end
