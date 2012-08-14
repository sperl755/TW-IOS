//
//  FacebookBtn.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookBtn.h"
#import "StaffItToMeAppDelegate.h"

@implementation FacebookBtn
-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"FacebookNormal.png"]];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.image.size.width, self.image.size.height)];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setImage:[UIImage imageNamed:@"FacebookPressed.png"]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setImage:[UIImage imageNamed:@"FacebookNormal.png"]];
    StaffItToMeAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate facebookFunction];
}
@end
