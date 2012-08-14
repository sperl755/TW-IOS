//
//  MyJobDisplayCell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyJobDisplayCell.h"
#import "StaffItToMeAppDelegate.h"
#import "ISO8601DateFormatter.h"


@implementation MyJobDisplayCell
@synthesize delegate;
/**
 This will initailize a my job cell. A My job cell is a cell to go in a table view that both checks in and out, automatically and manually for you.
 @variable frame - Frame of the object 
 @variable the_url - Useless
 @variable the_name - The name of the Job you are contracted to
 @variable the_description - The description provided with the job
 @variable the_position - The position in the global my job array that this cell belongs to.
 */
- (id)initWithFrame:(CGRect)frame urlString:(NSString*)the_url name:(NSString*)the_name description:(NSString*)the_description arrayPosition:(int)the_position
{
    self = [super initWithFrame:frame];
    if (self) {
        //Create Row 1
        UIImage *row_background         = [UIImage imageNamed:@"module_row.png"];
        module_row_one_background       = [[UIImageView alloc] initWithImage:row_background];
        module_row_one_background.frame = CGRectMake(0,0, 310, 42);
        [self addSubview:module_row_one_background];
        
        //Setup the first job suggestions information.
        job_one_picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_company"]];
        [job_one_picture setFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 8, 25, 25)];
        [self addSubview:job_one_picture];
        
        job_one_name                    = [[UILabel alloc] initWithFrame:CGRectMake(job_one_picture.frame.origin.x + job_one_picture.frame.size.width + 10, job_one_picture.frame.origin.y - 2, 130, 20)];
        job_one_name.backgroundColor    = [UIColor clearColor];
        job_one_name.font               = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11];
        job_one_name.text               = the_name;
        [self addSubview:job_one_name];
        
        job_one_description                 = [[UILabel alloc] initWithFrame:CGRectMake(job_one_name.frame.origin.x, job_one_name.frame.origin.y + job_one_name.frame.size.height - 10, 200, 30)];
        job_one_description.textColor       = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        job_one_description.backgroundColor = [UIColor clearColor];
        job_one_description.font            = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        job_one_description.text            = the_description;
        [self addSubview:job_one_description];
        array_position = the_position;
        
        //Create manual checkin button
        manual_button           = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *manual_image   = [UIImage imageNamed:@"ManualButtonBackground"];
        manual_button.frame     = CGRectMake(200, 9, 50, 24);
        [manual_button setImage:manual_image forState:UIControlStateNormal];
        [manual_button addTarget:self action:@selector(manualButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:manual_button];
        
        //Create checkin button
        checkin_button          = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *checkin_image  = [UIImage imageNamed:@"CheckinButtonBackground"];
        checkin_button.frame    = CGRectMake(manual_button.frame.origin.x + manual_button.frame.size.width + 5, manual_button.frame.origin.y, 50, 24);
        [checkin_button setImage:checkin_image forState:UIControlStateNormal];
        [checkin_button addTarget:self action:@selector(checkinButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkin_button];
        
        check_in_out_label                  = [[UILabel alloc] initWithFrame:CGRectMake(checkin_button.frame.origin.x + 6, checkin_button.frame.origin.y + 4, 45, 20)];
        check_in_out_label.textColor        = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        check_in_out_label.backgroundColor  = [UIColor clearColor];
        check_in_out_label.font             = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        check_in_out_label.text             = @"Check In";
        [self addSubview:check_in_out_label];
        
        //setup checkin_in to be yes. meaning that the next button was checked into
        checkin_in = YES;
        
        
    }
    return self;
}
/**
 This will cause a pop up to have you pick a date and a time for checking in.
 Then it will calculate the time using setCheckedInWithTime, switch the manual
 to check out and grey out the checkin button so it cant be used and sets the checkin_in to YES
 so other jobs may not be checked in.
 */
-(void)manualButtonAction
{
    if(checkin_in)//if the next action to happen is a checkin
    {
        //but i am already checked in with another job then I dont work.
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        if (app_delegate.user_state_information.on_my_job) {
            return;
        }
    }
    NSString *button_text;
    if(checkin_in)
    {
        button_text = @"Checkin";
    }
    else if (!checkin_in)
    {
        button_text = @"Checkout";
    }
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Pick a checkin date\n\n\n\n\n\n\n\n\n\n\n\n\n" 
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:button_text, nil];
    //if I want to check in manually checkin_in should be set to yes saying that the next action is a checkin
    if (checkin_in)
    {
        menu.tag = 21;//Set this for comparing in the delegate callback method.   
    }
    else if (!checkin_in)//if i was checked in
    {
        menu.tag = 23;//set this for comparing in the delegate callback method.
    }

    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 35, 325, 250)];
	datePicker.datePickerMode = UIDatePickerModeDateAndTime;
	datePicker.hidden = NO;
	datePicker.date = [NSDate date];
	[datePicker addTarget:self
                   action:@selector(setManualCheckinString:)
         forControlEvents:UIControlEventValueChanged];
	[menu addSubview:datePicker];
	[datePicker release];
    [menu showInView:self.superview];
}
-(void)setManualCheckinString:(UIDatePicker*)the_date_picker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss-Z"];
    ISO8601DateFormatter *formateriso   = [[ISO8601DateFormatter alloc] init];
    NSString *dateString                = [[[formateriso dateFromString:[the_date_picker.date description]] description] retain];
    NSString *releaser                  = my_manual_checkin_date_time;
    my_manual_checkin_date_time         = [[NSString alloc] initWithString:dateString];
    [releaser release];
}
/**
 Depending on which actionsheet has been clicked various things will happen such as sending a checkin to the server
 or sending a checkout to the server.
 */
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //If they clicked checkin
    if (buttonIndex == 0 && actionSheet.tag == 21)//21 becuase we are checking to see if they were checking in or out.
    {
        [((StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate]) displayLoadingView];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        /********************BElow will access the server requesting a checking on the job*****/
        checkin_date = my_manual_checkin_date_time;
        //Perform the accessing of the server.
        NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getCheckinCheckoutLink]];
        ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
        [request_ror setRequestMethod:@"POST"];
        [request_ror setValidatesSecureCertificate:NO];
        [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        
        [request_ror setPostValue:@"A Manual Checkin"           forKey:@"status_notes"];
        [request_ror setPostValue:@"1"                       forKey:@"is_manual"];
        [request_ror setPostValue:@"checkin"                    forKey:@"checkin_or_checkout"];
        [request_ror setPostValue:my_manual_checkin_date_time   forKey:@"start_datetime"];
        [request_ror setPostValue:@""                           forKey:@"end_datetime"];
        
        [request_ror setPostValue:[[app_delegate.user_state_information.my_jobs objectAtIndex:array_position] my_job_id] forKey:@"contract_id"];
        
        [request_ror setTimeOutSeconds:30];
        [request_ror setDelegate:self];
        [request_ror startAsynchronous];
        /********************Above is the asihttprequest *********////
        //checkin_in = NO;//set it to no because the next action will be checkin out
        //[self setCheckedInWithTime:my_manual_checkin_date_time manual:YES];
    }
    else if (buttonIndex == 0 && actionSheet.tag == 23)
    {
        [((StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate]) displayLoadingView];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        /********************BElow will access the server requesting a checking on the job*****/
        //Perform the accessing of the server.
        NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getCheckinCheckoutLink]];
        ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
        [request_ror setRequestMethod:@"POST"];
        [request_ror setValidatesSecureCertificate:NO];
        [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        [request_ror setPostValue:@"A Manual Checkout"          forKey:@"status_notes"];
        [request_ror setPostValue:@"1"                       forKey:@"is_manual"];
        [request_ror setPostValue:@"checkout"                   forKey:@"checkin_or_checkout"];
        [request_ror setPostValue:@""                           forKey:@"start_datetime"];
        [request_ror setPostValue:my_manual_checkin_date_time   forKey:@"end_datetime"];
        [request_ror setPostValue:[[app_delegate.user_state_information.my_jobs objectAtIndex:array_position] my_job_id] forKey:@"contract_id"];
        [request_ror setTimeOutSeconds:30];
        [request_ror setDelegate:self];
        [request_ror startAsynchronous];
        /********************Above is the asihttprequest *********////
        //checkin_in = YES;
        timer_done = YES;
    }
}
/**
 This method will check in the user and send the message up to the server
 checking in the person on the site.
 */
-(void)checkinButtonAction
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    if (app_delegate.user_state_information.on_my_job) {
        return;
    }
    //show a alertview that we are accessing the credentials and talking to the server.
    [((StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate]) displayLoadingView];
    /********************BElow will access the server requesting a checking on the job*****/
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getCheckinCheckoutLink]];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setPostValue:@"A Checkin"  forKey:@"status_notes"];
    [request_ror setPostValue:@"0"          forKey:@"is_manual"];
    [request_ror setPostValue:@"checkin"    forKey:@"checkin_or_checkout"];
    //[request_ror setPostValue:@""           forKey:@"start_datetime"];
    //[request_ror setPostValue:@""           forKey:@"end_datetime"];
    
    [request_ror setPostValue:[[app_delegate.user_state_information.my_jobs objectAtIndex:array_position] my_job_id] forKey:@"contract_id"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
    //checkin_in = YES;
    /********************Above is the asihttprequest *********////
    //ISO8601DateFormatter *formateriso = [[ISO8601DateFormatter alloc] init];
    //checkin_date = [[formateriso stringFromDate:[NSDate date]] retain];
    //my_manual_checkin_date_time = [formateriso stringFromDate:[NSDate date]];
    
}
/**
    Sets the cell checked in and calculates the time that it has been checked in then displays to user.
    @variable the_time - Time in yyyy-MM-dd'T'hh:mm:ss-timezone
 */
-(void)setCheckedInWithTime:(NSString*)the_time manual:(BOOL)isManual
{
    NSString *releaser  = checkin_date;
    checkin_date        = the_time;
    [releaser release];
    
    NSCalendar *calendar                = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    ISO8601DateFormatter *formateriso   = [[ISO8601DateFormatter alloc] init];
    NSCalendarUnit unitFlags            = NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *old_date                    = [formateriso dateFromString:the_time];
    NSDateComponents *difference        = [calendar components:unitFlags fromDate:old_date toDate:[NSDate date] options:0];
    
    hour_count      = [difference hour];
    minute_count    = [difference minute];
    second_count    = [difference second];
    day_count       = [difference day];
    month_count     = [difference month];
    //checkin_in = YES;
    [self requestFinished:nil];
}
/**
 If this is the last cell in the table then the background rounds out in the bottoms.
 */
-(void)setBackgroundImageToModuleLast
{
    UIImage *image      = [UIImage imageNamed:@"module_row_last"];
    UIImage *stretched  = [image stretchableImageWithLeftCapWidth:(image.size.width/2)-1 topCapHeight:(image.size.height/2)-1];
    [module_row_one_background setImage:stretched];
}
/**
 Once the server has responded it is handled in this method. If i am checking in on this call then I show the timer and show the distance and start increasing the time
 If I was not then I was checking out so then  I show checkin and reset most of the assets.
 */
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [((StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate]) removeLoadingViewFromWindow];
    if (checkin_in) //if user clicks check in then we change to check out and start timer
    {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        app_delegate.user_state_information.on_my_job = YES;
        timer_done = NO;
        
        [checkin_button removeTarget:self action:@selector(checkinButtonAction) forControlEvents:UIControlEventTouchUpInside];
        check_in_out_label.text         = @"Check out";
        check_in_out_label.center       = CGPointMake(check_in_out_label.center.x - 3, check_in_out_label.center.y);
        [checkin_button addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
        
        timer_display                   = [[UILabel alloc] initWithFrame:CGRectMake(120, job_one_name.frame.origin.y + 3, 75, 30)];
        timer_display.text              = [NSString stringWithFormat:@"%d:%d:%d:%d:%d",month_count, day_count, hour_count, minute_count, second_count];
        timer_display.textAlignment     = UITextAlignmentRight;
        timer_display.textColor         = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        timer_display.backgroundColor   = [UIColor clearColor];
        timer_display.font              = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        [self addSubview:timer_display];
        
        [self performSelector:@selector(updateTimerLook) withObject:nil afterDelay:1.0];
        checkin_in = NO;
    }
    else //If the person clicked check out then we change button back to check in
    {
        minute_count    = 0;
        second_count    = 0;
        hour_count      = 0;
        day_count       = 0;
        month_count     = 0;
        
        check_in_out_label.text     = @"Check In";
        my_manual_checkin_date_time = nil;
        checkin_date                = nil;
        
        check_in_out_label.center                       = CGPointMake(check_in_out_label.center.x + 3, check_in_out_label.center.y);
        StaffItToMeAppDelegate *app_delegate            = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        app_delegate.user_state_information.on_my_job   = NO;
        
        timer_display.text = @"";
        [checkin_button removeTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
        [checkin_button addTarget:self action:@selector(checkinButtonAction) forControlEvents:UIControlEventTouchUpInside];
        checkin_in = YES;
    }
}
/**
 This method increases the timer label that shows how long someone has been checked in.
 */
-(void)increaseLabel
{
    if (timer_done)
    {
        return;
    }
    second_count++;
    if (second_count == 60) {
        minute_count++;
        second_count = 0;
    }
    if (minute_count == 60) {
        hour_count++;
        minute_count = 0;
    }
    timer_display.text = [NSString stringWithFormat:@"%d:%d:%d:%d:%d",month_count, day_count, hour_count, minute_count, second_count];
    [self performSelector:@selector(increaseLabel) withObject:nil afterDelay:1.0];
}
-(void)updateTimerLook
{
    if (timer_done)
    {
        return;
    }
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    ISO8601DateFormatter *formateriso = [[ISO8601DateFormatter alloc] init];
    NSCalendarUnit unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *old_date;
    if (checkin_date == nil)
    {
        checkin_date    = [[[formateriso dateFromString:[[NSDate date] description]] description] retain];
        old_date        = [formateriso dateFromString:checkin_date];
    }
    else
    {
        old_date = [formateriso dateFromString:checkin_date];
    }
    NSDateComponents *difference    = [calendar components:unitFlags fromDate:old_date toDate:[NSDate date] options:0];
    hour_count                      = [difference hour];
    minute_count                    = [difference minute];
    second_count                    = [difference second];
    day_count                       = [difference day];
    month_count                     = [difference month];
    timer_display.text              = [NSString stringWithFormat:@"%d:%d:%d:%d:%d",month_count, day_count, hour_count, minute_count, second_count];
    [self performSelector:@selector(updateTimerLook) withObject:nil afterDelay:1.0];
}
/**
 This stops the timer and also performs a checkout
 */
-(void)stopTimer
{
    timer_done = YES;
    
    [((StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate]) displayLoadingView];
    /********************BElow will access the server requesting a checking on the job*****/
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:[[URLLibrary sharedInstance] getCheckinCheckoutLink]];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setPostValue:@"A Checkout"  forKey:@"status_notes"];
    [request_ror setPostValue:@"0"      forKey:@"is_manual"];
    [request_ror setPostValue:@"checkout"    forKey:@"checkin_or_checkout"];
    //[request_ror setPostValue:@""           forKey:@"start_datetime"];
    //[request_ror setPostValue:@""           forKey:@"end_datetime"];
    
    [request_ror setPostValue:[[app_delegate.user_state_information.my_jobs objectAtIndex:array_position] my_job_id] forKey:@"contract_id"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
    /********************Above is the asihttprequest *********////
    //checkin_in = NO;
    minute_count    = 0;
    second_count    = 0;
    hour_count      = 0;
    day_count       = 0;
    month_count     = 0;
}

- (void)dealloc
{
    [module_row_one_background  release];
    [job_one_name               release];
    [job_one_picture            release];
    [job_one_description        release];
    [check_in_out_label         release];
    [manual_button              release];
    [checkin_button             release];
    [load_message               release];
    [timer_display              release];
    [super dealloc];
}

@end
