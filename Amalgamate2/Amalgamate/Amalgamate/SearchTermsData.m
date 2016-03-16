//
//  SearchTermsData.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-15.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "SearchTermsData.h"

@implementation SearchTermsData
@synthesize searchTerms;


-(void)initializeSearchTerms
{
    //initialize data structure that holds search terms
    searchTerms = [[NSMutableArray alloc]initWithObjects:@"Test Search Term", nil];
}

-(NSMutableArray *)getSearchTerms
{
    return self.searchTerms;
}



@end
