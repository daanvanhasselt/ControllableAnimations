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
    
    TSCAAnimation *horizontalAnimation = [TSCAAnimation animationWithObject:animatedView.layer keyPath:@"position.x" values:[NSArray arrayWithObjects:
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
    
    TSCAAnimation *verticalAnimation = [TSCAAnimation animationWithObject:animatedView.layer keyPath:@"position.y" values:[NSArray arrayWithObjects:
                                                                                                                               [NSNumber numberWithFloat:0],
                                                                                                                               [NSNumber numberWithFloat:10],
                                                                                                                               [NSNumber numberWithFloat:20],
                                                                                                                               [NSNumber numberWithFloat:30],
                                                                                                                               [NSNumber numberWithFloat:100],
                                                                                                                               [NSNumber numberWithFloat:200],
                                                                                                                               [NSNumber numberWithFloat:300],
                                                                                                                               [NSNumber numberWithFloat:350],
                                                                                                                               [NSNumber numberWithFloat:400],
                                                                                                                               [NSNumber numberWithFloat:450],
                                                                                                                               nil]];
    [horizontalAnimation animateToFraction:1.0 withDuration:0.5];
    [verticalAnimation animateToFraction:1.0 withDuration:0.5];
    
    UIPinchGestureRecognizer *horizontalPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:horizontalAnimation action:@selector(pinchHandler:)];
    horizontalPinch.delegate = self;
    [self.view addGestureRecognizer:horizontalPinch];
    
    UIPinchGestureRecognizer *verticalPinch = [[UIPinchGestureRecognizer alloc] initWithTarget:verticalAnimation action:@selector(pinchHandler:)];
    verticalPinch.delegate = self;
    [self.view addGestureRecognizer:verticalPinch];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
