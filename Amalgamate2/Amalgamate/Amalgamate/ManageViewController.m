//
//  ManageViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "ManageViewController.h"
#import <TwitterKit/TwitterKit.h>


@interface ManageViewController ()

@end

@implementation ManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //dont need facebook button anymore
//    FBSDKLoginButton *loginButtonFB = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
////    loginButton.center = self.view.center;
////    [self.view addSubview:loginButton];
//    CGPoint fbPoint = self.view.center;//CGPointMake(187.5, 250);
//    fbPoint.y = fbPoint.y + 50;
//    loginButtonFB.center = fbPoint;
//    [self.view addSubview:loginButtonFB];
    
    self.navigationItem.title = @"Amalgamate";
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector (dismissLoginScreen)];
    
    
    self.navigationItem.rightBarButtonItem = doneButton;
    
    TWTRLogInButton *loginButtonTW = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            // Callback for login success or failure. The TWTRSession
            // is also available on the [Twitter sharedInstance]
            // singleton.
            //
            // Here we pop an alert just to give an example of how
            // to read Twitter user info out of a TWTRSession.
            //
            // TODO: Remove alert and use the TWTRSession's userID
            // with your app's user model
            NSString *message = [NSString stringWithFormat:@"@%@ logged in! (%@)",
                                 [session userName], [session userID]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged in!"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else {
            NSLog(@"Login error: %@", [error localizedDescription]);
        }
    }];
    
    // TODO: Change where the log in button is positioned in your view
    CGPoint loc = self.view.center;
    loginButtonTW.center = loc;
    loginButtonTW.contentScaleFactor = 0.2;
    //[twitterButtonView addSubview:loginButtonTW];
    [self.view addSubview:loginButtonTW];
    
//    [loginButtonFBParent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[loginButtonFB(==loginButtonTW)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loginButtonFB, loginButtonTW)]];
//    [loginButtonFBParent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loginButtonFB(==loginButtonTW)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loginButtonFB, loginButtonTW)]];
//    [loginButtonFB addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[loginButtonFB(>=100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loginButtonFB)]];
//    [loginButtonFB addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loginButtonFB(>=26)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(loginButtonFB)]];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (void)  loginButton:  (FBSDKLoginButton *)loginButton
//didCompleteWithResult:  (FBSDKLoginManagerLoginResult *)result
//                error:  (NSError *)error
//{
//    NSLog(@"facebook login button successful");
//}
//
//- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
//{
//    NSLog(@"facebook logout button successful");
//}


-(void)dismissLoginScreen
{
    [self.delegate didDismissViewController:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
