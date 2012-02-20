//
//  TSCAAnimation.m
//  ControllableAnimation
//
//  Created by Daan van Hasselt on 2/20/12.
//  Copyright (c) 2012 Touchwonders B.V. All rights reserved.
//

#import "TSCAAnimation.h"

@interface TSCAAnimation (_Private)
/** Runloop update method */
-(void)update;
/** Update value according to fraction. */
-(void)updateToFraction:(float)fraction;
@end

@implementation TSCAAnimation

@synthesize object;
@synthesize keyPath;
@synthesize values;

-(id)init{
    self = [super init];
    if(self){
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return self;
}

+(TSCAAnimation *)animationWithObject:(id)object keyPath:(NSString *)keyPath values:(NSArray *)values{
    TSCAAnimation *animation = [[TSCAAnimation alloc] init];
    animation.object = object;
    animation.keyPath = keyPath;
    animation.values = values;
    return animation;
}

-(void) pinchHandler:(UIPinchGestureRecognizer *)pinchGestureRecognizer{
    /* TODO: intelligent pinch handling
     * The way I see it, the animation needs an 'isOpen' property. This means it can only be in 2 states: open or closed.
     * After pinching, depending on the pinch scale and pinch velocity, it can:
     * - Animate back to old state
     * - Animate to other state
     * To simplify this, don't allow interaction while animating.
     */
    
    
    [self updateToFraction:pinchGestureRecognizer.scale];
}

-(void)animateToFraction:(float)_fraction withDuration:(float)_duration{
    if(_duration <= 0){
        [self updateToFraction:_fraction];
        return;
    }
    
    // start runloop and update value in 'update' method
    duration = _duration;
    startFraction = currentFraction;
    targetFraction = clampToMaximum(_fraction, 1.0);
    startTime = CACurrentMediaTime();
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)update{
    double deltaTime = CACurrentMediaTime() - startTime;
    double timeFraction = deltaTime / duration;
    currentFraction = timeFraction * (targetFraction - startFraction);

    [self updateToFraction:currentFraction];
    
    if(targetFraction >= startFraction)
        if(currentFraction >= targetFraction){
            [displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }
    
    if(targetFraction <= startFraction)
        if(currentFraction <= targetFraction){
            [displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        }
}

-(void)updateToFraction:(float)_fraction{
    currentFraction = _fraction;
    double valueIndex = _fraction * ([values count] - 1);    
    int leftValueIndex = floor(valueIndex);
    leftValueIndex = clampToMaximum(leftValueIndex, [values count] - 1);
    int rightValueIndex = ceil(valueIndex);
    rightValueIndex = clampToMaximum(rightValueIndex, [values count] - 1);
    
    float leftValue = [[self.values objectAtIndex:leftValueIndex] floatValue];
    float rightValue = [[self.values objectAtIndex:rightValueIndex] floatValue];
    
    double fractionBetweenIndices = valueIndex - leftValueIndex;
    float interpolatedValue = ((leftValue * (1.0f - fractionBetweenIndices)) + (rightValue * fractionBetweenIndices));
    [self.object setValue:[NSNumber numberWithFloat:interpolatedValue] forKeyPath:self.keyPath];
}

@end
