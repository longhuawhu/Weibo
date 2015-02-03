//
//  LHSearchBar.m
//  Weibo
//
//  Created by lh on 15/2/3.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHSearchBar.h"
#import "UIImage+LH.h"

@implementation LHSearchBar

+(instancetype)searchBar
{
    return [[self alloc] init];

}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage resizeImageWithName:@"searchbar_textfield_background"];
        self.frame = CGRectMake(0, 0, 300, 30);
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        iconView.frame = CGRectMake(0, 0, 30, 30);
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.font = [UIFont systemFontOfSize:13];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode =UITextFieldViewModeAlways;
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor redColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        self.returnKeyType = UIReturnKeySearch;
    }
    
    return self;
}

@end
