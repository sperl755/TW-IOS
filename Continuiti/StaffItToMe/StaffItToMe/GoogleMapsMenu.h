//
//  GoogleMapsMenu.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/MapKit.h>
#import "AvailableJobsAnnotation.h"
#import <CoreLocation/CoreLocation.h>
#import "MyCustomMKMapView.h"
#import "WildcardGestureRecognizer.h"
#import "CustomAnnotationView.h"
#import "CustomGoogleMapBubble.h"

@interface GoogleMapsMenu : UIView <MKMapViewDelegate, UITextViewDelegate> {
    MKMapView *main_map_view;
    UIImageView *header_shadow;
    
    LoadingView *load_view;
    //yes if its loading a job to bring up and no if it is not.
    BOOL loading_job;
    LoadingView *big_load_view;
    
    UIButton *clear_text_x;
    UIImageView *search_bar_background;
    UITextView *search_bar_text;
    
    
    NSMutableArray *table_data;
    NSTimer *job_search_update;
    UIImageView *job_description_image;
    CGPoint touch_pos;
    int updatingWithTimer;
    CustomGoogleMapBubble *popover;
    NSMutableArray *annotations;
    double previous_delta;
    double previous_latitude;
    double previous_longitude;
    BOOL need_to_die;
    BOOL is_loading;
    CLLocationCoordinate2D current_selected_annotation_coordinate;
}
-(void)setDie;
- (id)initWithFrame:(CGRect)frame withLocation:(CLLocation*)the_location;
-(void)changeCenter:(CLLocation*)the_location;
-(void)updateCriteriaWithMapPosition;
@end
