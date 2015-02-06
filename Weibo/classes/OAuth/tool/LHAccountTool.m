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
    NSLog(@"save accout  %@", account.access_token);
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accout1.data"];
    NSLog(@"%@", file);
    file = @"/Users/lh/Desktop/data.txt";
    
    [NSKeyedArchiver archiveRootObject:account toFile:file];
    
   
    LHWbAccount *account1 = [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
     NSLog(@"get accout  %@", account1.access_token);
}

+(LHWbAccount *)account
{
    NSString * file = [[NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"accout1.data"];
    
    file = @"/Users/lh/Desktop/data.txt";
    LHWbAccount *accout = [NSKeyedUnarchiver unarchiveObjectWithFile:file];

  
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
