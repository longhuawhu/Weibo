//
//  LHStatusFrame.m
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHStatusFrame.h"
#import "LHStatuses.h"
#import "LHUser.h"
#import "public.h"
#define LHStatusCellBorder 5


@implementation LHStatusFrame

-(void)setStatus:(LHStatuses *)status
{
    _status = status;
    
    //
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * LHStatusCellBorder;
    
    //topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    //iconView 设置图象
    CGFloat iconViewW = 50;
    CGFloat iconViewX = LHStatusCellBorder;
    CGFloat iconViewY = LHStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewW);
    
    //nickname设置昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + LHStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:LHStatusNameFont];
    _nameLableF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    //设置会员图片
    if (status.user.mbrank) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLableF) + LHStatusCellBorder;;
        CGFloat vipViewY = nameLabelY;
        _iconViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //设置时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLableF) + LHStatusCellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithFont:LHStatusTimeFont];
    _timeLableF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    //设置来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLableF) + LHStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:LHStatusSourceFont];
    _sourceLableF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    //设置微博正文
    CGFloat contentLabelX = LHStatusCellBorder;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLableF), CGRectGetMaxY(_iconViewF)) + LHStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:LHStatusNameFont constrainedToSize:CGSizeMake(cellW - 2*LHStatusCellBorder, MAXFLOAT)];
    _contentLableF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 设置图片
    if (status.thumbnail_pic) {
        CGFloat thumbnail_picWH = 70;
        CGFloat thumbnail_picX = LHStatusCellBorder;
        CGFloat thumbnail_picY = CGRectGetMaxY(_contentLableF) +LHStatusCellBorder;
        _photoViewF = CGRectMake(thumbnail_picX, thumbnail_picY, thumbnail_picWH, thumbnail_picWH);
        
    }
    
    CGFloat contentLableMaxW = cellW - 2 * LHStatusCellBorder;
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLableMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLableF) +LHStatusCellBorder;
        CGFloat retweetHeight = 0;
        
        CGFloat retweetNameLabelX = LHStatusCellBorder;
        CGFloat retweetNameLabelY = LHStatusCellBorder;
        CGSize retweetNameLabelSize = [status.retweeted_status.user.name sizeWithFont:LHStatusRetweetNameFont];
        _retweetNameLableF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        CGFloat retweetContentLabelX = LHStatusCellBorder;
        CGFloat retweetContextLabelY = CGRectGetMaxY(_retweetNameLableF) + LHStatusCellBorder;
        CGSize retweetContentSize = [status.retweeted_status.text sizeWithFont:LHStatusRetweetNameFont constrainedToSize:CGSizeMake(retweetViewW - 2 * LHStatusCellBorder, MAXFLOAT)];
        _retweetContentLableF = (CGRect){{retweetContentLabelX, retweetContextLabelY},retweetContentSize};
        
        
        if (status.retweeted_status.thumbnail_pic) {
            CGFloat thumbnail_picWH = 70;
            CGFloat thumbnail_picX = retweetContentLabelX;
            CGFloat thumbnail_picY = CGRectGetMaxY(_retweetContentLableF) +LHStatusCellBorder;
            _retweetPhotoViewF= CGRectMake(thumbnail_picX, thumbnail_picY, thumbnail_picWH, thumbnail_picWH);
            
            retweetHeight = CGRectGetMaxY(_retweetPhotoViewF) +  LHStatusCellBorder;
        }
        else
        {
           retweetHeight = CGRectGetMaxY(_retweetContentLableF) +  LHStatusCellBorder;
        }
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetHeight);
        
        topViewH = CGRectGetMaxY(_retweetViewF);
    }
    else
    {
        if (status.thumbnail_pic) {
            topViewH = CGRectGetMaxY(_photoViewF);
        }
        else
        {
            topViewH = CGRectGetMaxY(_contentLableF);
        }
    }
    
    topViewH +=LHStatusCellBorder;
    
//    CGFloat topViewH = MAX(CGRectGetMaxY(_contentLableF), CGRectGetMaxY(_photoViewF)) + LHStatusCellBorder;
//    
    _topViewF = CGRectMake(0, 0, cellW, topViewH);
    
    
    //工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);// + LHStatusCellBorder;
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolBarH = 35;
    _statusToolbarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolBarH);
    
    _cellHeight = CGRectGetMaxY(_statusToolbarF) + LHStatusCellBorder;
    
}
@end
