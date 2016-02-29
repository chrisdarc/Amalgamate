//
//  FirstViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "FirstViewController.h"
#import "Login.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
{
    LoginState *loginState;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    loginState = [LoginState new];
    [loginState setInitialLoggedIn];
    
    if ([loginState getLoggedInState])
    {
        //if the user is not logged in, present them with the login button.
        logInButton.alpha = 1;
        
    }
    else
    {
        //if the user is logged in, show them their feed
        feedLabel.alpha = 1;
        subtitle.alpha = 1;
    }
    
}

-(IBAction)presentLoginScreen:(id)sender
{
    Login* loginScreen = [[Login alloc] initWithNibName:@"Login" bundle: nil];
    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: loginScreen];
    [self presentViewController: enclosingNav animated: YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
