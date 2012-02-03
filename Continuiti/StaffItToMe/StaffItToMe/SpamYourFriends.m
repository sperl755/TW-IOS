//
//  SpamYourFriends.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpamYourFriends.h"
#import "StaffItToMeAppDelegate.h"


@implementation SpamYourFriends
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/**
 Default Constructor for creating Spam your friends.
 */
-(id)init
{
    if ((self = [super init])) {
        StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];
        // Initialization code
        //Okay so the beginning is where the array is starting and then the end is
        //the row stopping point in the array. End will be behind beginning sometimes
        //as they are indexes that curl around the array
        beginning = 0;
        if (app_delegate.user_state_information.my_facebook_friends.count > 4)
        {
            end = 3; //Creating 4 because 0, 1, 2, 3 = 4 items.
        }
        else
        {
            if (app_delegate.user_state_information.my_facebook_friends.count >= 1)
            {
                end = app_delegate.user_state_information.my_facebook_friends.count-1;
            }
            else
            {
                end = 0;   
            }
        }
        
        //Create Header
        UIImage *header_image = [UIImage imageNamed:@"module_header.png"];
        module_header_background = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame = CGRectMake(0, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        spam_your_friends_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 200, 22)];
        spam_your_friends_label.textColor = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        spam_your_friends_label.text = @"Build Your Network";
        [self addSubview:spam_your_friends_label];
        
        //Create button on far right for shuffling.
        shuffle_button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *shuffle_image = [UIImage imageNamed:@"shuffle"];
        [shuffle_button setImage:shuffle_image forState:UIControlStateNormal];
        shuffle_button.frame = CGRectMake(250, 5, 50, 23);
        [shuffle_button addTarget:self action:@selector(changeIndexes) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:shuffle_button];
        //[shuffle_image release];
        int height = module_header_background.frame.size.height;
        for (int i = beginning; i <= end; i++)
        {
            StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*) [[UIApplication sharedApplication] delegate];  
            FacebookFriendEICell *cell = [[FacebookFriendEICell alloc] initWithFriendName:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] name] friend_id:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] friend_id]];
            cell.frame = CGRectMake(0, height, 310, 42);
            [self addSubview:cell];
            [friend_cells addObject:cell];
            [cell release];
            [self performSelectorInBackground:@selector(friendCellInitialize) withObject:nil];
            height+=43;
        }
        [self setFrame:CGRectMake(5, 0, 310, height)];
        
    }
    return self;
}
-(void)friendCellInitialize
{
}
-(void)changeIndexes
{
    StaffItToMeAppDelegate *app_delegate = (StaffItToMeAppDelegate*)[[UIApplication sharedApplication] delegate];
    int id_array_indeices[end+1];
    for (int i = 0; i <= end; i++)
    {
        id_array_indeices[i] = rand()%app_delegate.user_state_information.my_facebook_friends.count-1;
    }
    //Empty the array
    [friend_cells removeAllObjects];
    //recreate the arrays
    int height = module_header_background.frame.size.height;
    for (int i = 0; i <= end; i++)
    {
        FacebookFriendEICell *cell = [[FacebookFriendEICell alloc] initWithFriendName:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:id_array_indeices[i]] name] friend_id:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:id_array_indeices[i]] friend_id]];
        cell.frame = CGRectMake(0, height, 310, 42);
        [self addSubview:cell];
        height+=43;
        [friend_cells addObject:cell];
        [cell release];
    }
    //increase the variables and if they are above the count then rap them around.
    /*beginning++;
    if (beginning >= app_delegate.user_state_information.my_facebook_friends.count)
    {
        beginning = 0;
    }
    end++;
    if (end >= app_delegate.user_state_information.my_facebook_friends.count)
    {
        end = 0;
    }
    for (int i = 0; i < friend_cells.count; i++)
    {
        [[friend_cells objectAtIndex:i] removeFromSuperview];
    }
    //Empty the array
    [friend_cells removeAllObjects];
    //recreate the arrays
    int height = module_header_background.frame.size.height;
    for (int i = beginning; i <= end; i++)
    {
        //this is so if i ends up getting the array and end is at the beginning
        //then it brings i to the beginning
        if (i >= app_delegate.user_state_information.my_facebook_friends.count)
        {
            i = 0;
        }
        FacebookFriendEICell *cell = [[FacebookFriendEICell alloc] initWithFriendName:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] name] friend_id:[[app_delegate.user_state_information.my_facebook_friends objectAtIndex:i] friend_id]];
        cell.frame = CGRectMake(0, height, 310, 42);
        [self addSubview:cell];
        height+=43;
        [friend_cells addObject:cell];
        [cell release];
    }*/
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
    [super dealloc];
}

@end
