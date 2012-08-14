//
//  UserInfo.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"
#define FIRST_NAME_KEY  @"FIRSTNAMEKEYS"
#define LAST_NAME_KEY   @"LAstNameKeys"
#define FULL_NAME_KEY   @"FullNameKEy"
#define USERS_ID_KEY    @"USERSIDSKEYS"


@implementation UserInfo
@synthesize first_name;
@synthesize last_name;
@synthesize full_name;
@synthesize user_id;

-(id)initWithCoder:(NSCoder*)aDecoder
{
    if ((self = [super init]))
    {
        NSString *user_id_string = [[aDecoder decodeObjectForKey:USERS_ID_KEY] retain];
        user_id = [user_id_string intValue];
        first_name = [[aDecoder decodeObjectForKey:FIRST_NAME_KEY] retain];
        last_name = [[aDecoder decodeObjectForKey:LAST_NAME_KEY] retain];
        full_name = [[aDecoder decodeObjectForKey:FULL_NAME_KEY] retain];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder*)aCoder
{
    NSString *user_id_string = [NSString stringWithFormat:@"%d", user_id];
    [aCoder encodeObject:user_id_string forKey:USERS_ID_KEY];
    [aCoder encodeObject:first_name forKey:FIRST_NAME_KEY];
    [aCoder encodeObject:last_name forKey:LAST_NAME_KEY];
    [aCoder encodeObject:full_name forKey:FULL_NAME_KEY];
}
@end
