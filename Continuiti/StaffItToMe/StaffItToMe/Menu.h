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
#import "ListViewMenu.h"
#import "IndustrySearchController.h"

@interface Menu : UIView <SearchFilterProtocol> {
    GoogleMapsMenu *google_map;
    ListViewMenu *list_screen;
    IndustrySearchController *industry_search;
    
    UIButton *map_button;
    UIButton *list_button;
    UIButton *option_button;
    UIImageView *seperator_view;
    
    LoadingView *load_view;
    UIAlertView *load_message;
    
	//0 means not anything 1 means map 2 means list
	int list_or_map;
}
@property (nonatomic, retain) SearchFilterScreen *filter_screen;
-(void)setUserLocation:(CLLocation*)the_location;
-(void)updateCriteria;
@end
