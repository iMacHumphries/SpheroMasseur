//
//  Vibrations.h
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/29/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RobotKit/RobotKit.h>
#import "RobotUIKit/RobotUIKit.h"
#import "AppDelegate.h"


@interface Vibrations : NSObject{
    RKMacroObject *vibrationMacro;
    NSMutableArray *vibrationNames;
    NSMutableArray *allVibrations;
    NSMutableArray *colorsImages;
}
@property (retain,nonatomic) RKMacroObject *vibrationMacro;
@property (retain,nonatomic)NSMutableArray *vibrationNames;
@property (retain,nonatomic)NSMutableArray *allVibrations;
@property (retain,nonatomic)NSMutableArray *colorsImages;

-(RKMacroObject *)getMacroForName:(NSString *)vibName;
-(NSMutableArray *)getVibrationNames;
-(NSMutableArray *)getAllVibrations;
-(NSMutableArray *)getColorUIImages;
@end
