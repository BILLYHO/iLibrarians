//
//  SLMyInfoViewController.m
//  iLibrarians
//
//  Created by johnsonpuning on 14-7-12.
//  Copyright (c) 2014年 Apple Club. All rights reserved.
//

#import "SLMyInfoViewController.h"
#import "iLIBEngine.h"

@interface SLMyInfoViewController ()

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
    
    self.logoutButton = [[UIButton alloc] initWithFrame:CGRectMake((width - 285)/2, (height - 55)/2, 285., 55.)];
    [self.logoutButton setBackgroundImage:[UIImage imageNamed:@"item_bg_3.png"] forState:UIControlStateNormal];
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(didTouchOnLogoutItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
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
        //       [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

@end
