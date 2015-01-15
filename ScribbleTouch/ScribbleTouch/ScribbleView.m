//
//  ScribbleView.m
//  ScribbleTouch
//
//  Created by Jo Albright on 1/14/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ScribbleView.h"

@implementation ScribbleView

//    @[
//
//        @{
//            @"type":@"path",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"points":@[CGPoint,CGPoint,CGPoint]
//        },
//
//        @{
//            @"type":@"circle",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"frame":CGRect
//        }
//
//    ];



- (NSMutableArray *)scribbles {
    
    if (_scribbles == nil) { _scribbles = [@[] mutableCopy]; }
    return _scribbles;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSDictionary * scribble in self.scribbles) {
        
        //// Stroke color and width
        
        
        
        CGContextSetLineWidth(context, [scribble[@"strokeWidth"] floatValue]);
        
        UIColor * strokeColor = scribble[@"strokeColor"];
        [strokeColor set];
        
        
        //// Build Stroke Path
        
        BOOL typeIsScribble = [scribble[@"type"] isEqualToString:@"Scribble"];
        BOOL typeIsLine = [scribble[@"type"] isEqualToString:@"Line"];
        
        if (typeIsScribble || typeIsLine) {
            
        }
        
        
        CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        
        for (NSValue * pointValue in scribble[@"points"]) {
            
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
            
        }
        
        CGContextStrokePath(context);
        
    }
    
}

@end
