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
#import "SearchFilterScreen.h"

@interface Menu : UIView <SearchFilterProtocol> {
    GoogleMapsMenu *google_map;
    LocationManager *local_manager;
    CLLocation *user_location;
    SearchFilterScreen *filter_screen;
}

-(void)setUserLocation:(CLLocation*)the_location;
@end
