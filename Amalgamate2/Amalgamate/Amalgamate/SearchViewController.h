//
//  SearchViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
{
    IBOutlet UITableView* searchTerms;
}

@property UITableView* tableView;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

-(void) getContent;

@end
