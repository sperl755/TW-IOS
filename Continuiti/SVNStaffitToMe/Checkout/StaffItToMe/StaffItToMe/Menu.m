//
//  Menu.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"


@implementation Menu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        local_manager = [[LocationManager alloc] init];
        local_manager.delegate = self;
        google_map = [[GoogleMapsMenu alloc] initWithFrame:[UIScreen mainScreen].applicationFrame withLocation:user_location];
        [self addSubview:google_map];
    }
    return self;
}
-(void)setUserLocation:(CLLocation*)the_location
{
    user_location = [the_location copy];
    [google_map changeCenter:user_location];
    [local_manager.manager stopUpdatingLocation];
}
-(void)viewAndApplyForJobs
{
    printf("I just got all the jobs in the world");
}
-(void)checkIntoMyJobs
{
    printf("I ran errands for ms potts!");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [google_map release];
    [super dealloc];
}

@end
