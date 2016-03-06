//
//  SecondViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "SecondViewController.h"
#import "Login.h"

//static NSString* keyword;
@interface SecondViewController ()

@end

@implementation SecondViewController

- (IBAction)tweetTapped:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction) openWebpage:(id)sender{
        Login* obj = [[Login alloc] init];
        NSString* _usernameforTW= obj.getusername;
    
    NSString* twurl= [NSString stringWithFormat:@"%@%@",@"https://twitter.com/",_usernameforTW];
   // NSLog(_usernameforTW);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:twurl]];
    /*
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/"]];
    //[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error){
        NSString: *userID = [Twitter sharedInstance].sessionStore.session.userID;
        //NSString: *userName =[Twitter sharedInstance].sessionStore.session.userName;
        NSLog(userID);
        NSLog([session userName]);

    //}]
    
      //TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:userID];
    
   //[client loadTweetWithID:@"20" completion:^(TWTRTweet *tweet, NSError *error) {
        // handle the response or error
   //}];
     */
}

-(IBAction)settingsForsocial:(id)sender{
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=TWITTER"]];

}




- (IBAction) openWebpageFB:(id)sender{
    
    
    NSString* fburl= [NSString stringWithFormat:@"%@",@"https://www.facebook.com"];
    // NSLog(_usernameforTW);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fburl]];
    /*
     //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/"]];
     //[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error){
     NSString: *userID = [Twitter sharedInstance].sessionStore.session.userID;
     //NSString: *userName =[Twitter sharedInstance].sessionStore.session.userName;
     NSLog(userID);
     NSLog([session userName]);
     
     //}]
     
     //TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:userID];
     
     //[client loadTweetWithID:@"20" completion:^(TWTRTweet *tweet, NSError *error) {
     // handle the response or error
     //}];
     */
}

//-(IBAction)search:(id)sender{
//    keyword=_SearchKeyword.text;
//    NSLog(@"11111");
//    NSLog(keyword);
//}
//
//
//-(void) setKeyword{
//    keyword=_SearchKeyword.text;
//    NSLog(@"2222");
//    NSLog(keyword);
//}
//
//-(NSString*)getKeyWord{
//    _MYKeyWord=keyword;
//    NSLog(@"33333");
//    NSLog(_MYKeyWord);
//    return [self MYKeyWord];
//}



- (void)viewDidLoad {
    [super viewDidLoad];
//    TWTRLogInButton* logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession* session, NSError* error) {
//        if (session) {
//            NSLog(@"signed in as %@", [session userName]);
//            _usernameforTW=[session userName];
//        } else {
//            NSLog(@"error: %@", [error localizedDescription]);
//            _usernameforTW=[session userName];
//        }
//    }];
//    logInButton.center = self.view.center;
//    [self.view addSubview:logInButton];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
