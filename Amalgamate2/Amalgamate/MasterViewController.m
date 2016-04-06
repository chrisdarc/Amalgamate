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
{
    float cellHeight;
}

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
        [self.tableView reloadData];
        //self.dataSource = nil;
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

//-(IBAction)managePressed:(id)sender
//{
//    ManageViewController* manageScreen = [[ManageViewController alloc] initWithNibName:@"ManageViewController" bundle: nil];
//    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: manageScreen];
//    manageScreen.delegate = self;
//    [self presentViewController:enclosingNav animated:YES completion:nil];
//    //    ManageViewController* manageScreen = [[ManageViewController alloc] initWithNibName:@"ManageViewController" bundle: nil];
//    //    //    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: manageScreen];
//    //    manageScreen.delegate = self;
//    //    [self presentViewController: manageScreen animated:YES completion:nil];//]: enclosingNav animated: YES completion:nil];
//}

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
    if([searchTermData getSearchTermsString] == nil)
    {
        //[self.tableView reloadData];
        
        return 0;
    }
    else
    {
        return self.postFromData.numberOfPosts;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    TumblrIndividualObject* individualPost = [ self.postFromData objectAtIndex: indexPath.row ];
    
    //      // ---------------------- add username ----------------------
    //    UILabel* cellusername = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 220.0, 15.0)];
    //
    //    cellusername.tag = 4;
    //    cellusername.font = [UIFont systemFontOfSize:17.0];
    //    //    cellPostTime.textAlignment = UITextAlignmentLeft;
    //    cellusername.textColor = [UIColor blueColor];
    //    cellusername.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    //    [cell.contentView addSubview:cellusername];
    //    // ----------------------- add tumblr icon -----------------
    //    UIImageView* tumblrIcon = [[UIImageView alloc] initWithFrame:CGRectMake(330.0, 0.0, 18.0, 18.0)];
    //    tumblrIcon.image = [UIImage imageNamed: @"favicon.ico"];
    //    [cell.contentView addSubview:tumblrIcon];
    //
    //    // ---------------------- add description ----------------------
    //    UILabel* celldes = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 17.0, 220.0, 15.0)];
    //
    //    celldes.tag = 5;
    //    celldes.font = [UIFont systemFontOfSize:14.0];
    //    //    cellPostTime.textAlignment = UITextAlignmentLeft;
    //    celldes.textColor = [UIColor blueColor];
    //    celldes.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    //    [cell.contentView addSubview:celldes];
    //    // ---------------------- add post time ----------------------
    ////       UIView *viewToRemove = [self.view viewWithTag:1];
    ////       [viewToRemove removeFromSuperview];
    //    UILabel* cellPostTime = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 34.0, 220.0, 15.0)];
    //
    //    cellPostTime.tag = 1;
    //    cellPostTime.font = [UIFont systemFontOfSize:14.0];
    //    //    cellPostTime.textAlignment = UITextAlignmentLeft;
    //    cellPostTime.textColor = [UIColor blackColor];
    //    cellPostTime.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    //    [cell.contentView addSubview:cellPostTime];
    //
    //    // ---------------------- add post text ----------------------
    ////        UIView *viewToRemove2 = [self.view viewWithTag:2];
    ////       [viewToRemove2 removeFromSuperview];
    //    UILabel* cellPostText = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 55.0, 300.0, 45.0)];
    //
    //    //    cellPostText.textAlignment = UITextAlignmentCenter;
    //    cellPostText.lineBreakMode = UILineBreakModeWordWrap;
    //    cellPostText.numberOfLines = 0;
    //    cellPostText.tag = 2;
    //    cellPostText.font = [UIFont systemFontOfSize:17.0];
    //    //    cellPostText.textAlignment = UITextAlignmentLeft;
    //    cellPostText.textColor = [UIColor blackColor];
    //    cellPostText.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    //    [cell.contentView addSubview:cellPostText];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // --------------- define for layout -------------------
    float topBlank = 10.0;
    float bottomBlank = 10.0;
    float sectionLineBlank = 5.0;
    
    float widthX = 12.0;
    float startX = cell.frame.origin.x + widthX;
    
    float endX = cell.frame.origin.x + cell.frame.size.width - widthX;
    float iconEdge = 18.0;
    
    float imageWidth = cell.frame.origin.x + cell.frame.size.width - widthX * 2;
    float textWidth = cell.frame.origin.x + cell.frame.size.width - widthX * 2;
    
    // --------------- define for the cell conponent ----------------
    UILabel* cellusername;
    UIImageView* tumblrIcon;
    UILabel* cellPostTime;
    UILabel* cellPostText;
    UIImageView* myImage;
    UIWebView* webView;
    
    // --------------- username -----------------
    cellusername = [[UILabel alloc]
                    initWithFrame:CGRectMake(startX, topBlank + 0.0,
                                             220.0, 17.0)];
    
    cellusername.tag = 4;
    cellusername.font = [UIFont systemFontOfSize:17.0];
    cellusername.textColor = [UIColor blueColor];
    
    [cell.contentView addSubview:cellusername];
    
    // --------------- icon -----------------
    tumblrIcon = [[UIImageView alloc]
                  initWithFrame:CGRectMake(endX - iconEdge, topBlank + 0.0,
                                           iconEdge, iconEdge)];
    
    tumblrIcon.image = [UIImage imageNamed: @"favicon.ico"];
    
    [cell.contentView addSubview:tumblrIcon];
    
    // ------------- section 2: post time --------------
    cellPostTime = [[UILabel alloc]
                    initWithFrame:CGRectMake(startX, cellusername.frame.origin.y +
                                             cellusername.frame.size.height +
                                             sectionLineBlank,
                                             220.0, 15.0)];
    cellPostTime.tag = 1;
    cellPostTime.font = [UIFont systemFontOfSize:14.0];
    cellPostTime.textColor = [UIColor blackColor];
    
    [cell.contentView addSubview:cellPostTime];
    
    // ------------- section 3: post text --------------
    cellPostText = [[UILabel alloc]
                    initWithFrame:CGRectMake(startX, cellPostTime.frame.origin.y +
                                             cellPostTime.frame.size.height + sectionLineBlank,
                                             0.0, 0.0)];
    cellPostText.tag = 2;
    
    // ------------ set text label size dynamic ---------------------
    cellPostText.lineBreakMode = UILineBreakModeWordWrap;
    CGSize maximumLabelSize = CGSizeMake(296,999);
    CGSize expectedLabelSize = [individualPost.photoCaption
                                sizeWithFont:[UIFont systemFontOfSize:17.0]
                                constrainedToSize:maximumLabelSize
                                lineBreakMode: cellPostText.lineBreakMode];
    cellPostText.numberOfLines = 0;
    CGRect tempFrame = cellPostText.frame;
    tempFrame.size.height = expectedLabelSize.height;
    tempFrame.size.width = textWidth;
    cellPostText.frame = tempFrame;
    
    [cell.contentView addSubview:cellPostText];
    
    
    
    if ( cell == nil )
    {
        cell = [ [ UITableViewCell alloc ] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: @"Cell" ];
    }
    else{
        cellPostTime = (UILabel *)[cell.contentView viewWithTag:1];
        cellPostText = (UILabel *)[cell.contentView viewWithTag:2];
        cellusername = (UILabel *)[cell.contentView viewWithTag:4];
    }
    
    // ------------- add content for each component ----------------
    cellusername.text = individualPost.Susername;
    cellPostTime.text = individualPost.SpostTime;
    cellPostText.text = individualPost.photoCaption;
    
    // ------------- calculate the height without image/gif/vedio -------------
    CGRect cellFrame;
    cellFrame.size.height = topBlank +
    cellusername.frame.size.height +
    sectionLineBlank +
    cellPostTime.frame.size.height +
    sectionLineBlank +
    cellPostText.frame.size.height +
    sectionLineBlank;
    
    //----------added image--------------
    if ([individualPost.videourl isEqualToString:@"pic"])
    {
        if ( individualPost.SphotoData != nil )
        {
            UIImage* image;
            NSString *path = [individualPost.SphotoURL path];//get the extension of the url, in oreder to check if it is a gif
            NSString * extension = [path pathExtension];
            //            NSLog(extension);
            
            myImage = [[UIImageView alloc]
                       initWithFrame: CGRectMake(startX, cellPostText.frame.origin.y +
                                                 cellPostText.frame.size.height +
                                                 sectionLineBlank,
                                                 imageWidth, 280)];
            myImage.tag = 3;
            [[cell.contentView viewWithTag:3]removeFromSuperview];
            [[cell.contentView viewWithTag:6]removeFromSuperview];
            [cell.contentView addSubview:myImage];
            myImage.contentMode = UIViewContentModeScaleAspectFit;// aspect fit
            
            if ([extension isEqualToString:@"gif"])
            {
                image = [UIImage animatedImageWithAnimatedGIFURL:individualPost.SphotoURL];
                //            myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 99.0, 350.0, 280.0)];
                //            myImage.tag = 3;
                //            myImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
                //            [[cell.contentView viewWithTag:3]removeFromSuperview] ;
                //            [[cell.contentView viewWithTag:6]removeFromSuperview] ;
                //            [cell.contentView addSubview:myImage];
                //myImage=(UIImageView *)[cell.contentView viewWithTag:3];
                //            myImage.contentMode = UIViewContentModeScaleAspectFit;// aspect fit
                //            myImage.image=image;
                
            }
            else {
                //            myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 99.0, 350.0, 280.0)];
                //            myImage.tag = 3;
                //            myImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
                //            [[cell.contentView viewWithTag:3]removeFromSuperview] ;
                //            [[cell.contentView viewWithTag:6]removeFromSuperview] ;
                //            [cell.contentView addSubview:myImage];
                //myImage=(UIImageView *)[cell.contentView viewWithTag:3];
                //            myImage.contentMode = UIViewContentModeScaleAspectFit;// aspect fit
                image = [[UIImage alloc] initWithData:individualPost.SphotoData ];
                
                //            myImage.image=[ [ UIImage alloc ] initWithData: individualPost.SphotoData ];
            }
            myImage.image=image;
            
            cellFrame.size.height += myImage.frame.size.height + bottomBlank;
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
    else {
        [[cell.contentView viewWithTag:6]removeFromSuperview] ;
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(startX, cellPostText.frame.origin.y +
                                                              cellPostText.frame.size.height +
                                                              sectionLineBlank,
                                                              imageWidth, 280)];
        [webView setAllowsInlineMediaPlayback:YES];
        [webView setMediaPlaybackRequiresUserAction:NO];
        webView.tag=6;
        [cell.contentView addSubview:webView];
        //[self.view addSubview:self.webView];
        
        //        NSString* embedHTML = [NSString stringWithFormat:@"\n<video  id='embed-56fb4a939f802192906454' class='crt-video crt-skin-default' width='250' height='444' poster='https://31.media.tumblr.com/tumblr_o4u1z8NpsX1rzftr5_frame1.jpg' preload='none' data-crt-video data-crt-options='{\"autoheight\":null,\"duration\":9,\"hdUrl\":false,\"filmstrip\":{\"url\":\"https:\\/\\/38.media.tumblr.com\\/previews\\/tumblr_o4u1z8NpsX1rzftr5_filmstrip.jpg\",\"width\":\"200\",\"height\":\"357\"}}' >\n    <source src=\"https://api.tumblr.com/video_file/141936067900/tumblr_o4u1z8NpsX1rzftr5/480\" type=\"video/mp4\">\n</video>\n"];
        //NSLog(individualPost.videourl);
        NSString* embedHTML =individualPost.videourl;
        [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
        
        cellFrame.size.height += webView.frame.size.height + bottomBlank;
    }
    
    cellFrame.size.width = cell.frame.size.width;
    cell.frame = cellFrame;
    
    cellHeight = cellFrame.size.height;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}

-(void)dismissMasterViewController
{
    [self.delegate didDismissMasterViewController:self];
    [self dismissViewControllerAnimated:NO completion:nil];
}




@end
