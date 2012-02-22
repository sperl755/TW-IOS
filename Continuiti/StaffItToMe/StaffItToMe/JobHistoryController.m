//
//  JobHistoryController.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobHistoryController.h"
#import "StaffItToMeAppDelegate.h"


@implementation JobHistoryController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPos:(int)the_pos
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        job_position = the_pos;
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        UITextView *information = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
        NSMutableString *description = [[NSMutableString alloc] init];
        for (int i = 0; i < [[[app_delegate.user_state_information.my_jobs objectAtIndex:job_position] job_history] count]; i++)
        {
            [description appendString:[[[[app_delegate.user_state_information.my_jobs objectAtIndex:job_position] job_history] objectAtIndex:i] job_date]];
            [description appendString:@"\nTotal time: "];
            [description appendString:[[[[app_delegate.user_state_information.my_jobs objectAtIndex:job_position] job_history] objectAtIndex:i] total_time]];
            [description appendString:@"\nJob_Time: "];
            [description appendString:[[[[app_delegate.user_state_information.my_jobs objectAtIndex:job_position] job_history] objectAtIndex:i] job_time]];
            [description appendString:@"\n"];
        }
        information.text = description;
        information.userInteractionEnabled = NO;
        [self.view addSubview:information];
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
-(void)doneDisplaying
{
    [delegate removeJobHistoryDetail];
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
