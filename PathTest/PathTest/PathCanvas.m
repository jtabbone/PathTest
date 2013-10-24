//
//  PathCanvas.m
//  PathTest
//
//  Created by John Tabbone on 10/24/13.
//  Copyright (c) 2013 John V. Tabbone, Inc. All rights reserved.
//

#import "PathCanvas.h"

@interface PathCanvas()

@property (strong,nonatomic) NSMutableArray* pointArray;
@property (strong,nonatomic) NSMutableArray* pathList;
@property (nonatomic) BOOL isLine;

@end

@implementation PathCanvas

-(NSMutableArray*) pointArray
{
    if ( ! _pointArray)
        {
        _pointArray = [[NSMutableArray alloc]init];
        }
    return _pointArray;
}

-(NSMutableArray*) pathList
{
    if ( ! _pathList)
        {
        _pathList = [[NSMutableArray alloc]init];
        }
    return _pathList;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        NSLog(@"initCalled");
        self.isLine = YES;
        // Initialization code
    }
    return self;
}


-(void) setLine:(BOOL) aFlag;
{
    self.isLine = aFlag;
}

-(void) addPoint:(CGPoint) aPoint
{
       [self.pointArray addObject:[NSValue valueWithCGPoint:aPoint] ];
    NSLog(@"Added point");
}

-(void) createPath
{
    NSMutableArray* tmp = [[NSMutableArray alloc]initWithArray:self.pointArray copyItems:YES];
    [self.pathList addObject:tmp];
    [self.pointArray removeAllObjects];
}
-(void) clearCanvas
{
       [self.pointArray removeAllObjects];
        [self.pathList removeAllObjects];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
        // Clear the canvas
    if ( self.pathList.count == 0 && self.pointArray.count == 0)
    {
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextBeginPath(c);
        CGContextAddRect(c,self.bounds);
        CGContextSetRGBFillColor(c,1, 1, 1, 1);
        CGContextFillPath(c);
    }
        // draw the current path
    if ( self.pointArray.count > 0)
    {
        for (int i=0; i<self.pointArray.count; i++ )
        {
            CGContextRef c = UIGraphicsGetCurrentContext();
            CGContextBeginPath(c);
            NSValue* val = [self.pointArray objectAtIndex:0];
            CGPoint p = val.CGPointValue;
            CGContextMoveToPoint(c,p.x, p.y);
            for( int i=1; i<self.pointArray.count; i++)
            {
                NSValue* val = [self.pointArray objectAtIndex:i];
                CGPoint p = val.CGPointValue;
                CGContextAddLineToPoint(c,p.x, p.y);
            }
            CGContextSetRGBStrokeColor(c, 1, 0, 0, 1);
            CGContextSetLineWidth(c, 5);
            CGContextStrokePath(c);
        }
    }
        // draw the previous paths
    if( self.pathList.count > 0)
    {
        for (int i=0; i<self.pathList.count; i++ )
        {
            NSMutableArray* path = (NSMutableArray*)[self.pathList objectAtIndex:i];
        
            CGContextRef c = UIGraphicsGetCurrentContext();
            CGContextBeginPath(c);
            NSValue* frstVal = [path objectAtIndex:0];
            CGPoint firstPoint = frstVal.CGPointValue;
            CGContextMoveToPoint(c,firstPoint.x, firstPoint.y);
            for( int j=1; j<path.count; j++)
            {
                NSValue* val = [path objectAtIndex:j];
                CGPoint p = val.CGPointValue;
                CGContextAddLineToPoint(c,p.x, p.y);
            }
            // add final line to first point to close
            //     CGContextAddLineToPoint(c,firstPoint.x, firstPoint.y);
            CGContextClosePath(c);
        
            if ( self.isLine)
            {
                CGContextSetRGBStrokeColor(c, 0, 1, 1, 1);
                CGContextSetLineWidth(c, 5);
                CGContextStrokePath(c);
            }
            if ( ! self.isLine)
            {
                CGContextSetRGBFillColor(c,0, 0, 1, 1);
                CGContextFillPath(c);
            }
        }
    
        // draw curent path 
        }
}


@end
