//
//  LHNewfeatureViewController.m
//  Weibo
//
//  Created by lh on 15/2/3.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHNewfeatureViewController.h"
#import "LHTabBarController.h"

#define LHNewfeatureImageCount 3

@interface LHNewfeatureViewController()
@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation LHNewfeatureViewController 

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImageView *background = [[UIImageView alloc] init];
//    background.image = [UIImage imageNamed:@"new_feature_background"];
//    background.frame = self.view.bounds;
//    [self.view addSubview:background];
   //
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    [self setupScrollView];
    
    [self setupPageControl];
   
}

-(void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = LHNewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width*0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:pageControl];
    
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    
    self.pageControl = pageControl;
}

-(void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < LHNewfeatureImageCount; ++index) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        imageView.image = [UIImage imageNamed:name];
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        
        if (index == LHNewfeatureImageCount -1) {
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageW * 3, imageH);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    scrollView.bounces = NO;
    
    scrollView.delegate = self;
}

-(void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"]forState:UIControlStateHighlighted];
    
    CGFloat centerX = imageView.frame.size.width*.5;
    CGFloat centerY = imageView.frame.size.height*.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    UIButton *checkbox = [[UIButton alloc] init];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    CGFloat checkboxX = centerX;
    CGFloat checkboxY = centerY - 50;
    checkbox.center = CGPointMake(checkboxX, checkboxY);
    checkbox.bounds = startButton.bounds;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [checkbox addTarget:self action:@selector(clickCheckbox:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkbox];
    
}

-(void)start
{
    self.view.window.rootViewController = [[LHTabBarController alloc] init];
}


-(void)dealloc
{
    NSLog(@"-------");
}
-(void)clickCheckbox:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.selected;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    self.pageControl.currentPage = (int)(0.5 + offsetX/scrollView.frame.size.width);
}


@end
