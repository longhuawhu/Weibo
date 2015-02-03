//
//  LHNewfeatureViewController.m
//  Weibo
//
//  Created by lh on 15/2/3.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHNewfeatureViewController.h"

@implementation LHNewfeatureViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIImageView *background = [[UIImageView alloc] init];
//    background.image = [UIImage imageNamed:@"new_feature_background"];
//    background.frame = self.view.bounds;
//    [self.view addSubview:background];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index < 3; ++index) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        imageView.image = [UIImage imageNamed:name];
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
    }
    
    scrollView.contentSize = CGSizeMake(imageW * 3, imageH);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    scrollView.bounces = NO;
}
@end
