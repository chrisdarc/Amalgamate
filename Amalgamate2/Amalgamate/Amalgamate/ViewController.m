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
@synthesize searchTermData, activeFeed;


- (IBAction)contactUs:(id)sender {
    // Email Subject
    NSString *emailTitle = @"Amalgamate issue report";
    // Email Content
    NSString *messageBody = @"I want to report this issue";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"amalgamateapp@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    searchTermData = [SearchTermData new];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"iFLaunchedOnce"])
    {
        NSLog(@"it is the first time");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"iFLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"agreedToTerms"];

        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"agreedToTerms"])
    {
        TermsAndConditionsViewController * termsView = [[TermsAndConditionsViewController alloc]initWithNibName:@"TermsAndConditionsViewController" bundle: nil];
        
        //delegate
        termsView.delegate = self;
        
        [self presentViewController:termsView animated:NO completion:nil];
    }
}

-(void)termsAndConditionsAgreed:(UIViewController*)vc
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"agreedToTerms"];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    [self loadActiveFeed];
    
    if([searchTermData getSearchTermsString] == nil)
    {
        NSLog(@"string is nil");
        NSLog(@"%s%@", "String contains: ", [searchTermData getSearchTermsString]);
        self.dataSource = nil;
        feed.scrollEnabled = NO;
        infoLabel.alpha = 1;
        
    }
    else if([activeFeed isEqualToString:@"TWITTER"])
    {
        NSLog(@"Displaying Twitter Feed");
        infoLabel.alpha = 0;
        feed.scrollEnabled = YES;

        
        NSString * twitterSearchQuery = [searchTermData getSearchTermsStringTwitter];
        TWTRTimelineViewController *client = [[TWTRAPIClient alloc] init];
        self.dataSource = [[TWTRSearchTimelineDataSource alloc] initWithSearchQuery:twitterSearchQuery APIClient:client];
    }
    else if ([activeFeed isEqualToString:@"TUMBLR"])
    {
        infoLabel.alpha = 0;
        feed.scrollEnabled = YES;


        NSString * tumblrSearchQuery = [searchTermData getSearchTermsStringTumblr];
        
//        **TUMBLR TABLE VIEW CODE GOES HERE**
        //set self.dataSource to be your table view.
        self.dataSource = nil;
        
        
        MasterViewController * tumblrViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tumblrView"];
        UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController:tumblrViewController];
        tumblrViewController.delegate = self;
        [self presentViewController:enclosingNav animated:NO completion:nil];
        //[self presentViewController:tumblrViewController animated:YES completion:nil];
        
        
        NSLog(@"Displaying Tumblr Feed");
    }
    else
    {
        NSLog(@"Error displaying feed");
        self.dataSource = nil;
    }
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didDismissViewController:(UIViewController*)vc
{
    NSLog(@"Dismissed !!!!!");
}

-(void)didDismissSelectFeedViewController:(UIViewController *)vc
{
    NSLog(@"SelectFeedViewController Dissmissed");
}

-(void)didDismissMasterViewController:(UIViewController *)vc
{
    NSLog(@"MasterViewController (TUMBLR) Dissmissed");
    //[self viewDidAppear:YES];
    
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
     if([[segue identifier] isEqualToString:@"toSelectFeed"])
     {
         SelectFeedViewController* selectFeedViewController = [[SelectFeedViewController alloc] initWithNibName:@"SelectFeedViewController" bundle: nil];
         UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: selectFeedViewController];
         
         selectFeedViewController.delegate = self;
         [self presentViewController: enclosingNav animated: YES completion:nil];
//         [self presentModalViewController:otherViewCon animated:YES];
     }
     
 }

@end
