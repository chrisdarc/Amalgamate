//
//  Login.h
//  
//
//  Created by Chris Darc on 2016-02-28.
//
//

#import <UIKit/UIKit.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "FirstViewController.h"


@interface Login : UIViewController

//@property (nonatomic, copy) void (^didDismiss)(NSString *data);

@property LoginState *loginState;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

//-(void)didDismissViewController:(UIViewController*)vc;

- (void)  loginButton:  (FBSDKLoginButton *)loginButton
didCompleteWithResult:  (FBSDKLoginManagerLoginResult *)result
                error:  (NSError *)error;

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton;

-(IBAction)dismissLoginScreen:(id)sender;

@end
