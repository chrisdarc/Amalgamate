//
//  TweetViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-05.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>
@interface TweetViewController : TWTRTimelineViewController{
    IBOutlet UIButton* BGo;
    IBOutlet UILabel* Lkeyword;
    IBOutlet UITextField* UserInput;
    IBOutlet UIImageView *Background;
}

- (IBAction)go:(id)sender;


@end
