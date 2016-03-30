//
//  SearchViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    IBOutlet UILabel * SearchInfoLabel;
}

@property (weak, nonatomic) IBOutlet UITableView* searchTable;

@property (strong, nonatomic) NSMutableArray * searchTerms;

-(void)loadArray;

-(void)saveArray;

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

@end
