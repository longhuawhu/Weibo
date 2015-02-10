//
//  LHRetweetView.h
//  Weibo
//
//  Created by lh on 15/2/10.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  LHStatusFrame;

@interface LHRetweetView : UIImageView

@property (nonatomic, weak) UILabel *retweetNameLable;

@property (nonatomic, weak) UILabel *retweetContentLable;

@property (nonatomic, weak) UIImageView *retweetPhotoView;

@property (nonatomic, strong)LHStatusFrame *statusFrame;

@end
