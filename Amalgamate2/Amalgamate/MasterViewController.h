//
//  MasterViewController.h
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/22/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SelectFeedViewController.h"
#import "SearchTermData.h"
//#import "ViewController.h"

@protocol MasterViewControllerDelegate <NSObject>
-(void)didDismissMasterViewController:(UIViewController*)vc;
@end

@interface MasterViewController : UITableViewController <SelectFeedViewControllerDelegate>

@property SearchTermData * searchTermData;

@property(nonatomic, weak) id<MasterViewControllerDelegate> delegate;

-(void)dismissMasterViewController;

-(void)didDismissSelectFeedViewController:(UIViewController*)vc;


@end

