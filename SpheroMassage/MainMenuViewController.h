//
//  MainMenuViewController.h
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/28/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RobotKit/RobotKit.h>
#import "RobotKit/RobotKit.h"
#import "RobotUIKit/RobotUIKit.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <iAd/iAd.h>
#import "sparkleView.h"


@interface MainMenuViewController : UIViewController<ADBannerViewDelegate>{
BOOL robotOnline;
BOOL robotInitialized;
BOOL noSpheroViewShowing;
RUINoSpheroConnectedViewController* noSpheroView;
    UIAlertView *alert;
    UIActivityIndicatorView *spinner;
    UILabel *searching;
   IBOutlet ADBannerView *adView;
     BOOL bannerIsVisible;
    CAEmitterLayer *emitter;
    IBOutlet sparkleView *theView;
    BOOL isAlert;

}
@property (retain, nonatomic) IBOutlet sparkleView *theView;

@property (retain, nonatomic)CAEmitterLayer *emitter;
@property (retain,nonatomic) UILabel *searching;
@property (retain, nonatomic) IBOutlet ADBannerView *adView;
@property (nonatomic, assign) BOOL bannerIsVisible;
@property (retain,nonatomic)UIAlertView *alert;
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
- (IBAction)beginButton:(UIButton *)sender;
-(void)setupRobotConnection;
-(void)handleRobotOnline;
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;
-(void)bannerViewDidLoadAd:(ADBannerView *)banner;
@end
