//
//  ViewController.m
//  PathTest
//
//  Created by John Tabbone on 10/24/13.
//  Copyright (c) 2013 John V. Tabbone, Inc. All rights reserved.
//

#import "ViewController.h"
#import "PathCanvas.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PathCanvas *pathCanvas;
@end

@implementation ViewController

- (IBAction)fillPressed:(id)sender {
}
- (IBAction)clearPressed:(id)sender
{
    [self.pathCanvas clearCanvas];
    [self.pathCanvas setNeedsDisplay ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonPressed:(UISegmentedControl *)sender
{
        if ( sender.selectedSegmentIndex == 0 )
            {
                // line
            [self.pathCanvas setLine:YES];
            }
        else if ( sender.selectedSegmentIndex == 1)
            {
                // fill
            [self.pathCanvas setLine:NO];
                       
            }
        else if ( sender.selectedSegmentIndex == 2)
            {
                //clear;
            [self.pathCanvas clearCanvas];
            [self.pathCanvas setLine:YES];
            }
                [self.pathCanvas setNeedsDisplay];
    
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self.view];
    [self.pathCanvas addPoint:p];
    [self.pathCanvas setNeedsDisplay ];
}

-( void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.pathCanvas createPath];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
