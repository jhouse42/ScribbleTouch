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
        
        NSArray *points = scribble [@"points"];
        
        if (points.count < 2) continue;
        
       [self addToContext:context withScribble:scribble andType:@"Fill"];
       [self addToContext:context withScribble:scribble andType:@"Stroke"];
    }

}



- (void)addToContext:(CGContextRef)context withScribble:(NSDictionary *)scribble andType:(NSString *)type {
    
    NSArray *shapeTypes = @[
                            
                                @"Scribble",
                                @"Line",
                                @"Rectangle",
                                @"Triangle",
                                @"Ellipse"
                                
                            
                            ];
    
    NSArray *points = scribble[@"points"];
    
    //// Stroke color and width
    
    
    
    CGContextSetLineWidth(context, [scribble[@"strokeWidth"] floatValue]);
    
    CGContextSetAlpha(context, [scribble[@"alpha"] floatValue]);
    
    //        NSLog(@"alpha %f",[scribble[@"alpha"] floatValue]);
    
    
    // Covers all shape types
    CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
    CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
    CGFloat width = secondPoint.x - firstPoint.x;
    CGFloat height = secondPoint.y - firstPoint.y;
    CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);
    
    
    switch ([shapeTypes indexOfObject:scribble[@"type"]]) {
        case 0://Scribble
        case 1://Line
            
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            
            for (NSValue * pointValue in scribble[@"points"]) {
                
                CGPoint point = [pointValue CGPointValue];
                CGContextAddLineToPoint(context, point.x, point.y);
                
            }
            break;
            
        case 2: //Rectangle
            
            
            CGContextAddRect(context, rect);
            break;
            
        case 3: //Triangle
            
            CGContextMoveToPoint(context, firstPoint.x + width /2, firstPoint.y);
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
            CGContextAddLineToPoint(context, firstPoint.x, secondPoint.y);
            CGContextAddLineToPoint(context, firstPoint.x + width / 2, firstPoint.y);
            
            break;
            
        case 4: //Ellipse
            
            CGContextAddEllipseInRect(context, rect);
            break;
            
        default:
            
            break;
    }
    

    
    if ([type isEqualToString:@"Fill"]) {
        
        
        UIColor * fillColor = scribble[@"fillColor"];
        [fillColor set];
        
        CGContextFillPath(context);
    } else {
        
        
        UIColor * strokeColor = scribble[@"strokeColor"];
        [strokeColor set];
        
        CGContextStrokePath(context);
    }
    
}

@end
