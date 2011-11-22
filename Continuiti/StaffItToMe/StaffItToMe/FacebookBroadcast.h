//
//  FacebookBroadcast.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookFriendEICell.h"
#import "FriendFacebookBroadcast.h"
@protocol FacebookBroadcastProtocol <NSObject>
-(void)goToFriendFacebookBroadcast:(int)array_position;
@end

@interface FacebookBroadcast : UIViewController<UITableViewDataSource, UITextViewDelegate, UIActionSheetDelegate, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UISearchBarDelegate> {
    UIImageView *background;
    IBOutlet UITextField *friend_choice;
    UITableView *table;
    UISearchBar *search_bar;
    
    
    NSMutableArray *pre_made_cells;
    
    LoadingView *load_view;
    NSMutableArray *original_people;
    NSMutableArray *original_facebook_ids;
    
    NSMutableArray *filtered_people;
    NSMutableArray *filtered_facebook_ids;
    
    
    UISearchDisplayController *search_dc;
    UIActionSheet *friend_menu;
    int index_in_real_array;
    int begin;
    int table_size;
    int end;
}
-(IBAction)chooseFriend;
@property (retain) id <FacebookBroadcastProtocol> delegate;
@end
