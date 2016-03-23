//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *userName;
@interface TBViewController : UIViewController{
    
    IBOutlet UITextField* username;
}
-(NSString*)getTBUserName;
- (IBAction)TBuser:(id)sender;
@end
