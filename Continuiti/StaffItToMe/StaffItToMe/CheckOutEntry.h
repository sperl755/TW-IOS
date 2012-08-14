//
//  CheckOutEntry.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "AudioRecordingScreen.h"
@protocol CheckOutEntryProtocol <NSObject>
-(void)removeCheckOutEntryDetail;
@end


@interface CheckOutEntry : UIViewController <AudioRecordingScreenProtocol>{
    int job_pos;
    IBOutlet UITextView *information;
    IBOutlet UITextView *status_note;
    UIImagePickerController *image_picker;
    IBOutlet UITextField *start_date_txt;
    IBOutlet UITextField *end_date_txt;
    
    //1 = start txt
    //2 = end txt
    int start_or_end;
    
    NSData *audio_data;
    NSData *photo_data;
    NSData *video_data;
    //1 means picture
    //2 means video
    int video_or_picture;
    
}
-(IBAction)cancelCheckout;
-(IBAction)getPicture;
-(IBAction)getVideo;
-(IBAction)getAudio;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andPos:(int)the_pos;
@property (retain) id <CheckOutEntryProtocol> delegate;

@end
