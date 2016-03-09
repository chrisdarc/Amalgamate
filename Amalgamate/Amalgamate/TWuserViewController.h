//
//  TWuserViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-05.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TwitterKit/TwitterKit.h>
@interface TWuserViewController : TWTRTimelineViewController{
    IBOutlet UIButton* uBGo;
    IBOutlet UILabel* uLkeyword;
    IBOutlet UITextField* uUserInput;
    IBOutlet UIImageView *Background;
}
- (IBAction)ugo:(id)sender;

@end
