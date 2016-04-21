//
//  ViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "SearchTermData.h"
#import "SelectFeedViewController.h"
#import "MasterViewController.h"
#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>
#import <MessageUI/MessageUI.h>

@protocol ViewControllerDelegate <NSObject>
-(void)aFeedDismissed:(UIViewController*)vc;
@end

@interface ViewController : TWTRTimelineViewController <SelectFeedViewControllerDelegate, MasterViewControllerDelegate,MFMailComposeViewControllerDelegate>
{
    IBOutlet UITableView* feed;
    IBOutlet UIButton* currentFeedButton;
    IBOutlet UILabel* infoLabel;
}

@property(nonatomic, weak) id<ViewControllerDelegate> delegate;

@property SearchTermData * searchTermData;

@property (strong, nonatomic) NSString * activeFeed;


-(void) viewDidAppear:(BOOL)animated;

-(void)loadActiveFeed;

-(IBAction)currentFeedButtonPressed:(id)sender;
-(IBAction)contactUs:(id)sender;
-(void) refreshFeed;


-(void)didDismissViewController:(UIViewController*)vc;

-(void)didDismissSelectFeedViewController:(UIViewController *)vc;

-(void)didDismissMasterViewController:(UIViewController*)vc;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;


@end

