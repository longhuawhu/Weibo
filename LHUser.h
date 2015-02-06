//
//  LHUser.h
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHUser : NSObject

@property (nonatomic, assign) long long ID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *profile_image_url;

@property (nonatomic, assign, getter=isVip) BOOL Vip;

+(instancetype)userWithDict:(NSDictionary *)dict;

@end


//                 "user": {
//                     "id": 1404376560,
//                     "screen_name": "zaku",
//                     "name": "zaku",
//                     "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
//
//                 }
