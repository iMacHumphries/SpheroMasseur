//
//  Vibrations.m
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/29/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "Vibrations.h"

@implementation Vibrations
@synthesize vibrationMacro;
@synthesize vibrationNames;
@synthesize allVibrations;
@synthesize colorsImages;

- (id)init
{
    self = [super init];
    vibrationNames = [[NSMutableArray alloc]init];
    vibrationMacro = [[RKMacroObject alloc]init];
    allVibrations = [[NSMutableArray alloc]init];
    colorsImages = [[NSMutableArray alloc]init];
    [self setupVibrationNames];
    
    return self;
}
-(void)setupVibrationNames{
    
    [vibrationNames addObject:@"Put Sphero to sleep"];
    [allVibrations addObject:[self getMacroForName:@"sleep"]];
    [colorsImages addObject:[UIImage imageNamed:@"sleep"]];
    
    
    [vibrationNames addObject:@"Healing Energy"];
    [allVibrations addObject:[self getMacroForName:@"healingEnergy"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroYellow"]];
    
    
    
    [vibrationNames addObject:@"Stress Buster"];
    [allVibrations addObject:[self getMacroForName:@"StressBuster"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroBlue"]];

    
    [vibrationNames addObject:@"Healing Feeling"];
    [allVibrations addObject:[self getMacroForName:@"healingFeeling"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroGreen"]];
    
    [vibrationNames addObject:@"Light Temple"];
    [allVibrations addObject:[self getMacroForName:@"lightTemp"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroPink"]];
    
    [vibrationNames addObject:@"Deep Temple"];
    [allVibrations addObject:[self getMacroForName:@"deepTemp"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroRed"]];
    
    [vibrationNames addObject:@"Back in Balance"];
    [allVibrations addObject:[self getMacroForName:@"back"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroOrange"]];

    [vibrationNames addObject:@"Zenergy"];
    [allVibrations addObject:[self getMacroForName:@"zenergy"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroDBlue"]];

    [vibrationNames addObject:@"Neck Kneads"];
    [allVibrations addObject:[self getMacroForName:@"neckKneads"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroYellowTeal"]];
    
    [vibrationNames addObject:@"Best of Both"];
    [allVibrations addObject:[self getMacroForName:@"best"]];
    [colorsImages addObject:[UIImage imageNamed:@"spheroRedBlue"]];
    
   
}
-(RKMacroObject *)getMacroForName:(NSString *)vibName{
 vibrationMacro = [[RKMacroObject alloc]init];
    if ([vibName isEqualToString:@"healingEnergy"]){
        [self healingEnergy];
    }
    else if ([vibName isEqualToString:@"StressBuster"]){
        [self stressBuster];
    }
    else if ([vibName isEqualToString:@"healingFeeling"]){
        [self healingFeeling];

    }
    else if ([vibName isEqualToString:@"sleep"]){
        [self sleep];
    }
    else if ([vibName isEqualToString:@"lightTemp"]){
        [self templeLight];
    }
    else if ([vibName isEqualToString:@"deepTemp"]){
        [self templeDeep];
    }
    else if ([vibName isEqualToString:@"back"]){
        [self backInBalance];
    }
    else if ([vibName isEqualToString:@"zenergy"]){
        [self zenergy];
    }
    else if ([vibName isEqualToString:@"neckKneads"]){
        [self neckKneads];
    }
    else if ([vibName isEqualToString:@"best"]){
        [self bestOfBoth];
    }

    
    return vibrationMacro;
}
-(void)healingEnergy{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRoll commandWithSpeed:100.0 heading:0 delay:0]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:1.0 green:1.0 blue:0.0 delay:30]];
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
}
-(void)stressBuster{
     vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:20]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:20]];
     [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:0.0 blue:1.0 delay:0]];
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
    
}
-(void)healingFeeling{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:1.0 blue:0.0 delay:0]];
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
    
    
}
-(void)sleep{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCSleep commandWithDelay:0]];
}
-(void)templeLight{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:100 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:5]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:100 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:5]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:0.0 blue:0.0 delay:0]];
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
}
-(void)templeDeep{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:99 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:40]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:99 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:40]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:0.0 blue:0.0 delay:0]];
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
}
-(void)backInBalance{
      vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRoll commandWithSpeed:100.0 heading:0 delay:0]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    
  [vibrationMacro addCommand:[RKMCDelay commandWithDelay:300]];
    
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:100]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:255 delay:100]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.9 green:0.05 blue:0.0 delay:0]];
    
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
}
-(void)zenergy{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:0.0 blue:1.0 delay:0]];
    [vibrationMacro addCommand:[RKMCRoll commandWithSpeed:100.0 heading:0 delay:0]];
 [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:1000]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:1.0 blue:0.2 delay:0]];
    

     [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
    
}
-(void)neckKneads{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:0.0 blue:1.0 delay:0]];
    [vibrationMacro addCommand:[RKMCRoll commandWithSpeed:100.0 heading:0 delay:0]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
     [vibrationMacro addCommand:[RKMCDelay commandWithDelay:40]];
    
    
    
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:1.0 blue:0.0 delay:0]];
     [vibrationMacro addCommand:[RKMCDelay commandWithDelay:40]];
    
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];

}

-(void)bestOfBoth{
    vibrationMacro = [RKMacroObject new];
    [vibrationMacro addCommand:[RKMCLoopFor commandWithRepeats:200]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:0.0 blue:1.0 delay:0]];
    [vibrationMacro addCommand:[RKMCRoll commandWithSpeed:100.0 heading:0 delay:0]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCLoopEnd command]];
    
     [vibrationMacro addCommand:[RKMCLoopFor commandWithRepeats:100]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeForward leftSpeed:255 rightMode:RKRawMotorModeForward rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRawMotor commandWithLeftMode:RKRawMotorModeReverse leftSpeed:255 rightMode:RKRawMotorModeReverse rightSpeed:255 delay:0]];
    [vibrationMacro addCommand:[RKMCDelay commandWithDelay:10]];
    [vibrationMacro addCommand:[RKMCRGB commandWithRed:0.0 green:1.0 blue:0.0 delay:0]];
     [vibrationMacro addCommand:[RKMCLoopEnd command]];
    [vibrationMacro addCommand:[RKMCGoTo commandWithID:255]];
}
-(NSMutableArray *)getVibrationNames{
    return vibrationNames;
}
-(NSMutableArray *)getAllVibrations{
    return allVibrations;
}
-(NSMutableArray *)getColorUIImages{
    return colorsImages;
}
@end


/*
-names-
 sleep - turn off sphero
healing Energy ---> raw motor jumping
 stress Buster ----> raw motor vibration
 healing Feeling -----> faster vibration
 light Temple ----> no light med vibration
 deep temple --->no light rough slow vibration
 Back In blance ---> ??? IDK
*/