//
//  LHUser.m
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHUser.h"

@implementation LHUser

+(instancetype)userWithDict:(NSDictionary *)dict
{
    return  [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.profile_image_url = dict[@"profile_image_url"];
        self.ID = [dict[@"id"] longLongValue];
        self.mbrank = [dict[@"mbrank"] longValue];
    }
    
    return self;
}
@end
