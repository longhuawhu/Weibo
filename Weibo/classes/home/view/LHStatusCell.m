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
#import "LHStatusToolBarView.h"
#import "LHRetweetView.h"
#import "public.h"
#import "LHStatusTopView.h"

#define LHSTatusTableBorder 5

@interface LHStatusCell()

@property (nonatomic, weak) LHStatusTopView *topView;

@property (nonatomic, weak) LHStatusToolBarView * statusToolBar;

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
        [self setupStatusToolSubviews];
    }
    
    return self;
}


/**
添加原创微博内部子空间
 */
-(void)setupOriginalSubviews
{
   // self.selectedBackgroundView = [[UIView alloc] init];
    LHStatusTopView *topView = [[LHStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}


/**
 添加转发微博内部子空间
 */
-(void)setupStatusToolSubviews
{
    LHStatusToolBarView *statusToolBar = [[LHStatusToolBarView alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;

}

-(void)setStatusFrame:(LHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    [self setupOriginalData];
    
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
    self.topView.frame = self.statusFrame.topViewF;
    self.topView.statusFrame = self.statusFrame;
}


-(void)setupStatusToolData
{
    self.statusToolBar.frame = self.statusFrame.statusToolbarF;
    self.statusToolBar.status = self.statusFrame.status;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
