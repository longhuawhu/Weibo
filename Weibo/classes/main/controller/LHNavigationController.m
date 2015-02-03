//
//  LHNavigationController.m
//  Weibo
//
//  Created by lh on 15/2/3.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHNavigationController.h"
#import "UIImage+LH.h"
#import "public.h"

@implementation LHNavigationController

+(void)initialize
{
     //1.设置导航栏主题
    [self setupNavBarTheme];;
    
    [self setupBarButtonItemTheme];
    
}

+(void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    if (!iOS7) {
       
        [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_push"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackButtonBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
}

+(void)setupNavBarTheme
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    if(!iOS7){
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:18];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
    
}
@end
