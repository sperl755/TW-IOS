//
//  TwitterBtn.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 6/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterBtn.h"
#import "StaffItToMeAppDelegate.h"

@implementation TwitterBtn
-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"TwitterNormal.png"]];
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.image.size.width, self.image.size.height)];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setImage:[UIImage imageNamed:@"TwitterPressed.png"]];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setImage:[UIImage imageNamed:@"TwitterNormal.png"]];
    StaffItToMeAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate twitterLogin];
}
@end
