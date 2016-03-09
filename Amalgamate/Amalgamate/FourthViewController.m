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

- (IBAction)updateAccounts:(id)sender{
    a1=account1.text;
    a2=account2.text;
    a3=account3.text;
    a4=account4.text;
}

-(NSString*)getA1{
    return a1;
}
-(NSString*)getA2{
    return a2;
}
-(NSString*)getA3{
    return a3;
}
-(NSString*)getA4{
    return a4;
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
