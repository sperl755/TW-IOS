//
//  SearchFilterScreen.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Checkbox.h"
@protocol SearchFilterProtocol <NSObject>
@required
-(void)setupGoogleMap;
@end
@interface SearchFilterScreen : UIView <UITextFieldDelegate>{
    UIImageView *background;
    UITextField *search_by_txt;
    UIButton *list_btn;
    UIButton *map_btn;
    UILabel *distance_from_you;
    UISlider *distance_from_slider;
    UILabel *total_value_lbl;
    UISlider *total_value_slider;
    UILabel *rate_per_hour_lbl;
    UISlider *rate_slider;
    UILabel *from_lbl;
    UITextField *from_txt;
    UILabel *to_lbl;
    UITextField *to_txt;
    //TouchItems
    CGPoint startPoint;
    BOOL displayed;
}
//set up a delegate so that way you can call functions when
//this menu is in ceratin places.
@property (retain) id <SearchFilterProtocol> delegate;
@end
