//
//  FirstViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[loginState setInitialLoggedIn];
    
    //If user is not logged in, go to feed, otherwise present them with a log in button.
    if ([FBSDKAccessToken currentAccessToken])//(![loginState getLoggedInState])
    {
        
        //show the feed
        [self showFeed];
    }
    else
    {
        
        //button presentation
        amalgamateLabel.alpha = 1;
        subtitle.alpha = 1;
        logInButton.alpha = 1;
        feed.alpha = 0;
        feed.userInteractionEnabled = NO;
    }
}

-(void)showFeed
{
    //if the user is logged in, show them their feed
    logInButton.enabled = NO;
    logInButton.alpha = 0;
    
    amalgamateLabel.text = @"Feed";
    amalgamateLabel.alpha = 0;
    subtitle.text = @"Feed will be here.";
    subtitle.alpha = 0;
    
    feed.userInteractionEnabled = YES;
    feed.alpha = 1;
    
//    amalgamateLabel.alpha = 1;
//    subtitle.alpha = 1;
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

-(IBAction)presentLoginScreen:(id)sender
{
    Login* loginScreen = [[Login alloc] initWithNibName:@"Login" bundle: nil];
    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: loginScreen];
    loginScreen.delegate = self;
    [self presentViewController: enclosingNav animated: YES completion:nil];
}

-(void)didDismissViewController:(UIViewController*)vc
{
    NSLog(@"Dismissed !!!!!");
    [self showFeed];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
