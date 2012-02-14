//
//  GoogleMapsMenu.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GoogleMapsMenu.h"
#import "StaffItToMeAppDelegate.h"

#define DISTANCE_BEFORE_RELOAD 20

@implementation GoogleMapsMenu
static NSString *GMAP_ANNOTATION_SELECTED = @"GMAP";
-(void)renewMapsData
{
    if (is_loading)
    {
        return;
    }
    is_loading = YES;
    NSMutableString *job_list_address = [NSMutableString stringWithString:@"https://helium.staffittome.com/apis/search/"];
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    
    //Acesss the server with solr parameters
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_list_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setValidatesSecureCertificate:NO];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request setPostValue:[NSString stringWithFormat:@"%f", main_map_view.centerCoordinate.latitude] forKey:@"latitude"];
    [request setPostValue:[NSString stringWithFormat:@"%f", main_map_view.centerCoordinate.longitude] forKey:@"longitude"];
    //set the currently selected industry type
    [request setPostValue:app_delegate.user_state_information.industry_search_type forKey:@"industry_name"];
    //set the currently selected job_type_name
    [request setPostValue:app_delegate.user_state_information.distance_search_type forKey:@"job_type_name"];
    printf("%f", (main_map_view.region.span.latitudeDelta * 111));
    [request setPostValue:[NSString stringWithFormat:@"%f", (main_map_view.region.span.latitudeDelta * 111)] forKey:@"distance"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [load_view setMiniatureMapLoading];
    [self addSubview:load_view];
    
}
-(void)updateCriteriaWithMapPosition
{
    updatingWithTimer = 20;
    
    /*
     Use the haversine formula to calculate the distance bewteen the previous center position of the map and this current one.
     */
    double earth_radius = 6371;
    double deltaLat     = (main_map_view.centerCoordinate.latitude - previous_latitude);
    deltaLat            = (deltaLat * 3.14) / 180;//Convert DeltaLat Into Radians
    double deltaLong    = (main_map_view.centerCoordinate.longitude - previous_longitude);
    deltaLong           = (deltaLong *3.14) / 180;//Convert DeltaLong Into Radians
    double latOne       = (previous_latitude * 3.14) /180;//get previous lat in radians
    double latTwo       = (main_map_view.centerCoordinate.latitude * 3.14) / 180;
    
    //Get current lat in radians
    double a        = (sin(deltaLat/2) * sin(deltaLat/2)) + (sin(deltaLong/2) * sin(deltaLong/2) * cos(latOne) * cos(latTwo));
    double c        = 2 * atan2(sqrt(a), sqrt(1-a));
    double distance = earth_radius * c;
    /*
     Condition Checks to make sure we arent redundently accessing the server
     */
    double current_delta    = main_map_view.region.span.latitudeDelta;
    double delta_difference = current_delta - previous_delta;
    
    if (distance > DISTANCE_BEFORE_RELOAD)
    {
        previous_latitude   = main_map_view.centerCoordinate.latitude;
        previous_longitude  = main_map_view.centerCoordinate.longitude;
        [self renewMapsData];
        
    }
    else if (delta_difference > .1 || delta_difference < -.1)
    {
        previous_delta = main_map_view.region.span.latitudeDelta;
        [self renewMapsData];
    }

}
-(void)reloadMap
{
    [main_map_view removeAnnotations:main_map_view.annotations];
   /* NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:10];
    for (id annotation in main_map_view.annotations)
    {
        [toRemove addObject:annotation];
    }
    if (toRemove.count >= 1)
    {
        [main_map_view removeAnnotations:toRemove];
    }*/
    [annotations removeAllObjects];
    //Fill the map with jobs that are near user.
    printf("Table Count: %d", [table_data count]);
    for (int i = 0; i < [table_data count]; i++)
    {
        //Get the location of the job
        CLLocationCoordinate2D coordinate = {[[table_data objectAtIndex:i] latitude], [[table_data objectAtIndex:i] longitude]};
        //Create an annotation for it with an id of the current position in the array that the job is in.
        AvailableJobsAnnotation *a_job = [[[AvailableJobsAnnotation alloc] initWithTitle:[[table_data objectAtIndex:i] title] subTitle:@"" andCoordinate:coordinate andID:[[table_data objectAtIndex:i] job_id]] retain];
        
        printf("\n%d", a_job.pin_id);
        
        if (coordinate.latitude == 0) {
            [a_job release];
        }
        else {
            //add the annotation
            //[main_map_view addAnnotation:a_job];
            //[main_map_view removeAnnotation:a_job];
            //[main_map_view addAnnotation:a_job];
            [annotations addObject:a_job];
            //sleep(5);
        }
    }
    MKCoordinateRegion beginning_region;
    beginning_region = main_map_view.region;
    [main_map_view removeFromSuperview];
    [main_map_view release];
    main_map_view = nil;
    
    //REallocate Map View
    main_map_view = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
    main_map_view.delegate = self;
    
    [main_map_view addAnnotations:annotations];
    [main_map_view setRegion:beginning_region animated:NO];
    [main_map_view regionThatFits:beginning_region];
    [main_map_view setCenterCoordinate:beginning_region.center animated:NO];
    
    WildcardGestureRecognizer *my_touches_ended_recognizer = [[WildcardGestureRecognizer alloc] init];
    my_touches_ended_recognizer.touchesEndedCallback = ^(NSSet *touches, UIEvent *event)
    {
        [main_map_view touchesEnded:touches withEvent:event];
        UITouch *touch          = (UITouch*) [touches anyObject];
        CGPoint touch_location  = [touch locationInView:main_map_view];
        touch_pos               = touch_location;
        [self updateCriteriaWithMapPosition];
    };
    my_touches_ended_recognizer.touchesMovedCallback = ^(NSSet *touches, UIEvent *event)
    {
        [main_map_view touchesMoved:touches withEvent:event];
        
        CGPoint center_of_popover   = [main_map_view convertCoordinate:current_selected_annotation_coordinate toPointToView:self];
        popover.center              = CGPointMake(center_of_popover.x, center_of_popover.y - 65);
    };
    [main_map_view addGestureRecognizer:my_touches_ended_recognizer];
    
    previous_delta      = main_map_view.region.span.latitudeDelta;
    previous_latitude   = main_map_view.centerCoordinate.latitude;
    previous_longitude  = main_map_view.centerCoordinate.longitude;
    [self insertSubview:main_map_view atIndex:0];
    
   // [main_map_view addAnnotations:annotations];
    /*[main_map_view setNeedsLayout];
    [main_map_view setNeedsDisplay];
    updatingWithTimer = 0;
    for (int i = 0; i < annotations.count; i++)
    {
        [main_map_view removeAnnotation:[annotations objectAtIndex:i]];
        [main_map_view addAnnotation:[annotations objectAtIndex:i]];
        //[main_map_view addSubview:[self mapView:main_map_view viewForAnnotation:[main_map_view.annotations objectAtIndex:i]]];
    }*/
    //[self performSelectorInBackground:@selector(updateMapDisplay) withObject:nil];
}
-(void)updateMapDisplay
{
    sleep(5);
    printf("%d", annotations.count);
     [main_map_view addAnnotations:annotations];
}
-(void)setDie
{
    need_to_die = YES;
}
- (id)initWithFrame:(CGRect)frame withLocation:(CLLocation*)the_location
{
    self = [super initWithFrame:frame];
    if (self) {
        if (the_location == nil)
        {
            printf("Issue");
        }
        //This variable will be set to die when the map needs to be
        //deallocated and they are changing the screen.
        need_to_die = NO;
        
        header_shadow       = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self addSubview:header_shadow];
        
        annotations = [[NSMutableArray alloc] initWithCapacity:25];
        is_loading  = NO;
        
        //Create Table Data
        table_data                              = [[NSMutableArray alloc] initWithCapacity:11]; 
        StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        
        for (int i = 0; i < app_delegate.user_state_information.job_array.count; i++)
        {
            
            SmallJobs *small_jobs = [[SmallJobs alloc] init];
            
            small_jobs.title    = [[app_delegate.user_state_information.job_array objectAtIndex:i] title];
            small_jobs.skills   = [[app_delegate.user_state_information.job_array objectAtIndex:i] skills];
            small_jobs.job_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_id];
            small_jobs.job_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_description];
            small_jobs.user_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] user_id];
            small_jobs.created_at = [[app_delegate.user_state_information.job_array objectAtIndex:i] created_at];
            small_jobs.job_city = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_city];
            small_jobs.job_state = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_state];
            small_jobs.job_duration = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_duration];
            small_jobs.hours_per_week = [[app_delegate.user_state_information.job_array objectAtIndex:i] hours_per_week];
            small_jobs.task_start_date = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_date];
            small_jobs.task_start_time = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_time];
            small_jobs.company = [[app_delegate.user_state_information.job_array objectAtIndex:i] company];
            small_jobs.company_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] company_description];
            small_jobs.compensation = [[app_delegate.user_state_information.job_array objectAtIndex:i] compensation];
            small_jobs.latitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] latitude];
            small_jobs.longitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] longitude];
            
            [table_data addObject:small_jobs];
            [small_jobs release];
        }
        
        main_map_view = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
        main_map_view.delegate = self;
        
        /*for (int i = 0; i < 100; i++)
        {
            CLLocationCoordinate2D coordinate = {47.3225,-122.3113889};
            //Create an annotation for it with an id of the current position in the array that the job is in.
            AvailableJobsAnnotation *a_job = [[AvailableJobsAnnotation alloc] initWithTitle:@"" subTitle:@"" andCoordinate:coordinate andID:0];
            [main_map_view addAnnotation:a_job];
        }*/
        
        [self addSubview:main_map_view];
        MKCoordinateRegion beginning_region;
        beginning_region.center.latitude        = the_location.coordinate.latitude;
        beginning_region.center.longitude       = the_location.coordinate.longitude;
        beginning_region.span.latitudeDelta     = 11;
        beginning_region.span.longitudeDelta    = 11;
        
        [main_map_view setRegion:beginning_region animated:NO];
        [main_map_view regionThatFits:beginning_region];
        [main_map_view setCenterCoordinate:beginning_region.center animated:NO];
        
        [self reloadMap];

        //Create Search Bar
        search_bar_background = [[UIImageView alloc] initWithFrame:CGRectMake(1, 292, 318, 43)];
        search_bar_background.image = [UIImage imageNamed:@"search_box"];
        [self addSubview:search_bar_background];
        
        search_bar_text = [[UITextView alloc] initWithFrame:CGRectMake(search_bar_background.frame.origin.x + 2, search_bar_background.frame.origin.y + 13, search_bar_background.frame.size.width - 30, search_bar_background.frame.size.height + 5)];
        search_bar_text.delegate = self;
        search_bar_text.backgroundColor = [UIColor clearColor];
        [self addSubview:search_bar_text];
        
        WildcardGestureRecognizer *my_touches_ended_recognizer = [[WildcardGestureRecognizer alloc] init];
        my_touches_ended_recognizer.touchesEndedCallback = ^(NSSet *touches, UIEvent *event)
        {
            [main_map_view touchesEnded:touches withEvent:event];
            UITouch *touch = (UITouch*) [touches anyObject];
            CGPoint touch_location = [touch locationInView:main_map_view];
            touch_pos = touch_location;
            [self updateCriteriaWithMapPosition];
        };
        my_touches_ended_recognizer.touchesMovedCallback = ^(NSSet *touches, UIEvent *event)
        {
            [main_map_view touchesMoved:touches withEvent:event];
            
            CGPoint center_of_popover = [main_map_view convertCoordinate:current_selected_annotation_coordinate toPointToView:self];
            popover.center = CGPointMake(center_of_popover.x, center_of_popover.y - 65);
        };
        [main_map_view addGestureRecognizer:my_touches_ended_recognizer];
        
        previous_delta      = main_map_view.region.span.latitudeDelta;
        previous_latitude   = main_map_view.centerCoordinate.latitude;
        previous_longitude  = main_map_view.centerCoordinate.longitude;
        //renew map data
        updatingWithTimer = 20;
        [self renewMapsData];
    }
    return self;
}
-(void)clearSearchBarText
{
    search_bar_text.text = @"";
}
-(BOOL)checkMatchItem:(NSString*)item withPhrase:(NSString*)phrase
{
    BOOL match = NO;
    NSPredicate *containsPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", phrase];
    match = match | [containsPredicate evaluateWithObject:item];
    return match;
}
-(void)updateMapView
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [table_data removeAllObjects];
    if (search_bar_text.text.length < 1) {
        for (int i = 0; i < app_delegate.user_state_information.job_array.count; i++)
        {
            SmallJobs *small_jobs = [[SmallJobs alloc] init];
            small_jobs.title = [[app_delegate.user_state_information.job_array objectAtIndex:i] title];
            small_jobs.skills = [[app_delegate.user_state_information.job_array objectAtIndex:i] skills];
            small_jobs.job_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_id];
            small_jobs.job_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_description];
            small_jobs.user_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] user_id];
            small_jobs.created_at = [[app_delegate.user_state_information.job_array objectAtIndex:i] created_at];
            small_jobs.job_city = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_city];
            small_jobs.job_state = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_state];
            small_jobs.job_duration = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_duration];
            small_jobs.hours_per_week = [[app_delegate.user_state_information.job_array objectAtIndex:i] hours_per_week];
            small_jobs.task_start_date = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_date];
            small_jobs.task_start_time = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_time];
            small_jobs.company = [[app_delegate.user_state_information.job_array objectAtIndex:i] company];
            small_jobs.company_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] company_description];
            small_jobs.compensation = [[app_delegate.user_state_information.job_array objectAtIndex:i] compensation];
            small_jobs.latitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] latitude];
            small_jobs.longitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] longitude];
            
            [table_data addObject:small_jobs];
            [small_jobs release];
        }
        [self reloadMap];
        return;
    }
    
    for (int i = 0; i < app_delegate.user_state_information.job_array.count; i++)
    {
        if ([self checkMatchItem:[[app_delegate.user_state_information.job_array objectAtIndex:i] title] withPhrase:search_bar_text.text])
        {
            SmallJobs *small_jobs = [[SmallJobs alloc] init];
            small_jobs.title = [[app_delegate.user_state_information.job_array objectAtIndex:i] title];
            small_jobs.skills = [[app_delegate.user_state_information.job_array objectAtIndex:i] skills];
            small_jobs.job_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_id];
            small_jobs.job_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_description];
            small_jobs.user_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] user_id];
            small_jobs.created_at = [[app_delegate.user_state_information.job_array objectAtIndex:i] created_at];
            small_jobs.job_city = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_city];
            small_jobs.job_state = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_state];
            small_jobs.job_duration = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_duration];
            small_jobs.hours_per_week = [[app_delegate.user_state_information.job_array objectAtIndex:i] hours_per_week];
            small_jobs.task_start_date = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_date];
            small_jobs.task_start_time = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_time];
            small_jobs.company = [[app_delegate.user_state_information.job_array objectAtIndex:i] company];
            small_jobs.company_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] company_description];
            small_jobs.compensation = [[app_delegate.user_state_information.job_array objectAtIndex:i] compensation];
            small_jobs.latitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] latitude];
            small_jobs.longitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] longitude];
            
            [table_data addObject:small_jobs];
            [small_jobs release];
        }
    }
    [self reloadMap];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    //popover.hidden = YES;
    search_bar_text.center = CGPointMake(search_bar_text.center.x, search_bar_text.center.y - 150);
    search_bar_background.center = CGPointMake(search_bar_background.center.x, search_bar_background.center.y - 150);
    
    if (clear_text_x == nil)
    {
        clear_text_x = [UIButton buttonWithType:UIButtonTypeCustom];
        search_bar_background.image = [UIImage imageNamed:@"search_box_remove"];
        clear_text_x.frame = CGRectMake(search_bar_text.frame.origin.x + search_bar_text.frame.size.width - 6, search_bar_text.frame.origin.y - 1, 20, 20);
        [clear_text_x addTarget:self action:@selector(clearSearchBarText) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clear_text_x];
    }
    else
    {
        search_bar_background.image = [UIImage imageNamed:@"search_box_remove"];
        clear_text_x.center = CGPointMake(clear_text_x.center.x, clear_text_x.center.y - 150);
        clear_text_x.hidden = NO;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        popover.hidden = NO;
        search_bar_background.image = [UIImage imageNamed:@"search_box"];
        search_bar_text.center = CGPointMake(search_bar_text.center.x, search_bar_text.center.y + 150);
        search_bar_background.center = CGPointMake(search_bar_background.center.x, search_bar_background.center.y + 150);
        clear_text_x.center = CGPointMake(clear_text_x.center.x, clear_text_x.center.y + 150);
        clear_text_x.hidden = YES;
        [search_bar_text resignFirstResponder];
        [self updateMapView];
    }
    return YES;
}
-(void)changeCenter:(CLLocation*)the_location
{
    MKCoordinateRegion beginning_region;
    beginning_region.center.latitude = the_location.coordinate.latitude;
    beginning_region.center.longitude = the_location.coordinate.longitude;
    beginning_region.span.latitudeDelta = .1;
    beginning_region.span.longitudeDelta = .1;
    [main_map_view setRegion:beginning_region animated:YES];
    previous_latitude = main_map_view.centerCoordinate.latitude;
    previous_longitude = main_map_view.centerCoordinate.longitude;
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
   /* [mapView deselectAnnotation:view.annotation animated:YES];
    UIViewController *temp_controller = [[UIViewController alloc] init];
    UIPopoverController *pop_over = [[UIPopoverController alloc] initWithContentViewController:temp_controller];
    [temp_controller release];
    my_popover_controller = pop_over;
    pop_over.popoverContentSize = CGSizeMake(100, 100);
    [pop_over presentPopoverFromRect:view.bounds inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [pop_over release];*/
    
    /*printf("%f", view.frame.origin.x);
    job_description_image = [[UIImageView alloc] initWithFrame:CGRectMake(touch_pos.x, touch_pos.y - 20, 20, 20)];
    job_description_image.image = [UIImage imageNamed:@"icon57"];
    view.leftCalloutAccessoryView = job_description_image;
    [main_map_view addSubview:job_description_image];*/
}
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    [job_description_image removeFromSuperview];
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
	AvailableJobsAnnotation *annotation = view.annotation;
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    for (int i = 0; i < delegate.user_state_information.job_array.count; i++)
    {
        if (annotation.pin_id == [[delegate.user_state_information.job_array objectAtIndex:i] job_id])
        {
            delegate.user_state_information.current_job_in_array = i;
        }
    }
    
    updatingWithTimer = 0;
    //show a alertview that we are accessing the credentials and talking to the server.
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [load_view setMiniatureMapLoading];
    [self addSubview:load_view];
    /*load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];*/
    
    NSMutableString *job_info_url = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
    [job_info_url appendString:[NSString stringWithFormat:@"%d", [[delegate.user_state_information.job_array objectAtIndex:delegate.user_state_information.current_job_in_array] job_id]]];
    [job_info_url appendString:@"/job"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_info_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"GET"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
    
    
    
}
/**
 Returns the current text in the search bar for syncing with list view search bar.
 */
-(NSString*)getFilterText
{
    return search_bar_text.text;
}
/**
 Sets the search bar text for syncing with list view search bar.
 */
-(void)setFilterText:(NSString *)the_text
{
    search_bar_text.text = the_text;
    [self updateMapView];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (need_to_die)
    {
        return;
    }
    [load_view removeFromSuperview];
    if (loading_job && !is_loading)
    {
        [big_load_view removeFromSuperview];
        NSDictionary *request_info = [NSDictionary dictionaryWithObject:[request responseString] forKey:@"responseString"];
        printf("\n\n\nThis is stuff: %s", [[request responseString] UTF8String]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToJobDetail" object:self userInfo:request_info];
        loading_job = NO;
    }
    is_loading = NO;
    if (updatingWithTimer == 20)
    {
        printf("%s", [[request responseString] UTF8String]);
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        [app_delegate.user_state_information populateJobArrayWithJSONString:[request responseString]];
        if (app_delegate.user_state_information.job_array.count <= 1)
        {
            MKCoordinateRegion beginning_region;
            beginning_region.center.latitude = main_map_view.region.center.latitude;
            beginning_region.center.longitude = main_map_view.region.center.longitude;
            beginning_region.span.latitudeDelta = main_map_view.region.span.latitudeDelta+.5;
            beginning_region.span.longitudeDelta = main_map_view.region.span.longitudeDelta+.5;
            [main_map_view setRegion:beginning_region animated:NO];
            [main_map_view regionThatFits:beginning_region];
            [main_map_view setCenterCoordinate:beginning_region.center animated:YES];
            [self renewMapsData];
            return;
        }
        [self updateMapView];
        updatingWithTimer = 0;
        return;
    }
}
/*
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Job"];
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Job"];
    }
    pin.pinColor = MKPinAnnotationColorRed;
    pin.animatesDrop = YES;
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pin;
}*/
-(MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *annotation_view = nil;
    AvailableJobsAnnotation *annot = (AvailableJobsAnnotation*)annotation;
    printf("%s", [annot.name UTF8String]);
    CustomAnnotationView *view;
            view = [[[CustomAnnotationView alloc] initWithAnnotation:annot reuseIdentifier:annot.name] autorelease];
    [view addObserver:self forKeyPath:@"selected"options:NSKeyValueObservingOptionNew context:GMAP_ANNOTATION_SELECTED];
    
    view.image = [UIImage imageNamed:@"map_marker"];
    view.canShowCallout = YES;
    annotation_view = view;
    [annotation_view setEnabled:YES];
    [annotation_view setCanShowCallout:YES];
        //view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
       // aView.backgroundColor = [UIColor yellowColor];
    
    //UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //image.image = [UIImage imageNamed:@"icon57"];
       // view.leftCalloutAccessoryView = image;
    printf("ADDED AN ANNOTATION\n");
    
    return annotation_view;
}
-(void)showAnnotation:(AvailableJobsAnnotation*)annot_view
{
    int job_array_position;
    
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    for (int i = 0; i < delegate.user_state_information.job_array.count; i++)
    {
        if (annot_view.pin_id == [[delegate.user_state_information.job_array objectAtIndex:i] job_id])
        {
            job_array_position = i;
            delegate.user_state_information.current_job_in_array = job_array_position;
        }
    }
    current_selected_annotation_coordinate  = annot_view.coordinate;
    main_map_view.centerCoordinate          = annot_view.coordinate;
    previous_latitude                       = main_map_view.centerCoordinate.latitude;
    previous_longitude                      = main_map_view.centerCoordinate.longitude;
    
    CGPoint center_of_popover   = [main_map_view convertCoordinate:annot_view.coordinate toPointToView:self];
    popover                     = [[CustomGoogleMapBubble alloc] initWithFrame:CGRectMake(0, 0, 200, 70) andPos:job_array_position];
    popover.delegate            = self;
    popover.react_to_tap        = @selector(viewJob);
    popover.center              = CGPointMake(center_of_popover.x, center_of_popover.y - 65);
    [self insertSubview:popover atIndex:1];
}
-(void)hideAnnotation
{
    [popover removeFromSuperview];
}
-(void)viewJob
{
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    updatingWithTimer = 0;
    //show a alertview that we are accessing the credentials and talking to the server.
    /*load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];*/
    big_load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [big_load_view setMiniatureMapLoading];
    big_load_view.frame = CGRectMake(popover.frame.origin.x + popover.frame.size.width - 43, popover.frame.origin.y + popover.frame.size.height - 53, 20, 20);
    [self addSubview:big_load_view];
    loading_job = YES;
    /*UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];*/
    
    NSMutableString *job_info_url = [[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"];
    [job_info_url appendString:[NSString stringWithFormat:@"%d", [[delegate.user_state_information.job_array objectAtIndex:delegate.user_state_information.current_job_in_array] job_id]]];
    [job_info_url appendString:@"/job"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_info_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"GET"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    /*ConversationViewController *tester = [[ConversationViewController alloc] initWithNibName:@"ConversationViewController" bundle:nil andMessageArray:nil andDateArray:nil];
     [_viewController presentModalViewController:tester animated:YES];*/
    [request_ror startAsynchronous];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *action = (NSString*)context;
    if ([action isEqualToString:GMAP_ANNOTATION_SELECTED])
    {
        BOOL appeared = [[change valueForKey:@"new"] boolValue];
        if (appeared)
        {
            [self showAnnotation:((CustomAnnotationView*) object).annotation];
        }
        else
        {
            [self hideAnnotation];
        }
    }
}
- (void)dealloc
{
    [main_map_view          release];
    [load_view              release];
    [search_bar_text        release];
    [search_bar_background  release];
    [table_data             removeAllObjects];
    [table_data             release];
    [job_search_update      invalidate];
    
    job_search_update = nil;
    [super dealloc];
}

@end
