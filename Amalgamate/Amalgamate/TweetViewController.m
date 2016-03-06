//
//  TweetViewController.m
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-05.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    TWTRTimelineViewController *client = [[TWTRAPIClient alloc] init];
    self.dataSource = [[TWTRSearchTimelineDataSource
                        alloc] initWithSearchQuery:@"saskatoon" APIClient:(client)];
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
