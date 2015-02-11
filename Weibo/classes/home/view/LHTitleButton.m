//
//  LHTitleButton.m
//  Weibo
//
//  Created by lh on 15/2/3.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHTitleButton.h"
#import "UIImage+LH.h"

@implementation LHTitleButton

+(instancetype)titleButton
{
    return  [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage resizeImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        self.adjustsImageWhenHighlighted = NO;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = contentRect.size.width - 20;
    CGFloat imageX = 0;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = 20;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
    CGRect frame = self.frame;
    frame.size.width = titleW + 25;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}
@end
