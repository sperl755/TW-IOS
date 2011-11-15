//
//  Menu.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checkbox.h"
#import "GoogleMapsMenu.h"
#import "LocationManager.h"

@interface Menu : UIView {
    GoogleMapsMenu *google_map;
    LocationManager *local_manager;
    CLLocation *user_location;
}

-(void)setUserLocation:(CLLocation*)the_location;
@end
