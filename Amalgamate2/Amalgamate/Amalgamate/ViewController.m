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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    searchTermData = [SearchTermData new];
    
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
        
        
//        SelectFeedViewController* selectFeedViewController = [[SelectFeedViewController alloc] initWithNibName:@"SelectFeedViewController" bundle: nil];
//        UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: selectFeedViewController];
//        
//        selectFeedViewController.delegate = self;
//        [self presentViewController: enclosingNav animated: YES completion:nil];
        
        
        ManageViewController * tumblrViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"tumblrView"];
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
    
    //[self refreshFeed];
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


//-(IBAction)currentFeedButtonPressed:(id)sender
//{
//    SelectFeedViewController* selectFeedViewController = [[SelectFeedViewController alloc] initWithNibName:@"SelectFeedViewController" bundle: nil];
//    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: selectFeedViewController];
//    
//    selectFeedViewController.delegate = self;
//    [self presentViewController: enclosingNav animated: YES completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void) refreshFeed
//{
//    //[myTableView reload];
//}

-(IBAction)managePressed:(id)sender
{
    ManageViewController* manageScreen = [[ManageViewController alloc] initWithNibName:@"ManageViewController" bundle: nil];
    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: manageScreen];
    manageScreen.delegate = self;
    [self presentViewController:enclosingNav animated:YES completion:nil];
    //[self presentViewController: manageScreen animated:YES completion:nil];
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




//-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController*)controller
//{
//    return UIModalPresentationNone;
//}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    //number of sections to display social media
//    return (1);
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    //number of posts currently available to display?
//    return (25);
//}
//
//-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell* cellToReturn = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    
//    if(cellToReturn == nil)
//    {
//        cellToReturn = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"Cell"];
//    }
//    
//    //Call a get content function and put content here.
//    cellToReturn.textLabel.text = [NSString stringWithFormat:@"%ld %s", (long)indexPath.row, "Social Media Content"];
//    
//    return (cellToReturn);
//}
//
////function to get content from facebook?
//-(void) getContent
//{
//    return;
//}


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
