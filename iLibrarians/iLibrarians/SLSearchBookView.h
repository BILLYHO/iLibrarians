//
//  SLSearchBookView.h
//  iLibrarians
//
//  Created by Hahn.Chan on 7/16/14.
//  Copyright (c) 2014 Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iLIBEngine.h"
#import "SLMainViewController.h"

@protocol SearchBookDelegate <NSObject>

- (void) searchKeyword:(NSString *)searchString;

@end

@interface SLSearchBookView : UIView

//@property (weak,nonatomic) SLMainViewController *vc;
@property (strong,nonatomic) NSString *searchRequest;
@property (strong,nonatomic) iLIBEngine *iLibEngine;

@property (nonatomic, weak) id<SearchBookDelegate>delegate;

@end
