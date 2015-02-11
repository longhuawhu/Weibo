//
//  LHOauthViewController.m
//  Weibo
//
//  Created by lh on 15/2/4.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHOauthViewController.h"
#import "AFNetworking.h"
#import "LHWbAccount.h"
#import "LHAccountTool.h"
#import "LHWeiboTool.h"

@interface LHOauthViewController() <UIWebViewDelegate>

@end

@implementation LHOauthViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3828026369&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
}

-(BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        [self accessTokenWithCode:code];
        
        //不加载回调页面
        return NO;
    }
    
    return YES;
}

-(void)accessTokenWithCode:(NSString *)code
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3828026369";
    params[@"client_secret"] = @"156ed2229e946176320e450fe4d6e960";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://www.baidu.com";
    
   [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
       
       LHWbAccount *account = [LHWbAccount accoutWithDict:responseObject];
       //
       [LHAccountTool saveAccount:account];
       
       [LHWeiboTool chooseRootController];
    
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"%@", error);;
   }];
}

@end
