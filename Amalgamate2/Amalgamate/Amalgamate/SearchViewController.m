//
//  SearchViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.allowsMultipleSelectionDuringEditing = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //number of sections to display social media
    return (1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //number of posts currently available to display?
    return (25);
}

-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cellToReturn = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cellToReturn == nil)
    {
        cellToReturn = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"Cell"];
    }
    
    //Call a get content function and put content here.
    cellToReturn.textLabel.text = [NSString stringWithFormat:@"%ld %s", (long)indexPath.row, "Search Term/Keyword"];
    
    return (cellToReturn);
}

// Swipe to delete.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [ removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

//function to get content from facebook?
-(void) getContent
{
    return;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
