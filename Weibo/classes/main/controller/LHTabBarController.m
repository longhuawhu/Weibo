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
#import "UIImage+LH.h"

#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@interface LHTabBarController ()

@end

@implementation LHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.初始化所有的子控制器
    [self setupAllChildViewController];
    
}
-(void)setupAllChildViewController
{
    LHHomeTableViewController *home = [[LHHomeTableViewController alloc] init];
    [self setupChildViewController:home title:@"home" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    LHMessageTableViewController *message = [[LHMessageTableViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    LHDiscoverTableViewController *discover = [[LHDiscoverTableViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover"selectedImageName:@"tabbar_discover_selected"];
    
    LHWeTableViewController *me = [[LHWeTableViewController alloc] init];
    [self setupChildViewController:me title: @"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];

}

-(void) setupChildViewController:(UIViewController *) childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;  //可以同时设置下面两个属性
    // home.tabBarItem.title = @"home";
    // home.navigationItem.title = @"home";
    if (iOS7) {
        childVc.tabBarItem.selectedImage =[[UIImage imageWithName:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else{
        childVc.tabBarItem.selectedImage =[UIImage imageNamed:selectedImageName];
    }
    
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
   
    UINavigationController *childVcnav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:childVcnav];
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
