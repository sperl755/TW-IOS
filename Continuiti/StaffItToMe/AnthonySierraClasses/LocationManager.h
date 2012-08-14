//
//  LocationManager.h
//  Location
//
//  Created by Anthony Sierra on 1/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@protocol CoreLocationControllerDelegate
@required
-(void)locationUpdate:(CLLocation *)location;
-(void)locationError:(NSError *)error;
-(void)setUserLocation:(CLLocation*)the_location;


@end


@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
	CLLocationManager *manager;
	id delegate;

}
@property (nonatomic, retain) CLLocationManager *manager;
@property (nonatomic, retain) id delegate;

@end
