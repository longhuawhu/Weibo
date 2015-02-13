//
//  LHTextView.m
//  Weibo
//
//  Created by lh on 15/2/11.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHTextView.h"
@interface LHTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation LHTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}
-(void)setPlaceholder:(NSString *)placeholder
{
    self.placeholderLabel.text = placeholder;
 //   self.placeholderLabel.hidden = (placeholder.length == 0);
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
        CGFloat maxW = self.frame.size.width;
        CGFloat maxH = self.frame.size.height;
        
        CGSize placeholderSize = [placeholder sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(maxW, maxH)];
        
        self.placeholderLabel.frame = CGRectMake(0, 0, placeholderSize.width, placeholderSize.height);
    }
    else{
        self.placeholderLabel.hidden = YES;
    }
}
@end
