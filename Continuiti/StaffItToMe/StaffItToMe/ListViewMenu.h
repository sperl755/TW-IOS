//
//  ListViewMenu.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobDisplayCell.h"
#import "SmallJobs.h"

@interface ListViewMenu : UIView <UITableViewDataSource, UITextViewDelegate,UITableViewDelegate>{
    UIImageView *header_shadow;
    UITableView *table_view;
    UIImageView *search_bar_background;
    UITextView *search_bar_text;
    UIAlertView *load_message;
    NSMutableArray *table_data;
}

@end
