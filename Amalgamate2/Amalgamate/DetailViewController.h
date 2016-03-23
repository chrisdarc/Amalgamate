//
//  DetailViewController.h
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/22/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    IBOutlet UIWebView *postweb;
}

@property (strong, nonatomic) id detailItem;
//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

