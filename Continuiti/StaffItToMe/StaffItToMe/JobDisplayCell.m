//
//  JobDisplayCell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 8/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobDisplayCell.h"

@implementation JobDisplayCell

- (id)initWithFrame:(CGRect)frame pictureURL:(NSString*)picture_url name:(NSString*)the_name description:(NSString*)the_description detail:(NSString*)the_detail
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Create Row 1
        UIImage *row_background = [UIImage imageNamed:@"module_row.png"];
        UIImage *stretched_back = [row_background stretchableImageWithLeftCapWidth:(row_background.size.width/2)-1 topCapHeight:(row_background.size.height/2)-1];
        module_row_one_background = [[UIImageView alloc] initWithImage:row_background];
        module_row_one_background.frame = CGRectMake(0,0, 310, 42);
        [self addSubview:module_row_one_background];
        
        //Setup the first job suggestions information.
        job_one_picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_company"]];
        [job_one_picture setFrame:CGRectMake(module_row_one_background.frame.origin.x + 10, module_row_one_background.frame.origin.y + 8, 25, 25)];
        [self addSubview:job_one_picture];
        
        job_one_name = [[UILabel alloc] initWithFrame:CGRectMake(job_one_picture.frame.origin.x + job_one_picture.frame.size.width + 10, job_one_picture.frame.origin.y - 1, 200, 20)];
        job_one_name.backgroundColor = [UIColor clearColor];
        job_one_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        if (the_name != nil || the_name != [NSNull null])
        {
            job_one_name.text = the_name;
        }
        [self addSubview:job_one_name];
        
        job_one_description = [[UILabel alloc] initWithFrame:CGRectMake(job_one_name.frame.origin.x, job_one_name.frame.origin.y + job_one_name.frame.size.height - 11, 200, 30)];
        job_one_description.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1];
        job_one_description.backgroundColor = [UIColor clearColor];
        job_one_description.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9];
        if (the_description != nil || the_description != [NSNull null])
        {
            job_one_description.text = the_description;
        }
        [self addSubview:job_one_description]; 
        //Make detail label of the cell
        detail = [[UILabel alloc] initWithFrame:CGRectMake(module_row_one_background.frame.origin.x + 175, module_row_one_background.frame.origin.y + 4,110, 40)];
        [detail setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:9]];
        detail.backgroundColor = [UIColor clearColor];
        if (the_detail != nil || the_detail != [NSNull null])
        {
            detail.text = the_detail;
        }
        [self addSubview:detail];
        detail.textColor = [UIColor colorWithRed:110.0/255 green:146.0/255 blue:212.0/255 alpha:1];
        detail.textAlignment = UITextAlignmentRight;
        arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        arrow.frame = CGRectMake(detail.frame.origin.x + detail.frame.size.width + 10, detail.frame.origin.y + 11.5, 6.5, 12);
        [self addSubview:arrow];
        
        [self setFrame:CGRectMake(5, 0, 310, 42)];
    }
    return self;
}
-(void)removeArrow
{
    [arrow removeFromSuperview];
}
-(void)setBackgroundImageToModuleRowLast
{
    UIImage *last_image = [UIImage imageNamed:@"module_row_last"];
    UIImage *stretched_back = [last_image stretchableImageWithLeftCapWidth:(last_image.size.width/2)-1 topCapHeight:(last_image.size.height/2)-1];
    [module_row_one_background setImage:stretched_back];
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
