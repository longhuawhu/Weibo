//
//  UIImage+LH.m
//  Weibo
//
//  Created by lh on 15/2/2.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "UIImage+LH.h"
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

@implementation UIImage (LH)

+(UIImage*) imageWithName:(NSString *)imageName
{
    if(iOS7)
    {
        NSString *imageNameAppend = [imageName stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:imageNameAppend];
        if (image == nil) {
            return [UIImage imageNamed:imageName];
        }
    }
    return [UIImage imageNamed:imageName];
}

+(UIImage*) resizeImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

@end
