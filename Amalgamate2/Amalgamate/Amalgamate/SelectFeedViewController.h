//
//  SelectFeedViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-22.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectFeedViewControllerDelegate <NSObject>
-(void)didDismissSelectFeedViewController:(UIViewController*)vc;
@end

@interface SelectFeedViewController : UIViewController
{
    IBOutlet UILabel * twitterCheckMark;
    IBOutlet UILabel * tumblrCheckMark;
}

@property (strong, nonatomic) NSString * activeFeed;

@property(nonatomic, weak) id<SelectFeedViewControllerDelegate> delegate;

-(IBAction)twitterSelectorButtonPressed:(id)sender;

-(IBAction)tumblrSelectorButtonPressed:(id)sender;

-(void)dismissSelectFeedViewController;
@end
