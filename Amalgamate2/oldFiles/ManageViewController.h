//
//  ManageViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@protocol ManageViewControllerDelegate <NSObject>
-(void)didDismissViewController:(UIViewController*)vc;
@end

@interface ManageViewController : UIViewController
//{
//    IBOutlet UIView *twitterButtonView;
//}

@property(nonatomic, weak) id<ManageViewControllerDelegate> delegate;


-(void)dismissLoginScreen;

//- (void)  loginButton:  (FBSDKLoginButton *)loginButton
//didCompleteWithResult:  (FBSDKLoginManagerLoginResult *)result
//                error:  (NSError *)error;
//
//- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton;


@end
