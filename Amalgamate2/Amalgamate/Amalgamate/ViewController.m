//
//  ViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self refreshFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) refreshFeed
{
    //[myTableView reload];
}

-(IBAction)managePressed:(id)sender
{
    ManageViewController* manageScreen = [[ManageViewController alloc] initWithNibName:@"ManageViewController" bundle: nil];
//    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: manageScreen];
    manageScreen.delegate = self;
    [self presentViewController: manageScreen animated:YES completion:nil];//]: enclosingNav animated: YES completion:nil];
}

-(void)didDismissViewController:(UIViewController*)vc
{
    NSLog(@"Dismissed !!!!!");
    [self refreshFeed];
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
    cellToReturn.textLabel.text = [NSString stringWithFormat:@"%ld %s", (long)indexPath.row, "Social Media Content"];
    
    return (cellToReturn);
}

//function to get content from facebook?
-(void) getContent
{
    return;
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([[segue identifier] isEqualToString:@"toSearch"])
     {
         
         // Get reference to the destination view controller
         SearchViewController *SearchScreen;
         SearchScreen = [segue destinationViewController];
         
         // Pass any objects to the view controller here, like...
         //[vc setMyObjectHere:object];
     }
 }

@end
