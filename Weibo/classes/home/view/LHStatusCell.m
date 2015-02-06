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
    
    return self;
}


/**
添加原创微博内部子空间
 */
-(void)setupOriginalSubviews
{
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.contentView addSubview:vipView];
    self.vipView = vipView;
    
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.contentView addSubview:photoView];
    self.photoView = photoView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = LHStatusNameFont;
    [self.topView addSubview:nameLabel];
    self.nameLable = nameLabel;
    
    UILabel *contentLable = [[UILabel alloc] init];
    contentLable.font = LHStatusNameFont;
    contentLable.numberOfLines = 0;//设置自动换行
    [self.topView addSubview:contentLable];
    self.contentLable = contentLable;

    UILabel *sourceLable = [[UILabel alloc] init];
    sourceLable.font = LHStatusSourceFont;
    [self.topView addSubview:sourceLable];
    self.sourceLable = sourceLable;

    
    UILabel *timeLable = [[UILabel alloc] init];
    timeLable.font = LHStatusTimeFont;
    [self.topView addSubview:timeLable];
    self.timeLable = timeLable;

    
}

/**
添加转发微博内部子空间
*/
-(void)setupRetweetSubviews
{
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLable = retweetNameLabel;
    
    UILabel *retweetContentLable = [[UILabel alloc] init];
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
    
}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupOriginalData];
    
    [self setupRetweetData];
}

-(void)setupOriginalData
{
    LHStatuses *status = self.statusFrame.status;
    LHUser *user = status.user;
    
    self.topView.frame = self.statusFrame.topViewF;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    self.nameLable.text = user.name;
    self.nameLable.frame = self.statusFrame.nameLableF;
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
    }
    else
    {
        self.vipView.hidden = YES;
    }
    
    self.timeLable.text = status.created_at;
    self.timeLable.frame = self.statusFrame.timeLableF;
    
    self.sourceLable.text = status.source;
    self.sourceLable.frame = self.statusFrame.sourceLableF;
    
    self.contentLable.text = status.text;
    self.contentLable.frame = self.statusFrame.contentLableF;
    
}

-(void)setupRetweetData
{
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
