//
//  LHComposeController.m
//  Weibo
//
//  Created by lh on 15/2/11.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHComposeController.h"
#import "LHTextView.h"
#import "AFNetworking.h"
#import "LHAccountTool.h"
#import "LHWbAccount.h"
#import "MBProgressHUD.h"

@interface LHComposeController()
@property (nonatomic, weak) LHTextView *textView;
@end

@implementation LHComposeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupTextView];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

-(void)setupTextView
{
    LHTextView *textView = [[LHTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:textView];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textChanged
{
    self.navigationItem.rightBarButtonItem.enabled = (self.textView.text.length != 0);
   // NSLog(@"**********%d", self.navigationItem.rightBarButtonItem.enabled);
}

-(void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"cancle" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"send" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

-(void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LHAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
      // [MBProgressHUD shows
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-------%@", error);
    }];
    
    [self  cancle];
}

@end
