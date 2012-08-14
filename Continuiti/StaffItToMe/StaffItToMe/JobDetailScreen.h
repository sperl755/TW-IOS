//
//  JobDetailScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobInformationHeader.h"
#import "SuggestedJobsInformationHeader.h"
#import "JobSummaryModule.h"
#import "BasicInfoModule.h"
#import "JobSkillsModule.h"
@protocol JobDetailScreenProtocol <NSObject>
-(void)respondToCompanyInformationRequest:(NSString*)information;
@end

@interface JobDetailScreen : UIViewController <UITableViewDelegate, UITableViewDataSource, JobInformationHeaderProtocol>
{
    UITextView *description_txt;
    UIButton *apply_btn;
    UIButton *discuss_btn;
    
    UIImageView *background;
    UITableView *search_table;
    
    JobInformationHeader *job_info_header;
    SuggestedJobsInformationHeader *suggested_job_info_header;
    NSArray *module_array;
    JobSummaryModule *job_summary;
    BasicInfoModule *basic_info;
    JobSkillsModule *job_skills_module;
}

-(id)initWithJSONString:(NSString*)json_info;
-(id)initWithSuggestedJobsArrayWithJSONString:(NSString *)json_info ;
@property (nonatomic, retain) id <JobDetailScreenProtocol> delegate;
@property NSUInteger array_position;
@end
