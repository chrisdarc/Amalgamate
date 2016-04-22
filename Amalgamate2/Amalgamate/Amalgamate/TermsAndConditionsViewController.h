//
//  TermsAndConditionsViewController.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-04-21.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TermsAndConditionsViewControllerDelegate <NSObject>
-(void)termsAndConditionsAgreed:(UIViewController*)vc;
@end

@interface TermsAndConditionsViewController : UIViewController
{
    __weak IBOutlet UILabel *termsAndConditionsLabel;
    __weak IBOutlet UIButton *agreeButton;
    __weak IBOutlet UIButton *disagreeButton;
    __weak IBOutlet UILabel *pleaseReadLabel;
    __weak IBOutlet UIButton *viewTermsButton;
    __weak IBOutlet UITextView *termsAndConditionsTextView;
    
}

@property(nonatomic, weak) id<TermsAndConditionsViewControllerDelegate> delegate;

@end
