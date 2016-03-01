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
    Login *login;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //first go, if user is logged in or not.
    NSLog(@"%d\n", login.loginState.getLoggedInState);
    if (![login.loginState getLoggedInState])
    {
        //if the user is not logged in, present them with the login button.
        NSLog(@"Got Here");
        amalgamateLabel.alpha = 1;
        subtitle.alpha = 1;
        logInButton.alpha = 1;
        
    }
    else
    {
        [self showFeed];
    }
}

-(void)showFeed
{
    NSLog(@"also got here...");
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
//    Login * loginScreen = [[Login alloc] init];
//    [self presentViewController: loginScreen animated:YES completion:nil];
//    Login* loginScreen = [[Login alloc] initWithNibName:@"Login" bundle: nil];
//    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: loginScreen];
//    __weak typeof(self) weakSelf = self;
//    login.didDismiss = ^(NSString *data)
//    {
//        NSLog(@"Dismissed SecondViewController");
//        [weakSelf showFeed];
//    };
//    [self presentViewController:loginScreen animated:YES completion:nil];
    
    //login = [Login new];
    
    Login* loginScreen = [[Login alloc] initWithNibName:@"Login" bundle: nil];
    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: loginScreen];
    [self presentViewController: enclosingNav animated: YES completion:nil];
}

-(void)didDismissViewController
{
    NSLog(@"Dismissed !!!!!");
    [self showFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
