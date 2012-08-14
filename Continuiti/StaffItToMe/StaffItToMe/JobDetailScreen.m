//
//  JobDetailScreen.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobDetailScreen.h"
#import "StaffItToMeAppDelegate.h"
#import "JSON.h"

@implementation JobDetailScreen
@synthesize delegate;
@synthesize array_position;
-(id)init
{
    if ((self = [super init]))
    {
        StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        array_position                          = app_delegate.user_state_information.current_job_in_array;
        background                              = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
        background.frame                        = CGRectMake(0, 0, 320, 480);
        [self.view insertSubview:background atIndex:0];
        
        job_info_header = [[JobInformationHeader alloc] initWithPos:array_position];
        [self.view addSubview:job_info_header];
        
        
        search_table                    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
        search_table.delegate           = self;
        search_table.dataSource         = self;
        search_table.allowsSelection    = NO;
        search_table.separatorColor     = [UIColor clearColor];
        search_table.backgroundColor    = [UIColor clearColor];
        [self.view addSubview:search_table];
        
        job_summary         = [[JobSummaryModule alloc] initWithSummary:[[app_delegate.user_state_information.job_array objectAtIndex:app_delegate.user_state_information.current_job_in_array] job_description]];
        basic_info          = [[BasicInfoModule alloc] initWithPos:app_delegate.user_state_information.current_job_in_array];
        job_skills_module   = [[JobSkillsModule alloc] initWithPos:app_delegate.user_state_information.current_job_in_array];
        
        module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:job_summary, basic_info, job_skills_module, nil]];
        
    }
    return self;
}

-(id)initWithJSONString:(NSString*)json_info
{
    if ((self = [super init]))
    {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        array_position = app_delegate.user_state_information.current_job_in_array;
        background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
        background.frame = CGRectMake(0, 0, 320, 480);
        [self.view insertSubview:background atIndex:0];
        
        job_info_header             = [[JobInformationHeader alloc] initWithPos:array_position];
        job_info_header.delegate    = self;
        //[self.view addSubview:job_info_header];
        
        
        
        NSDictionary *json_job_info = [json_info JSONValue];
        NSMutableDictionary *json_job_info_mutable = [NSMutableDictionary dictionaryWithDictionary:json_job_info];
        
        job_summary         = [[JobSummaryModule alloc] initWithSummary:[json_job_info_mutable objectForKey:@"description"]];
        basic_info          = [[BasicInfoModule alloc] initWithMutableDictionary:json_job_info_mutable];
        job_skills_module   = [[JobSkillsModule alloc] initWithArray:[json_job_info objectForKey:@"skills"]];
        
        module_array                    = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:job_info_header, job_summary, basic_info, job_skills_module, nil]];
        search_table                    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370)];
        search_table.delegate           = self;
        search_table.dataSource         = self;
        search_table.allowsSelection    = NO;
        search_table.separatorColor     = [UIColor clearColor];
        search_table.backgroundColor    = [UIColor clearColor];
        [self.view addSubview:search_table];
    }
    return self;
}
-(void)respondToCompanyTouch:(NSString *)the_information
{
    [delegate respondToCompanyInformationRequest:the_information];
}
-(id)initWithSuggestedJobsArrayWithJSONString:(NSString *)json_info 
{
    if ((self = [super init]))
    {
        NSDictionary *json_job_info = [json_info JSONValue];
        NSMutableDictionary *json_job_info_mutable = [NSMutableDictionary dictionaryWithDictionary:json_job_info];
        
        StaffItToMeAppDelegate *app_delegate    = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
        array_position                          = app_delegate.user_state_information.current_suggested_job_in_array;
        background                              = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background.png"]];
        background.frame                        = CGRectMake(0, 0, 320, 480);
        [self.view insertSubview:background atIndex:0];
        
        suggested_job_info_header = [[SuggestedJobsInformationHeader alloc] initWithPos:array_position];
        [self.view addSubview:suggested_job_info_header];
        
        
        job_summary         = [[JobSummaryModule alloc] initWithSummary:[json_job_info objectForKey:@"description"]];
        basic_info          = [[BasicInfoModule alloc] initWithMutableDictionary:json_job_info_mutable];
        job_skills_module   = [[JobSkillsModule alloc] initWithArray:[json_job_info objectForKey:@"skills"]];
        
        module_array = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:suggested_job_info_header, job_summary, basic_info, job_skills_module, nil]];
        
        search_table                    = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 370)];
        search_table.delegate           = self;
        search_table.dataSource         = self;
        search_table.allowsSelection    = NO;
        search_table.separatorColor     = [UIColor clearColor];
        search_table.backgroundColor    = [UIColor clearColor];
        [self.view addSubview:search_table];
    }
    return self;
    
}
//--------------TABLE VIEW METHOD TABLE VIEW METHODS TABLE VIEW METHODS-----------
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return module_array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  [[module_array objectAtIndex:indexPath.row] frame].size.height + 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    [cell.contentView addSubview:[module_array objectAtIndex:indexPath.row]];
    return cell;
}
//--------------End TABLE VIEW METHOD END TABLE VIEW METHODS END TABLE VIEW METHODS-----------
-(void)applyScreen
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToJobApply" object:nil];
}
-(void)discussScreen
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToJobDiscussion" object:nil];
}

@end
