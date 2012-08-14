//
//  LocationManager.m
//  Location
//
//  Created by Anthony Sierra on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"


@implementation LocationManager
@synthesize manager;
@synthesize delegate;
-(id)init
{
	self = [super init];
	
	if(self != nil)
	{
		self.manager = [[[CLLocationManager alloc] init] autorelease];
		self.manager.delegate = self;
        [self.manager startUpdatingLocation];
	}
	return self;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	[self.delegate setUserLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	if([self.delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
		//[self.delegate locationError:error];
	}
}
- (void)dealloc {
	[self.manager release];
	[super dealloc];
}
@end
