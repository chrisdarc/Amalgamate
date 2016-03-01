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

@protocol LoginViewControllerDelegate <NSObject>
-(void)didDismissViewController:(UIViewController*)vc;
@end

@interface Login : UIViewController

@property(nonatomic, weak) id<LoginViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

- (void)  loginButton:  (FBSDKLoginButton *)loginButton
didCompleteWithResult:  (FBSDKLoginManagerLoginResult *)result
                error:  (NSError *)error;

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton;

-(IBAction)dismissLoginScreen:(id)sender;

@end
