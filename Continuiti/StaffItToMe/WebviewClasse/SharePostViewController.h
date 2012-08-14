//
//  SharePostViewController.h
//  TalentWire
//
//  Created by Anthony Sierra on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "JSON.h"

@interface SharePostViewController : UIViewController  <NSURLConnectionDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate>
{
    IBOutlet UIButton *my_list_select_button;
    IBOutlet UIButton *my_send_button;
    IBOutlet UITextView *my_message_text;
    IBOutlet UILabel *my_selected_list_category;
    IBOutlet UILabel *my_characters_left;
    IBOutlet UIButton *my_camera_button;
    IBOutlet UIButton *image_to_post_button;
    
    NSString *selected_feed;
    NSMutableArray *sub_name_array;
    NSMutableArray *sub_subscription_id;
    NSMutableArray *sub_topic_id;
    UIPickerView *topic_picker;
    UIActionSheet *my_action_sheet;
    UIActionSheet *camera_picker;
    
    
}
-(void)ghettoURLConnect;
-(void)choosePicture:(id)sender;
-(IBAction)selectTopic:(id)sender;
-(IBAction)makePost:(id)sender;
-(void)populateWithString:(NSString*)the_info;
@end
