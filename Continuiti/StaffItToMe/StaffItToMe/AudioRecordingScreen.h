//
//  AudioRecordingScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol AudioRecordingScreenProtocol <NSObject>
-(void)leaveScreenWithData:(NSData*)the_audio;
@end


@interface AudioRecordingScreen : UIViewController <AVAudioRecorderDelegate>
{
    IBOutlet UIButton *record_button;
    AVAudioRecorder *the_recorder;
    NSMutableDictionary *recordSetting;
    NSString *recorderFilePath;
}
@property (nonatomic, retain) id <AudioRecordingScreenProtocol> delegate;
@end
