//
//  CustomCategoryCell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCategoryCell.h"


@implementation CustomCategoryCell
@synthesize tag;
- (id)initWithFrame:(CGRect)frame andCategory:(NSString*)the_category andDetail:(NSString*)the_detail
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //make background of the cell
        cell_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
        cell_background.frame = CGRectMake(5, 8, 310, 42);
        [self addSubview:cell_background];
        //Make category label
        UILabel *category = [[UILabel alloc] initWithFrame:CGRectMake(cell_background.frame.origin.x + 10, cell_background.frame.origin.y + 4, 200, 40)];
        [category setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12]];
        category.backgroundColor = [UIColor clearColor];
        [self addSubview:category];
        //Make detail label of the cell
        detail = [[UILabel alloc] initWithFrame:CGRectMake(cell_background.frame.origin.x + 165, cell_background.frame.origin.y + 4,110, 40)];
        [detail setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12]];
        detail.backgroundColor = [UIColor clearColor];
        [self addSubview:detail];
        detail.textColor = [UIColor colorWithRed:110.0/255 green:146.0/255 blue:212.0/255 alpha:1];
        detail.textAlignment = UITextAlignmentRight;
        arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        arrow.frame = CGRectMake(detail.frame.origin.x + detail.frame.size.width + 15, detail.frame.origin.y + 11.5, 6.5, 12);
        [self addSubview:arrow];
        [self setFrame:CGRectMake(0, 0, 320, 47)];
        
        category.text = the_category;
        detail.text = the_detail;
    }
    return self;
}
-(void)changeBackgroundToBlue
{
    [cell_background setImage:[UIImage imageNamed:@"module_row_single_pressed"]];   
}
-(void)hideArrow
{
    [arrow removeFromSuperview];
}
-(void)setLast
{
    UIImage *image = [UIImage imageNamed:@"module_row_last"];
    UIImage *strect = [image stretchableImageWithLeftCapWidth:(image.size.width/2)-1 topCapHeight:(image.size.height/2)-1];
    cell_background.image = strect;
}
-(void)addCheckmark
{
    UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"check_mark"]];
    checkmark.frame = CGRectMake(detail.frame.origin.x + detail.frame.size.width + 5, detail.frame.origin.y - 5, 26.5, 41.5);
    [self addSubview:checkmark];
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [cell_background setImage:[UIImage imageNamed:@"module_row_single_pressed"]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [cell_background setImage:[UIImage imageNamed:@"module_row_single"]];
}*/

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
    [cell_background release];
    [super dealloc];
}

@end
