//
//  DetailViewController.h
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/29/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vibrations.h"
#import <RobotKit/RobotKit.h>
#import "RobotKit/RobotKit.h"
#import "RobotUIKit/RobotUIKit.h"
#import "AppDelegate.h"
#import "SelectionTableViewController.h"
#import <iAd/iAd.h>
#import "sparkleView.h"
@class SelectionTableViewController;
@interface DetailViewController : UIViewController<ADBannerViewDelegate,UIApplicationDelegate>{
    NSMutableArray *allMacros;
    RKMacroObject *currentMacro;
    RKMacroObject *clearMacro;
    BOOL robotOnline;
    BOOL robotInitialized;
    BOOL noSpheroViewShowing;
    RUINoSpheroConnectedViewController* noSpheroView;
    UIAlertView *alert;
    UIActivityIndicatorView *spinner;
    SelectionTableViewController *selectionTableView;
    NSInteger index;
    IBOutlet ADBannerView *adView;
    BOOL bannerIsVisible;
    BOOL isShowing;
    
   }
+(id)sharedDetailView;
-(void)setCurrentMacro:(RKMacroObject *)inMac;
- (IBAction)startButton:(UIButton *)sender;
-(void)setupRobotConnection;
-(void)handleRobotOnline;
-(void)setIndex:(NSInteger)dex;
-(void)stopRobot;

@property (retain,nonatomic)UIAlertView *alert;
@property (retain,nonatomic)NSMutableArray *allMacros;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic,retain) NSString *theTitle;
@property (retain, nonatomic) RKMacroObject *currentMacro;
@property (retain, nonatomic) RKMacroObject *clearMacro;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) IBOutlet sparkleView *theView;

@property (retain, nonatomic) IBOutlet ADBannerView *adView;
@property (nonatomic, assign) BOOL bannerIsVisible;

@end
