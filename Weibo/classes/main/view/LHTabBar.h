//
//  LHTabBar.h
//  Weibo
//
//  Created by lh on 15/2/2.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHTabBar;
@protocol LHTabBarDelegate <NSObject>

@optional
-(void)tabBar:(LHTabBar *)tabBar didSelectedItemFrom:(int)from to:(int)to;

@end

@interface LHTabBar : UIView
-(void)addTabBarButtonWithItem:(UITabBarItem *)item;
@property (nonatomic, weak) id<LHTabBarDelegate> delegate;
@end
