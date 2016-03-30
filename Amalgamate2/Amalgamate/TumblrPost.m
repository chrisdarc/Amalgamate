//
//  TumblrPost.m
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/29/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import "TumblrPost.h"

#import "SBJSON.h"

#import "CommonIncludes.h"


@interface TumblrPost()

@property NSMutableArray* arrayOfIndividualPosts;

@end


@implementation TumblrPost


////V3
//+(BOOL)_internalInternalDictionaryIsValid:(NSDictionary*)dictionaryReceived//check each post
//{
//   BOOL validDictionary;
//
//   NSArray* posts = [ dictionaryReceived objectForKey: @"posts" ];
//   
//   if ( ( posts != nil ) && ( [ posts isKindOfClass: [ NSArray class ] ] ) )
//   {
//      validDictionary = YES;
//      
//      for ( NSDictionary* currentDictionary in posts )
//      {
//         if ( ( currentDictionary != nil ) && ( [ currentDictionary isKindOfClass: [ NSDictionary class ] ] ) )
//         {
//
//            //do nothing
//         }
//         else
//         {
//            validDictionary = NO;
//         }
//      }
//   }
//   else
//   {
//      validDictionary = NO;
//   }
//   
//   return( validDictionary );
//}
//
//
////V2
//+(BOOL)_internalStringIsValid:(NSString*)stringReceived//get rid of the useless text, conver to String , Parse JSON
//{
//   BOOL validString;
//   
//   NSString* stringFromData = [ stringReceived stringByReplacingOccurrencesOfString: @"var tumblr_api_read = " withString: @"" ];
//   
//   if ( [ stringFromData length ] >= 2 )
//   {
//      stringFromData = [ stringFromData substringToIndex: [ stringFromData length ] - 1 ];// reget string???
//      
//      if ( [ stringFromData length ] > 0 )
//      {
//         SBJsonParser* myParser = [ [ SBJsonParser alloc ] init ];
//   
//         NSDictionary* resultDictionary = [ myParser objectWithString: stringFromData ];
//         
//         if ( ( resultDictionary != nil ) && ( [ resultDictionary isKindOfClass: [ NSDictionary class ] ] ) )
//         {
//            validString = [ TumblrPost _internalInternalDictionaryIsValid: resultDictionary ];//->V3
//         }
//         else
//         {
//            validString = NO;
//         }
//      }
//      else
//      {
//         validString = NO;
//      }
//   }
//   else
//   {
//      validString = NO;
//   }
//   
//   return( validString );
//}
//
//
////v1
//+(BOOL)dataIsValid:(NSData*)dataReceived//check if JSON is not empty
//{
//   BOOL validData;
//
//   if ( dataReceived != nil )
//   {
//      if ( [ dataReceived isKindOfClass: [ NSData class ] ] )
//      {
//         NSString* stringFromData = [ [ NSString alloc ] initWithData: dataReceived encoding: NSUTF8StringEncoding ];
//         
//         if ( ( stringFromData != nil ) && ([ stringFromData length ] > 0 ) )
//         {
//            validData = [ TumblrPost _internalStringIsValid: stringFromData ];//->V2
//         }
//         else
//         {
//            validData = NO;
//         }
//      }
//      else
//      {
//         validData = NO;
//      }
//   }
//   else
//   {
//      validData = NO;
//   }
//   
//   return( validData );
//}
//

//2
-(void)addToPostsIfPossible:(NSDictionary*)postToAdd// "postToAdd" is a dictionary which holds all the detail information of a post
{
    if (TRUE)//( [ postToAdd objectForKey: kPhotoCaptionKey ] != nil ) &&( [ postToAdd objectForKey: kPhotoURLKey ] != nil )
        
   {
      TumblrIndividualObject* tumblrObject = [ TumblrIndividualObject new ];

//      tumblrObject.photoCaption = [ postToAdd objectForKey: kPhotoCaptionKey ];//keywords of json are stored in CommonInclueds.h
//
//      NSString* photoURLString = [ postToAdd objectForKey: kPhotoURLKey ];//set text and photo url from each post(JSON)
//      
//      tumblrObject.photoURL = [ NSURL URLWithString: photoURLString ];//to form a real post (TumblrIndividualObject.h)
//       tumblrObject.postTime = [ postToAdd objectForKey: kdateKey ];
//        NSString* URLString = [ postToAdd objectForKey: kurlKey ];
//       tumblrObject.purl=[ NSURL URLWithString: URLString ];
//       tumblrObject.title=username;
//       tumblrObject.des=des;
       
       
       username=[ postToAdd objectForKey: kblognamekey ];
     // NSLog(username);
               NSString* SURLString = [ postToAdd objectForKey: kSPhotoURLKey ];
       tumblrObject.purl=SURLString;
       tumblrObject.photoCaption=[postToAdd objectForKey:kSphotocaptionKey];
       tumblrObject.SpostTime=[ postToAdd objectForKey: kSdateKey ];
       tumblrObject.Susername=[ postToAdd objectForKey: kblognamekey ];
      
       if ([ postToAdd objectForKey: kSphotoKey ]!=nil){// check if there is no photo but a video
           NSArray* Sphotos =[ postToAdd objectForKey: kSphotoKey ];
       NSDictionary *Spho= Sphotos[0];
       NSArray* Sphotoswithsize = [ Spho objectForKey: kSphotosizeKeyArray ];
           
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
       else{
           tumblrObject.SphotoURL=[ NSURL URLWithString: @"http://ww1.sinaimg.cn/mw690/abc170eajw1f2eju26fj7j207902rdfz.jpg" ];

       }
       
       
//       NSDictionary* Sphoto = [ Spho objectForKey: koriginalSizelKey ];
//       NSString *SphotoURLString=[ Sphoto objectForKey: kurlKey ];
//       tumblrObject.SphotoURL=[ NSURL URLWithString: SphotoURLString ];
       
       
      
      [ self.arrayOfIndividualPosts addObject: tumblrObject ];//added into "arrayOfIndividualPosts"
   }
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
          //NSLog(stringFromData);
          
          //stringFromData = [ stringFromData stringByReplacingOccurrencesOfString: @"var tumblr_api_read = " withString: @"" ];//delete the useless head, nothing important here
          
          //stringFromData = [ stringFromData substringToIndex: [ stringFromData length ] - 1 ];//meaningless
           // NSLog(stringFromData);
         SBJsonParser* myParser = [ [ SBJsonParser alloc ] init ];
         
         NSDictionary* resultDictionary = [ myParser objectWithString: stringFromData ];
         
//        NSDictionary* log=resultDictionary[ @"tumblelog" ];//get the user name//!!!delete!
//        username=[log objectForKey:ktitleKey];
//        des=[log objectForKey:kdesKey];
//          NSLog(@"!!!!!!!!!");
//          NSLog(des);
//          NSLog(@"??????????");
          
          
          
          //NSLog(@"Dictionary: %@", [resultDictionary description]);
         NSArray* arrayOfPosts = resultDictionary[ @"response" ];//get the post array into a list "arrayOfPosts"

//          for (NSString *string in arrayOfPosts) {
//              NSLog(@"%@", string);
//          }
//          NSLog(@"here!!!!!!!!!!!!!!!");
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
