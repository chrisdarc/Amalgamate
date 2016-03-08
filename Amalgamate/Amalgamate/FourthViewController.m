//
//  SecondViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "FourthViewController.h"
#import "FirstViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface FourthViewController ()

@end

@implementation FourthViewController


-(IBAction)temp:(id)sender{
        TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    TWTRSession *sssion;
        TWTRSession *lastSession = store.session;
        NSArray *sessions = [store existingUserSessions];
        TWTRSession *specificSession = [store sessionForUserID:@"123"];
    
    NSLog([lastSession userName]);
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)displayLogin:(id)sender
{
    Login* loginScreen = [[Login alloc] initWithNibName:@"Login" bundle: nil];
    UINavigationController* enclosingNav = [[UINavigationController alloc] initWithRootViewController: loginScreen];
    loginScreen.delegate = self;
    [self presentViewController: enclosingNav animated: YES completion:nil];
}

-(void)didDismissViewController:(UIViewController*)vc
{
    NSLog(@"Dismissed in fourth");
    //[self.delegate whatToShowFromOtherClass:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
