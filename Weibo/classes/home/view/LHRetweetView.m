//
//  LHRetweetView.m
//  Weibo
//
//  Created by lh on 15/2/10.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHRetweetView.h"
#import "UIImage+LH.h"
#import "public.h"
#import "LHUser.h"
#import "LHStatusFrame.h"
#import "LHStatuses.h"
#import "UIImageView+WebCache.h"

@implementation LHRetweetView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.image = [UIImage resizeImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        retweetNameLabel.font = LHStatusRetweetNameFont;
        [self addSubview:retweetNameLabel];
        self.retweetNameLable = retweetNameLabel;
        
        UILabel *retweetContentLable = [[UILabel alloc] init];
        retweetContentLable.backgroundColor = [UIColor clearColor];
        retweetContentLable.font = LHStatusRetweetNameFont;
        retweetContentLable.numberOfLines = 0;
        [self addSubview:retweetContentLable];
        self.retweetContentLable = retweetContentLable;
        
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;

    }
    return self;
}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    LHStatuses *retweetStatus = statusFrame.status.retweeted_status;

    LHUser *user = retweetStatus.user;
        
    self.frame = self.statusFrame.retweetViewF;
        
    self.retweetNameLable.text = user.name;
    self.retweetNameLable.frame = self.statusFrame.retweetNameLableF;
        
    self.retweetContentLable.text = retweetStatus.text;
    self.retweetContentLable.frame = self.statusFrame.retweetContentLableF;
        
    if (retweetStatus.thumbnail_pic) {
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
        [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }
    else
    {
        self.retweetPhotoView.hidden = YES;
    }

}

@end
