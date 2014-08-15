#import "SLAppDelegate.h"
#import "SLLoginViewController.h"
#import "SLMyInfoViewController.h"
#import "SLMainViewController.h"
#import "MBProgressHUD.h"

#import "SLCubeViewController.h"

#define tabbarTintColor [UIColor colorWithRed:0.4157 green:0.9216 blue:0.6784 alpha:1.0]

@interface SLLogInViewController ()

@property (nonatomic, strong) UIView *tranView;

@end

@implementation SLLogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"登陆"];
    self.usernameTextField.placeholder        = @"默认为学号";
    self.usernameTextField.returnKeyType      = UIReturnKeyNext;
    self.usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.placeholder        = @"默认为身份证后六位";
    self.passwordTextField.returnKeyType      = UIReturnKeyDone;
    self.passwordTextField.secureTextEntry    = YES;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.usernameTextField.text               = [userDefault objectForKey:@"username"];
    self.passwordTextField.text               = [userDefault objectForKey:@"password"];
}



- (IBAction)backgroundTouchUpInside:(id)sender
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (IBAction)usernameDidEndOnExit:(id)sender
{
    [self.passwordTextField becomeFirstResponder];
}

- (IBAction)passwordDidEndOnExit:(id)sender
{
    [self resignFirstResponder];
    [self login];
}

- (IBAction)loginTouchUpInside:(id)sender
{
    [self resignFirstResponder];
    [self login];
    
}

- (void)login
{
    if (self.usernameTextField.text == nil || self.passwordTextField.text == nil || [self.usernameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"完善信息" message:@"用户名和密码不完整" delegate:nil cancelButtonTitle:@"寡人知道了" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    hud.labelText      = @"登录中...";
    [hud show:YES];
    hud.dimBackground  = YES;
    [self.view addSubview:hud];
    
    [[iLIBEngine sharedInstance] loginWithName:self.usernameTextField.text password:self.passwordTextField.text onSucceeded:^{
        NSLog(@"%@ loggin",self.usernameTextField.text);
        NSUserDefaults *userDefaut = [NSUserDefaults standardUserDefaults];
        [userDefaut setObject:self.usernameTextField.text forKey:@"username"];
        [userDefaut setObject:self.passwordTextField.text forKey:@"password"];
        [userDefaut synchronize];
        [hud removeFromSuperview];
        [self goToMainViewController];
    }onError:^(NSError *engineError){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:@"请检查用户名密码或网络设置" delegate:self cancelButtonTitle:@"寡人知道了" otherButtonTitles:nil];
        [hud removeFromSuperview];
        [alert show];
        NSLog(@"%@ login failed\n",self.usernameTextField.text);
    }];
}

- (void)goToMainViewController
{
//    SLMainViewController *mainViewController = [[SLMainViewController alloc] init];
//    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
//    [self presentViewController:mainNavigationController animated:YES completion:^{
//                         [mainViewController setPageOfScrollView:2];
//                     }];
    
    SLCubeViewController *controller = [[SLCubeViewController alloc]init];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:mainNavigationController animated:YES completion:nil];
    
//    if (![@"YES" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"introHasShown"]])
//    {
//        [self setUpTranView];
//        [mainNavigationController.view addSubview:_tranView];
//        [mainNavigationController.view bringSubviewToFront:_tranView];
//        //[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"introHasShown"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
}

- (void) setUpTranView
{
    _tranView = [[UIView alloc] initWithFrame:self.view.frame];
    _tranView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    
    UIImageView *centerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Single_Tap"]];
    centerImage.frame = CGRectMake(0, 0, 64, 64);
    centerImage.center = CGPointMake(160, 270);
    [_tranView addSubview:centerImage];
    
    UILabel *centerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
    centerLabel.text = @"点击查询图书";
    centerLabel.textColor = [UIColor whiteColor];
    centerLabel.textAlignment = NSTextAlignmentCenter;
    centerLabel.center = CGPointMake(160, 310);
    [_tranView addSubview:centerLabel];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Swipe_Right"]];
    leftImage.frame = CGRectMake(0, 0, 64, 64);
    leftImage.center = CGPointMake(50, 300);
    [_tranView addSubview:leftImage];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 100, 60)];
    leftLabel.numberOfLines = 2;
    leftLabel.text = @"右划查看\n借阅记录";
    leftLabel.textColor = [UIColor whiteColor];
    [_tranView addSubview:leftLabel];
    
    UIImageView *rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Swipe_Left"]];
    rightImage.frame = CGRectMake(0, 0, 64, 64);
    rightImage.center = CGPointMake(270, 300);
    [_tranView addSubview:rightImage];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 320, 100, 60)];
    rightLabel.numberOfLines = 2;
    rightLabel.text = @"左划查看\n漂流图书";
    rightLabel.textColor = [UIColor whiteColor];
    [_tranView addSubview:rightLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [button setTitle:@"我知道了" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 0.5f;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.cornerRadius = 20.0f;
    button.layer.masksToBounds = YES;
    button.center = CGPointMake(160, 450);
    [button addTarget:self action:@selector(dismissTranView) forControlEvents:UIControlEventTouchUpInside];
    
    [_tranView addSubview:button];
}

- (void) dismissTranView
{
    [_tranView removeFromSuperview];
}

@end
