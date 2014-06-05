//
//  PtViewImagePreview.m
//  Pastel2
//
//  Created by SSC on 2014/05/31.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtEdViewImagePreview.h"

@implementation PtEdViewImagePreview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        _scrollView = [[PtEdViewImagePreviewScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    if (image == nil) {
        _image = nil;
        return;
    }
    _image = image;
    
    _scrollView.delegate = self;
    _scrollView.contentSize = image.size;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delaysContentTouches = NO;
    _scrollView.bounces = YES;
    _scrollView.maximumZoomScale = 1.0f;
    _scrollView.minimumZoomScale = MIN(1.0, MIN(self.width / image.size.width, self.height / image.size.height));
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)];
    _imageView.center = CGPointMake(MAX(_scrollView.contentSize.width, self.width) / 2.0f, _imageView.center.y);
    _imageView.image = image;
    [_scrollView addSubview:_imageView];
    [self addSubview:_scrollView];
    
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:NO];
}

#pragma mark delegate

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat y = MAX(0.0f, self.frame.size.height - scrollView.contentSize.height);
    CGFloat x = MAX(0.0f, self.frame.size.width - scrollView.contentSize.width);
    [scrollView setX:x / 2.0f];
    [scrollView setY:y / 2.0f];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}
- (void)dealloc
{
    LOG(@"Preview dealloc.");
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
