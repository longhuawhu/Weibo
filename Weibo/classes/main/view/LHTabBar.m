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
#import "UIImage+LH.h"

@interface LHTabBar()
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIButton *plusBtn;
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@end

@implementation LHTabBar
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
             self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        }
        
        UIButton *plusButton = [[UIButton alloc] init];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [plusButton addTarget:self action:@selector(plusBtnClicked) forControlEvents:UIControlEventTouchDown];
        
        self.plusBtn = plusButton;
        [self addSubview:plusButton];
       
    }
    return self;
}

-(NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    
    return  _tabBarButtons;
}

-(void)plusBtnClicked
{
    if([self.delegate respondsToSelector:@selector(tabbarDidClickedPlusBtn:)]){
        [self.delegate tabbarDidClickedPlusBtn:self];
    }
}

-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    LHTabBarButton *btn = [[LHTabBarButton alloc] init];
    
    btn.item = item;
    
    [self addSubview:btn];
    [self.tabBarButtons addObject:btn];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.tabBarButtons.count == 1) {
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
    
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.plusBtn.center = CGPointMake(w*0.5, h*0.5);
    
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width/self.subviews.count;
    CGFloat btnY = 0;
    CGFloat btnX = 0;
    
    for (int index = 0; index < self.tabBarButtons.count; ++index) {
        btnX = index*btnW;
        if (index > 1) {
            btnX += btnW;
        }
        UIButton *btn = self.tabBarButtons[index];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.tag = index;
    }
}
@end
