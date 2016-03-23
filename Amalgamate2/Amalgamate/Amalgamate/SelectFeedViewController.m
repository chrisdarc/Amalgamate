//
//  SelectFeedViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-22.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "SelectFeedViewController.h"

@interface SelectFeedViewController ()

@end

@implementation SelectFeedViewController
@synthesize activeFeed;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Amalgamate";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector (dismissSelectFeedViewController)];
    
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    [self loadActiveFeed];
    [self setCheckMark];

}

-(void)loadActiveFeed
{
    //Load feed previously saved
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * storedString= [userDefaults objectForKey:@"activeFeed"];
    if (storedString == nil)
    {
        //initialize the string that holds the active feed
        activeFeed = @"TWITTER";
    }
    else
    {
        //make search terms equal to the string that is stored
        activeFeed = storedString;
    }
}

-(void)saveActiveFeed
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:activeFeed forKey:@"activeFeed"];
    [userDefaults synchronize];
}

-(void)setCheckMark
{
    if([activeFeed  isEqualToString: @"TWITTER"])
    {
        twitterCheckMark.alpha = 1;
        tumblrCheckMark.alpha = 0;
    }
    else if([activeFeed isEqualToString:@"TUMBLR"])
    {
        twitterCheckMark.alpha = 0;
        tumblrCheckMark.alpha = 1;
    }
    else
    {
        NSLog(@"activeFeed error in SelectFeedViewController");
    }
}

-(IBAction)twitterSelectorButtonPressed:(id)sender
{
    
    activeFeed = @"TWITTER";
    [self saveActiveFeed];
    [self setCheckMark];
    [self dismissSelectFeedViewController];
}

-(IBAction)tumblrSelectorButtonPressed:(id)sender
{
    activeFeed = @"TUMBLR";
    [self saveActiveFeed];
    [self setCheckMark];
    [self dismissSelectFeedViewController];

}

-(void)dismissSelectFeedViewController
{
    [self.delegate didDismissSelectFeedViewController:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
