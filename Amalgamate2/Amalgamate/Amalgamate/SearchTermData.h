//
//  SearchTermData.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-16.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchViewController.h"

@interface SearchTermData : NSObject

@property SearchViewController * searchVC;

@property (strong, nonatomic) NSMutableArray * termsToSearch;

-(NSArray*)loadSearchTerms;

-(NSString*)getSearchTermsString;

-(NSString*)getSearchTermsStringTwitter;

@end
