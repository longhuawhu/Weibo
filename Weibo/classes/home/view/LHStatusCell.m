//
//  LHStatusCell.m
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHStatusCell.h"
#import "LHUser.h"
#import "LHStatusFrame.h"
#import "LHStatuses.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LH.h"

#define LHSTatusTableBorder 5

@interface LHStatusCell()

@property (nonatomic, weak) UIImageView *topView;

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UIImageView *vipView;

@property (nonatomic, weak) UIImageView *photoView;

@property (nonatomic, weak) UILabel *nameLable;

@property (nonatomic, weak) UILabel *timeLable;

@property (nonatomic, weak) UILabel *contentLable;

@property (nonatomic, weak) UILabel *sourceLable;



@property (nonatomic, weak) UIImageView *retweetView;

@property (nonatomic, weak) UILabel *retweetNameLable;

@property (nonatomic, weak) UILabel *retweetContentLable;

@property (nonatomic, weak) UIImageView *retweetPhotoView;

@property (nonatomic, weak) UIImageView * statusToolBar;

@end

@implementation LHStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID =@"status";
    LHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LHStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupOriginalSubviews];
        [self setupRetweetSubviews];
        [self setupStatusToolSubviews];
    }
    
   // self.contentView.backgroundColor = [UIColor clearColor];
    
    return self;
}


/**
添加原创微博内部子空间
 */
-(void)setupOriginalSubviews
{
    
   // self.selectedBackgroundView = [[UIView alloc] init];
    
    
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage resizeImageWithName:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_top_background_highlighted"];
    topView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = LHStatusNameFont;
    nameLabel.textColor = [UIColor colorWithRed:225/255.0 green:135/255.0 blue:85/255.0 alpha:1.0];
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:nameLabel];
    self.nameLable = nameLabel;
    
    UILabel *contentLable = [[UILabel alloc] init];
    contentLable.font = LHStatusNameFont;
    contentLable.backgroundColor = [UIColor clearColor];
    contentLable.numberOfLines = 0;//设置自动换行
    [self.topView addSubview:contentLable];
    self.contentLable = contentLable;

    UILabel *sourceLable = [[UILabel alloc] init];
    sourceLable.font = LHStatusSourceFont;
    sourceLable.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:sourceLable];
    self.sourceLable = sourceLable;

    
    UILabel *timeLable = [[UILabel alloc] init];
    timeLable.font = LHStatusTimeFont;
    timeLable.textColor = [UIColor colorWithRed:225/255.0 green:135/255.0 blue:85/255.0 alpha:1.0];
    timeLable.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:timeLable];
    self.timeLable = timeLable;

    
}

/**
添加转发微博内部子空间
*/
-(void)setupRetweetSubviews
{
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizeImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.backgroundColor = [UIColor clearColor];
    retweetNameLabel.font = LHStatusRetweetNameFont;
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLable = retweetNameLabel;
    
    UILabel *retweetContentLable = [[UILabel alloc] init];
    retweetContentLable.backgroundColor = [UIColor clearColor];
    retweetContentLable.font = LHStatusRetweetNameFont;
    retweetContentLable.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLable];
    self.retweetContentLable = retweetContentLable;
    
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

/**
 添加转发微博内部子空间
 */
-(void)setupStatusToolSubviews
{
    UIImageView *statusToolBar = [[UIImageView alloc] init];
    statusToolBar.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
    statusToolBar.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_bottom_background_highlighted"];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;

}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupOriginalData];
    
    [self setupRetweetData];
    
    [self setupStatusToolData];
}


-(void)setFrame:(CGRect)frame
{
    frame.origin.x = LHSTatusTableBorder;
    frame.origin.y += LHSTatusTableBorder;
    frame.size.width -= 2 *LHSTatusTableBorder;
    frame.size.height -= LHSTatusTableBorder;
    
    [super setFrame:frame];
}
-(void)setupOriginalData
{
    LHStatuses *status = self.statusFrame.status;
    LHUser *user = status.user;
    
    self.topView.frame = self.statusFrame.topViewF;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    NSLog(@"user.profile_image_url %@ ", user.profile_image_url);
    
    self.nameLable.text = user.name;
    self.nameLable.frame = self.statusFrame.nameLableF;
    
    if (user.mbrank) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]] ;
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLable.textColor = [UIColor orangeColor];
         NSLog(@"****%@ ", [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank] );
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
    
}

-(void)setupRetweetData
{
    LHStatuses *retweetStatus = self.statusFrame.status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        LHUser *user = retweetStatus.user;
       
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
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
    else
    {
         self.retweetView.hidden = YES;
    }
    
}

-(void)setupStatusToolData
{
    self.statusToolBar.frame = self.statusFrame.statusToolbarF;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
