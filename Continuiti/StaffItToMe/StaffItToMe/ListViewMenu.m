//
//  ListViewMenu.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "StaffItToMeAppDelegate.h"
#import "ListViewMenu.h"


@implementation ListViewMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        table_data = [[NSMutableArray alloc] initWithCapacity:11];
        UIImageView *table_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
        table_background.frame = CGRectMake(0, 0, 320, 370); 
        [self addSubview:table_background];
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        for (int i = 0; i < app_delegate.user_state_information.job_array.count; i++)
        {
        
            SmallJobs *small_jobs = [[SmallJobs alloc] init];
            
            small_jobs.title = [[app_delegate.user_state_information.job_array objectAtIndex:i] title];
            small_jobs.skills = [[app_delegate.user_state_information.job_array objectAtIndex:i] skills];
            small_jobs.job_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_id];
            small_jobs.job_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_description];
            small_jobs.user_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] user_id];
            small_jobs.created_at = [[app_delegate.user_state_information.job_array objectAtIndex:i] created_at];
            small_jobs.job_city = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_city];
            small_jobs.job_state = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_state];
            small_jobs.job_duration = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_duration];
            small_jobs.hours_per_week = [[app_delegate.user_state_information.job_array objectAtIndex:i] hours_per_week];
            small_jobs.task_start_date = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_date];
            small_jobs.task_start_time = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_time];
            small_jobs.company = [[app_delegate.user_state_information.job_array objectAtIndex:i] company];
            small_jobs.company_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] company_description];
            small_jobs.compensation = [[app_delegate.user_state_information.job_array objectAtIndex:i] compensation];
            small_jobs.latitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] latitude];
            small_jobs.longitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] longitude];
                
            [table_data addObject:small_jobs];
            [small_jobs release];
        }
        
        table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, 290) style:UITableViewStylePlain];
        table_view.dataSource = self;
        [table_view setDelegate:self];
        table_view.separatorColor = [UIColor clearColor];
        table_view.backgroundColor = [UIColor clearColor];
        [self addSubview:table_background];
        [self addSubview:table_view];
        
        search_bar_background = [[UIImageView alloc] initWithFrame:CGRectMake(1, 292, 318, 43)];
        search_bar_background.image = [UIImage imageNamed:@"search_box"];
        [self addSubview:search_bar_background];
        
        search_bar_text = [[UITextView alloc] initWithFrame:CGRectMake(search_bar_background.frame.origin.x, search_bar_background.frame.origin.y + 13, search_bar_background.frame.size.width - 30, search_bar_background.frame.size.height + 5)];
        search_bar_text.delegate = self;
        search_bar_text.backgroundColor = [UIColor clearColor];
        [self addSubview:search_bar_text];
        
        header_shadow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 10)];
        header_shadow.image = [UIImage imageNamed:@"header_shadow"];
        [self addSubview:header_shadow];
    }
    return self;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    search_bar_text.center = CGPointMake(search_bar_text.center.x, search_bar_text.center.y - 150);
    search_bar_background.center = CGPointMake(search_bar_background.center.x, search_bar_background.center.y - 150);
    if (clear_text_x == nil)
    {
        clear_text_x = [UIButton buttonWithType:UIButtonTypeCustom];
        [clear_text_x setImage:[UIImage imageNamed:@"search_x"] forState:UIControlStateNormal];
        clear_text_x.frame = CGRectMake(search_bar_text.frame.origin.x + search_bar_text.frame.size.width - 26, search_bar_text.frame.origin.y - 1, 20, 20);
        [clear_text_x addTarget:self action:@selector(clearSearchBarText) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clear_text_x];
    }
    else
    {
        clear_text_x.center = CGPointMake(clear_text_x.center.x, clear_text_x.center.y - 150);
        clear_text_x.hidden = NO;
    }
}
-(void)clearSearchBarText
{
    search_bar_text.text = @"";
}
-(BOOL)checkMatchItem:(NSString*)item withPhrase:(NSString*)phrase
{
    BOOL match = NO;
    NSPredicate *containsPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", phrase];
    match = [containsPredicate evaluateWithObject:item];
    return match;
}
-(void)filterTable
{
    [table_data removeAllObjects];
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
    if (search_bar_text.text.length < 1) {
        for (int i = 0; i < app_delegate.user_state_information.job_array.count; i++)
        {
                SmallJobs *small_jobs = [[SmallJobs alloc] init];
                small_jobs.title = [[app_delegate.user_state_information.job_array objectAtIndex:i] title];
                small_jobs.skills = [[app_delegate.user_state_information.job_array objectAtIndex:i] skills];
                small_jobs.job_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_id];
                small_jobs.job_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_description];
                small_jobs.user_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] user_id];
                small_jobs.created_at = [[app_delegate.user_state_information.job_array objectAtIndex:i] created_at];
                small_jobs.job_city = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_city];
                small_jobs.job_state = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_state];
                small_jobs.job_duration = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_duration];
                small_jobs.hours_per_week = [[app_delegate.user_state_information.job_array objectAtIndex:i] hours_per_week];
                small_jobs.task_start_date = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_date];
                small_jobs.task_start_time = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_time];
                small_jobs.company = [[app_delegate.user_state_information.job_array objectAtIndex:i] company];
                small_jobs.company_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] company_description];
                small_jobs.compensation = [[app_delegate.user_state_information.job_array objectAtIndex:i] compensation];
                small_jobs.latitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] latitude];
                small_jobs.longitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] longitude];
                
                [table_data addObject:small_jobs];
                [small_jobs release];
        }
        [table_view reloadData];
        return;
    }
    for (int i = 0; i < app_delegate.user_state_information.job_array.count; i++)
    {
        if ([self checkMatchItem:[[app_delegate.user_state_information.job_array objectAtIndex:i] title] withPhrase:search_bar_text.text])
        {
            SmallJobs *small_jobs = [[SmallJobs alloc] init];
            small_jobs.title = [[app_delegate.user_state_information.job_array objectAtIndex:i] title];
            small_jobs.skills = [[app_delegate.user_state_information.job_array objectAtIndex:i] skills];
            small_jobs.job_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_id];
            small_jobs.job_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_description];
            small_jobs.user_id = [[app_delegate.user_state_information.job_array objectAtIndex:i] user_id];
            small_jobs.created_at = [[app_delegate.user_state_information.job_array objectAtIndex:i] created_at];
            small_jobs.job_city = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_city];
            small_jobs.job_state = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_state];
            small_jobs.job_duration = [[app_delegate.user_state_information.job_array objectAtIndex:i] job_duration];
            small_jobs.hours_per_week = [[app_delegate.user_state_information.job_array objectAtIndex:i] hours_per_week];
            small_jobs.task_start_date = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_date];
            small_jobs.task_start_time = [[app_delegate.user_state_information.job_array objectAtIndex:i] task_start_time];
            small_jobs.company = [[app_delegate.user_state_information.job_array objectAtIndex:i] company];
            small_jobs.company_description = [[app_delegate.user_state_information.job_array objectAtIndex:i] company_description];
            small_jobs.compensation = [[app_delegate.user_state_information.job_array objectAtIndex:i] compensation];
            small_jobs.latitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] latitude];
            small_jobs.longitude = [[app_delegate.user_state_information.job_array objectAtIndex:i] longitude];
            
            [table_data addObject:small_jobs];
            [small_jobs release];
        }
    }
    [table_view reloadData];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        search_bar_text.center = CGPointMake(search_bar_text.center.x, search_bar_text.center.y + 150);
        search_bar_background.center = CGPointMake(search_bar_background.center.x, search_bar_background.center.y + 150);
        clear_text_x.center = CGPointMake(clear_text_x.center.x, clear_text_x.center.y + 150);
        clear_text_x.hidden = YES;
        [search_bar_text resignFirstResponder];
        [self filterTable];
    }
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 33;
    }
    return 42;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [table_data count];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StaffItToMeAppDelegate *delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    for (int i = 0; i < delegate.user_state_information.job_array.count; i++)
    {
        if ([[table_data objectAtIndex:indexPath.row] job_id] -1 == [[delegate.user_state_information.job_array objectAtIndex:i] job_id])
        {
            delegate.user_state_information.current_job_in_array = i;
            break;
        }
    }
    
    //show that we are loading the information about the job
    load_view = [[LoadingView alloc] initWithFrame:CGRectMake(0, -100, 320, 480)];
    [self addSubview:load_view];
    
    
    NSMutableString *job_info_url = [[[NSMutableString alloc] initWithString:@"http://helium.staffittome.com/apis/"] autorelease];
    [job_info_url appendString:[NSString stringWithFormat:@"%d", [[delegate.user_state_information.job_array objectAtIndex:delegate.user_state_information.current_job_in_array] job_id]]];
    [job_info_url appendString:@"/job"];
    //Perform the accessing of the server.
    NSURL *url = [NSURL URLWithString:job_info_url];
    ASIFormDataRequest *request_ror = [ASIFormDataRequest requestWithURL:url];
    [request_ror setRequestMethod:@"GET"];
    [request_ror setValidatesSecureCertificate:NO];
    [request_ror setPostValue:delegate.user_state_information.sessionKey forKey:@"session_key"];
    
    [request_ror setTimeOutSeconds:30];
    [request_ror setDelegate:self];
    /*ConversationViewController *tester = [[ConversationViewController alloc] initWithNibName:@"ConversationViewController" bundle:nil andMessageArray:nil andDateArray:nil];
     [_viewController presentModalViewController:tester animated:YES];*/
    [request_ror startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [load_view removeFromSuperview];
    NSDictionary *request_info = [NSDictionary dictionaryWithObject:[request responseString] forKey:@"responseString"];
    printf("\n\n\nThis is stuff: %s", [[request responseString] UTF8String]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToJobDetail" object:self userInfo:request_info];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0)
    {
        //Create Header
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        UIImageView *module_header_background = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame = CGRectMake(5, 0, 310, 33);
        [cell.contentView addSubview:module_header_background];
        
        //Create Header Label
        UILabel *my_jobs_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 200, 22)];
        my_jobs_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        my_jobs_label.backgroundColor = [UIColor clearColor];
        [my_jobs_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        my_jobs_label.text = @"Available Jobs";
        [cell.contentView addSubview:my_jobs_label];
        return cell;
    }
    JobDisplayCell *cell_information = [[[JobDisplayCell alloc] initWithFrame:CGRectMake(0, 0, 310, 33) pictureURL:@"" name:[[table_data objectAtIndex:indexPath.row] title] description:[[table_data objectAtIndex:indexPath.row] company] detail:[[table_data objectAtIndex:indexPath.row] compensation]] autorelease];
    if (indexPath.row == table_data.count -1)
    {
        [cell_information setBackgroundImageToModuleRowLast];
    }
    [cell.contentView addSubview:cell_information];
    return cell;
}  

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
	[table_view setDelegate:nil];
    [table_view release];
    [super dealloc];
}

@end
