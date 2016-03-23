//
//  TumblrPost.h
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/29/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TumblrIndividualObject.h"

@interface TumblrPost : NSObject{
    NSString* username;
    NSString* des;
    NSString* Sdate;
}

+(BOOL)dataIsValid:(NSData*)dataReceived;

-(instancetype)initWithData:(NSData*)dataReceived;

@property ( readonly ) NSUInteger numberOfPosts;

-(TumblrIndividualObject*)objectAtIndex:(NSInteger)index;

@end
