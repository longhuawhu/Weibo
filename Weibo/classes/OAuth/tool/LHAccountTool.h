//
//  LHAccountTool.h
//  Weibo
//
//  Created by lh on 15/2/5.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHWbAccount;

@interface LHAccountTool : NSObject

+(void)saveAccount:(LHWbAccount *)account;
+(LHWbAccount *)account;

@end
