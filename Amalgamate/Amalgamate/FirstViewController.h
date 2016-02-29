//
//  FirstViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginState.h"

@interface FirstViewController : UIViewController
{
    IBOutlet UIButton* logInButton;
    IBOutlet UILabel* feedLabel;
    IBOutlet UILabel* subtitle;
}

-(IBAction)presentLoginScreen:(id)sender;

@end

