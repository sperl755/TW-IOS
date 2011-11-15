//
//  NoInformationCell.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NoInformationCell.h"


@implementation NoInformationCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    if ((self = [super init]))
    {
        UIImage *row_background = [UIImage imageNamed:@"module_row_last.png"];
        UIImageView *module_row_one_background = [[UIImageView alloc] initWithImage:row_background];
        module_row_one_background.frame = CGRectMake(0,0, 310, 42);
        [self addSubview:module_row_one_background];
        
        UILabel *job_one_name = [[UILabel alloc] initWithFrame:CGRectMake(module_row_one_background.frame.origin.x + 8, 12, 200, 20)];
        job_one_name.backgroundColor = [UIColor clearColor];
        job_one_name.font = [UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:12];
        job_one_name.text = @"No Information Found";
        [self addSubview:job_one_name];
        [self setFrame:CGRectMake(5, 0, 310, 42)];   
    }
    
    return self;
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
