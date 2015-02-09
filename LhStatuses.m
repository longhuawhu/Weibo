//
//  Statuses.m
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHStatuses.h"
#import "LHUser.h"
#import "NSDate+LH.h"

@implementation LHStatuses

-(NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate  = [fmt dateFromString:_created_at];
    
    if (createDate.isToday) {
        if (createDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", createDate.deltaWithNow.hour];
        }else if(createDate.deltaWithNow.minute >= 1){
             return [NSString stringWithFormat:@"%d分钟前", createDate.deltaWithNow.minute];
        }else{
             return @"刚刚";
        }
        
    }else if (createDate.isYesterday){
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }else if (createDate.isThisYear){
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
   
}

-(void )setSource:(NSString *)source
{
    int startLoc = [source rangeOfString:@">"].location + 1;
    int length = [source rangeOfString:@"</"].location - startLoc;
   _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:NSMakeRange(startLoc, length)]];
}


+(instancetype)statusesWithDict:(NSDictionary *)dict
{
    return  [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.text = dict[@"text"];
        self.source = dict[@"source"];
        self.reposts_count = [dict[@"reposts_count"] intValue];
        self.comments_count = [dict[@"comments_count"] intValue];
        self.user = [LHUser userWithDict:dict[@"user"]];
        self.created_at = dict[@"created_at"];
        self.attitudes_count = [dict[@"attitudes_count"] intValue];
        self.thumbnail_pic = dict[@"thumbnail_pic"];
        NSDictionary *retweeteddict = dict[@"retweeted_status"];
        if (retweeteddict) {
         ///   NSLog(@"%@", retweeteddict);
            self.retweeted_status = [[LHStatuses alloc] init];
            self.retweeted_status.text = retweeteddict[@"text"];
            self.retweeted_status.user = [LHUser userWithDict:retweeteddict[@"user"]];
            self.retweeted_status.thumbnail_pic = retweeteddict[@"thumbnail_pic"];
        //    NSLog(@"%@", self.retweeted_status.text);
        }
    }
    
    return  self;
}
@end
