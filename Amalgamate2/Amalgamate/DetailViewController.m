//
//  DetailViewController.m
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/22/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
   if (_detailItem != newDetailItem) {
       _detailItem = newDetailItem;
           
       // Update the view.
       [self configureView];
   }
}

- (void)configureView {
   // Update the user interface for the detail item.
    NSString* myurl=[self.detailItem description];
   if (self.detailItem) {
       //self.detailDescriptionLabel.text = [self.detailItem description];
   }
    NSString* fburl= [NSString stringWithFormat:@"%@",myurl];
    NSURL* post =[NSURL URLWithString:fburl];
    NSLog(@"fuckoff");
    NSURLRequest* myre=[NSURLRequest requestWithURL:post];
    [postweb loadRequest:myre];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:fburl]];
}

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   [self configureView];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
