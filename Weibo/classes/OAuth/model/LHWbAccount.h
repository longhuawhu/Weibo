//
//  LHWbAccount.h
//  Weibo
//
//  Created by lh on 15/2/4.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHWbAccount : NSObject <NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long  expires_in;
@property (nonatomic, assign) long long  remind_in;
@property (nonatomic, assign) long long  uid;

+(instancetype)accoutWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
