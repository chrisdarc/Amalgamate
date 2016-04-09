//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
//

#import "TumblrPost.h"

#import "SBJSON.h"

#import "CommonIncludes.h"


@interface TumblrPost()

@property NSMutableArray* arrayOfIndividualPosts;

@end


@implementation TumblrPost




//2
-(void)addToPostsIfPossible:(NSDictionary*)postToAdd// "postToAdd" is a dictionary which holds all the detail information of a post
{
    
    
    
    TumblrIndividualObject* tumblrObject = [ TumblrIndividualObject new ];
    
    
    
    
    username=[ postToAdd objectForKey: kblognamekey ];
    NSString* SURLString = [ postToAdd objectForKey: kSPhotoURLKey ];
    tumblrObject.purl=SURLString;
    tumblrObject.photoCaption=[postToAdd objectForKey:kSphotocaptionKey];
    
    
    
    if ([ postToAdd objectForKey: @"body" ]!=nil) {
        tumblrObject.sbody=[postToAdd objectForKey:@"body"];
    }
    else{
        tumblrObject.sbody=@"none";
    }
    
    
    
    
    
    
    tumblrObject.SpostTime=[ postToAdd objectForKey: kSdateKey ];
    tumblrObject.Susername=[ postToAdd objectForKey: kblognamekey ];
    
    if ([ postToAdd objectForKey: kSphotoKey ]!=nil){// check if there is no photo but a video
        NSArray* Sphotos =[ postToAdd objectForKey: kSphotoKey ];
        NSDictionary *Spho= Sphotos[0];
        NSArray* Sphotoswithsize = [ Spho objectForKey: kSphotosizeKeyArray ];
        tumblrObject.videourl=@"pic";
        
        if(Sphotoswithsize.count>=3){                //deal with different sizes of photos
            NSDictionary* photo3=Sphotoswithsize[2];//"width": 250,"height": 333
            NSString *SphotoURLString=[ photo3 objectForKey: kurlKey ];
            tumblrObject.SphotoURL=[ NSURL URLWithString: SphotoURLString ];
            
        }
        else{
            NSDictionary* photo3=Sphotoswithsize[1];
            NSString *SphotoURLString=[ photo3 objectForKey: kurlKey ];
            tumblrObject.SphotoURL=[ NSURL URLWithString: SphotoURLString ];
            
        }
    }
    else if([ postToAdd objectForKey: kSvideoKey ]!=nil){//if there is a video, we use this photos to notice users
        
        
        
        tumblrObject.SphotoURL=[ NSURL URLWithString: @"http://ww1.sinaimg.cn/mw690/abc170eajw1f2eju26fj7j207902rdfz.jpg" ];
        NSArray* Svidoe =[ postToAdd objectForKey: kSvideoKey ];
        
        if ([ Svidoe isKindOfClass: [ NSArray class ] ]) {
            NSDictionary* myvidoe=Svidoe[0];
            
            tumblrObject.videourl=[myvidoe objectForKey:kSeachVideoKey];
        }
        else{
            
            tumblrObject.videourl=[ postToAdd objectForKey: kSvideoKey ];
            
        }
        
        
    }
    else{
        
    }
    
    
    
    
    
    [ self.arrayOfIndividualPosts addObject: tumblrObject ];//added into "arrayOfIndividualPosts"
    
}


//1
-(instancetype)initWithData:(NSData*)dataReceived
{
    self = [ super init ];
    
    if ( self != nil )
    {
        if ( true )//validation ->V1
        {
            NSString* stringFromData = [ [ NSString alloc ] initWithData: dataReceived encoding: NSUTF8StringEncoding ];
            
            SBJsonParser* myParser = [ [ SBJsonParser alloc ] init ];
            
            NSDictionary* resultDictionary = [ myParser objectWithString: stringFromData ];
            
            NSArray* arrayOfPosts = resultDictionary[ @"response" ];//get the post array into a list "arrayOfPosts"
            
            
            self.arrayOfIndividualPosts = [ NSMutableArray new ];
            
            for ( NSDictionary* individualPost in arrayOfPosts )
            {
                [ self addToPostsIfPossible: individualPost ];//->2 set all the post(form a new dictionary in order to get more detail information) from "arrayOfPosts" into the property which named                 "arrayOfIndividualPosts"
            }
        }
        else
        {
            self = nil;
        }
    }
    
    return( self );
}



-(NSUInteger)numberOfPosts
{
    return( self.arrayOfIndividualPosts.count );
}



-(TumblrIndividualObject*)objectAtIndex:(NSInteger)index
{
    TumblrIndividualObject* objectToReturn;
    
    if ( ( index >= 0 ) && ( index < self.arrayOfIndividualPosts.count ) )
    {
        objectToReturn = [ self.arrayOfIndividualPosts objectAtIndex: index ];
    }
    else
    {
        objectToReturn = nil;
    }
    
    return( objectToReturn );
}


@end
