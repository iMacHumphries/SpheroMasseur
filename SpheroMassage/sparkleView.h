//
//  sparkleView.h
//  SpheroMassage
//
//  Created by Benjamin Humphries on 4/4/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface sparkleView : UIView{
    CAEmitterLayer *emitter;
}
@property (retain, nonatomic)CAEmitterLayer *emitter;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
