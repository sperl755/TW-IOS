//
//  SearchFilterScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checkbox.h"
#import "CustomCategoryCell.h"
@protocol SearchFilterProtocol <NSObject>
@required
-(void)setupListView;
-(void)setupGoogleMap;
-(void)goToIndustryPage;
-(void)goToSalaryPage;
@end
@interface SearchFilterScreen : UIView <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    UIImageView *background;
    UITextField *search_by_txt;
    UIImageView *header_shadow;
    UITableView *search_table;
    
    UIButton *list_btn;
    UIButton *map_btn;
    UIButton *update_criteria;
    
    UILabel *rate_per_hour_lbl;
    UISlider *rate_slider;
    UILabel *desired_rate;
    
    UITextField *to_txt;
	UIPickerView *my_job_type_picker;
    NSArray *my_job_types;
    UIActionSheet *actionSheet;
    
    //TouchItems
    CGPoint startPoint;
    BOOL displayed;
	int list_or_map;
	UIAlertView *load_message;
}
-(void)displayDatePicker;
-(void)updateTableView;
//set up a delegate so that way you can call functions when
//this menu is in ceratin places.
@property (retain) id <SearchFilterProtocol> delegate;
@end
