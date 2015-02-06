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
        NSDictionary *retweeted_status = dict[@"retweeted_status"];
        self.retweeted_status = nil;
    }
    
    return  self;
}
@end
