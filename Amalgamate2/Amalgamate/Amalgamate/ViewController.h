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
#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>

@interface ViewController : TWTRTimelineViewController <ManageViewControllerDelegate>
{
    IBOutlet UITableView* feed;
}

@property SearchTermData * searchTermData;

-(void) viewDidAppear:(BOOL)animated;

-(void) refreshFeed;

-(IBAction)managePressed:(id)sender;

-(void)didDismissViewController:(UIViewController*)vc;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//
//-(void) getContent;

@end

