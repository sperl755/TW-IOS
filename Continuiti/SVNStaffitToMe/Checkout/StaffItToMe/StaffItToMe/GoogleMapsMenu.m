//
//  GoogleMapsMenu.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoogleMapsMenu.h"


@implementation GoogleMapsMenu

- (id)initWithFrame:(CGRect)frame withLocation:(CLLocation*)the_location
{
    self = [super initWithFrame:frame];
    if (self) {
        main_map_view = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self addSubview:main_map_view];
        MKCoordinateRegion beginning_region;
        beginning_region.center.latitude = the_location.coordinate.latitude;
        beginning_region.center.longitude = the_location.coordinate.longitude;
        beginning_region.span.latitudeDelta = .1;
        beginning_region.span.longitudeDelta = .1;
        [main_map_view setRegion:beginning_region animated:YES];
        main_map_view.delegate = self;
    }
    return self;
}
-(void)changeCenter:(CLLocation*)the_location
{
    MKCoordinateRegion beginning_region;
    beginning_region.center.latitude = the_location.coordinate.latitude;
    beginning_region.center.longitude = the_location.coordinate.longitude;
    beginning_region.span.latitudeDelta = .1;
    beginning_region.span.longitudeDelta = .1;
    [main_map_view setRegion:beginning_region animated:YES];
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
    [main_map_view release];
    [super dealloc];
}

@end
