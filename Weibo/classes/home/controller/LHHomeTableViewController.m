//
//  LHHomeTableViewController.m
//  Weibo
//
//  Created by lh on 15/2/2.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHHomeTableViewController.h"
#import "UIImage+LH.h"
#import "UIBarButtonItem+LH.h"
#import "LHTitleButton.h"
#import "AFNetworking.h"
#import "LHWbAccount.h"
#import "LHAccountTool.h"
#import "UIImageView+WebCache.h"
#import "LHUser.h"
#import "LHStatuses.h"
#import "LHStatusFrame.h"
#import "LHStatusCell.h"
#import "MJRefresh.h"

@interface LHHomeTableViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *statuseFrames;
@property (nonatomic, weak) LHTitleButton* titleButton;
@property (nonatomic, weak) MJRefreshFooterView* footer;
@end

@implementation LHHomeTableViewController

-(NSMutableArray *)statuseFrames
{
    if (_statuseFrames == nil) {
        _statuseFrames = [NSMutableArray array];
    }
    return  _statuseFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefreshView];
    
    //1 setup navigationbar
    [self setupNavBar];
    
    //2 load weibo data
    [self loadUserInfo];
    
}

-(void) setupRefreshView
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControlValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [self refreshControlValueChange:refreshControl];
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}
-(void)dealloc
{
    [self.footer free];
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LHAccountTool account].access_token;
    params[@"count"] = @10;
    if (self.statuseFrames.count) {
        LHStatusFrame *statusFrame= [self.statuseFrames lastObject];
        long long lastId =  [statusFrame.status.idstr longLongValue] - 1;
        params[@"max_id"] = @(lastId);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *statusArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            LHStatuses *status = [LHStatuses statusesWithDict:dict];
            LHStatusFrame *statusFrame = [[LHStatusFrame alloc] init];
            statusFrame.status = status;
            [statusArray addObject:statusFrame];
        }
 
        [self.statuseFrames addObjectsFromArray:statusArray];
    
        [self.tableView reloadData];
        
        [refreshView endRefreshing];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-------%@", error);
        [refreshView endRefreshing];
    }];

}

-(void)refreshControlValueChange:(UIRefreshControl *)refreshControl
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    NSLog(@"accout ***  %@", [LHAccountTool account]);
    params[@"access_token"] = [LHAccountTool account].access_token;
    params[@"count"] = @10;
    
    if (self.statuseFrames.count) {
        LHStatusFrame *statusFrame= self.statuseFrames[0];
        params[@"since_id"] = statusFrame.status.idstr;
    }
   
    
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *statusArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            LHStatuses *status = [LHStatuses statusesWithDict:dict];
            LHStatusFrame *statusFrame = [[LHStatusFrame alloc] init];
            statusFrame.status = status;
            [statusArray addObject:statusFrame];
        }
      //  self.statuseFrames = statusArray;
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusArray];
        [tempArray addObjectsFromArray:self.statuseFrames];
        self.statuseFrames = tempArray;
        
        [self.tableView reloadData];
        
        //停止刷新
        [refreshControl endRefreshing];
        
        [self showNewStatusCount:statusArray.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-------%@", error);
    }];
}

-(void)showNewStatusCount:(int) count
{
    UIButton *btn = [[UIButton alloc] init];
    
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizeImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"共有%d条新微博", count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新微博" forState:UIControlStateNormal];
    }
    
    CGFloat btnH = 44;
    CGFloat btnY = 64-btnH;
    CGFloat btnX = 0;
    CGFloat btnW = self.view.frame.size.width;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:0.5 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
      }];
    }];
    
}


-(void)loadUserInfo
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [LHAccountTool account].access_token;
    params[@"uid"] = @([LHAccountTool account].uid);
    
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LHUser *user = [LHUser userWithDict:responseObject];
       // self.navigationController.title = user.name;
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-------%@", error);
    }];
 
}
-(void)setupNavBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];;
    
    // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithName:@"navigationbar_friendsearch"]style:UIBarMetricsDefault target:nil action:nil];
    
    LHTitleButton *titleButton = [LHTitleButton titleButton];
    titleButton.frame = CGRectMake(0, 0, 0, 30);
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    titleButton.selected = YES;
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
  //  #define IWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
}

-(void)titleClick:(LHTitleButton *)titleButton
{
    if (titleButton.selected) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.selected = NO;
    }
    else
    {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.selected = YES;
    }
}

-(void)findFriend
{
    
}
-(void)pop
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuseFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LHStatusCell *cell = [LHStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statuseFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHStatusFrame *statusFrame = self.statuseFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
