//
//  NSDate+LH.h
//  Weibo
//
//  Created by lh on 15/2/9.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LH)
-(BOOL)isToday;
-(BOOL)isYesterday;
-(BOOL)isThisYear;
-(NSDateComponents *)deltaWithNow;
@end
