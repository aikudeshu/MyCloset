//
//  MyClosetTodayCell.m
//  MyCloset
//
//  Created by WangXiao on 9/11/14.
//  Copyright (c) 2014 WangXiao. All rights reserved.
//

#import "MyClosetTodayCell.h"

@implementation MyClosetTodayCell
@synthesize myClosetItemImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.myClosetItemImage = [[UIImageView alloc]initWithFrame:CGRectZero];
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

@end
