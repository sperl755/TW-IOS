//
//  UIImage-Extended.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage-Extended.h"
#define image_data_key @"image_data_key"
@implementation UIImage_Extended

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        NSData *image_data = [aDecoder decodeObjectForKey:image_data_key];
        self = [self initWithData:image_data];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    NSData *data = UIImagePNGRepresentation(self);
    [aCoder encodeObject:data forKey:image_data_key];
}
@end
