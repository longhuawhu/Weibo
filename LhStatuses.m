//
//  Statuses.m
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHStatuses.h"
#import "LHUser.h"

@implementation LHStatuses


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
            NSLog(@"%@", self.retweeted_status.text);
        }
    }
    
    return  self;
}
@end
