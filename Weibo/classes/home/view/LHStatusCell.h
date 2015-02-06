//
//  LHStatusCell.h
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHStatusFrame;

@interface LHStatusCell : UITableViewCell

@property (nonatomic, strong) LHStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
