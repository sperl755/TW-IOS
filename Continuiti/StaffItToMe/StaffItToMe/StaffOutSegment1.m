//
//  StaffOutSegment1.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StaffOutSegment1.h"


@implementation StaffOutSegment1
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
-(IBAction)goToNext
{
    if ([proposal_title.text isEqualToString:@""] || [customer_name.text isEqualToString:@""] || [customer_company.text isEqualToString:@""] || [customer_email.text isEqualToString:@""] || [capabilities.text isEqualToString:@""])
    {
        UIAlertView *invalid_input = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"Please fill in all fields in order to staff out" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [invalid_input show];
        [invalid_input release];
        return;
    }
    delegate.proposal_title = proposal_title.text;
    delegate.customer_name = customer_name.text;
    delegate.customer_company = customer_company.text;
    delegate.customer_email = customer_email.text;
    delegate.capabilities = capabilities.text;
    [delegate goToSegment2];
}
#pragma mark - View lifecycle
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == capabilities && [text isEqualToString:@"\n"])
    {
        [capabilities resignFirstResponder];
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    int movement = 60;
    proposal_title.frame = CGRectMake(proposal_title.frame.origin.x, proposal_title.frame.origin.y - movement, proposal_title.frame.size.width, proposal_title.frame.size.height);
    customer_name.frame = CGRectMake(customer_name.frame.origin.x, customer_name.frame.origin.y - movement, customer_name.frame.size.width, customer_name.frame.size.height);
    customer_company.frame = CGRectMake(customer_company.frame.origin.x, customer_company.frame.origin.y - movement, customer_company.frame.size.width, customer_company.frame.size.height);
    customer_email.frame = CGRectMake(customer_email.frame.origin.x, customer_email.frame.origin.y - movement, customer_email.frame.size.width, customer_email.frame.size.height);
    capabilities.frame = CGRectMake(capabilities.frame.origin.x, capabilities.frame.origin.y - movement, capabilities.frame.size.width, capabilities.frame.size.height);
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    int movement = -60;
    proposal_title.frame = CGRectMake(proposal_title.frame.origin.x, proposal_title.frame.origin.y - movement, proposal_title.frame.size.width, proposal_title.frame.size.height);
    customer_name.frame = CGRectMake(customer_name.frame.origin.x, customer_name.frame.origin.y - movement, customer_name.frame.size.width, customer_name.frame.size.height);
    customer_company.frame = CGRectMake(customer_company.frame.origin.x, customer_company.frame.origin.y - movement, customer_company.frame.size.width, customer_company.frame.size.height);
    customer_email.frame = CGRectMake(customer_email.frame.origin.x, customer_email.frame.origin.y - movement, customer_email.frame.size.width, customer_email.frame.size.height);
    capabilities.frame = CGRectMake(capabilities.frame.origin.x, capabilities.frame.origin.y - movement, capabilities.frame.size.width, capabilities.frame.size.height);
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == proposal_title && [string isEqualToString:@"\n"])
    {
        [proposal_title resignFirstResponder];
        [customer_name becomeFirstResponder];
    }
    else if (textField == customer_name && [string isEqualToString:@"\n"])
    {
        [customer_name resignFirstResponder];
        [customer_company becomeFirstResponder];
    }
    else if (textField == customer_company && [string isEqualToString:@"\n"])
    {
        [customer_company resignFirstResponder];
        [customer_email becomeFirstResponder];
    }
    else if (textField == customer_email && [string isEqualToString:@"\n"])
    {
        [customer_email resignFirstResponder];
        [capabilities becomeFirstResponder];
    }
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    proposal_title.placeholder = @"Proposal Title";
    proposal_title.delegate = self;
    customer_name.placeholder = @"Customer Name";
    customer_name.delegate = self;
    customer_company.placeholder = @"Customer Company";
    customer_company.delegate = self;
    customer_email.placeholder = @"Customer Email";
    customer_email.delegate = self;
    capabilities.delegate = self;
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
