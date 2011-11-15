//
//  AvailableJobsAnnotation.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>

@interface AvailableJobsAnnotation : NSObject <MKAnnotation> {
    
}
-(id)initWithTitle:(NSString*)theTitle subTitle:(NSString*)theSubTitle andCoordinate:(CLLocationCoordinate2D)theCoordinate andID:(int)the_id;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *title;
@property (nonatomic) int pin_id;
@end
