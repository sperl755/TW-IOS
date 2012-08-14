//
//  SuggestionModuleCell.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SuggestionModuleCellProtocol<NSObject>
-(void)respondToTouchWithIndex:(int)the_index andJobTitle:(NSString*)the_title;
@end
@interface SuggestionModuleCell : UIView
{
    UIImageView *module_row_one_background;
    UIImageView *job_one_picture;
    UIImageView *job_one_overlay;
    UILabel *job_one_name;
    UILabel *job_one_description;
    UIImageView *arrow_one;
    int my_index;
}
-(BOOL)changeIndex:(int)index;
- (id)initWithFrame:(CGRect)frame andJobSuggestionIndex:(int)the_index;
@property(nonatomic, retain) id <SuggestionModuleCellProtocol> delegate;
@end
