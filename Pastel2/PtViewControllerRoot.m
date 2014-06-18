//
//  PtViewControllerRoot.m
//  Pastel2
//
//  Created by SSC on 2014/05/27.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "PtViewControllerRoot.h"
#import "AppDelegate.h"

@interface PtViewControllerRoot ()

@end

@implementation PtViewControllerRoot

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //スワイプによる戻るを無効にする(スワイプを少しして戻すとNavigationBarが存在しなくなる事象回避)
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    appdelegate.rootViewController = self;
    
    [self.navigationBar setHidden:YES];
    self.delegate = self;
    
    _lmCmViewController = [[LmCmViewController alloc] init];
    [self pushViewController:_lmCmViewController animated:NO];
}


#pragma mark application

- (void)applicationDidEnterBackground
{
    if([self.visibleViewController isKindOfClass:[LmCmViewController class]]){
        [self.lmCmViewController disableCamera];
    }
}

- (void)applicationWillEnterForeground
{
    if([self.visibleViewController isKindOfClass:[LmCmViewController class]]){
        [self.lmCmViewController enableCamera];
        [self.lmCmViewController loadLastPhoto];
    }
}

- (BOOL)shouldAutorotate
{
    //表示しているViewControllerにまかせる
    return [self.visibleViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    //表示しているViewControllerにまかせる
    return [self.visibleViewController supportedInterfaceOrientations];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
