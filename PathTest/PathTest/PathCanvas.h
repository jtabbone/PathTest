//
//  PathCanvas.h
//  PathTest
//
//  Created by John Tabbone on 10/24/13.
//  Copyright (c) 2013 John V. Tabbone, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathCanvas : UIView
-(void) createPath;
-(void) addPoint:(CGPoint) aPoint;
-(void) clearCanvas;
-(void) setLine:(BOOL) aFlag;
@end
