//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
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
    
    
    
}



-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
    if([searchTermData getSearchTermsString] == nil)
    {
        tumblrTable = nil;
        [self.tableView reloadData];
        instructions.alpha = 1;
        tumblrTable.scrollEnabled = NO;
    }
    else
    {
        instructions.alpha = 0;
        tumblrTable.scrollEnabled = YES;
        
        NSString* TBusername;
        TBusername= [searchTermData getSearchTermsStringTumblr];
        NSString* myJSON=[NSString stringWithFormat:@"%@%@%@",@"https://api.tumblr.com/v2/tagged?tag=",TBusername,@"&api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGutBN4Xh10LXZhhRKjWlV4"];
        NSURL* myURL = [ NSURL URLWithString: myJSON ];
        
        NSURLRequest* myRequest = [ NSURLRequest requestWithURL: myURL ];
        AFHTTPRequestOperation* myOperation = [ [ AFHTTPRequestOperation alloc ] initWithRequest:myRequest ];
        
        [ myOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSString* stringFromSource = [ [ NSString alloc ] initWithData: responseObject encoding: NSUTF8StringEncoding ];
             
             
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
    
}



-(void)didDismissViewController:(UIViewController*)vc
{
}



#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"TBpost"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString* posturl=[self.postFromData objectAtIndex:indexPath.row].purl;
        
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
        
    }
    
}



-(void)didDismissSelectFeedViewController:(UIViewController*)vc
{
    
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
    
    if (![individualPost.sbody isEqualToString:@"none"]) {
        [[cell.contentView viewWithTag:3]removeFromSuperview];
        [[cell.contentView viewWithTag:6]removeFromSuperview];
        cellPostText.text =individualPost.sbody;
        cellHeight=150;
    }
    else{
        
        
        
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
                    
                    
                }
                else {
                    
                    image = [[UIImage alloc] initWithData:individualPost.SphotoData ];
                    
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
            
            NSString* embedHTML =individualPost.videourl;
            [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
            
            cellFrame.size.height += webView.frame.size.height + bottomBlank;
        }
        
        cellFrame.size.width = cell.frame.size.width;
        cell.frame = cellFrame;
        
        cellHeight = cellFrame.size.height;
    }
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
