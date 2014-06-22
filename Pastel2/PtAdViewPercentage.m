//
//  PtAdViewPercentage.m
//  Pastel2
//
//  Created by SSC on 2014/06/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtAdViewPercentage.h"

@implementation PtAdViewPercentage

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [PtAdConfig percentageBarBgColor];
        _percentageLabel = [[VnViewLabel alloc] initWithFrame:self.bounds];
        [self addSubview:_percentageLabel];
    }
    return self;
}

- (void)setPercentage:(float)percentage
{
    if (percentage < 0.0f) {
        _percentageLabel.text = [NSString stringWithFormat:@"-%d", (int)(-percentage)];
    }else{
        _percentageLabel.text = [NSString stringWithFormat:@"+%d", (int)(percentage)];        
    }
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
