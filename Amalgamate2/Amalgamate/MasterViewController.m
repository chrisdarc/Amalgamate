//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
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
    
    
    if([searchTermData getSearchTermsString] == nil)
    {
        tumblrTable = nil;
        instructions.alpha = 1;
        tumblrTable.scrollEnabled = NO;
    }
    else
    {
        instructions.alpha = 0;
        tumblrTable.scrollEnabled = YES;
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
    
}


- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

-(IBAction)managePressed:(id)sender
{
    ManageViewController* manageScreen = [[ManageViewController alloc] initWithNibName:@"ManageViewController" bundle: nil];
    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: manageScreen];
    manageScreen.delegate = self;
    [self presentViewController:enclosingNav animated:YES completion:nil];
//    ManageViewController* manageScreen = [[ManageViewController alloc] initWithNibName:@"ManageViewController" bundle: nil];
//    //    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: manageScreen];
//    manageScreen.delegate = self;
//    [self presentViewController: manageScreen animated:YES completion:nil];//]: enclosingNav animated: YES completion:nil];
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
    
    
    //----------added image--------------
    if ([individualPost.videourl isEqualToString:@"pic"]) {
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
    
}   //---------added a video---------------------
    else{
        UIWebView* webView;
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 99.0, 350.0, 280.0)];
        [webView setAllowsInlineMediaPlayback:YES];
        [webView setMediaPlaybackRequiresUserAction:NO];
        [cell.contentView addSubview:webView];
        //[self.view addSubview:self.webView];
        
//        NSString* embedHTML = [NSString stringWithFormat:@"\n<video  id='embed-56fb4a939f802192906454' class='crt-video crt-skin-default' width='250' height='444' poster='https://31.media.tumblr.com/tumblr_o4u1z8NpsX1rzftr5_frame1.jpg' preload='none' data-crt-video data-crt-options='{\"autoheight\":null,\"duration\":9,\"hdUrl\":false,\"filmstrip\":{\"url\":\"https:\\/\\/38.media.tumblr.com\\/previews\\/tumblr_o4u1z8NpsX1rzftr5_filmstrip.jpg\",\"width\":\"200\",\"height\":\"357\"}}' >\n    <source src=\"https://api.tumblr.com/video_file/141936067900/tumblr_o4u1z8NpsX1rzftr5/480\" type=\"video/mp4\">\n</video>\n"];
        //NSLog(individualPost.videourl);
        NSString* embedHTML =individualPost.videourl;
        [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
    
    
    }
    
   
   
   return cell;
}

-(void)dismissMasterViewController
{
    [self.delegate didDismissMasterViewController:self];
    [self dismissViewControllerAnimated:NO completion:nil];
}




@end
