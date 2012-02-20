//
//  TSCAAnimation.h
//  ControllableAnimation
//
//  Created by Daan van Hasselt on 2/20/12.
//  Copyright (c) 2012 Touchwonders B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface TSCAAnimation : NSObject{
    float currentFraction;
    float startFraction;
    float targetFraction;
    double duration;
    double startTime;
    CADisplayLink *displayLink;
    BOOL isOpen;
}

///-------------------------------------------------
/// @name Methods
///-------------------------------------------------

/**
 * Create an animation.
 *
 * @param object object to run the animatino on
 * @param keyPath we will animate the property object.keyPath
 * @param values the array of values. Interpolation will occur if there are less then 60 values / second and values will be skipped if there are more then 60 values / second.
 * @return initialized object
 */
+(TSCAAnimation *) animationWithObject:(id)object keyPath:(NSString *)keyPath values:(NSArray *)values;


/**
 * Animate to a fraction of the animation
 *
 * @param fraction animate to this fraction. For example, if this value is 0.5 we will animate to the value at the middle of the array of values
 * @param duration the time it takes to animate to the fraction
 */
-(void) animateToFraction:(float)fraction withDuration:(float)duration;

/**
 * Handle incoming pinches
 *
 * @param pinchGestureRecognizer the recognizer sending pinch events
 */
-(void) pinchHandler:(UIPinchGestureRecognizer *)pinchGestureRecognizer;

///-------------------------------------------------
/// @name Properties
///-------------------------------------------------

/** The object to animate a property on. We have a strong reference because we want the user to be able to release the object before the animation is finished */
@property (nonatomic, strong) id object;

/** KeyPath of the property we will animate */
@property (nonatomic, strong) NSString *keyPath;

/** The values of the animation, sort of keyframes */
@property (nonatomic, strong) NSArray *values;



@end
