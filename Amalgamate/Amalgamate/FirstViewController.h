//
//  FirstViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"

@interface FirstViewController : UIViewController <LoginViewControllerDelegate>
{
    IBOutlet UIButton* logInButton;
    IBOutlet UILabel* amalgamateLabel;
    IBOutlet UILabel* subtitle;
    IBOutlet UITableView* feed;
}


-(void)showFeed;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(void) getContent;

-(IBAction)presentLoginScreen:(id)sender;

-(void)didDismissViewController:(UIViewController*)vc;

@end

