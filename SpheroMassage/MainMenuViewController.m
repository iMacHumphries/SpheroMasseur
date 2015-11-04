//
//  MainMenuViewController.m
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/28/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "MainMenuViewController.h"
#import "sparkleView.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize alert;
@synthesize adView;
@synthesize bannerIsVisible;
@synthesize searching;
@synthesize emitter;
@synthesize theView;
@synthesize beginButton;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Get a Sphero"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://store.gosphero.com"]];
        
    }
}

-(void)setupRobotConnection {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidGainControl:) name:RKRobotDidGainControlNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRobotOnline) name:RKDeviceConnectionOnlineNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRobotOffline) name:RKDeviceConnectionOfflineNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRobotOffline) name:RKRobotDidLossControlNotification object:nil];
    //Attempt to control the connected robot so we get the notification if one is connected
    robotInitialized = NO;
    
    if ([[RKRobotProvider sharedRobotProvider] isRobotUnderControl]) {
        robotInitialized = YES;
        [[RKRobotProvider sharedRobotProvider] openRobotConnection];
    }
    else {
        robotOnline = NO;
        // connectionLabel.text = @"CONNECTING";
        // Give the device a second to connect
        [self performSelector:@selector(showNoSpheroConnectedView) withObject:nil afterDelay:1.0];
    }
    robotInitialized = YES;
}

-(void)connectToRobot
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRobotOnline) name:RKDeviceConnectionOnlineNotification object:nil];
    if ([[RKRobotProvider sharedRobotProvider] isRobotUnderControl])
    {
        [[RKRobotProvider sharedRobotProvider] openRobotConnection];
    }else
    {
        [[RKRobotProvider sharedRobotProvider] controlConnectedRobot];
    }
}

- (void)handleRobotOnline {
    /*The robot is now online, we can begin sending commands*/
    if(!robotOnline) {
        /* Send commands to Sphero Here: */
        [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:1.0 blue:0.0];
         [RKRGBLEDOutputCommand sendCommandWithRed:1.0 green:0.0 blue:0.0];
          }
    robotOnline = YES;
}
- (void)handleRobotOffline {
    if(robotOnline) {
        robotOnline = NO;
    
        [self showNoSpheroConnectedView];
    }
}

-(void)showNoSpheroConnectedView {
    if( robotOnline ) return;
    //RobotUIKit resources like images and nib files stored in an external bundle and the path must be specified
    /*
    NSString* rootpath = [[NSBundle mainBundle] bundlePath];
    NSString* ruirespath = [NSBundle pathForResource:@"RobotUIKit" ofType:@"bundle" inDirectory:rootpath];
    NSBundle* ruiBundle = [NSBundle bundleWithPath:ruirespath];
    
    NSString* nibName;
    // Set up for iPhone/ipod
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // Change if your app is portrait
        nibName = @"RUINoSpheroConnectedViewController_Portrait";
        //nibName = @"RUINoSpheroConnectedViewController_Landscape";
    }
    // Set up for iPad
    else {
        // Change if your app is portrait
        nibName = @"RUINoSpheroConnectedViewController_iPad_Portrait";
        // nibName = @"RUINoSpheroConnectedViewController_iPad_Landscape";
    }
    
    noSpheroView = [[RUINoSpheroConnectedViewController alloc]
                    initWithNibName:nibName
                    bundle:ruiBundle];
    [noSpheroView setWantsFullScreenLayout:YES];
    [self presentModalLayerViewController:noSpheroView animated:YES];
     */
    if (!noSpheroViewShowing){
     alert = [[UIAlertView alloc] initWithTitle:@"Searching for Sphero" message:@"This app requires Sphero to function properly.  Make sure that the Bluetooth is currently turned on for this device.  If Sphero is not blinking, it may be asleep. Double-shake to  wake it up!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Get a Sphero", nil];

    if (!isAlert)
    {
       [alert show];
        isAlert = true;
    }
         noSpheroViewShowing = YES;
    }
    else {
    noSpheroViewShowing = NO;
    }
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(self.view.center.x, self.view.center.y+150)];
    [searching setCenter:CGPointMake(spinner.center.x, spinner.center.y)];
    [self.view addSubview:spinner];
    [self.view addSubview:searching];
    [spinner startAnimating];
}


-(void)handleDidGainControl:(NSNotification*)notification {
    NSLog(@"didGainControlNotification");
    
    [noSpheroView.view removeFromSuperview];
    [spinner removeFromSuperview];
    [searching removeFromSuperview];
    [alert dismissWithClickedButtonIndex:100 animated:YES];
    
    if(!robotInitialized) return;
    [[RKRobotProvider sharedRobotProvider] openRobotConnection];
     
}
-(void)appWillResignActive:(NSNotification*)notification {
    /*When the application is entering the background we need to close the connection to the robot*/
    
    [RKRollCommand sendStop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:0.0 blue:0.0];
    [RKRollCommand sendStop];
    [RKRawMotorValuesCommand sendCommandWithLeftMode:0 leftPower:0 rightMode:0 rightPower:0];
    [[RKRobotProvider sharedRobotProvider]
     closeRobotConnection];
}

-(void)appDidBecomeActive:(NSNotification*)notification {
    /*When the application becomes active after entering the background we try to connect to the robot*/
    [self setupRobotConnection];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(appWillResignActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    return self;
}
- (void)willResignActive:(NSNotification *)note
{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    [RKRollCommand sendStop];
    [RKRawMotorValuesCommand sendCommandWithLeftMode:0 leftPower:0 rightMode:0 rightPower:0];
    [RKRGBLEDOutputCommand sendCommandWithRed:0.0 green:0.0 blue:0.0];
    [[RKRobotProvider sharedRobotProvider] closeRobotConnection];
}
- (void)viewDidLoad
{
    UIImage *im = [UIImage imageNamed:@"spheroI"];
    UIImageView *sphere = [[UIImageView alloc] initWithImage:im];
    sphere.frame = CGRectMake(-60, 420, sphere.frame.size.width, sphere.frame.size.height);
    [self.view addSubview:sphere];
    [self runSpinAnimationOnView:sphere duration:2 rotations:1 repeat:INFINITY];
   
    [super viewDidLoad];
    
    
    searching = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
    searching.text = @"Searching...";
    searching.textColor = [UIColor whiteColor];
    [searching setFont:[UIFont systemFontOfSize:23]];
    [searching setTextAlignment:NSTextAlignmentCenter];
    
   
   
    
    //---------------------------------------------------------------------------//
    adView = [[ADBannerView alloc]initWithFrame:CGRectZero];
    adView.delegate = self;
    adView.frame = CGRectZero;
  //  adView.frame = CGRectOffset(adView.frame, 0, adView.frame.origin.y + 180.0f);
   // adView.frame =CGRectMake(adView.frame.origin.x, adView.frame.origin.y +50.0, adView.frame.size.width, adView.frame.size.height);
    // adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    //adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    /// [self.view addSubview:adView];
     bannerIsVisible = YES;
    //---------------------------------------------------------------------//

    
    
    /*Register for application lifecycle notifications so we known when to connect and disconnect from the robot*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    robotOnline = NO;
    
    
    
   }


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"LOADED AD!");
    if (!bannerIsVisible){
        //show
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        banner.frame = CGRectOffset(banner.frame, 0, -50.0f);
        [UIView commitAnimations];
        bannerIsVisible = YES;
    }
}
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"AD FAILED!   %@",error);
    if (bannerIsVisible)
    {
        //hide
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
         banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        bannerIsVisible = NO;
    }
   
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"memOry");
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)beginButton:(UIButton *)sender {
    
}
- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
   [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
   
   
   
    [UIView animateWithDuration:duration animations:^(void){
        view.frame = CGRectMake(370, 420, view.frame.size.width, view.frame.size.height);

    } completion:^(BOOL finished) {
        view.frame = CGRectMake(-60, 420, view.frame.size.width, view.frame.size.height);
        [self runSpinAnimationOnView:view duration:2 rotations:1 repeat:INFINITY];

    }];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [theView touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [theView touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [theView touchesEnded:touches withEvent:event];
  }

@end
