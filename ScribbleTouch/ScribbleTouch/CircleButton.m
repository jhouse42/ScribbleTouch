//
//  CircleButton.m
//  ScribbleTouch
//
//  Created by Jeanie House on 1/16/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "CircleButton.h"

@implementation CircleButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = self.cornerSize;
    self.layer.masksToBounds = YES;
    
    // Drawing code
}


@end
