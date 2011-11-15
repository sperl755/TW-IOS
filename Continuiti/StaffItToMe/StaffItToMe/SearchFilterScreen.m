//
//  SearchFilterScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchFilterScreen.h"
#import "StaffItToMeAppDelegate.h"
#import "ASIFormDataRequest.h"

#define SPACING 7
@implementation SearchFilterScreen
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, 320, 370)];
        
        search_table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370) style:UITableViewStylePlain];
        search_table.dataSource = self;
        search_table.delegate = self;
        UIImageView *table_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
        table_background.frame = CGRectMake(0, 0, 320, 370);
        search_table.separatorColor = [UIColor clearColor];
        search_table.backgroundColor = [UIColor clearColor];
        search_table.backgroundView = table_background;
        [self addSubview:search_table];
        header_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self addSubview:header_shadow];
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToIndustrySearch" object:nil];
            break;
        /*case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToSalarySearch" object:nil];
            break;*/
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToDistanceSearch" object:nil];
            break;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    //create cell
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CustomCategoryCell *my_category;
    switch (indexPath.row) {
        case 1:
            my_category = [[CustomCategoryCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andCategory:@"Industry" andDetail:app_delegate.user_state_information.industry_search_type];
            break;
        /*case 1:
            my_category = [[CustomCategoryCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andCategory:@"Salary" andDetail:app_delegate.user_state_information.salary_search_type];*/
            break;
        case 0:
            my_category = [[CustomCategoryCell alloc] initWithFrame:CGRectMake(0, 0, 0, 0) andCategory:@"Job Type" andDetail:app_delegate.user_state_information.distance_search_type];
            break;
    }
    [cell.contentView addSubview:my_category];
    return cell;
}
-(void)updateCriteria
{
    NSMutableString *job_list_address = [NSMutableString stringWithString:@"http://helium.staffittome.com/apis/search/"];
    if (search_by_txt.text != nil)
    {
        [job_list_address appendString:search_by_txt.text];
    }
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
	//Acesss the server with solr parameters
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_list_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
}
-(void)listFunction
{
    NSMutableString *job_list_address = [NSMutableString stringWithString:@"http://helium.staffittome.com/apis/search/"];
    if (search_by_txt.text != nil)
    {
        [job_list_address appendString:search_by_txt.text];
    }
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
	//Acesss the server with solr parameters
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_list_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
	//make list activated
	list_or_map = 1;
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
}

-(void)mapFunction
{
    NSMutableString *job_list_address = [NSMutableString stringWithString:@"http://helium.staffittome.com/apis/search/"];
    if (search_by_txt.text != nil)
    {
        [job_list_address appendString:search_by_txt.text];
    }
	StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
	//Acesss the server with solr parameters
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_list_address];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [request setTimeOutSeconds:30];
    [request setDelegate:self];
    [request startAsynchronous];
	//make map activated
	list_or_map = 2;
    //show a alertview that we are accessing the credentials and talking to the server.
    load_message = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [load_message show];
    UIActivityIndicatorView *active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    active.center = CGPointMake(load_message.bounds.size.width / 2, load_message.bounds.size.height - 40);
    [active startAnimating];
    [load_message addSubview:active];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
	[load_message dismissWithClickedButtonIndex:0 animated:YES];
    if ([[request responseString] length] < 5)
    {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"No Jobs Found" message:@"No jobs could be found with what you were looking for. Maybe change your search criteria?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [aler show];
        [aler release];
        return;
    }
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.user_state_information populateJobArrayWithJSONString:[request responseString]];
    
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"Updated!" message:@"You have succesfully updated your search criteria!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [aler show];
    [aler release];
    /*
	if (list_or_map == 1)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
		[UIView setAnimationRepeatCount:0];
		[self setFrame:CGRectMake(0, -(self.frame.size.height) + 20, self.frame.size.width, self.frame.size.height)];
		[UIView commitAnimations];
		displayed = NO;
		StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
		[app_delegate.user_state_information populateJobArrayWithJSONString:[request responseString]]; 
		[delegate setupListView];
	}
	else if (list_or_map == 2)
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:1];
		[UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
		[UIView setAnimationRepeatCount:0];
		[self setFrame:CGRectMake(0, -(self.frame.size.height) + 20, self.frame.size.width, self.frame.size.height)];
		[UIView commitAnimations];
		displayed = NO;
		StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
		[app_delegate.user_state_information populateJobArrayWithJSONString:[request responseString]]; 
		[delegate setupGoogleMap];
	}*/
}
-(void)setRatePerHour
{
    desired_rate.text = [NSString stringWithFormat:@"%d/hr+", (int)rate_slider.value];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (displayed == NO)
    {
        startPoint = [[touches anyObject] locationInView:self];
        /*printf("%f\n%f", startPoint.y, self.frame.origin.y);
        [self setFrame:CGRectMake(0, startPoint.y - ((self.frame.size.height*2) - 18), self.frame.size.width, self.frame.size.height)];*/
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (displayed == NO)
    {
        CGPoint cpoint = [[touches anyObject] locationInView:self];
        if (self.frame.origin.y < 0)
        {
            int DX = startPoint.y - cpoint.y;
            printf("\n%f\n", self.frame.origin.y);
            printf("%f\n", self.frame.size.height);
            printf("%d\n", DX);
            if (self.frame.origin.y + self.frame.size.height - DX < 21)
            {
                return;
            }
            [self setFrame:CGRectMake(0, self.frame.origin.y - DX, self.frame.size.width, self.frame.size.height)];
        }
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint cpoint = [[touches anyObject] locationInView:self];
    if (self.frame.origin.y + self.frame.size.height > 240 && displayed == NO)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
        displayed = YES;
    }
    else if (self.frame.origin.y == 0 && displayed == YES && cpoint.y > self.frame.size.height - 30)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, -(self.frame.size.height) + 40, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
        displayed = NO;
    }
    else if(self.frame.origin.y + self.frame.size.height < 240 && self.frame.origin.y > -370 && displayed == NO)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, -(self.frame.size.height) + 40, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
        displayed = NO;
    }
    else if (self.frame.origin.y< -380 && displayed == NO && cpoint.y > 440)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(removeFromScreen)];
        [UIView setAnimationRepeatCount:0];
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [UIView commitAnimations];
        displayed = YES;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == to_txt)
    {
        [to_txt resignFirstResponder];
        [self displayDatePicker];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"] && textField == search_by_txt) {
        [search_by_txt resignFirstResponder];
    }
    else if([string isEqualToString:@"\n"] && textField == to_txt) {
        [to_txt resignFirstResponder];
    }
    return YES;
}
-(void)updateTableView
{
    [search_table reloadData];
}


-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
}
-(void)displayDatePicker
{
	[actionSheet showInView:self];
    
	/*UIDatePicker *date_picker = [[UIDatePicker alloc] init];
	date_picker.tag = 131;
	date_picker.datePickerMode = UIDatePickerModeDate;*/
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [my_job_types objectAtIndex:row];
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 320;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [my_job_types count];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    to_txt.text = [my_job_types objectAtIndex:row];
}

- (void)dealloc
{
    [background release];
    [search_by_txt release];
    [list_btn release];
    [map_btn release];
    [rate_per_hour_lbl release];
    [rate_slider release];
    [to_txt release];
    [delegate release];
    [super dealloc];
}

@end
