//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
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
@property NSString* videourl;
@property (nonatomic) NSString* sbody;
@end
