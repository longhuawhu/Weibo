//
//  LHAccountTool.m
//  Weibo
//
//  Created by lh on 15/2/5.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#define FILEPATH  ([[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accout.data"])

#import "LHAccountTool.h"
#import "LHWbAccount.h"

@implementation LHAccountTool
+(void)saveAccount:(LHWbAccount *)account
{
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:FILEPATH];
}

+(LHWbAccount *)account
{
    LHWbAccount *accout = [NSKeyedUnarchiver unarchiveObjectWithFile:FILEPATH];
  
    NSDate *now = [NSDate date];
    //NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    if ([now compare:accout.expiresTime] == NSOrderedAscending) {
        return accout;
    }
    else{ //过期
        return nil;
    }

}

@end
