//
//  Statuses.h
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHUser;

@interface LHStatuses : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *idstr;

@property (nonatomic, assign) int  reposts_count;

@property (nonatomic, assign) int  comments_count;

@property (nonatomic, assign) int  attitudes_count;

@property (nonatomic, strong) LHUser *user;

@property (nonatomic, copy) NSString *thumbnail_pic;

@property (nonatomic, strong) LHStatuses *retweeted_status;

+(instancetype)statusesWithDict:(NSDictionary *)dict;

@end

//
//"statuses": [
//             {
//                 "created_at": "Tue May 31 17:46:55 +0800 2011",
//                 "id": 11488058246,
//                 "text": "求关注。"，
//                 "source": "<a href="http://weibo.com" rel="nofollow">新浪微博</a>",
//                 "reposts_count": 8,
//                 "comments_count": 9,
//                 "user": {
//                     "id": 1404376560,
//                     "screen_name": "zaku",
//                     "name": "zaku",
//                     "profile_image_url": "http://tp1.sinaimg.cn/1404376560/50/0/1",
//
//                 }
//             },