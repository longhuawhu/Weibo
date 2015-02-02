//
//  LHTabBarController.m
//  Weibo
//
//  Created by lh on 15/2/2.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHTabBarController.h"
#import "LHHomeTableViewController.h"
#import "LHMessageTableViewController.h"
#import "LHDiscoverTableViewController.h"
#import "LHWeTableViewController.h"

@interface LHTabBarController ()

@end

@implementation LHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.初始化所有的子控制器
    LHHomeTableViewController *home = [[LHHomeTableViewController alloc] init];
    home.view.backgroundColor = [UIColor redColor];
    
    home.title = @"home";  //可以同时设置下面两个属性
   // home.tabBarItem.title = @"home";
   // home.navigationItem.title = @"home";
    
    home.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    home.tabBarItem.selectedImage =[[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *homenav = [[UINavigationController alloc] initWithRootViewController:home];
    [self addChildViewController:homenav];
    
    LHMessageTableViewController *message = [[LHMessageTableViewController alloc] init];
    message.view.backgroundColor = [UIColor redColor];
    message.title = @"消息";
    message.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    message.tabBarItem.selectedImage =[[UIImage imageNamed:@"tabbar_message_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *messagenav = [[UINavigationController alloc] initWithRootViewController:message];

    [self addChildViewController:messagenav];
    
    LHDiscoverTableViewController *discover = [[LHDiscoverTableViewController alloc] init];
    discover.view.backgroundColor = [UIColor redColor];
    discover.title = @"广场";
    discover.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    discover.tabBarItem.selectedImage =[[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *discvernav = [[UINavigationController alloc] initWithRootViewController:discover];

    [self addChildViewController:discvernav];
    
    LHWeTableViewController *me = [[LHWeTableViewController alloc] init];
    me.view.backgroundColor = [UIColor redColor];
    me.title = @"我";
    me.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    me.tabBarItem.selectedImage =[[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *menav = [[UINavigationController alloc] initWithRootViewController:me];

    [self addChildViewController:menav];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
