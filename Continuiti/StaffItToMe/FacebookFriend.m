//
//  FacebookFriend.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookFriend.h"
#define FRIEND_ID_KEY   @"FRIEND_ID"
#define NAME_KEY    @"NAMEEE"
#define PROFILE_PICTURE_KEY @"PROFILEPICTUREKEY"

@implementation FacebookFriend
@synthesize friend_id;
@synthesize name;
@synthesize profile_pic;

-(id)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super init]))
    {
        friend_id = [[aDecoder decodeObjectForKey:FRIEND_ID_KEY] retain];
        name = [[aDecoder decodeObjectForKey:NAME_KEY] retain];
        profile_pic = [[aDecoder decodeObjectForKey:PROFILE_PICTURE_KEY] retain];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:friend_id forKey:FRIEND_ID_KEY];
    [aCoder encodeObject:name forKey:NAME_KEY];
    [aCoder encodeObject:profile_pic forKey:PROFILE_PICTURE_KEY];
}
@end
