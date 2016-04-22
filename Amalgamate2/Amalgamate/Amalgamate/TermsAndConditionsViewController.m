//
//  TermsAndConditionsViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-04-21.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "TermsAndConditionsViewController.h"

@interface TermsAndConditionsViewController ()

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    termsAndConditionsTextView.editable = NO;
    
    termsAndConditionsLabel.alpha = 1.0;
    
    agreeButton.alpha = 1.0;
    agreeButton.enabled = YES;
    
    disagreeButton.alpha = 1.0;
    disagreeButton.enabled = YES;
    
    pleaseReadLabel.alpha = 0.0;
    
    viewTermsButton.alpha = 0.0;
    viewTermsButton.enabled = NO;
    
    termsAndConditionsTextView.alpha = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)agreeButtonPressed:(id)sender
{
    NSLog(@"Agree Pressed");
    [self.delegate termsAndConditionsAgreed:self];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)disagreeButtonPressed:(id)sender
{
    NSLog(@"Disagree Pressed");
    
    termsAndConditionsLabel.alpha = 0.0;
    
    agreeButton.alpha = 0.0;
    agreeButton.enabled = NO;
    
    disagreeButton.alpha = 0.0;
    disagreeButton.enabled = NO;
    
    pleaseReadLabel.alpha = 1.0;
    
    viewTermsButton.alpha = 1.0;
    viewTermsButton.enabled = YES;
    
    termsAndConditionsTextView.alpha = 0.0;
}

- (IBAction)viewTermsButtonPressed:(id)sender
{
    NSLog(@"View Terms Pressed");
    termsAndConditionsLabel.alpha = 1.0;
    
    agreeButton.alpha = 1.0;
    agreeButton.enabled = YES;
    
    disagreeButton.alpha = 1.0;
    disagreeButton.enabled = YES;
    
    pleaseReadLabel.alpha = 0.0;
    
    viewTermsButton.alpha = 0.0;
    viewTermsButton.enabled = NO;
    
    termsAndConditionsTextView.alpha = 1.0;
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
