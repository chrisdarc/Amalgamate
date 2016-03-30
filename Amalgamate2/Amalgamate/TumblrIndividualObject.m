//
//  TBViewController.h
//  Amalgamate
//
//  Created by Ji Hua on 2016-03-14.
//  Copyright (c) 2016 Group10. All rights reserved.
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
