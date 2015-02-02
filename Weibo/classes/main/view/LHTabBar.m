//
//  LHTabBar.m
//  Weibo
//
//  Created by lh on 15/2/2.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHTabBar.h"

@interface LHTabBar()
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation LHTabBar
//-(id) initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//       // <#statements#>
//    }
//    return self;
//}


-(void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    UIButton *btn = [[UIButton alloc] init];
    
    [self addSubview:btn];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setImage:item.image forState:UIControlStateNormal];
    [btn setImage:item.selectedImage forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
}

-(void)btnClick:(UIButton*)btn
{
    btn.selected = YES;
    self.selectedBtn.selected = NO;
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
