//
//  LHTabBar.m
//  Weibo
//
//  Created by lh on 15/2/2.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHTabBar.h"
#import "LHTabBarButton.h"
#import "public.h"

@interface LHTabBar()
@property (nonatomic, weak) UIButton *selectedBtn;
@end

@implementation LHTabBar
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
             self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        }
       
    }
    return self;
}


-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    LHTabBarButton *btn = [[LHTabBarButton alloc] init];
    
    btn.item = item;
    
    [self addSubview:btn];
        
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.subviews.count == 1) {
        [self btnClick:btn];
    }
}

-(void)btnClick:(UIButton*)btn
{
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)])
    {
        [self.delegate tabBar:self didSelectedItemFrom:self.selectedBtn.tag to:btn.tag];
    }
    
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width/self.subviews.count;
    CGFloat btnY = 0;
    CGFloat btnX = 0;
    
    for (int index = 0; index < self.subviews.count; ++index) {
        btnX = index*btnW;
        UIButton *btn = self.subviews[index];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = index;
    }
}
@end
