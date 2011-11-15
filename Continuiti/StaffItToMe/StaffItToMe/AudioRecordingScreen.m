//
//  AudioRecordingScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AudioRecordingScreen.h"


@implementation AudioRecordingScreen
@synthesize delegate;
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
-(void)viewDidAppear:(BOOL)animated
{
    if (![[AVAudioSession sharedInstance] inputIsAvailable]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Cannot Record!" message:@"This device does not support audio recording." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message show];
        [message release];
        [self audioRecorderDidFinishRecording:nil successfully:NO];
    }   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [record_button addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
}
-(void)startRecording
{
    [record_button removeTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
    [record_button addTarget:self action:@selector(stopRecording) forControlEvents:UIControlEventTouchUpInside];
    [record_button setTitle:@"Stop Recording" forState:UIControlStateNormal];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    [audioSession setActive:YES error:&err];
    err = nil;
    if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey]; 
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
    [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *caldate = [now description];
    recorderFilePath = [[NSString stringWithFormat:@"%@/%@.caf", DOCUMENTS_FOLDER, caldate] retain];
    
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    err = nil;
    the_recorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    //prepare to record
    [the_recorder setDelegate:self];
    [the_recorder prepareToRecord];
    the_recorder.meteringEnabled = YES;
    
    BOOL audioHWAvailable = audioSession.inputIsAvailable;
    if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: @"Audio input hardware not available"
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [cantRecordAlert show];
        [cantRecordAlert release]; 
        return;
    }
    
    // start recording
    [the_recorder record];
}
-(void)stopRecording
{
    [the_recorder stop];
}
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if (recorder != nil)
    {
        [delegate leaveScreenWithData:[[NSData alloc] initWithContentsOfURL:recorder.url]];
    }
    else 
    {
        [delegate leaveScreenWithData:nil];
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
