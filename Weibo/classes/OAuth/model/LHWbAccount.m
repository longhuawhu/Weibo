//
//  LHWbAccount.m
//  Weibo
//
//  Created by lh on 15/2/4.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHWbAccount.h"

@implementation LHWbAccount
+(instancetype)accoutWithDict:(NSDictionary *)dict;
{
    return  [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        self.expiresTime = [aDecoder decodeObjectForKey:@"expiresTime"];
    }
    return  self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.access_token forKey:@"access_token"];
    [coder encodeInt64:self.remind_in forKey:@"remind_in"];
    [coder encodeInt64:self.expires_in forKey:@"expires_in"];
    [coder encodeInt64:self.uid forKey:@"uid"];
    [coder encodeObject:self.expiresTime forKey:@"expiresTime"];
}
@end
