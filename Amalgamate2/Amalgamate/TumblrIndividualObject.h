//
//  TumblrIndividualObject.h
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/29/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TumblrIndividualObject : NSObject

@property NSURL* photoURL;
@property NSData* photoData;
@property (nonatomic) NSString* photoCaption;
@property (nonatomic) NSString* postTime;
@property (nonatomic) NSString* purl;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* des;


@property (nonatomic) NSString* Susername;
@property NSURL* SphotoURL;
@property NSData* SphotoData;
@property (nonatomic) NSString* SpostTime;
@end
