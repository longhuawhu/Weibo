//
//  LHStatusToolBarView.m
//  Weibo
//
//  Created by lh on 15/2/9.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHStatusToolBarView.h"
#import "UIImage+LH.h"
#import "LHStatuses.h"

@interface LHStatusToolBarView()

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) NSMutableArray *dividerArray;

@property (nonatomic, weak) UIButton *retweetBtn;

@property (nonatomic, weak) UIButton *commentBtn;

@property (nonatomic, weak) UIButton *attitudeBtn;

@end

@implementation LHStatusToolBarView

-(void)setStatus:(LHStatuses *)status
{
    _status = status;
    
    if (status.reposts_count) {
        NSString *title = [NSString stringWithFormat:@"%d", status.reposts_count];
        [self.retweetBtn setTitle:title forState:UIControlStateNormal];
    }else{
        [self.retweetBtn setTitle:@"转发" forState:UIControlStateNormal];
    }
    
    if (status.comments_count) {
        NSString *title = [NSString stringWithFormat:@"%d", status.comments_count];
        [self.commentBtn setTitle:title forState:UIControlStateNormal];
    }else{
        [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    }
    
    if (status.attitudes_count) {
        NSString *title = [NSString stringWithFormat:@"%d", status.attitudes_count];
        [self.attitudeBtn setTitle:title forState:UIControlStateNormal];
    }else{
        [self.attitudeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }
    
    
}

-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    
    return _btnArray;
}

-(NSMutableArray *)dividerArray
{
    if (_dividerArray == nil) {
        _dividerArray = [NSMutableArray array];
    }
    
    return _dividerArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizeImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        self.retweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" backgroudImage:@"timeline_card_leftbottom_highligthed"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" backgroudImage:@"timeline_card_middlebottom_highligthed"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" backgroudImage:@"timeline_card_rightbottom_highligthed"];
        
        
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}

-(UIButton *) setupBtnWithTitle:(NSString *)tilte image:(NSString *)image backgroudImage:(NSString *)bgImage
{
    UIButton *btn = [[UIButton alloc] init];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizeImageWithName:bgImage] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [btn setTitle:tilte forState:UIControlStateNormal];
    [self addSubview:btn];
    [self.btnArray addObject:btn];
    return btn;
}
-(void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividerArray addObject:divider];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.btnArray.count; ++i) {
        UIButton *btn = self.btnArray[i];
        
        CGFloat btnW = self.frame.size.width / self.btnArray.count;
        CGFloat btnH = self.frame.size.height;
        CGFloat btnY = 0;
        CGFloat btnX = i *btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    
    for (int i = 0; i < self.dividerArray.count; ++i) {
        UIImageView *divider = self.dividerArray[i];
        
        CGFloat dividerW = 2;
        CGFloat dividerH = self.frame.size.height;
        CGFloat dividerY = 0;
        CGFloat dividerX = (i + 1) *(self.frame.size.width/(self.dividerArray.count + 1));
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
    
}
@end
