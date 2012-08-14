//
//  SharePostViewController.m
//  TalentWire
//
//  Created by Anthony Sierra on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SharePostViewController.h"
#import "StaffItToMeAppDelegate.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#define MAX_CHARACTERS 200
@implementation SharePostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        sub_name_array = [[NSMutableArray alloc] initWithCapacity:11];
        sub_subscription_id = [[NSMutableArray alloc] initWithCapacity:11];
        sub_topic_id = [[NSMutableArray alloc] initWithCapacity:11];
       // [my_camera_button setImage:[UIImage imageNamed:@"CameraButton"] forState:UIControlStateNormal];
    }
    return self;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    my_characters_left.text = [NSString stringWithFormat:@"%d", MAX_CHARACTERS - my_message_text.text.length];
    if ([text isEqualToString:@"\n"])
    {
        [my_message_text resignFirstResponder];
    }
    return YES;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selected_feed = [sub_name_array objectAtIndex:row];
    my_selected_list_category.text = selected_feed;
}
-(IBAction)selectTopic:(id)sender
{
    if (sub_name_array.count >= 1)
    {
        my_action_sheet = [[UIActionSheet alloc] initWithTitle:@"Pick a feed to post to.\n\n\n\n\n\n\n\n\n\n\n" 
                                                      delegate:self
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"Select", @"Cancel", nil];
        topic_picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        topic_picker.showsSelectionIndicator = YES;
        [my_action_sheet addSubview:topic_picker];
        [my_action_sheet showInView:self.view.superview];
    }
}
-(void)populateWithString:(NSString *)the_info
{
    NSArray *data_array = [the_info JSONValue];
    for (int i = 0; i < data_array.count; i++)
    {
        if ([[[[data_array objectAtIndex:i] objectForKey:@"subscription"] objectForKey:@"topic"] isEqualToString:@"Do"] || 
            [[[[data_array objectAtIndex:i] objectForKey:@"subscription"] objectForKey:@"topic"] isEqualToString:@"Trend"] || 
            [[[[data_array objectAtIndex:i] objectForKey:@"subscription"] objectForKey:@"topic"] isEqualToString:@"Mentor"])
        {
            [sub_name_array addObject:[[[data_array objectAtIndex:i] objectForKey:@"subscription"] objectForKey:@"topic"]];
            [sub_subscription_id addObject:[[[data_array objectAtIndex:i] objectForKey:@"subscription"] objectForKey:@"subscription_id"]];
            [sub_topic_id addObject:[[[data_array objectAtIndex:i] objectForKey:@"subscription"] objectForKey:@"topic_id"]];
        }
    }
    if (sub_name_array.count >= 1)
    {
        selected_feed = [[NSString alloc] initWithString:[sub_name_array objectAtIndex:0]]; 
    }
    else
    {
        selected_feed = @"";
    }
    my_selected_list_category.text = selected_feed;
    my_message_text.delegate = self;
    topic_picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 35, 320, 200)];
    topic_picker.delegate = self;
    topic_picker.dataSource = self;
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [sub_name_array objectAtIndex:row];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return sub_name_array.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(void)choosePicture:(id)sender
{
    camera_picker = [[UIActionSheet alloc] initWithTitle:@"Attach picture from where?" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Library", @"Camera", @"Cancel", nil];
    [camera_picker showInView:self.view.superview];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet == camera_picker)
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        @try {
            if (buttonIndex == 0)
            {
                imagePicker.sourceType = 
                UIImagePickerControllerSourceTypePhotoLibrary;
            }
            else if (buttonIndex == 1)
            {
                imagePicker.sourceType = 
                UIImagePickerControllerSourceTypeCamera;
            }
            else 
            {
                return;
            }
        }
        @catch (NSException *exception) {
            return;
        }
        
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage, nil];
        
        imagePicker.allowsEditing = YES;
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        [app_delegate.window.rootViewController presentModalViewController:imagePicker 
                                animated:YES];
        [imagePicker release]; 
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.window.rootViewController dismissModalViewControllerAnimated:YES];
    [self.view setFrame:CGRectMake(34365324, 0, 320, 480)];
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //obtaining saving path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
    
    NSData *webData = [NSData dataWithData:UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], .9)];
    if (webData != nil)
    {
        [webData writeToFile:imagePath atomically:YES];   
    }
    
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate.window.rootViewController dismissModalViewControllerAnimated:YES];
    [self.view setFrame:CGRectMake(34365324, 0, 320, 480)];
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    
    [my_camera_button setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
    [my_camera_button removeTarget:self action:@selector(choosePicture:) forControlEvents:UIControlEventTouchUpInside];
    [my_camera_button addTarget:self action:@selector(removeImage) forControlEvents:UIControlEventTouchUpInside];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

}
-(void)removeImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imagePath error:NULL];
    
    [my_camera_button setImage:[UIImage imageNamed:@"CameraButton"] forState:UIControlStateNormal];
    [my_camera_button removeTarget:self action:@selector(removeImage) forControlEvents:UIControlEventTouchUpInside];
    [my_camera_button addTarget:self action:@selector(choosePicture:) forControlEvents:UIControlEventTouchUpInside];   
}
-(IBAction)makePost:(id)sender
{
    @try {
        [self ghettoURLConnect];
       /* StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
        
        
        NSURL *url = [[NSURL alloc] initWithString:[[URLLibrary sharedInstance] getCreateFeedURL]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request setValidatesSecureCertificate:NO];
        [request setTimeOutSeconds:30];
        [request setDelegate:self];
        [request setDidFailSelector:@selector(didFail:)];
        [request setDidFinishSelector:@selector(didFinish:)];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath])
        {
            [request setPostFormat:ASIMultipartFormDataPostFormat];
            //[request setPostValue:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
            
            CGFloat compression = 0.9f;
            CGFloat maxCompression = 0.1f;
            int maxFileSize = 250*1024;

            NSData *imageData = [[NSData alloc] initWithContentsOfFile:imagePath];
            
            while ([imageData length] > maxFileSize && compression > maxCompression)
            {
                compression -= 0.1;
                imageData = UIImageJPEGRepresentation([UIImage imageNamed:imagePath], compression);
            }
            
            //[request setPostValue:imageData forKey:@"upload_file"];
            
            //[request addData:imageData withFileName:@"temp.png" andContentType:@"image/jpeg" forKey:@"upload_file"];
            //[request setPostValue:imageData  forKey:@"upload_file"];

            //[request setData:imageData withFileName:@"temp.jpg" andContentType:@"image/jpeg" forKey:@"upload_file"];   
            [request setFile:imagePath forKey:@"upload_file"];
            [request setPostValue:@"1"  forKey:@"richmedia_type"];
        }
        else
        {
            [request setPostValue:@"0"                                           forKey:@"richmedia_type"];   
        }
        
        
        [request setPostValue:app_delegate.user_state_information.sessionKey    forKey:@"session_key"];
        [request setPostValue:my_message_text.text                              forKey:@"feed"];
        [request setPostValue:@"0"                                              forKey:@"share_to_career_team"];
        [request setPostValue:@"0"                                              forKey:@"share_to_friend"];
        [request setPostValue:@""                                               forKey:@"url_title"];
        [request setPostValue:@""                                               forKey:@"url_address"];
        [request setPostValue:@""                                               forKey:@"url_description"];
        
        int id_position;
        for (int i = 0; i < sub_name_array.count; i++)
        {
            if ([[sub_name_array objectAtIndex:i] isEqualToString:selected_feed])
            {
                id_position = i;
            }
        }
        [request setPostValue:[sub_topic_id objectAtIndex:id_position] forKey:@"post_to"];
        
        [request startAsynchronous];
        [app_delegate displayLoadingView];*/
    }
    @catch (NSException *exception) {
        
    }
}
-(void)ghettoURLConnect
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"temp.jpg"];
    
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];                                    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"------WebKitFormBoundary4QuqLuM1cE5lMwCy";
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:11];
    [parameters setValue:app_delegate.user_state_information.sessionKey forKey:@"session_key"];
    [parameters setValue:my_message_text.text forKey:@"feed"];
    [parameters setValue:@"0" forKey:@"share_to_career_team"];
    [parameters setValue:@"0" forKey:@"share_to_friend"];
    [parameters setValue:@"" forKey:@"url_title"];
    [parameters setValue:@"" forKey:@"url_description"];
    [parameters setValue:@"" forKey:@"url_address"];
    [parameters setValue:@"1" forKey:@"richmedia_type"];
    int id_position;
    for (int i = 0; i < sub_name_array.count; i++)
    {
        if ([[sub_name_array objectAtIndex:i] isEqualToString:selected_feed])
        {
            id_position = i;
        }
    }
    [parameters setValue:[sub_topic_id objectAtIndex:id_position] forKey:@"post_to"];
    
    // add params (all params are strings)
    for (NSString *param in parameters) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [parameters objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *FileParamConstant = @"image";
    // add image data
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 250*1024;
    
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:imagePath];
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation([UIImage imageNamed:imagePath], compression);
    }
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set URL
    [request setURL:[NSURL URLWithString:[[URLLibrary sharedInstance] getCreateFeedURL]]];
    NSURLResponse* response;
    NSError* error;
    [app_delegate displayLoadingView];
    
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               [app_delegate removeLoadingViewFromWindow];
                               [self removeImage];
                               my_characters_left.text = @"200";
                               my_message_text.text = @"";
                           }];

    [my_message_text resignFirstResponder];
   // NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //NSLog(@"%@", [[[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding] autorelease]);

}
-(void)didFinish:(ASIHTTPRequest*)request
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate removeLoadingViewFromWindow];
    
}
-(void)didFail:(ASIHTTPRequest*)request
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    [app_delegate removeLoadingViewFromWindow];
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
    my_selected_list_category.text = selected_feed;
    [my_camera_button addTarget:self action:@selector(choosePicture:) forControlEvents:UIControlEventTouchUpInside];
    [my_camera_button setBackgroundImage:[UIImage imageNamed:@"CameraButton.png"] forState:UIControlStateNormal];
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
