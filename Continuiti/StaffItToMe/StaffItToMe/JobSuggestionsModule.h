//
//  JobSuggestionsModule.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "SuggestionModuleCell.h"
@protocol JobSuggestionProtocol <NSObject>
-(void)respondToSuggestionSelection;
-(void)finishedLoadingSuggestedJob;
@end

@interface JobSuggestionsModule : UIView <SuggestionModuleCellProtocol>
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
    int index_beginning;
    int index_end;
    int array_size;
    
    NSMutableArray *cell_array;
    
    BOOL information_loaded;
}
-(void)scrollThroughJobs;
@property (nonatomic, retain) id <JobSuggestionProtocol> delegate;
@end
