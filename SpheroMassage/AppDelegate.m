//
//  AppDelegate.m
//  SpheroMassage
//
//  Created by Benjamin Humphries on 2/27/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "AppDelegate.h"
#import <RobotKit/RobotKit.h>
#import "DetailViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
-(void)appWillResignActive:(NSNotification*)notification {
    /*When the application is entering the background we need to close the connection to the robot*/
    NSLog(@"entering background");
    
    [RKRollCommand sendStop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:0.0 blue:0.0];
    [RKRollCommand sendStop];
    [RKRawMotorValuesCommand sendCommandWithLeftMode:0 leftPower:0 rightMode:0 rightPower:0];
    [[RKRobotProvider sharedRobotProvider]
     closeRobotConnection];
    [[DetailViewController sharedDetailView] stopRobot];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [RKRollCommand sendStop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:0.0 blue:0.0];
    [RKRollCommand sendStop];
    [RKRawMotorValuesCommand sendCommandWithLeftMode:0 leftPower:0 rightMode:0 rightPower:0];
    [[RKRobotProvider sharedRobotProvider]
     closeRobotConnection];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:0.0 blue:0.0];
    [[RKRobotProvider sharedRobotProvider] closeRobotConnection];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

-(void)appDidBecomeActive:(NSNotification*)notification {
    /*When the application becomes active after entering the background we try to connect to the robot*/
   
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"this term is called");
    [RKRollCommand sendStop];
    [RKAbortMacroCommand sendCommand];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:0.0 blue:0.0];
    [RKRollCommand sendStop];
    [RKRawMotorValuesCommand sendCommandWithLeftMode:0 leftPower:0 rightMode:0 rightPower:0];
    [[RKRobotProvider sharedRobotProvider]
     closeRobotConnection];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:0.0 blue:0.0];
    [[[RKRobotProvider sharedRobotProvider] robot]disconnect];
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
