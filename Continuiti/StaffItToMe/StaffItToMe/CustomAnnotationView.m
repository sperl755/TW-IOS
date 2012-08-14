//
//  CustomAnnotationView.m
//  StaffItToMe
//
//  Created by Anthony Sierra on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomAnnotationView.h"


@implementation CustomAnnotationView
-(void)drawRect:(CGRect)rect
{
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    background.image = [UIImage imageNamed:@"BalloonBackground"];
    [background.image drawInRect:CGRectMake(0, 0, 100, 30)];
}
@end
