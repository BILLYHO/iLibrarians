//
//  SLCubeViewController.m
//  iLibrarians
//
//  Created by billy.ho on 8/12/14.
//  Copyright (c) 2014 Johnson. All rights reserved.
//

#import "SLCubeViewController.h"

#import "iLIBBorrowedBookDetailViewController.h"
#import "SLSearchBookView.h"
#import "SLBookExchangeView.h"
#import "SLMyLibraryView.h"

#import "SLMyInfoViewController.h"
#import "SLBookExchangePublishViewController.h"
#import "SLBookExchangeDetailViewController.h"
#import "SLSearchResultViewController.h"

#define NAVIGATION_BAR_HEIGHT 64
#define PAGE_CONTROL_BAR_HEIGHT 10
#define NUMBER_OF_PAGE 3

@interface SLCubeViewController () <BorrowBookDelegate, BookExchangeDelegate, SearchBookDelegate,GKLCubeViewControllerDelegate>

@property (nonatomic, strong) iLIBBorrowedBookDetailViewController *iLibBorrowedBookDetailViewController;
@property (nonatomic, strong) UIPageControl *mainPageControl;

@end

@implementation SLCubeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTintColor:[UIColor grayColor]];
    [rightButton addTarget:self action:@selector(goToMyInfo) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)viewDidLoad
{
    self.delegate = self;
    [super viewDidLoad];
    
    [self configureDemonstrationChildViewControllers];
    //[self initPageControl];
    

    
}

- (void)configureDemonstrationChildViewControllers
{
    UIViewController *controller;

    controller = [[UIViewController alloc] init];
    SLSearchBookView *searchBookView = [[SLSearchBookView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height  - PAGE_CONTROL_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - 50)];
    searchBookView.delegate = self;
    [controller.view addSubview:searchBookView];
    [self addCubeSideForChildController:controller];
    
    controller = [[UIViewController alloc] init];
    SLBookExchangeView *bookExchangeView = [[SLBookExchangeView alloc] initWithFrame:CGRectMake(0, 0.5, self.view.frame.size.width, self.view.frame.size.height  - PAGE_CONTROL_BAR_HEIGHT)];
    bookExchangeView.delegate = self;
    [controller.view addSubview:bookExchangeView];
    [self addCubeSideForChildController:controller];
    
    controller = [[UIViewController alloc] init];
    [self addCubeSideForChildController:controller];
    
    controller = [[UIViewController alloc] init];
    SLMyLibraryView *myLibraryView = [[SLMyLibraryView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height  - PAGE_CONTROL_BAR_HEIGHT - 54)];
    myLibraryView.delegate = self;
    [controller.view addSubview:myLibraryView];
    [self addCubeSideForChildController:controller];
}

- (void)initPageControl
{
    self.mainPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height - PAGE_CONTROL_BAR_HEIGHT - 67,
                                                                           self.view.frame.size.width, PAGE_CONTROL_BAR_HEIGHT)];
    [self.mainPageControl setNumberOfPages:NUMBER_OF_PAGE];
    [self.mainPageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [self.mainPageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [self.mainPageControl setBackgroundColor:[UIColor whiteColor]];
    [self.mainPageControl setEnabled:NO];
    [self.mainPageControl setCurrentPage:1];
    [self.view addSubview:self.mainPageControl];
}

#pragma mark - NavigationItem Action
- (void)goToMyInfo
{
    SLMyInfoViewController *myInfoViewController = [[SLMyInfoViewController alloc] init];
    [self.navigationController pushViewController:myInfoViewController animated:YES];
}

- (void)publishBook
{
    SLBookExchangePublishViewController *publish = [[SLBookExchangePublishViewController alloc] init];
	[self.navigationController pushViewController:publish animated:YES];
}

#pragma mark - GKLCubeViewControllerDelegate
- (void)setupPage:(NSInteger)currentPage
{
    [self.mainPageControl setCurrentPage:currentPage];
    switch (currentPage) {
        case 0:
            [self setTitle:@"借阅记录"];
            self.navigationItem.leftBarButtonItem = nil;
            break;
        case 1:
            [self setTitle:@"图书查询"];
            self.navigationItem.leftBarButtonItem = nil;
            break;
        case 2:
            [self setTitle:@"图书漂流"];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(publishBook)];
            [self.navigationItem.leftBarButtonItem setTintColor:[UIColor grayColor]];
            break;
        default:
            break;
    }
}



#pragma mark - SearchBookDelegate
- (void) searchKeyword:(NSString *)searchString
{
    SLSearchResultViewController *resultViewController = [[SLSearchResultViewController alloc] init];
    [self.navigationController pushViewController:resultViewController animated:YES];
    resultViewController.searchString = searchString;
}

#pragma mark - BorrowBookDelegate

- (void)showBorrowBookDetailViewControllerWithCoverImage:(UIImage *)coverImage BookItem:(iLIBBookItem *)bookItem
{
    _iLibBorrowedBookDetailViewController = [[iLIBBorrowedBookDetailViewController alloc] initWithNibName:@"iLIBBorrowedBookDetailViewController" bundle:nil];
    _iLibBorrowedBookDetailViewController.coverView.image = coverImage;
    [_iLibBorrowedBookDetailViewController setBookItem:bookItem];
    [self.navigationController pushViewController:_iLibBorrowedBookDetailViewController animated:YES];
}

#pragma mark - BookExchangeDelegate

- (void)showBookExchangeDetailViewControllerWithBook:(iLIBFloatBookItem*)book
{
    SLBookExchangeDetailViewController *detailViewController = [[SLBookExchangeDetailViewController alloc] init];
    [detailViewController setBook:book];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
