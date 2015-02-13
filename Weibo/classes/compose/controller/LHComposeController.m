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
#import "LHComposeToolBarView.h"

@interface LHComposeController() <UITextViewDelegate>
@property (nonatomic, weak) LHTextView *textView;
@property (nonatomic, weak) LHComposeToolBarView *toolbar;
@end

@implementation LHComposeController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupTextView];
    
    [self setupToolBar];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.textView becomeFirstResponder];
}

-(void)setupToolBar
{
    LHComposeToolBarView *toolbar = [[LHComposeToolBarView alloc] init];
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    
    toolbar.frame = CGRectMake(0, toolbarY, toolbarW, toolbarH);
    toolbar.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)setupTextView
{
    LHTextView *textView = [[LHTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:12];
    textView.placeholder = @"新鲜事!!!!!!!!!!!!!!!新鲜事新鲜事!!!!!!!!!!!!!!!!!新鲜事!!!!!!!!!!!!!!!!!vv!!!!!!!!!!!!!!!!!!!新鲜事!!!!!!!!!!!!!!!!!!!";
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:textView];
    
    //监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardWillChange:(NSNotification *)note
{
    NSLog(@"%@", note.userInfo);
    CGRect keyboardRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animateTime = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animateTime animations:^{
          self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardRect.size.height);
    }];
  
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}

@end
