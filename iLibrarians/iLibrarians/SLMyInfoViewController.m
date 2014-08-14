//
//  SLMyInfoViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMyInfoViewController.h"
#import "iLIBEngine.h"

@interface SLMyInfoViewController ()  <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation SLMyInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.title = @"个人信息";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initView
{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    UITableView *infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStyleGrouped];
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    [self.view addSubview:infoTableView];
    
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0.5, width, 65)];
    
    self.logoutButton = [[UIButton alloc] initWithFrame:CGRectMake((width - 285)/2, 5, 285., 55.)];
    [self.logoutButton setBackgroundImage:[UIImage imageNamed:@"item_bg_3.png"] forState:UIControlStateNormal];
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(didTouchOnLogoutItem) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:self.logoutButton];
    
    infoTableView.tableFooterView = footView;
}

- (void)didTouchOnLogoutItem{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0){
        [[iLIBEngine sharedInstance] logout:^(void){
            NSLog(@"log out success!");
        }onError:^(NSError *errorEngine){
            NSLog(@"Engine error!Failed to logout!");
        }];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma -
#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"InfoTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: identifier];
    }
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat: @"Hi~ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"关于iLibrarians";
                break;
            case 1:
                cell.textLabel.text = @"关于SYSU AppleClub";
                break;
            case 2:
                cell.textLabel.text = @"意见反馈";
                break;
            case 3:
                cell.textLabel.text = @"五星好评";
                break;
            default:
                break;
        }
    }
    return cell;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return @"关于";
    }
    return nil;
}
#pragma -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
