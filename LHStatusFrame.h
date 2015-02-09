//
//  LHStatusFrame.h
//  Weibo
//
//  Created by lh on 15/2/6.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define LHStatusNameFont  [UIFont systemFontOfSize:13]
#define LHStatusRetweetNameFont  LHStatusNameFont

#define LHStatusTimeFont  [UIFont systemFontOfSize:11]

#define LHStatusSourceFont  LHStatusTimeFont

@class LHStatuses;

@interface LHStatusFrame : NSObject

@property (nonatomic, strong) LHStatuses *status;

@property (nonatomic, assign, readonly) CGRect topViewF;

@property (nonatomic, assign, readonly) CGRect iconViewF;

@property (nonatomic, assign, readonly) CGRect vipViewF;

@property (nonatomic, assign, readonly) CGRect photoViewF;

@property (nonatomic, assign, readonly) CGRect nameLableF;

@property (nonatomic, assign, readonly) CGRect timeLableF;

@property (nonatomic, assign, readonly) CGRect contentLableF;

@property (nonatomic, assign, readonly) CGRect sourceLableF;

@property (nonatomic, assign, readonly) CGRect retweetViewF;

@property (nonatomic, assign, readonly) CGRect retweetNameLableF;

@property (nonatomic, assign, readonly) CGRect retweetContentLableF;

@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;

@property (nonatomic, assign, readonly) CGRect statusToolbarF;

@property (nonatomic, assign) float cellHeight;

@end
