//
//  sparkleView.m
//  SpheroMassage
//
//  Created by Benjamin Humphries on 4/4/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "sparkleView.h"

@implementation sparkleView
@synthesize emitter;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    float multiplier = 0.25f;
    
    CGPoint pt = [[touches anyObject] locationInView:self];
    
    //Create the emitter layer
    emitter = [CAEmitterLayer layer];
    emitter.emitterPosition = pt;
    emitter.emitterMode = kCAEmitterLayerOutline;
    emitter.emitterShape = kCAEmitterLayerCircle;
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterSize = CGSizeMake(9 * multiplier, 0);
    
    //Create the emitter cell
    CAEmitterCell* particle = [CAEmitterCell emitterCell];
    particle.emissionLongitude = M_PI;
    particle.birthRate = multiplier * 100.0;
    particle.lifetime = multiplier *2;
    particle.lifetimeRange = multiplier * 0.35;
    particle.velocity = 180;
    particle.velocityRange = 130;
    particle.emissionRange = 3.1;
    particle.scaleSpeed = 1.0;// was 0.3
    particle.scaleRange = 0.5;
   // particle.color = (__bridge CGColorRef)([UIColor whiteColor]);
    particle.contents = (__bridge id)([UIImage imageNamed:@"spheroE.png"].CGImage);
    particle.name = @"particle";
    
    emitter.emitterCells = [NSArray arrayWithObject:particle];
    [self.layer addSublayer:emitter];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [[touches anyObject] locationInView:self];
    // Disable implicit animations
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    emitter.emitterPosition = pt;
    [CATransaction commit];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow: 0.4 ];
    [NSThread sleepUntilDate:future];
    [emitter removeFromSuperlayer];
    emitter = nil;
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

@end
