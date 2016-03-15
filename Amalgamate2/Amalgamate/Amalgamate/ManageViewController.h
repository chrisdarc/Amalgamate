//
//  ManageViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ManageViewControllerDelegate <NSObject>
-(void)didDismissViewController:(UIViewController*)vc;
@end

@interface ManageViewController : UIViewController

@property(nonatomic, weak) id<ManageViewControllerDelegate> delegate;


-(IBAction)dismissLoginScreen:(id)sender;

@end
