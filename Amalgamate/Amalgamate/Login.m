//
//  Login.m
//  
//
//  Created by Chris Darc on 2016-02-28.
//
//

#import "Login.h"

@interface Login ()
<FBSDKLoginButtonDelegate>

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    [loginButton setDelegate:self];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
}

- (void)  loginButton:  (FBSDKLoginButton *)loginButton
didCompleteWithResult:  (FBSDKLoginManagerLoginResult *)result
                error:  (NSError *)error
{
    NSLog(@"facebook login button successful");
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"facebook logout button successful");
}


-(IBAction)dismissLoginScreen:(id)sender
{
    [self.delegate didDismissViewController:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
