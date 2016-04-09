//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TumblrIndividualObject.h"

@interface TumblrPost : NSObject{
    NSString* username;
    NSString* des;
    NSString* Sdate;
}


-(instancetype)initWithData:(NSData*)dataReceived;

@property ( readonly ) NSUInteger numberOfPosts;

-(TumblrIndividualObject*)objectAtIndex:(NSInteger)index;

@end
