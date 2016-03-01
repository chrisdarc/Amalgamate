//
//  SecondViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"

@interface FourthViewController : UIViewController <LoginViewControllerDelegate>
{
    IBOutlet UIButton* manageAccountsButton;
}
-(IBAction)displayLogin:(id)sender;

-(void)didDismissViewController:(UIViewController*)vc;

@end

