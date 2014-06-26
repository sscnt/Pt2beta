//
//  PtFtViewBarWrapper.m
//  Pastel2
//
//  Created by SSC on 2014/06/01.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtFtViewBarWrapper.h"

@implementation PtFtViewBarWrapper


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addToolBar:(PtFtViewToolBar *)bar
{
    [bar setY:0.0f];
    [self addSubview:bar];
}

- (void)addOverlayBar:(PtFtViewLayerBar *)bar
{
    [bar setY:[PtFtConfig toolBarHeight]];
    [self addSubview:bar];
}

- (void)addColorBar:(PtFtViewLayerBar *)bar
{
    [bar setY:[PtFtConfig toolBarHeight] + [PtFtConfig overlayBarHeight] + [PtFtConfig artisticBarHeight]];
    [self addSubview:bar];
}

- (void)addArtisticBar:(PtFtViewLayerBar *)bar
{
    
    [bar setY:[PtFtConfig toolBarHeight] + [PtFtConfig overlayBarHeight]];
    [self addSubview:bar];
}

@end
