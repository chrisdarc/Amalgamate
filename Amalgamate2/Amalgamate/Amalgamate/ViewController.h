//
//  ViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "ManageViewController.h"
#import "SearchTermData.h"
#import "SelectFeedViewController.h"
#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>

@interface ViewController : TWTRTimelineViewController <ManageViewControllerDelegate, SelectFeedViewControllerDelegate>
{
    IBOutlet UITableView* feed;
    IBOutlet UIButton* currentFeedButton;
}

@property SearchTermData * searchTermData;

@property (strong, nonatomic) NSString * activeFeed;


-(void) viewDidAppear:(BOOL)animated;

-(void)loadActiveFeed;

-(IBAction)currentFeedButtonPressed:(id)sender;

-(void) refreshFeed;

-(IBAction)managePressed:(id)sender;

-(void)didDismissViewController:(UIViewController*)vc;

-(void)didDismissSelectFeedViewController:(UIViewController *)vc;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//
//-(void) getContent;

@end

