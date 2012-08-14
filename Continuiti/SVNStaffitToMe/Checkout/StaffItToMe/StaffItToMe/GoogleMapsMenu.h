//
//  GoogleMapsMenu.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/MapKit.h>

@interface GoogleMapsMenu : UIView <MKMapViewDelegate> {
    MKMapView *main_map_view;
    
}
- (id)initWithFrame:(CGRect)frame withLocation:(CLLocation*)the_location;
-(void)changeCenter:(CLLocation*)the_location;

@end
