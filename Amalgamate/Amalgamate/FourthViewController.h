//
//  SecondViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"

static NSString *a1;
static NSString *a2;
static NSString *a3;
static NSString *a4;
@interface FourthViewController : UIViewController <LoginViewControllerDelegate>
{
    IBOutlet UIButton* manageAccountsButton;
    IBOutlet UITextField* account1;
    IBOutlet UITextField* account2;
    IBOutlet UITextField* account3;
    IBOutlet UITextField* account4;
    IBOutlet UIButton* TWaccounts;
    IBOutlet UIButton* Update;
    
}

-(IBAction)displayLogin:(id)sender;
-(IBAction)TWac:(id)sender;
- (IBAction)updateAccounts:(id)sender;
-(NSString*)getA1;
-(NSString*)getA2;
-(NSString*)getA3;
-(NSString*)getA4;
-(void)didDismissViewController:(UIViewController*)vc;


@end

