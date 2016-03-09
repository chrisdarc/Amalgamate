//
//  Account2ViewController.m
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-09.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "Account2ViewController.h"
#import "FourthViewController.h"
NSString* count2;
@interface Account2ViewController ()

@end

@implementation Account2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FourthViewController *obj = [[FourthViewController alloc] init];
    count2=obj.getA2;
    NSLog(count2);
    TWTRTimelineViewController *client = [[TWTRAPIClient alloc] init];
    TWTRUserTimelineDataSource *userTimelineDataSource = [[TWTRUserTimelineDataSource alloc] initWithScreenName: count2 APIClient:client];
    self.dataSource= userTimelineDataSource;
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
