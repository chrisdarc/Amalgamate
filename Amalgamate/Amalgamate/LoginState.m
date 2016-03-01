//
//  LoginState.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "LoginState.h"

@implementation LoginState

-(void)setInitialLoggedIn
{
    [self setLoggedInFalse];
}

-(BOOL) getLoggedInState
{
    return self.loggedIn;
}

-(void)setLoggedInTrue
{
    NSLog(@"Recorded in log: Logged In");
    self.loggedIn = YES;
}

-(void)setLoggedInFalse
{
    NSLog(@"Recorded in log: Logged Out");
    self.loggedIn = NO;
}

@end
