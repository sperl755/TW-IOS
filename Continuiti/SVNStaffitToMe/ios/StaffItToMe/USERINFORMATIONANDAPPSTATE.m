//
//  USERINFORMATIONANDAPPSTATE.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "USERINFORMATIONANDAPPSTATE.h"


@implementation USERINFORMATIONANDAPPSTATE
@synthesize currentTabBar;
@synthesize userName;
@synthesize sessionKey;
-(id)init
{
    if ((self = [super init]))
    {
        currentTabBar = [[NSString alloc] init];
        userName = [[NSString alloc] init];
        sessionKey = [[NSString alloc] init];
    }
    return self;
}
@end
