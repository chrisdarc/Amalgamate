//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SelectFeedViewController.h"
#import "SearchTermData.h"
#import "ManageViewController.h"
//#import "ViewController.h"

@protocol MasterViewControllerDelegate <NSObject>
-(void)didDismissMasterViewController:(UIViewController*)vc;
@end

@interface MasterViewController : UITableViewController <SelectFeedViewControllerDelegate, ManageViewControllerDelegate>
{
    IBOutlet UITableView * tumblrTable;
    IBOutlet UILabel * instructions;
}

@property SearchTermData * searchTermData;

@property(nonatomic, weak) id<MasterViewControllerDelegate> delegate;

-(IBAction)managePressed:(id)sender;

-(void)didDismissViewController:(UIViewController*)vc;

-(void)dismissMasterViewController;

-(void)didDismissSelectFeedViewController:(UIViewController*)vc;


@end

