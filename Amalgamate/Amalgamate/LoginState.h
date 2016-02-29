//
//  LoginState.h
//  Amalgamate
//
//  Created by Chris Darc on 2016-02-28.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginState : NSObject

@property (nonatomic) BOOL loggedIn;

-(void)setInitialLoggedIn;

-(BOOL)getLoggedInState;

-(void)setLoggedInTrue;

-(void)setLoggedInFalse;

@end
