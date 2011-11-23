//
//  MyJobDisplayCell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyJobDisplayCell.h"
#import "StaffItToMeAppDelegate.h"


@implementation MyJobDisplayCell
static NSString *my_checkin_checkout_url = @"https://helium.staffittome.com/apis/checkin_checkout";
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
        UIImage *row_background = [UIImage imageNamed:@"module_row.png"];
        module_row_one_background = [[UIImageView alloc] initWithImage:row_background];
        module_row_one_background.frame = CGRectMake(0,0, 310, 42);
        [self addSubview:module_row_one_background];
        
        //Setup the first job suggestions information.
        job_one_picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_company"]];
        [job_one_picture setFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 8, 25, 25)];
        [self addSubview:job_one_picture];
        
        job_one_name = [[UILabel alloc] initWithFrame:CGRectMake(job_one_picture.frame.origin.x + job_one_picture.frame.size.width + 10, job_one_picture.frame.origin.y - 2, 130, 20)];
        job_one_name.backgroundColor = [UIColor clearColor];
        job_one_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11];
        job_one_name.text = the_name;
        [self addSubview:job_one_name];
        
        job_one_description = [[UILabel alloc] initWithFrame:CGRectMake(job_one_name.frame.origin.x, job_one_name.frame.origin.y + job_one_name.frame.size.height - 10, 200, 30)];
        job_one_description.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        job_one_description.backgroundColor = [UIColor clearColor];
        job_one_description.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        job_one_description.text = the_description;
        [self addSubview:job_one_description];
        array_position = the_position;
        
        //Create manual checkin button
        manual_button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *manual_image = [UIImage imageNamed:@"ManualButtonBackground"];
        [manual_button setImage:manual_image forState:UIControlStateNormal];
        manual_button.frame = CGRectMake(200, 9, 50, 24);
        [manual_button addTarget:self action:@selector(manualButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:manual_button];
        
        //Create checkin button
        checkin_button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *checkin_image = [UIImage imageNamed:@"CheckinButtonBackground"];
        [checkin_button setImage:checkin_image forState:UIControlStateNormal];
        checkin_button.frame = CGRectMake(manual_button.frame.origin.x + manual_button.frame.size.width + 5, manual_button.frame.origin.y, 50, 24);
        [checkin_button addTarget:self action:@selector(checkinButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkin_button];
        check_in_out_label = [[UILabel alloc] initWithFrame:CGRectMake(checkin_button.frame.origin.x + 6, checkin_button.frame.origin.y + 4, 45, 20)];
        
        check_in_out_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        check_in_out_label.backgroundColor = [UIColor clearColor];
        check_in_out_label.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        check_in_out_label.text = @"Check In";
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
    //[delegate reactToManualButton:array_position];
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
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
    /********************BElow will access the server requesting a checking on the job*****/
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:my_checkin_checkout_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror setPostValue:@"A Checkin" forKey:@"status_notes"];
    [request_ror setPostValue:@"false" forKey:@"is_manual"];
    [request_ror setPostValue:@"checkin" forKey:@"checkin_or_checkout"];
    [request_ror setPostValue:@"" forKey:@"start_datetime"];
    [request_ror setPostValue:@"" forKey:@"end_datetime"];
    printf("%s", [[[app_delegate.user_state_information.my_jobs objectAtIndex:array_position] my_job_id] UTF8String]);
    [request_ror setPostValue:[[app_delegate.user_state_information.my_jobs objectAtIndex:array_position] my_job_id] forKey:@"contract_id"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
    checkin_in = YES;
    /********************Above is the asihttprequest *********////
    
}
/**
 Sets the cell checked in and calculates the time that it has been checked in then displays to user.
 @variable the_time - Time in yyyy-MM-dd'T'hh:mm:ss-timezone
 */
-(void)setCheckedInWithTime:(NSString*)the_time
{
    NSMutableString *current_date_gmt_offset = [[NSMutableString alloc] initWithString:[[NSTimeZone localTimeZone] description]];
    [current_date_gmt_offset deleteCharactersInRange:NSMakeRange(0, 49)];
    printf("%s", [current_date_gmt_offset UTF8String]);
    [current_date_gmt_offset deleteCharactersInRange:NSMakeRange(current_date_gmt_offset.length-1, 1)];
    printf("%s", [current_date_gmt_offset UTF8String]);
    //get the gmt offset by seconds for where I am
    int current_gmt_offset = [current_date_gmt_offset intValue];
    printf("%d", current_gmt_offset);
    
    
    //Get the information about the older checkin date
    NSString *old_year = [the_time substringWithRange:NSMakeRange(0, 4)];
    printf("Old year: %d\n", [old_year intValue]);
    NSString *old_month = [the_time substringWithRange:NSMakeRange(5,2)];
    printf("Old month: %d\n", [old_month intValue]);
    NSString *old_day = [the_time substringWithRange:NSMakeRange(8,2)];
    printf("Old day: %d\n", [old_day intValue]);
    NSString *old_hour = [the_time substringWithRange:NSMakeRange(11,2)];
    printf("Old hour: %d\n", [old_hour intValue]);
    NSString *old_minutes = [the_time substringWithRange:NSMakeRange(14,2)];
    printf("Old minutes: %d\n", [old_minutes intValue]);
    NSString *old_timezone_hour = [the_time substringWithRange:NSMakeRange(19,3)];
    printf("Old timezone_hours: %d\n", [old_timezone_hour intValue]);
    NSString *old_timezone_minutes = [the_time substringWithRange:NSMakeRange(23,2)];
    printf("Old timezone minutes: %d\n", [old_timezone_minutes intValue]);
    
    /*Convert the old gmt offset to seconds. It usually comes in the form
     of hours and minutes. Also do a check to see if it is negative.*/
    int old_gmt_offset;
    if ([old_timezone_hour characterAtIndex:0] == '-')
    {
        old_gmt_offset = ((([old_timezone_hour intValue]*60)*60) -([old_timezone_minutes intValue]*60));
    }
    else
    {
        old_gmt_offset = ((([old_timezone_hour intValue]*60)*60) +([old_timezone_minutes intValue]*60));
    }
    //Times for adjusting based on GMT Time Zone
    int current_hours_time;
    int old_hours_time;
    int current_minutes_time;
    int old_minutes_time;
    
    //Get the current time and get the current date in order to calculate
    //How long the person was working.
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"dd HH:mm:ss"];
    NSString *the_current_time = [timeFormat stringFromDate:[NSDate date]];
    printf("The Current Time is %s", [the_current_time UTF8String]);
    NSString *current_date_in_month = [the_current_time substringWithRange:NSMakeRange(0, 2)];
    printf("\nThe current day is %s", [current_date_in_month UTF8String]);
    printf("\nThe old day is %s", [old_day UTF8String]);
    NSString *current_hour = [the_current_time substringWithRange:NSMakeRange(3, 2)];
    NSString *current_minutes = [the_current_time substringWithRange:NSMakeRange(6, 2)];
    if (current_gmt_offset == old_gmt_offset)
    {
        current_hours_time = [current_hour intValue];
        current_minutes_time = [current_minutes intValue];
        old_minutes_time = [old_minutes intValue];
        old_hours_time = [old_hour intValue];
    }
    else if (current_gmt_offset > old_gmt_offset)
    {
        //This gives me the minute count difference
        int  minutes_difference = floor((current_gmt_offset - old_gmt_offset)/60);
        int hour_difference = floor(minutes_difference/60);
        int remainder_minutes = minutes_difference%60;
        printf("Hour diff: %d, Minute Remainder: %d", hour_difference, remainder_minutes);
        
        current_hours_time = [current_hour intValue];
        current_minutes_time = [current_minutes intValue];
        old_minutes_time = remainder_minutes + [old_minutes intValue];
        old_hours_time = hour_difference + [old_hour intValue];
    }
    else if (current_gmt_offset < old_gmt_offset)
    {
        //This gives me the minute count difference
        int  minutes_difference = floor((old_gmt_offset - current_gmt_offset)/60);
        int hour_difference = floor(minutes_difference/60);
        int remainder_minutes = minutes_difference%60;
        printf("Hour diff: %d, Minute Remainder: %d", hour_difference, remainder_minutes);
        
        current_hours_time = hour_difference + [current_hour intValue];
        current_minutes_time = remainder_minutes + [current_minutes intValue];
        old_minutes_time = [old_minutes intValue];
        old_hours_time = [old_hour intValue];
    }
    //Calculate the day difference if there is one.
    if ([current_date_in_month intValue] > [old_day intValue])
    {
        printf("%d", current_hours_time);
        //if the new time is less then the older checkin time
        if ((current_hours_time* 60) + current_minutes_time < (old_hours_time * 60) + old_minutes_time)
        {
            int hours_worked = 24 - old_hours_time;
            int minutes_worked = 60 - old_minutes_time;
            for (int i = [current_date_in_month intValue] - 1; i > [old_day intValue]; i--)
            {
                hours_worked += 24;
            }
            hours_worked += current_hours_time;
            minutes_worked += current_minutes_time;
            hour_count = hours_worked;
            minute_count = minutes_worked;
            checkin_in = YES;
            [self requestFinished:nil];
            printf("Hours Worked: %d", hours_worked);
            printf("Minutes Worked: %d", minutes_worked);
        }
        else if ((current_hours_time*60) + current_minutes_time > (old_hours_time * 60) + old_minutes_time)
        {
            int hours_worked = current_hours_time - old_hours_time;
            int minutes_worked_time;
            if (current_minutes_time < old_minutes_time)
            {
                hours_worked--;
                int temp = 60 - old_minutes_time;
                temp += current_minutes_time;
                minutes_worked_time = temp;
            }
            else
            {
                minutes_worked_time = current_minutes_time - old_minutes_time;
            }
            for (int i = [current_date_in_month intValue]; i > [old_day intValue]; i--)
            {
                hours_worked += 24;
            }
            hour_count = hours_worked;
            minute_count = minutes_worked_time;
            checkin_in = YES;
            [self requestFinished:nil];
            printf("Hours Worked: %d", hours_worked);
            printf("Minutes Worked: %d", minutes_worked_time);
        }
    }
    else
    {
        int hours_worked_time = current_hours_time - old_hours_time;
        int minutes_worked_time;
        if (current_minutes_time < old_minutes_time)
        {
            hours_worked_time--;
            int temp = 60 - old_minutes_time;
            temp += current_minutes_time;
            minutes_worked_time = temp;
        }
        else
        {
            minutes_worked_time = current_minutes_time - old_minutes_time;
        }
        hour_count = hours_worked_time;
        minute_count = minutes_worked_time;
        checkin_in = YES;
        [self requestFinished:nil];
        printf("Hours Worked: %d", hours_worked_time);
        printf("Minutes Worked: %d", minutes_worked_time);
    }
    
}
/**
 If this is the last cell in the table then the background rounds out in the bottoms.
 */
-(void)setBackgroundImageToModuleLast
{
    UIImage *image = [UIImage imageNamed:@"module_row_last"];
    UIImage *stretched = [image stretchableImageWithLeftCapWidth:(image.size.width/2)-1 topCapHeight:(image.size.height/2)-1];
    [module_row_one_background setImage:stretched];
}
/**
 Once the server has responded it is handled in this method. If i am checking in on this call then I show the timer and show the distance and start increasing the time
 If I was not then I was checking out so then  I show checkin and reset most of the assets.
 */
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [load_message dismissWithClickedButtonIndex:0 animated:YES];
    if (checkin_in) //if user clicks check in then we change to check out and start timer
    {
        //printf("This is the checkin checkout information %s", [[request responseString] UTF8String]);
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        app_delegate.user_state_information.on_my_job = YES;
        timer_done = NO;
        [checkin_button removeTarget:self action:@selector(checkinButtonAction) forControlEvents:UIControlEventTouchUpInside];
        check_in_out_label.text = @"Check out";
        check_in_out_label.center = CGPointMake(check_in_out_label.center.x - 3, check_in_out_label.center.y);
        [checkin_button addTarget:self action:@selector(stopTimer) forControlEvents:UIControlEventTouchUpInside];
        timer_display = [[UILabel alloc] initWithFrame:CGRectMake(150, job_one_name.frame.origin.y + 3, 45, 30)];
        timer_display.text = [NSString stringWithFormat:@"%d:%d:%d", hour_count, minute_count, second_count];
        timer_display.textAlignment = UITextAlignmentRight;
        timer_display.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        timer_display.backgroundColor = [UIColor clearColor];
        timer_display.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        [self addSubview:timer_display];
        [self performSelector:@selector(increaseLabel) withObject:nil afterDelay:1.0];
        checkin_in = NO;
    }
    else //If the person clicked check out then we change button back to check in
    {
        check_in_out_label.text = @"Check In";
        check_in_out_label.center = CGPointMake(check_in_out_label.center.x + 3, check_in_out_label.center.y);
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        app_delegate.user_state_information.on_my_job = NO;
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
    timer_display.text = [NSString stringWithFormat:@"%d:%d:%d", hour_count, minute_count, second_count];
    [self performSelector:@selector(increaseLabel) withObject:nil afterDelay:1.0];
}
/**
 This stops the timer and also performs a checkout
 */
-(void)stopTimer
{
    timer_done = YES;
    
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    /********************BElow will access the server requesting a checking on the job*****/
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:my_checkin_checkout_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror setPostValue:@"Status Notes" forKey:@"status_notes"];
    [request_ror setPostValue:@"false" forKey:@"is_manual"];
    [request_ror setPostValue:@"checkout" forKey:@"checkin_or_checkout"];
    [request_ror setPostValue:@"" forKey:@"start_datetime"];
    [request_ror setPostValue:@"" forKey:@"end_datetime"];
    [request_ror setPostValue:[[app_delegate.user_state_information.my_jobs objectAtIndex:array_position] my_job_id] forKey:@"contract_id"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];
    /********************Above is the asihttprequest *********////
    checkin_in = NO;
    minute_count = 0;
    second_count = 0;
    hour_count = 0;
}

- (void)dealloc
{
    [module_row_one_background release];
    [job_one_name release];
    [job_one_picture release];
    [job_one_description release];
    [check_in_out_label release];
    [manual_button release];
    [checkin_button release];
    [load_message release];
    [timer_display release];
    [super dealloc];
}

@end
