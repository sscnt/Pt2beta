//
//  ShareOtherAppViewController.m
//  Pastel
//
//  Created by SSC on 2014/05/13.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "ShareOtherAppViewController.h"

@implementation ShareOtherAppViewController

- (void)viewDidAppear:(BOOL)animated
{
    self.interactionController = [UIDocumentInteractionController interactionControllerWithURL:[PtSharedApp originalImageUrl]];
    self.interactionController.delegate = self;
    
    BOOL isValid;
    isValid = [self.interactionController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
    if (!isValid) {
        NSLog(@"データを開けるアプリケーションが見つかりません。");
        [self closeView];
    }
}

- (void)closeView
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    self.interactionController.delegate = nil;
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
        willBeginSendingToApplication:(NSString *)application
{
    
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
           didEndSendingToApplication:(NSString *)application
{
    [self closeView];
}

- (void) documentInteractionControllerDidDismissOpenInMenu: (UIDocumentInteractionController *) controller
{
    // キャンセルで閉じたとき
    [self closeView];
}

@end
