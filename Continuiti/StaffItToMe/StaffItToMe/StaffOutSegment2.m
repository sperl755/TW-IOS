//
//  StaffOutSegment2.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffOutSegment2.h"


@implementation StaffOutSegment2
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
-(IBAction)submitProposal
{
    for (int i = 0; i < rate.text.length; i++)
    {
        if ([rate.text characterAtIndex:i] <48 || [rate.text characterAtIndex:i] > 57)
        {
            UIAlertView *invalid_input = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please make sure that the rate field contains only numbers." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [invalid_input show];
            [invalid_input release];
            return;
        }
    }
    if ([service_description.text isEqualToString:@""] || [rate.text isEqualToString:@""] || [items_included.text isEqualToString:@""] || [items_not_included.text isEqualToString:@""] || [start_date.text isEqualToString:@""] || [end_date.text isEqualToString:@""])
    {
        UIAlertView *invalid_input = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please fill in all fields in order to staff out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalid_input show];
        [invalid_input release];
        return;
    }
    delegate.service_description = service_description.text;
    delegate.rate = rate.text;
    delegate.items_included = items_included.text;
    delegate.items_not_included = items_not_included.text;
    delegate.start_date = start_date.text;
    delegate.end_date = end_date.text;
    [delegate didSubmitProposal];
}
#pragma mark - View lifecycle
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == service_description && [text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        [rate becomeFirstResponder];
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == rate_type && [string isEqualToString:@"\n"])
    {
        [rate_type resignFirstResponder];
        [rate becomeFirstResponder];
    }
    else if (textField == rate)
    {  if ([string isEqualToString:@"\n"])
        {
            [rate resignFirstResponder];
            [items_included becomeFirstResponder];
        }
    }
    else if (textField == items_included && [string isEqualToString:@"\n"])
    {
        [items_included resignFirstResponder];
        [items_not_included becomeFirstResponder];
    }
    else if (textField == items_not_included && [string isEqualToString:@"\n"])
    {
        [items_not_included resignFirstResponder];
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == start_date)
    {
        [start_date resignFirstResponder];
        start_or_end = 1;
        [self displayDatePicker];
    }
    else if (textField == end_date)
    {
        [end_date resignFirstResponder];
        start_or_end = 2;
        [self displayDatePicker];
    }
}
-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIDatePicker *picker = (UIDatePicker*)[actionSheet viewWithTag:131];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"MM/dd/YY";
	NSString *suggested_date = [formatter stringFromDate:picker.date];
    if (start_or_end == 1)
    {
        start_date.text = suggested_date;
    }
    else if (start_or_end == 2)
    {
        end_date.text = suggested_date;
    }
	[formatter release];
	[picker release];
	[actionSheet release];
}
-(void)displayDatePicker
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\nSuggest a date" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Set", nil];
	[actionSheet showInView:self.view];
	
	UIDatePicker *date_picker = [[UIDatePicker alloc] init];
	date_picker.tag = 131;
	date_picker.datePickerMode = UIDatePickerModeDate;
	[actionSheet addSubview:date_picker];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    service_description.delegate = self;
    rate_type.placeholder = @"Rate Type";
    rate_type.delegate = self;
    rate.placeholder = @"Rate Numbers only please";
    rate.delegate = self;
    items_included.placeholder = @"Items Included";
    items_included.delegate = self;
    items_not_included.placeholder = @"Items Not Included";
    items_not_included.delegate = self;
    start_date.placeholder = @"Start Date";
    start_date.delegate = self;
    end_date.placeholder = @"End Date";
    end_date.delegate = self;
    [rate_type_switch setOn:YES];
    [rate_type_switch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [rate_type_label setText:@"Hourly"];
}
-(void)switchValueChanged:(id)sender
{
    UISwitch *the_switch = (UISwitch*)sender;
    if (the_switch == rate_type_switch)
    {
        if ([rate_type_switch isOn] == YES)
        {
            [rate_type_label setText:@"Hourly"];
            delegate.rate_type = @"1";
        }
        else if ([rate_type_switch isOn] == NO)
        {
            [rate_type_label setText:@"Fixed Price"];
            delegate.rate_type = @"2";
        }
    }
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
