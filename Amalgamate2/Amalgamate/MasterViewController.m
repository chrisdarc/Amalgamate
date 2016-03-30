//
//  MasterViewController.m
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/22/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"//didn't use at all
#import "TBViewController.h"
#import "SBJson.h"
#import "AFNetworking.h"
#import "UIImage+animatedGIF.h"
#import "TumblrPost.h"

@interface MasterViewController ()

@property TumblrPost* postFromData;
@end

@implementation MasterViewController
@synthesize searchTermData;


- (void)awakeFromNib {
   [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchTermData = [SearchTermData new];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    //self.navigationItem.title = @"Amalgamate";
    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector (dismissMasterViewController)];
//    
//    
//    self.navigationItem.rightBarButtonItem = doneButton;
   
}



-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    //The wrong way
    //   NSURL* myURL = [ NSURL URLWithString: @"http://nbctv.tumblr.com/api/read/json" ];
    //
    ////   NSURLRequest* myRequest = [ NSURLRequest requestWithURL: myURL ];
    //
    //   NSString* stringFromSource = [ NSString stringWithContentsOfURL: myURL encoding: NSUTF8StringEncoding error: nil ];
    //
    //   NSLog( @"%@", stringFromSource );
    NSString* TBusername;
    TBViewController *obj = [[TBViewController alloc] init];
    //TBusername=obj.getTBUserName;
    TBusername= [searchTermData getSearchTermsStringTumblr];
    NSString* myJSON=[NSString stringWithFormat:@"%@%@%@",@"https://api.tumblr.com/v2/tagged?tag=",TBusername,@"&api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"];
    NSURL* myURL = [ NSURL URLWithString: myJSON ];
    
    NSURLRequest* myRequest = [ NSURLRequest requestWithURL: myURL ];
    AFHTTPRequestOperation* myOperation = [ [ AFHTTPRequestOperation alloc ] initWithRequest:myRequest ];
    
    [ myOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString* stringFromSource = [ [ NSString alloc ] initWithData: responseObject encoding: NSUTF8StringEncoding ];
         
         //NSLog( @"%@", stringFromSource );
         
         self.postFromData = [ [ TumblrPost alloc ] initWithData: responseObject ];
         
         [ self.tableView reloadData ];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         self.postFromData = nil;
         
         [ self.tableView reloadData ];
     }];
    
    [ myOperation start ];
    
}


- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
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
}



#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"TBpost"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString* posturl=[self.postFromData objectAtIndex:indexPath.row].purl;
        NSLog(posturl);
        [[segue destinationViewController] setDetailItem:posturl];
    }
    
    if([[segue identifier] isEqualToString:@"toHome"])
    {
        SelectFeedViewController* selectFeedViewController = [[SelectFeedViewController alloc] initWithNibName:@"SelectFeedViewController" bundle: nil];
        UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: selectFeedViewController];
        
        selectFeedViewController.delegate = self;
        [self presentViewController: enclosingNav animated: YES completion:nil];
    }
    if ([[segue identifier] isEqualToString:@"toSearchFromTumblr"])
    {
        
        // Get reference to the destination view controller
        SearchViewController *SearchScreen;
        SearchScreen = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
    }
    
}



-(void)didDismissSelectFeedViewController:(UIViewController*)vc
{
//    [self.delegate didDismissMasterViewController:self];
//    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"FEED SELECTED, TRYING TO DISMISS TUMBLR SCREEN");
    
    //don't know why, need to dimsiss four times to make it actually dismiss
    [self dismissMasterViewController];
    [self dismissMasterViewController];
    [self dismissMasterViewController];
    [self dismissMasterViewController];
}






#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.postFromData.numberOfPosts;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    TumblrIndividualObject* individualPost = [ self.postFromData objectAtIndex: indexPath.row ];
    // ---------------------- add none string ----------------------
    UILabel* ns= [[UILabel alloc] initWithFrame:CGRectMake(0.0, 350.0, 220.0, 0.0)];
    
    ns.text=@"ffffffffffffffffff!!!!!";
    ns.font = [UIFont systemFontOfSize:17.0];
    //    cellPostTime.textAlignment = UITextAlignmentLeft;
    ns.textColor = [UIColor blueColor];
    ns.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:ns];
      // ---------------------- add username ----------------------
    UILabel* cellusername = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 220.0, 15.0)];
    
    cellusername.tag = 4;
    cellusername.font = [UIFont systemFontOfSize:17.0];
    //    cellPostTime.textAlignment = UITextAlignmentLeft;
    cellusername.textColor = [UIColor blueColor];
    cellusername.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:cellusername];
    // ----------------------- add tumblr icon -----------------
    UIImageView* tumblrIcon = [[UIImageView alloc] initWithFrame:CGRectMake(330.0, 0.0, 18.0, 18.0)];
    tumblrIcon.image = [UIImage imageNamed: @"favicon.ico"];
    [cell.contentView addSubview:tumblrIcon];
    // ---------------------- add description ----------------------
    UILabel* celldes = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 17.0, 220.0, 15.0)];
    
    celldes.tag = 5;
    celldes.font = [UIFont systemFontOfSize:14.0];
    //    cellPostTime.textAlignment = UITextAlignmentLeft;
    celldes.textColor = [UIColor blueColor];
    celldes.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:celldes];
    // ---------------------- add post time ----------------------
//       UIView *viewToRemove = [self.view viewWithTag:1];
//       [viewToRemove removeFromSuperview];
    UILabel* cellPostTime = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 34.0, 220.0, 15.0)];
    
    cellPostTime.tag = 1;
    cellPostTime.font = [UIFont systemFontOfSize:14.0];
    //    cellPostTime.textAlignment = UITextAlignmentLeft;
    cellPostTime.textColor = [UIColor blackColor];
    cellPostTime.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:cellPostTime];
    
    // ---------------------- add post text ----------------------
//        UIView *viewToRemove2 = [self.view viewWithTag:2];
//       [viewToRemove2 removeFromSuperview];
    UILabel* cellPostText = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 55.0, 300.0, 45.0)];
    
    //    cellPostText.textAlignment = UITextAlignmentCenter;
    cellPostText.lineBreakMode = UILineBreakModeWordWrap;
    cellPostText.numberOfLines = 0;
    cellPostText.tag = 2;
    cellPostText.font = [UIFont systemFontOfSize:17.0];
    //    cellPostText.textAlignment = UITextAlignmentLeft;
    cellPostText.textColor = [UIColor blackColor];
    cellPostText.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    [cell.contentView addSubview:cellPostText];
    
    
    
    
   if ( cell == nil )
   {
      cell = [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"Cell" ];
   }
   else{
       cellPostTime = (UILabel *)[cell.contentView viewWithTag:1];
       cellPostText = (UILabel *)[cell.contentView viewWithTag:2];
       cellusername = (UILabel *)[cell.contentView viewWithTag:4];
       celldes= (UILabel *)[cell.contentView viewWithTag:5];
   }
   
   cellPostText.text = individualPost.photoCaption;
    NSLog(individualPost.SpostTime);
    cellPostTime.text = individualPost.SpostTime;// cellPostTime.text = individualPost.postTime;
    cellusername.text=individualPost.Susername;//cellusername.text=individualPost.title;
    //celldes.text=individualPost.Susername;//celldes.text=individualPost.des;
      if ( individualPost.SphotoData != nil )
    {
        NSString *path = [individualPost.SphotoURL path];//get the extension of the url, in oreder to check if it is a gif
        NSString * extension = [path pathExtension];
        NSLog(extension);
        if ([extension isEqualToString:@"gif"]) {
             NSLog(@"exhaust!!!!!!!!!!!");
            UIImage* mygif = [UIImage animatedImageWithAnimatedGIFURL:individualPost.SphotoURL];
            NSLog(@"aaaaaaaaaaaaaa!!!!!!!!!!!");
            UIImageView* myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 99.0, 350.0, 280.0)];
            myImage.tag = 3;
            myImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
            
            myImage.image=mygif;
            [cell.contentView addSubview:myImage];
           
        }
        else{
    UIImageView* myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 99.0, 350.0, 280.0)];
    myImage.tag = 3;
    myImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    myImage.image=[ [ UIImage alloc ] initWithData: individualPost.SphotoData ];
    [cell.contentView addSubview:myImage];
        }
    }
    
   else
   {
      if ( individualPost.SphotoURL != nil )
      {
        
         NSURLRequest* myRequest = [ NSURLRequest requestWithURL: individualPost.SphotoURL ];
         AFHTTPRequestOperation* myOperation = [ [ AFHTTPRequestOperation alloc ] initWithRequest: myRequest ];
         
         myOperation.userInfo = @{ @"Data" : individualPost };
         
         [ myOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            NSData* SphotoData = responseObject;
            
            NSDictionary* myUserInfo = operation.userInfo;
             
            
            TumblrIndividualObject* objectToUpdate = [ myUserInfo objectForKey: @"Data" ];
             
            objectToUpdate.SphotoData = SphotoData;
            
            [ self.tableView reloadData ];
            
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
         
            //do nothing
         }];
         
         [ myOperation start ];
      }
      else
      {
      
         //do nothing
      }
   }
   
   
   return cell;
}

-(void)dismissMasterViewController
{
    [self.delegate didDismissMasterViewController:self];
    [self dismissViewControllerAnimated:NO completion:nil];
}




@end
