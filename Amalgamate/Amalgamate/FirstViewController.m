//
//  FirstViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
{
    LoginState* loginState;// = [[LoginState alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [loginState setInitialLoggedIn];
    
    //If user is not logged in, go to feed, otherwise present them with a log in button.
    if (![loginState getLoggedInState])
    {
        //button presentation
        amalgamateLabel.alpha = 1;
        subtitle.alpha = 1;
        logInButton.alpha = 1;
        
    }
    else
    {
        //show the feed
        [self showFeed];
    }
}

-(void)showFeed
{
    //if the user is logged in, show them their feed
    logInButton.enabled = NO;
    logInButton.alpha = 0;
    
    amalgamateLabel.text = @"Feed";
    subtitle.text = @"Feed will be here.";
    
    amalgamateLabel.alpha = 1;
    subtitle.alpha = 1;
}

-(IBAction)presentLoginScreen:(id)sender
{
    Login* loginScreen = [[Login alloc] initWithNibName:@"Login" bundle: nil];
    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: loginScreen];
    loginScreen.delegate = self;
    [self presentViewController: enclosingNav animated: YES completion:nil];
}

-(void)didDismissViewController:(UIViewController*)vc
{
    NSLog(@"Dismissed !!!!!");
    [self showFeed];
}

-(void)recordUserLoggedIn:(UIViewController*)vc
{
    NSLog(@"123");
    [loginState setLoggedInTrue];
}

-(void)recordUserLoggedOut:(UIViewController*)vc
{
    NSLog(@"456");
    [loginState setLoggedInFalse];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
