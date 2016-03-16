//
//  SearchTermsData.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-15.
//  Copyright © 2016 Group10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchTermsData : NSObject

@property (strong, nonatomic) NSMutableArray * searchTerms;

-(void)initializeSearchTerms;

@end
