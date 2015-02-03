//
//  UIBarButtonItem+LH.h
//  Weibo
//
//  Created by lh on 15/2/3.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LH)
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id) target action:(SEL)action;
@end
