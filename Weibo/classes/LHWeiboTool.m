//
//  LHWeiboTool.m
//  Weibo
//
//  Created by lh on 15/2/5.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHWeiboTool.h"
#import "LHTabBarController.h"
#import "LHNewfeatureViewController.h"


@implementation LHWeiboTool

+(void) chooseRootController
{
    //从沙盒中取出存储的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:@"lastVersion"];
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    if ([lastVersion isEqualToString:currentVersion]) {
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LHTabBarController alloc] init];
    }
    else
    {
        //application.statusBarHidden = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[LHNewfeatureViewController alloc] init];
        [defaults setObject:currentVersion forKey:@"lastVersion"];
        [defaults synchronize];
    }

}

@end
