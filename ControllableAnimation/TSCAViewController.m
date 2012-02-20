//
//  TSCAViewController.m
//  ControllableAnimation
//
//  Created by Daan van Hasselt on 2/20/12.
//  Copyright (c) 2012 Touchwonders B.V. All rights reserved.
//

#import "TSCAViewController.h"
#import "TSCAAnimation.h"

@implementation TSCAViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView *animatedView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    animatedView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:animatedView];
    
    TSCAAnimation *controllableAnimation = [TSCAAnimation animationWithObject:animatedView.layer keyPath:@"position.x" values:[NSArray arrayWithObjects:
                                                                                [NSNumber numberWithFloat:0],
                                                                                [NSNumber numberWithFloat:200],
                                                                                [NSNumber numberWithFloat:300],
                                                                                [NSNumber numberWithFloat:350],
                                                                                [NSNumber numberWithFloat:400],
                                                                                [NSNumber numberWithFloat:500],
                                                                                [NSNumber numberWithFloat:600],
                                                                                [NSNumber numberWithFloat:700],
                                                                                [NSNumber numberWithFloat:800],
                                                                                [NSNumber numberWithFloat:900],
                                                                                nil]];
//    [controllableAnimation animateToFraction:1.0 withDuration:5];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:controllableAnimation action:@selector(pinchHandler:)];
    [self.view addGestureRecognizer:pinch];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
