//
//  MessageDetailsController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MessageDetailsController.h"
#import "StaffItToMeAppDelegate.h"

@implementation MessageDetailsController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithPositionInInboxArray:(int)the_position
{
    if ((self = [super init]))
    {
        looking_at_profile = 0;
        current_position = the_position;
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        
        item_holder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320 , 480)];
        //Create Header With Subject
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        subject_header = [[UIImageView alloc] initWithImage:header_image];
        subject_header.frame = CGRectMake(5, 5, 310, 33);
        [item_holder addSubview:subject_header];
        //[header_image release];
        subject_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 22)];
        subject_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        subject_label.backgroundColor = [UIColor clearColor];
        [subject_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        subject_label.text = [[app_delegate.user_state_information.my_inbox_messages objectAtIndex:the_position] my_subject];
        [item_holder addSubview:subject_label];
        //Create sender name label
        /*name_label = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 22)];
        name_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        name_label.textAlignment = UITextAlignmentRight;
        name_label.backgroundColor = [UIColor clearColor];
        [name_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        name_label.text = [[app_delegate.user_state_information.my_inbox_messages objectAtIndex:the_position] my_sender_name];
        [item_holder addSubview:name_label];*/
        
        //Create Sender Name Button
        UIImage *sender_btn_image = [UIImage imageNamed:@"CheckinButtonBackground"];
        UIImage *stretchable_sender_image = [sender_btn_image stretchableImageWithLeftCapWidth:(sender_btn_image.size.width/2)-1 topCapHeight:(sender_btn_image.size.height/2)-1];
        sender_name = [UIButton buttonWithType:UIButtonTypeCustom];
        [sender_name setBackgroundImage:stretchable_sender_image forState:UIControlStateNormal];
        [sender_name addTarget:self action:@selector(viewProfile) forControlEvents:UIControlEventTouchUpInside];
        [sender_name setTitle:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:the_position] my_sender_name] forState:UIControlStateNormal];
        
        sender_name.titleLabel.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:7];
        sender_name.titleLabel.textAlignment = UITextAlignmentCenter;
        CGSize button_size = [[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:the_position] my_sender_name] sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:7]];
        sender_name.frame = CGRectMake((subject_header.frame.origin.x + subject_header.frame.size.width) - (button_size.width + 15), 10, button_size.width + 10, 22);
        
        [sender_name setTitleColor:[UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1] forState:UIControlStateNormal];
        [item_holder addSubview:sender_name];
        
        //Create Middle Message Body Part
        UIImage *cell_image2 = [UIImage imageNamed:@"module_row_last"];
        UIImage *cell_stretchable2 = [cell_image2 stretchableImageWithLeftCapWidth:(cell_image2.size.width/2)-1 topCapHeight:(cell_image2.size.height/2)-1];
        UIImageView *body_background = [[UIImageView alloc] initWithFrame:CGRectMake(subject_header.frame.origin.x, subject_header.frame.origin.y + subject_header.frame.size.height, 310, 150)];
        body_background.image = cell_stretchable2;
        [item_holder addSubview:body_background];
         
         UITextView *body_text = [[UITextView alloc] initWithFrame:CGRectMake(9, body_background.frame.origin.y + 1, body_background.frame.size.width - 10, body_background.frame.size.height - 10)];
         body_text.text = [[app_delegate.user_state_information.my_inbox_messages objectAtIndex:the_position] my_body];
         body_text.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
         body_text.backgroundColor = [UIColor clearColor];
         [body_text setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        [item_holder addSubview:body_text];
        body_text.userInteractionEnabled = NO;
        
        //Create RespondToMessage
        //Create Header With Respondd to message
        UIImage *respond_image = [UIImage imageNamed:@"module_header.png"];
        UIImageView *respond_header = [[UIImageView alloc] initWithImage:respond_image];
        respond_header.frame = CGRectMake(body_background.frame.origin.x, body_background.frame.origin.y + body_background.frame.size.height + 5, 310, 33);
        [item_holder addSubview:respond_header];
        UILabel *respond_label = [[UILabel alloc] initWithFrame:CGRectMake(15, respond_header.frame.origin.y + 5, 200, 22)];
        respond_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        respond_label.backgroundColor = [UIColor clearColor];
        [respond_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        respond_label.text = @"Respond To Message";
        [item_holder addSubview:respond_label];
        
        //Create Respond Text
        UIImage *cell_image = [UIImage imageNamed:@"module_row_last"];
        UIImage *cell_stretchable = [cell_image stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        UIImageView *cell_background = [[UIImageView alloc] initWithImage:cell_stretchable];
        cell_background.frame = CGRectMake(respond_header.frame.origin.x, respond_header.frame.origin.y + respond_header.frame.size.height, 310, 100);
        [item_holder addSubview:cell_background];
        
        UIImage *backing_image = [UIImage imageNamed:@"StaffOutMEssageBacking"];
        UIImage *stretched_backing_image = [backing_image stretchableImageWithLeftCapWidth:(backing_image.size.width/2)-1 topCapHeight:(backing_image.size.height/2)-1];
        UIImageView *message_backing = [[UIImageView alloc] initWithImage:stretched_backing_image];
        message_backing.frame = CGRectMake(cell_background.frame.origin.x + 5, cell_background.frame.origin.y + 3, cell_background.frame.size.width - 10, cell_background.frame.size.height - 7);
        [item_holder addSubview:message_backing];
        
        message_txt = [[UITextView alloc] initWithFrame:CGRectMake(8, message_backing.frame.origin.y + 1, message_backing.frame.size.width - 10, message_backing.frame.size.height - 5)];
        [message_txt setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        message_txt.backgroundColor = [UIColor clearColor];
        message_txt.text = @"Send a Message.";
        message_txt.delegate = self;
        message_txt.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
        message_txt.userInteractionEnabled = YES;
        [item_holder addSubview:message_txt];
        
        //Create Send Button
        UIImage *send_button_image = [[UIImage imageNamed:@"SendButton"] stretchableImageWithLeftCapWidth:([UIImage imageNamed:@"SendButton"].size.width/2)-1 topCapHeight:([UIImage imageNamed:@"SendButton"].size.height/2)-1];
        UIButton *staff_out_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [staff_out_button setImage:send_button_image forState:UIControlStateNormal];
        [staff_out_button addTarget:self action:@selector(respondToMessage) forControlEvents:UIControlEventTouchUpInside];
        staff_out_button.frame = CGRectMake(5, cell_background.frame.origin.y + cell_background.frame.size.height + 12, 89.5, 22.5);
        [item_holder addSubview:staff_out_button];
        
        [self.view addSubview:item_holder];
        
    }
    return self;
}
-(void)viewProfile
{   
    looking_at_profile = 22;
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
    
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    NSMutableString *user_information = [[NSMutableString alloc] initWithString:@"https://helium.staffittome.com/apis/"];
    [user_information appendString:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:current_position] my_sender_id]];
    [user_information appendString:@"/profile_details"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:user_information];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"GET"];
    [request_ror setValidatesSecureCertificate:NO];
    //[request_ror setPostValue:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:current_position] my_sender_id] forKey:@"id"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    [request_ror startAsynchronous];

}
-(void)respondToMessage
{
    @try 
    {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        // Custom initialization
        NSURL *url = [NSURL URLWithString:@"https://helium.staffittome.com/apis/create_message"];
        ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
        [request_ror setRequestMethod:@"POST"];
        [request_ror setTimeOutSeconds:30];
        [request_ror setValidatesSecureCertificate:NO];
        [request_ror setDelegate:self];
        [request_ror setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
        int user_id = app_delegate.user_state_information.my_user_info.user_id;
        printf("%s", [[NSString stringWithFormat:@"%d", user_id] UTF8String]);
        [request_ror setPostValue:
         [NSString stringWithFormat:@"%d", app_delegate.user_state_information.my_user_info.user_id] forKey:@"sender_id"];
        [request_ror setPostValue:[[app_delegate.user_state_information.my_inbox_messages objectAtIndex:current_position] my_sender_id] forKey:@"recipient_id"];
        [request_ror setPostValue:message_txt.text forKey:@"body"];
        [request_ror setPostValue:subject_label.text forKey:@"subject"];
        [request_ror setPostValue:@"Job"  forKey:@"messageable_type"];
        [request_ror setPostValue:@"2" forKey:@"messageable_id"];
        [request_ror startAsynchronous];
        load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [load_message show];
        UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
        [active startAnimating];
        [load_message addSubview:active];
    }
    @catch (NSException *exception)
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Try Again" message:@"Sorry, we were unable to process your request. If you wait a few minutes it should we should be ready!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [message show];
        [message release];
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [load_message dismissWithClickedButtonIndex:0 animated:YES];
    printf("RESPONSEING: %s", [[request responseString] UTF8String]);
    if (looking_at_profile == 22)
    {
        @try {
            AUserProfileController *thingamajig = [[AUserProfileController alloc] initWithNibName:@"AUserProfileController" bundle:nil jsonInformation:[request responseString]];
            [delegate goToThisNewController:thingamajig];
            [thingamajig release];
        }
        @catch (NSException *exception) 
        {
            UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"" message:@"Unable To look at user information" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [aler show];
            [aler release];
        }
        looking_at_profile = 0;
    }
    else
    {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"" message:[request responseString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [aler show];
        [aler release];
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    item_holder.center = CGPointMake(item_holder.center.x, item_holder.center.y - 150);
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [message_txt resignFirstResponder];
        item_holder.center = CGPointMake(item_holder.center.x, item_holder.center.y + 150);
    }
    return YES;
}
-(id)initWithPositionInSentBoxArray:(int)the_position
{
    if ((self = [super init]))
    {
        current_position = the_position;
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        
        item_holder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320 , 480)];
        //Create Header With Subject
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        subject_header = [[UIImageView alloc] initWithImage:header_image];
        subject_header.frame = CGRectMake(5, 5, 310, 33);
        [item_holder addSubview:subject_header];
        //[header_image release];
        subject_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 22)];
        subject_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        subject_label.backgroundColor = [UIColor clearColor];
        [subject_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:11]];
        subject_label.text = [[app_delegate.user_state_information.my_sent_messages objectAtIndex:the_position] my_subject];
        [item_holder addSubview:subject_label];
        
        //Create Middle Message Body Part
        UIImageView *body_background = [[UIImageView alloc] initWithFrame:CGRectMake(subject_header.frame.origin.x, subject_header.frame.origin.y + subject_header.frame.size.height, 310, 150)];
        body_background.image = [UIImage imageNamed:@"module_row"];
        [item_holder addSubview:body_background];
        
        UITextView *body_text = [[UITextView alloc] initWithFrame:CGRectMake(15, body_background.frame.origin.y + 5, body_background.frame.size.width - 10, body_background.frame.size.height - 10)];
        body_text.text = [[app_delegate.user_state_information.my_sent_messages objectAtIndex:the_position] my_body];
        body_text.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        body_text.backgroundColor = [UIColor clearColor];
        [body_text setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        [item_holder addSubview:body_text];
        body_text.userInteractionEnabled = NO;
        
        
        [self.view addSubview:item_holder];
        
    }
    return self;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

@end
