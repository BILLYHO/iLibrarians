//
//  SLAboutiLibrariansViewController.m
//  iLibrarians
//
//  Created by billy.ho on 8/15/14.
//  Copyright (c) 2014 Johnson. All rights reserved.
//

#import "SLAboutiLibrariansViewController.h"

@interface SLAboutiLibrariansViewController ()

@end

@implementation SLAboutiLibrariansViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_114"]];
    icon.center = CGPointMake(160, 100);
    [self.view addSubview:icon];
    
    UILabel *stuff = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 220, 200)];
    stuff.numberOfLines = 0;
    stuff.text = @"制作人员:\n\n世界级产品经理: 陆莹\n\n世界级程序媛:YYY\n\n世界级程序猿:志炯, 初阳\n\n底层小码农:思翰, 嘉俊";
    [self.view addSubview:stuff];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
