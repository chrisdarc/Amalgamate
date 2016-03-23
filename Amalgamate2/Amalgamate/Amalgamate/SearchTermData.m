//
//  SearchTermData.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-16.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "SearchTermData.h"

@implementation SearchTermData
@synthesize searchVC, termsToSearch;

//for loading the array
-(NSArray*)loadSearchTerms
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * storedArray= [userDefaults objectForKey:@"tableViewSearchTerms"];
    if (storedArray == nil)
    {
        //initialize data structure that holds search terms
        //termsToSearch = [[NSMutableArray alloc]initWithObjects: @"First", nil];//@"Test Search Term", nil];
        NSLog(@"Array is empty");
    }
    else
    {
        //make search terms equal to the array that is stored
        termsToSearch = [[NSMutableArray alloc]initWithArray:storedArray];
        NSLog(@"Array has items in it");
    }
    NSLog(@"Done getting search terms");
    
    //doesn't return a mutable array because we don't want to be able to change it.
    return termsToSearch;
}

//puts the search term into a space separated string (generic function, probably won't be used, but is the basis for a function that would separate with " OR ", or some other value for twitter or another API)
-(NSString*)getSearchTermsString
{
    //place to store the string
    NSString * searchTermsStr;
    
    //load from the file
    NSArray* searchTermArray = [self loadSearchTerms];
    NSString * temp;
    
    for (int i = 0; i<searchTermArray.count; i++)
    {
        if(i == 0)
        {
            temp = [NSString stringWithFormat: @"%@", searchTermArray[i]];
            searchTermsStr = [NSString stringWithFormat:@"%@", temp];
        }
        else
        {
            temp = [NSString stringWithFormat: @"%@", searchTermArray[i]];
            searchTermsStr = [NSString stringWithFormat:@"%@%s%@", searchTermsStr, " ", temp];
        }
    }
    
    NSLog(@"%@", searchTermsStr);
    
    //it is possible to return null, need to check for this when calling this method.
    return searchTermsStr;
}

-(NSString*)getSearchTermsStringTwitter
{
    //place to store the string
    NSString * searchTermsStr;
    
    //load from the file
    NSArray* searchTermArray = [self loadSearchTerms];
    NSString * temp;
    
    for (int i = 0; i<searchTermArray.count; i++)
    {
        if(i == 0)
        {
            temp = [NSString stringWithFormat: @"%s%@", "(" ,searchTermArray[i]];
            searchTermsStr = [NSString stringWithFormat:@"%@", temp];
        }
        else
        {
            temp = [NSString stringWithFormat: @"%@", searchTermArray[i]];
            searchTermsStr = [NSString stringWithFormat:@"%@%s%@", searchTermsStr, " OR ", temp];
        }
    }
    
    searchTermsStr = [NSString stringWithFormat:@"%@%s", searchTermsStr, ") filter:safe"];
    
    NSLog(@"%@", searchTermsStr);
    
    //it is possible to return null, need to check for this when calling this method.
    return searchTermsStr;
}

-(NSString*)getSearchTermsStringTumblr
{
    //place to store the string
    NSString * searchTermsStr;
    
    //load from the file
    NSArray* searchTermArray = [self loadSearchTerms];
    NSString * temp;
    
    for (int i = 0; i<searchTermArray.count; i++)
    {
        if(i == 0)
        {
            temp = [NSString stringWithFormat: @"%@", searchTermArray[i]];
            searchTermsStr = [NSString stringWithFormat:@"%@", temp];
        }
        else
        {
            temp = [NSString stringWithFormat: @"%@", searchTermArray[i]];
            searchTermsStr = [NSString stringWithFormat:@"%@%s%@", searchTermsStr, "+", temp];
        }
    }
    
    NSLog(@"%@", searchTermsStr);
    
    //it is possible to return null, need to check for this when calling this method.
    return searchTermsStr;
}

@end
