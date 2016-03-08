//
//  TweetViewController.m
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-05.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "TweetViewController.h"
#import "SecondViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController



- (IBAction)go:(id)sender{
    
    UserInput.alpha=0;
    BGo.alpha=0;
    Lkeyword.alpha=0;
    TWTRTimelineViewController *client = [[TWTRAPIClient alloc] init];
    self.dataSource = [[TWTRSearchTimelineDataSource
                        alloc] initWithSearchQuery: UserInput.text APIClient:(client)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    
    
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
