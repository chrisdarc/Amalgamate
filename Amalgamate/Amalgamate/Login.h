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

@interface Login : UIViewController

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

- (void)  loginButton:  (FBSDKLoginButton *)loginButton
didCompleteWithResult:  (FBSDKLoginManagerLoginResult *)result
                error:  (NSError *)error;

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton;

@end
