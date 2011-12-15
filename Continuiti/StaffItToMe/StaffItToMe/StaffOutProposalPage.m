//
//  StaffOutProposalPage.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffOutProposalPage.h"
#import "StaffItToMeAppDelegate.h"
#define UISLIDER_TAG 23
#define EMAIL_TAG 26
#define SUBJECT_TAG 29
#define MESSAGE_TAG 33
#define BUTTON_TAG 38

@implementation StaffOutProposalPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        int user_id = app_delegate.user_state_information.my_user_info.user_id;
        NSMutableString *url_string = [[NSMutableString alloc] initWithString:@"https://helium.staffittome.com/apis/"];
        [url_string appendString:[NSString stringWithFormat:@"%d", user_id]];
        [url_string appendString:@"/capability_list"];
        //Perform the accessing of fthe server. for the user capabilities
        NSURL *url = [NSURL URLWithString:url_string];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        printf("%s", [[NSString stringWithFormat:@"%d", user_id] UTF8String]);
        [request setPostValue:[NSString stringWithFormat:@"%d", user_id]forKey:@"user_id"];
        ///Finish request
        [request setValidatesSecureCertificate:NO];
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request startAsynchronous];
        getting_information = YES;
        max_slider_value = 150;
        min_slider_value = 9.5;
        pay_type = @"Hourly";
        
        // Custom initialization
        module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:[self getHeader],[self getCapabilityDropDown],[self getRateCell], [self getEmailCell], [self getSubjectCell], [self getMessageCell], [self getStaffOutButtonCell], nil]];
        capability_txt.text = @"Choose a capability";
        positioning_arrows = [[FindRightSpotArrows alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
        positioning_arrows.center = CGPointMake(200, 200);
        positioning_arrows.delegate = self;
       // [self.view addSubview:positioning_arrows];
    }
    return self;
}
-(void)reactToButtonFindRightSpotButtonBeingPressed:(NSString *)the_button_name
{
    double movement_amount = .5;
    double x_offset = 0;
    double y_offset = 0;
    if ([the_button_name isEqualToString:@"Up"])
    {
        y_offset = -movement_amount;
    } else if ([the_button_name isEqualToString:@"Down"]) {
        y_offset = movement_amount;
    }
    else if ([the_button_name isEqualToString:@"Left"]){
        x_offset = -movement_amount;
    }
    else if ([the_button_name isEqualToString:@"Right"]){
        x_offset = movement_amount;
    }
    rate_slider.center = CGPointMake(rate_slider.center.x + x_offset, rate_slider.center.y + y_offset);
    printf("\nCenter X: %f, Center Y: %f", rate_slider.center.x, rate_slider.center.y);
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
//--------------TABLE VIEW METHOD TABLE VIEW METHODS TABLE VIEW METHODS-----------
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return module_array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 33;
    }
    if (indexPath.row == 2)
    {
        return 42;
    }
    //return  [[module_array objectAtIndex:indexPath.row] frame].size.height;
    if (indexPath.row == 5)
    {
        return 90;
    }
    return 42;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.contentView.clipsToBounds = NO;
    cell.clipsToBounds = NO;
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:[module_array objectAtIndex:indexPath.row]];
    return cell;
}
//--------------End TABLE VIEW METHOD END TABLE VIEW METHODS END TABLE VIEW METHODS-----------

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    my_table_view.allowsSelection = NO;
    my_table_view.backgroundColor = [UIColor clearColor];
    my_table_view.separatorColor = [UIColor clearColor];
    my_table_view.tag_for_listening = UISLIDER_TAG;
    my_table_view.email_tag_for_listening = EMAIL_TAG;
    my_table_view.subject_tag_for_listening = SUBJECT_TAG;
    my_table_view.message_tag_for_listening = MESSAGE_TAG;
    my_table_view.button_tag_for_listening = BUTTON_TAG;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(id)getHeader
{
    UIView *my_header_view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 310, 33)];
    //Create Header
    UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
    UIImageView *module_header_background = [[UIImageView alloc] initWithImage:header_image];
    module_header_background.frame = CGRectMake(0, 0, 310, 33);
    [my_header_view addSubview:module_header_background];
    //[header_image release];
    UILabel *spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
    spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    spam_your_friends_label.backgroundColor = [UIColor clearColor];
    [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    spam_your_friends_label.text = @"Send a Proposal";
    [my_header_view addSubview:spam_your_friends_label];
    [my_header_view setFrame:CGRectMake(5, 0, 310, module_header_background.frame.size.height)];
    return my_header_view;
}
-(id)getCapabilityDropDown
{
    UIView *capability_view = [[UIView alloc] init];
    UIButton *background_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [background_btn setBackgroundImage:[UIImage imageNamed:@"module_row"] forState:UIControlStateNormal];
    [background_btn setFrame:CGRectMake(5, 0, 310, 42)];
    [background_btn addTarget:self action:@selector(changeCapability) forControlEvents:UIControlEventTouchUpInside];
    [capability_view addSubview:background_btn];
    /*UIImageView *cell_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
    cell_background.frame = CGRectMake(5, 0, 310, 42);
    [capability_view addSubview:cell_background];*/
    
    //Make category label
    category = [[UILabel alloc] initWithFrame:CGRectMake(background_btn.frame.origin.x + 10, background_btn.frame.origin.y + 2.5, 200, 40)];
    [category setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12]];
    category.backgroundColor = [UIColor clearColor];
    category.text = @"Capability.";
    category.center = CGPointMake(115, 22);
    [capability_view addSubview:category];
    
    //Make detail label of the cell
    capability_txt = [[UILabel alloc] initWithFrame:CGRectMake(background_btn.frame.origin.x + 75, background_btn.frame.origin.y + 3,110, 40)];
    [capability_txt setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12]];
    capability_txt.backgroundColor = [UIColor clearColor];
    [capability_view addSubview:capability_txt];
    capability_txt.textColor = [UIColor colorWithRed:110.0/255 green:146.0/255 blue:212.0/255 alpha:1];
    capability_txt.textAlignment = UITextAlignmentRight;
    //Create arrow
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    arrow.frame = CGRectMake(capability_txt.frame.origin.x + capability_txt.frame.size.width + 105, capability_txt.frame.origin.y + 11, 6.5, 12);
    [capability_view addSubview:arrow];
    [capability_view setFrame:CGRectMake(0, 0, 320, 47)];
    
    //Create Value Display
    my_value_display = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SliderValueIndicator"]];
    my_value_display.frame = CGRectMake(75, 30, 39.5, 29.5);
    [capability_view addSubview:my_value_display];
    
    //Create value of slider
    my_value_display_text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    my_value_display_text.center = CGPointMake(my_value_display.center.x, my_value_display.center.y);
    my_value_display_text.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
    my_value_display_text.textAlignment = UITextAlignmentCenter;
    my_value_display_text.backgroundColor = [UIColor clearColor];
    [my_value_display_text setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
    NSMutableString *value_text = [[NSMutableString alloc] initWithString:@"$"];
    int min_value = (int) [rate_slider getMinValue];
    [value_text appendString:[NSString stringWithFormat:@"%d", min_value]];
    my_value_display_text.text = value_text;
    [capability_view addSubview:my_value_display_text];
    
    return capability_view;
}
-(void)changeCapability
{
    menu = [[UIActionSheet alloc] initWithTitle:@"Pick a capability.\n\n\n\n\n\n\n\n\n\n\n\n\n" 
                                                      delegate:self
                                             cancelButtonTitle:@"Cancel"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Select", nil];
    capability_picker_view = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, 325, 250)];
    capability_picker_view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    capability_picker_view.delegate = self;
    capability_picker_view.dataSource = self;
    capability_picker_view.showsSelectionIndicator = YES;
    [menu addSubview:capability_picker_view];
    [menu showInView:capability_txt.superview];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:[self getHeader],[self getCapabilityDropDown],[self getRateCell], [self getEmailCell], [self getSubjectCell], [self getMessageCell], [self getStaffOutButtonCell], nil]];
    [my_table_view reloadData];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString* return_string;
    if (pickerView == capability_picker_view)
    {
        if (row == 0)
        {
            return_string = @"Choose a capability.";
        }
        else
        {
            return_string = @"capability";   
        }
    }
    else if (pickerView == rate_picker_view)
    {
        if (row == 0)
        {
            return_string = @"Hourly";
        }
        else if (row == 1)
        {
            return_string = @"Fixed";
        }
    }
    return return_string;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    int return_rows;
    if (pickerView == capability_picker_view) {
        return_rows = 3;
    }
    else if (pickerView == rate_picker_view) 
    {
        return_rows = 2;
    }
    return return_rows;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == capability_picker_view)
    {
        
    }
    else if (pickerView == rate_picker_view)
    {
        //if they selected hourly
        if (row == 0)
        {
            pay_type = @"Hourly";
            max_slider_value = 150;
            min_slider_value = 9.5;
        }
        else if (row == 1)//if they selected fixed.
        {
            pay_type = @"Fixed";
            max_slider_value = 150000;
            min_slider_value = 10000;
        }
    }
}
-(id)getRateCell
{
    UIView *rate_view = [[UIView alloc] init];
    UIImage *cell_image2 = [UIImage imageNamed:@"module_row"];
    UIImage *cell_stretchable2 = [cell_image2 stretchableImageWithLeftCapWidth:(cell_image2.size.width/2)-1 topCapHeight:(cell_image2.size.height/2)-1];
    UIButton *background_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [background_btn setBackgroundImage:cell_stretchable2 forState:UIControlStateNormal];
    [background_btn setFrame:CGRectMake(5, 0, 310, 42)];
    [background_btn addTarget:self action:@selector(changeRateType) forControlEvents:UIControlEventTouchUpInside];
    [rate_view addSubview:background_btn];
    /*UIImageView *cell_background = [[UIImageView alloc] initWithImage:cell_stretchable2];
    cell_background.frame = CGRectMake(5, 0, 310, 42);
    [rate_view addSubview:cell_background];*/
    
    rate_txt = [[UILabel alloc] initWithFrame:CGRectMake(background_btn.frame.origin.x + 10, background_btn.frame.origin.y -4, 75, 40)];
    [rate_txt setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12]];
    rate_txt.backgroundColor = [UIColor clearColor];
    rate_txt.text = pay_type;
    rate_txt.center = CGPointMake(52.5, 22);
    [rate_view addSubview:rate_txt];
    
    rate_arrow = [[UIImageView alloc] initWithFrame:CGRectMake(rate_txt.frame.origin.x + rate_txt.frame.size.width - 15, rate_txt.frame.origin.y, 6.5, 12)];
    rate_arrow.image = [UIImage imageNamed:@"arrow"];
    rate_arrow.center = CGPointMake(78.25, 20);
    [rate_view addSubview:rate_arrow];
    
    rate_slider = [[ASSLider alloc] initWithFrame:CGRectMake(rate_arrow.frame.origin.x + rate_arrow.frame.size.width + 25, rate_arrow.frame.origin.y - 21, 205, 42) andMaxValue:max_slider_value minValue:min_slider_value];
    rate_slider.clipsToBounds = NO;
    rate_slider.center = CGPointMake(197.5, 14);
    rate_view.clipsToBounds = NO;
    [rate_slider hideValueDisplay];
    [rate_view addSubview:rate_slider];
    rate_slider.delegate = self;
    rate_slider.tag = UISLIDER_TAG;
    [rate_view setFrame:CGRectMake(0, 0, 310, 42)];
    
    return rate_view;
    
}
-(void)changeRateType
{
    menu = [[UIActionSheet alloc] initWithTitle:@"Pick a rate type\n\n\n\n\n\n\n\n\n\n\n\n\n" 
                                       delegate:self
                              cancelButtonTitle:@"Cancel"
                         destructiveButtonTitle:nil
                              otherButtonTitles:@"Select", nil];
    rate_picker_view = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, 325, 250)];
    rate_picker_view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    rate_picker_view.delegate = self;
    rate_picker_view.dataSource = self;
    rate_picker_view.showsSelectionIndicator = YES;
    [menu addSubview:rate_picker_view];
    [menu showInView:rate_txt.superview];
    
}
-(void)reactToASSliderValueChange:(double)the_slider_value
{
    if ([pay_type isEqualToString:@"Fixed"])
    {
        per_hr = (int)the_slider_value;   
        [my_value_display setCenter:CGPointMake(rate_slider.frame.origin.x + ([rate_slider getThumbFrame].origin.x + ([rate_slider getThumbFrame].size.width / 2)), my_value_display.center.y)];
        my_value_display_text.center = CGPointMake(my_value_display.center.x, my_value_display.center.y);
        NSMutableString *value_text = [[NSMutableString alloc] initWithString:@"$"];
        int min_value = (int) [rate_slider getCurrentValue];
        [value_text appendString:[NSString stringWithFormat:@"%d", min_value]];
        [value_text deleteCharactersInRange:NSMakeRange(3, 3)];
        [value_text appendString:@"g"];
        my_value_display_text.text = value_text;
        return;
    }
    per_hr = (int)the_slider_value;   
    [my_value_display setCenter:CGPointMake(rate_slider.frame.origin.x + ([rate_slider getThumbFrame].origin.x + ([rate_slider getThumbFrame].size.width / 2)), my_value_display.center.y)];
    my_value_display_text.center = CGPointMake(my_value_display.center.x, my_value_display.center.y);
    NSMutableString *value_text = [[NSMutableString alloc] initWithString:@"$"];
    int min_value = (int) [rate_slider getCurrentValue];
    [value_text appendString:[NSString stringWithFormat:@"%d", min_value]];
    my_value_display_text.text = value_text;
}
-(id)getEmailCell
{
    UIView *email_view = [[UIView alloc] init];
    UIImageView *cell_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
    cell_background.frame = CGRectMake(5, 0, 310, 42);
    [email_view addSubview:cell_background];
    
    subject_email_lbl = [[UILabel alloc] initWithFrame:CGRectMake(cell_background.frame.origin.x + 10, cell_background.frame.origin.y + 4, 75, 40)];
    subject_email_lbl.text = @"Send To ";
    [subject_email_lbl setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12]];
    subject_email_lbl.backgroundColor = [UIColor clearColor];
    subject_email_lbl.center = CGPointMake(52.5, 22);
    [email_view addSubview:subject_email_lbl];
    
    email_text = [[UITextField alloc] initWithFrame:CGRectMake(subject_email_lbl.frame.origin.x + subject_email_lbl.frame.size.width + 7, subject_email_lbl.frame.origin.y + 12, 200, 45)];
    email_text.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    email_text.delegate = self;
    [email_text setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
    email_text.backgroundColor = [UIColor clearColor];
    email_text.text = @"an@example.com";
    email_text.tag = EMAIL_TAG;
    email_text.delegate = self;
    email_text.center = CGPointMake(197, 37.5);
    email_text.userInteractionEnabled = YES;
    [email_view addSubview:email_text];
    
    return email_view;
}
-(id)getSubjectCell
{
    UIView *email_view = [[UIView alloc] init];
    UIImageView *cell_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
    cell_background.frame = CGRectMake(5, 0, 310, 42);
    [email_view addSubview:cell_background];
    
    email_lbl = [[UILabel alloc] initWithFrame:CGRectMake(cell_background.frame.origin.x + 10, cell_background.frame.origin.y, 75, 45)];
    email_lbl.text = @"Subject ";
    [email_lbl setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12]];
    email_lbl.backgroundColor = [UIColor clearColor];
    email_lbl.center = CGPointMake(email_lbl.center.x,22);
    [email_view addSubview:email_lbl];
    
    subject_txt = [[UITextField alloc] initWithFrame:CGRectMake(email_lbl.frame.origin.x + email_lbl.frame.size.width + 7, email_lbl.frame.origin.y + 16, 200, 50)];
    [subject_txt setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
    subject_txt.backgroundColor = [UIColor clearColor];
    subject_txt.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableString *subject_txt_string = [[NSMutableString alloc] initWithString:@"A proposal from "];
    [subject_txt_string appendString:app_delegate.user_state_information.my_user_info.full_name];
    [subject_txt_string appendString:@"."];
    subject_txt.text = subject_txt_string;
    subject_txt.tag = SUBJECT_TAG;
    subject_txt.delegate = self;
    subject_txt.userInteractionEnabled = YES;
    subject_txt.center = CGPointMake(197, 40);
    [email_view addSubview:subject_txt];
    
    return email_view;
}
-(id)getMessageCell
{
    UIView *email_view = [[UIView alloc] init];
    UIImage *cell_image2 = [UIImage imageNamed:@"module_row_last"];
    UIImage *cell_stretchable2 = [cell_image2 stretchableImageWithLeftCapWidth:(cell_image2.size.width/2)-1 topCapHeight:(cell_image2.size.height/2)-1];
    UIImageView *cell_background = [[UIImageView alloc] initWithImage:cell_stretchable2];
    cell_background.frame = CGRectMake(5, 0, 310, 90);
    [email_view addSubview:cell_background];
    
    UIImageView *message_backing = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StaffOutMEssageBacking"]];
    message_backing.frame = CGRectMake(10, 5, 300, 80);
    [email_view addSubview:message_backing];
    
    message_txt = [[UITextView alloc] initWithFrame:CGRectMake(message_backing.frame.origin.x + 5, message_backing.frame.origin.y, message_backing.frame.size.width - 10, message_backing.frame.size.height - 5)];
    [message_txt setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:11]];
    message_txt.backgroundColor = [UIColor clearColor];
    message_txt.text = @"Enter a description.";
    message_txt.tag = MESSAGE_TAG;
    message_txt.delegate = self;
    message_txt.center = CGPointMake(152, 42.5);
    message_txt.userInteractionEnabled = YES;
    [email_view addSubview:message_txt];
    
    return email_view;
}
-(id)getStaffOutButtonCell
{
    UIView *email_view = [[UIView alloc] init];
    UIButton *staff_out_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [staff_out_button setImage:[UIImage imageNamed:@"send_proposal"] forState:UIControlStateNormal];
    [staff_out_button setImage:[UIImage imageNamed:@"send_proposal_pressed"] forState:UIControlStateSelected];
    [staff_out_button addTarget:self action:@selector(sendProposal) forControlEvents:UIControlEventTouchUpInside];
    staff_out_button.frame = CGRectMake(76, 5, 170, 42);
    staff_out_button.tag = BUTTON_TAG;
    [email_view addSubview:staff_out_button];
    return email_view;
}
-(void)sendProposal
{
    
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:load_view];
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    // Custom initialization
    NSURL *url = [NSURL URLWithString:@"https://helium.staffittome.com/apis/create_proposal "];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"POST"];
    [request_ror setTimeOutSeconds:30];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setDelegate:self];
    [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request_ror setPostValue:@"1" forKey:@"payment_method"];
    [request_ror setPostValue:@"1" forKey:@"capability_id"];
    [request_ror setPostValue:[NSString stringWithFormat:@"%d", per_hr] forKey:@"rate"];
    [request_ror setPostValue:email_text.text forKey:@"email"];
    [request_ror setPostValue:message_txt.text forKey:@"message"];
    [request_ror setPostValue:subject_txt.text forKey:@"subject"];
    [request_ror startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (getting_information)
    {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        [app_delegate.user_state_information populateUserCapabilities:[request responseString]];
        printf("\n\n\nThis is theuser capabilities: %s\n\n", [[request responseString] UTF8String]);
        getting_information = NO;
        return;
    }
    [load_view removeFromSuperview];
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"" message:@"Your proposal was submitted!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [aler show];
    [aler release];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (message_txt == message_txt)
    {
        if (!message_text_touched)
        {
            message_text_touched = YES;
            message_txt.text = @"";
        }
        message_txt.textColor = [UIColor colorWithRed:110.0/255 green:146.0/255 blue:212.0/255 alpha:1];
    }
    my_table_view.center = CGPointMake(my_table_view.center.x, my_table_view.center.y - 200);
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (message_txt == message_txt)
    {
        message_txt.textColor = [UIColor blackColor];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [message_txt resignFirstResponder];
        my_table_view.center = CGPointMake(my_table_view.center.x, my_table_view.center.y + 200);
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == email_text)
    {
        if (!email_text_touched)
        {
            email_text_touched = YES;
            email_text.text = @"";
        }
        email_text.textColor = [UIColor colorWithRed:110.0/255 green:146.0/255 blue:212.0/255 alpha:1];
    }
    else if (textField == subject_txt)
    {
        if(!subject_text_touched)
        {
            subject_text_touched = YES;
            subject_txt.text = @"";
        }
        subject_txt.textColor = [UIColor colorWithRed:110.0/255 green:146.0/255 blue:212.0/255 alpha:1];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == email_text)
    {
        email_text.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    }
    else if (textField == subject_txt)
    {
        subject_txt.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    }
    else if (message_txt == message_txt)
    {
        message_txt.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
    {
        [email_text resignFirstResponder];
        [subject_txt resignFirstResponder];
    }
    return YES;
}
-(void)sliderValueChanged
{
}
@end
