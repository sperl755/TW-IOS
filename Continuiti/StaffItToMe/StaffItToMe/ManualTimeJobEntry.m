//
//  ManualTimeJobEntry.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ManualTimeJobEntry.h"
#import "StaffItToMeAppDelegate.h"


@implementation ManualTimeJobEntry
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPos:(int)the_pos
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        job_pos = the_pos;
    }
    return self;
}


-(IBAction)getPicture
{
    image_picker = [[UIImagePickerController alloc] init];
    image_picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        image_picker.sourceType = UIImagePickerControllerSourceTypeCamera;  
    }
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        image_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    video_or_picture = 1;
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.tab_bar_controller presentModalViewController:image_picker animated:YES];
}
-(IBAction)getVideo
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    UIImagePickerController *video_shooter = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        video_shooter.sourceType = UIImagePickerControllerSourceTypeCamera;
        video_shooter.delegate = self;
        //video_shooter.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        video_shooter.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeMovie, nil];
        video_or_picture = 2;
        [app_delegate.tab_bar_controller presentModalViewController:video_shooter animated:YES];
    }  
}
-(IBAction)getAudio
{
    AudioRecordingScreen *audio_screen = [[AudioRecordingScreen alloc] initWithNibName:@"AudioRecordingScreen" bundle:nil];
    audio_screen.delegate = self;
    [self presentModalViewController:audio_screen animated:YES];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (video_or_picture == 1)
    {
        photo_data = [[NSData alloc] initWithContentsOfURL:[info objectForKey:UIImagePickerControllerMediaURL]];
    }
    else if (video_or_picture == 2)
    {
        video_data = [[NSData alloc] initWithContentsOfURL:[info objectForKey:UIImagePickerControllerMediaURL]];   
    }
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.tab_bar_controller dismissModalViewControllerAnimated:YES];
    
}  
-(void)leaveScreenWithData:(NSData *)the_audio
{
    audio_data = [the_audio retain];
    [self dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    photo_data = UIImagePNGRepresentation(image);  
    [self dismissModalViewControllerAnimated:YES];
}


-(void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIDatePicker *picker = (UIDatePicker*)[actionSheet viewWithTag:131];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"MM/dd/YY";
	NSString *suggested_date = [formatter stringFromDate:picker.date];
    if (start_or_end == 1)
    {
        start_date_txt.text = suggested_date;
    }
    else if (start_or_end == 2)
    {
        end_date_txt.text = suggested_date;
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

-(IBAction)cancelSubmittalForm
{
    [delegate removeManualTimeJobEntryDetail];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    status_note.delegate = self;
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    NSMutableString *job_description = [[NSMutableString alloc] initWithString:[[app_delegate.user_state_information.my_jobs objectAtIndex:job_pos] title]];
    [job_description appendString:@", "];
    [job_description appendString:[[app_delegate.user_state_information.my_jobs objectAtIndex:job_pos] company]];
    
    information.text = job_description;
    
    start_date_txt.delegate = self;
    start_date_txt.placeholder = @"Start Date";
    end_date_txt.delegate = self;
    end_date_txt.placeholder = @"End Date";
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == start_date_txt)
    {
        start_or_end = 1;
        [start_date_txt resignFirstResponder];
        [self displayDatePicker];
    }
    else if (textField == end_date_txt)
    {
        start_or_end = 2;
        [end_date_txt resignFirstResponder];
        [self displayDatePicker];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == status_note && [text isEqualToString:@"\n"])
    {
        [status_note resignFirstResponder];
    }
    return YES;
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
