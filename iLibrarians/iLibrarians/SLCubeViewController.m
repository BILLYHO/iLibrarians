//
//  SLCubeViewController.m
//  iLibrarians
//
//  Created by billy.ho on 8/12/14.
//  Copyright (c) 2014 Johnson. All rights reserved.
//

#import "SLCubeViewController.h"

#import "iLIBBorrowedBookDetailViewController.h"
#import "SLCubeChildViewController.h"
#import "SLSearchBookView.h"
#import "SLBookExchangeView.h"
#import "SLMyLibraryView.h"

#import "SLBookExchangePublishViewController.h"
#import "SLBookExchangeDetailViewController.h"

@interface SLCubeViewController () <BorrowBookDelegate, BookExchangeDelegate>
@property (nonatomic, strong) iLIBBorrowedBookDetailViewController *iLibBorrowedBookDetailViewController;
@end

@implementation SLCubeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureDemonstrationChildViewControllers];
}

- (void)configureDemonstrationChildViewControllers
{
    UIViewController *controller;
    
    controller = [[SLCubeChildViewController alloc] init];
    SLMyLibraryView *myLibraryView = [[SLMyLibraryView alloc] initWithFrame:self.view.frame];
    myLibraryView.delegate = self;
    [controller.view addSubview:myLibraryView];
    [self addCubeSideForChildController:controller];
    
    controller = [[SLCubeChildViewController alloc] init];
    SLSearchBookView *searchBookView = [[SLSearchBookView alloc] initWithFrame:self.view.frame];
    [controller.view addSubview:searchBookView];
    [self addCubeSideForChildController:controller];
    
    controller = [[SLCubeChildViewController alloc] init];
    SLBookExchangeView *bookExchangeView = [[SLBookExchangeView alloc] initWithFrame:self.view.frame];
    bookExchangeView.delegate = self;
    [controller.view addSubview:bookExchangeView];
    [self addCubeSideForChildController:controller];
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
