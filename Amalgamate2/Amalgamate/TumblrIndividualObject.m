//
//  TumblrIndividualObject.m
//  MyTumblrFollowerApp
//
//  Created by Chad Jones on 2/29/16.
//  Copyright (c) 2016 CollegeMobile, Inc. All rights reserved.
//

#import "TumblrIndividualObject.h"

#import "NSString+HTML.h"

@implementation TumblrIndividualObject




-(void)setPhotoCaption:(NSString *)photoCaption
{
   _photoCaption = [ photoCaption stringByConvertingHTMLToPlainText ];
}
-(void)setdate:(NSString *)mydate
{
    _postTime = [ mydate stringByConvertingHTMLToPlainText ];
}


-(void)setSdate:(NSString *)mydate
{
    _SpostTime = [ mydate stringByConvertingHTMLToPlainText ];
}



-(void)setpurl:(NSString *)ur;//delete!
{
    _purl = [ ur stringByConvertingHTMLToPlainText ];
}
@end
