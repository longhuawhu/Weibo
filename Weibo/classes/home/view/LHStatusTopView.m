//
//  LHStatusTopView.m
//  Weibo
//
//  Created by lh on 15/2/10.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHStatusTopView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LH.h"
#import "public.h"
#import "LHRetweetView.h"
#import "LHUser.h"
#import "LHStatuses.h"
#import "LHStatusFrame.h"

@interface LHStatusTopView()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UIImageView *vipView;

@property (nonatomic, weak) UIImageView *photoView;

@property (nonatomic, weak) UILabel *nameLable;

@property (nonatomic, weak) UILabel *timeLable;

@property (nonatomic, weak) UILabel *contentLable;

@property (nonatomic, weak) UILabel *sourceLable;

@property (nonatomic, weak) LHRetweetView *retweetView;


@end

@implementation LHStatusTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_top_background_highlighted"];
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        
        UIImageView *photoView = [[UIImageView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = LHStatusNameFont;
        nameLabel.textColor = [UIColor colorWithRed:225/255.0 green:135/255.0 blue:85/255.0 alpha:1.0];
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLable = nameLabel;
        
        UILabel *contentLable = [[UILabel alloc] init];
        contentLable.font = LHStatusNameFont;
        contentLable.backgroundColor = [UIColor clearColor];
        contentLable.numberOfLines = 0;//设置自动换行
        [self addSubview:contentLable];
        self.contentLable = contentLable;
        
        UILabel *sourceLable = [[UILabel alloc] init];
        sourceLable.font = LHStatusSourceFont;
        sourceLable.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLable];
        self.sourceLable = sourceLable;
        
        
        UILabel *timeLable = [[UILabel alloc] init];
        timeLable.font = LHStatusTimeFont;
        timeLable.textColor = [UIColor colorWithRed:225/255.0 green:135/255.0 blue:85/255.0 alpha:1.0];
        timeLable.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLable];
        self.timeLable = timeLable;
        
        LHRetweetView *retweetView = [[LHRetweetView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
        
    }
    return self;
}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    LHStatuses *status = statusFrame.status;
    LHUser *user = status.user;
    
    self.frame = statusFrame.topViewF;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = statusFrame.iconViewF;
    
    self.nameLable.text = user.name;
    self.nameLable.frame = statusFrame.nameLableF;
    
    if (user.mbrank) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]] ;
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLable.textColor = [UIColor orangeColor];
    }
    else
    {
        self.nameLable.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    self.timeLable.text = status.created_at;
    self.timeLable.frame = self.statusFrame.timeLableF;
    
    self.sourceLable.text = status.source;
    self.sourceLable.frame = self.statusFrame.sourceLableF;
    
    self.contentLable.text = status.text;
    self.contentLable.frame = self.statusFrame.contentLableF;
    
    //设置图片
    if(status.thumbnail_pic)
    {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
    else
    {
        self.photoView.hidden = YES;
    }
    

    if (status.retweeted_status) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        self.retweetView.statusFrame = self.statusFrame;
    }
    else{
        self.retweetView.hidden = YES;
    }

}
@end
