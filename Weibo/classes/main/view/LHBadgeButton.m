//
//  LHBadgeButton.m
//  Weibo
//
//  Created by lh on 15/2/3.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHBadgeButton.h"
#import "UIImage+LH.h"

@implementation LHBadgeButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
       [self setBackgroundImage:[UIImage resizeImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return  self;
}

-(void)setBadgeValue:(NSString *)badgeValue
{
    if(badgeValue)
    {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];

        CGFloat badgeY = 0;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeX = self.frame.size.width - badgeW -10;
        self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
        
    }
    else
    {
        self.hidden = YES;
    }
}
@end
