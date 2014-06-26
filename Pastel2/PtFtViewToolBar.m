//
//  PtFtViewToolBar.m
//  Pastel2
//
//  Created by SSC on 2014/06/25.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewToolBar.h"

@implementation PtFtViewToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [PtFtConfig toolBarBgColor];
    }
    return self;
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
