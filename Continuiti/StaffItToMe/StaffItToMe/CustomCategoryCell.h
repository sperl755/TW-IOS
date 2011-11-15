//
//  CustomCategoryCell.h
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomCategoryCell : UIView 
{
    UIImageView *cell_background;
    UIImageView *arrow;
    UILabel *detail;
}
@property (nonatomic) NSInteger tag;

- (id)initWithFrame:(CGRect)frame andCategory:(NSString*)the_category andDetail:(NSString*)the_detail;
-(void)changeBackgroundToBlue;
-(void)hideArrow;
-(void)addCheckmark;
-(void)setLast;
@end
