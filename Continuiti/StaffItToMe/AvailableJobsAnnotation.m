//
//  AvailableJobsAnnotation.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AvailableJobsAnnotation.h"


@implementation AvailableJobsAnnotation
@synthesize coordinate, name, title, pin_id;

-(id)initWithTitle:(NSString*)theTitle subTitle:(NSString*)theSubTitle andCoordinate:(CLLocationCoordinate2D)theCoordinate andID:(int)the_id;
{
    if ((self = [super init])) {
        name = [theTitle retain];
        NSMutableString *asubtitle = [[NSMutableString alloc] initWithString:@"at "];
        [asubtitle appendString:theSubTitle];
        [asubtitle appendString:@" Company"];
        title = @" ";
        coordinate = theCoordinate;
        self.pin_id = the_id;
        
    }
    return self;
}
-(void)dealloc
{
    [name release];
    [title release];
    [super dealloc];
}
@end
