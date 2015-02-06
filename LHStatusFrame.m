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

#define LHStatusCellBorder 5


@implementation LHStatusFrame

-(void)setStatus:(LHStatuses *)status
{
    _status = status;
    
    //
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    //iconView
    CGFloat iconViewW = 35;
    CGFloat iconViewX = LHStatusCellBorder;
    CGFloat iconViewY = LHStatusCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewW);
    
    //nickname
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + LHStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:LHStatusNameFont];
    _nameLableF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    //
    if (status.user.isVip) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLableF) + LHStatusCellBorder;;
        CGFloat vipViewY = nameLabelY;
        _iconViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLableF) + LHStatusCellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithFont:LHStatusTimeFont];
    _timeLableF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLableF) + LHStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:LHStatusSourceFont];
    _sourceLableF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    
    CGFloat contentLabelX = LHStatusCellBorder;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLableF), CGRectGetMaxY(_iconViewF)) + LHStatusCellBorder;
    CGSize contentLabelSize = [status.text sizeWithFont:LHStatusNameFont constrainedToSize:CGSizeMake(cellW - 2*LHStatusCellBorder, MAXFLOAT)];
    _contentLableF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    CGFloat topViewH = CGRectGetMaxY(_contentLableF) + LHStatusCellBorder;
    
    _topViewF = CGRectMake(0, 0, cellW, topViewH);
    
    
}
@end
