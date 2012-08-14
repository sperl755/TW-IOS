//
//  JobSkillsModule.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JobSkillsModule.h"


@implementation JobSkillsModule

-(id)initWithArray:(NSArray *)the_skill_data
{
    if ((self = [super init]))
    {
        // Initialization code //Create Header
        UIImage *header_image           = [UIImage imageNamed:@"module_header.png"];
        module_header_background        = [[UIImageView alloc] initWithImage:header_image];
        module_header_background.frame  = CGRectMake(0, 0, 310, 33);
        [self addSubview:module_header_background];
        //[header_image release];
        
        spam_your_friends_label                 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 22)];
        spam_your_friends_label.textColor       = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
        spam_your_friends_label.backgroundColor = [UIColor clearColor];
        spam_your_friends_label.text            = @"Job Skills";
        [spam_your_friends_label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        [self addSubview:spam_your_friends_label];
        
        UIView *bottom_half = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 310, 42)];
        int height = 0;
        if (the_skill_data.count < 1)
        {
            //create the cell background;
            UIImageView *cell_background    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
            cell_background.frame           = CGRectMake(0, 0, 310, 42);
            [bottom_half addSubview:cell_background];
            
            height += 42;
            
            UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(cell_background.frame.origin.x + 5, cell_background.frame.origin.y + 8, 300, 25)];
            label.textColor         = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
            label.backgroundColor   = [UIColor clearColor];
            [label setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10]];
            [bottom_half addSubview:label];
            
            label.text = @"Not Available";
        }
        else
        {
            for (int i = 0; i < the_skill_data.count; i++)
            {
                //create the cell background;
                UIImageView *cell_background    = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"module_row"]];
                cell_background.frame           = CGRectMake(0, i * 42, 310, 42);
                [bottom_half addSubview:cell_background];
                height += 42;
                
                UILabel *label          = [[UILabel alloc] initWithFrame:CGRectMake(cell_background.frame.origin.x + 5, cell_background.frame.origin.y + 8, 300, 25)];
                label.textColor         = [UIColor colorWithRed:49.0/255 green:72.0/255 blue:106.0/255 alpha:1];
                label.backgroundColor   = [UIColor clearColor];
                [label setFont:[UIFont fontWithName:@"HelveticaNeueLTCom-Md" size:10]];
                [bottom_half addSubview:label];
                
                label.text = [[the_skill_data objectAtIndex:i] objectForKey:@"name"];
            }
            
            
        }
        bottom_half.frame = CGRectMake(0, module_header_background.frame.origin.y + module_header_background.frame.size.height, 310, height);
        [self addSubview:bottom_half];
        [self setFrame:CGRectMake(5, 0, 310, 33 + bottom_half.frame.size.height)];
        
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
