//
//  JobSuggestionsModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
@protocol JobSuggestionProtocol <NSObject>
-(void)respondToSuggestionSelection;
@end

@interface JobSuggestionsModule : UIView 
{
    UIImageView *module_header_background;
    UIButton *shuffle_button;
    UIImageView *module_row_one_background;
    UIImageView *arrow_one;
    UIImageView *module_row_two_background;
    UIImageView *arrow_two;
    UILabel *job_suggestion_label;
    
    //Rows Items
    int current_suggested_job_position;
    UIImageView *job_one_picture;
    UIImageView *job_one_overlay;
    UILabel *job_one_name;
    UILabel *job_one_description;
    
    UIImageView *job_two_picture;
    UIImageView *job_two_overlay;
    UILabel *job_two_name;
    UILabel *job_two_description;
    
    BOOL information_loaded;
}
-(void)scrollThroughJobs;
@property (nonatomic, retain) id <JobSuggestionProtocol> delegate;
@end
