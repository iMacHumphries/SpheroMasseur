//
//  DetailViewController.m
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/29/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize theTitle;
@synthesize currentMacro;
@synthesize startButton;
@synthesize alert;
@synthesize allMacros;
@synthesize clearMacro;
@synthesize adView,bannerIsVisible;
@synthesize background;
@synthesize theView;

static DetailViewController *sharedDetailViewController = nil;

+(id)sharedDetailView{
    if (!sharedDetailViewController)
    {
        sharedDetailViewController = [[self alloc]init];
    }
    return sharedDetailViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self setupBackgroundForIndex:index];
    
    self.navigationItem.title = theTitle;
    if ([theTitle isEqualToString:@"Put Sphero to sleep"]){
          [startButton setTitle:@"Sleep" forState:UIControlStateNormal];
    }
    
    [super viewDidLoad];
    /*Register for application lifecycle notifications so we known when to connect and disconnect from the robot*/
   
    robotOnline = NO;
    selectionTableView = [[SelectionTableViewController alloc] init];
    clearMacro = [[RKMacroObject alloc]init];
    
    UIImage *im = [UIImage imageNamed:@"spheroI"];
    UIImageView *sphere = [[UIImageView alloc] initWithImage:im];
    sphere.frame = CGRectMake(-60, 420, sphere.frame.size.width, sphere.frame.size.height);
    [self.view addSubview:sphere];
    [self runSpinAnimationOnView:sphere duration:5 rotations:1 repeat:INFINITY];
    
    
    //---------------------------------Different than iPadMainMenuViewController----------------------------------------------//
    adView = [[ADBannerView alloc]initWithFrame:CGRectZero];
    adView.delegate = self;
    adView.frame = CGRectZero;
    adView.frame = CGRectOffset(adView.frame, 0, adView.frame.origin.y + 180.0f);
    // adView.frame =CGRectMake(adView.frame.origin.x, adView.frame.origin.y +50.0, adView.frame.size.width, adView.frame.size.height);
    // adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    //adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    /// [self.view addSubview:adView];
    bannerIsVisible = YES;
    //-----------------------------------------------------------------------------------------------------------------------//

    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationWillTerminate:)
     name:UIApplicationWillTerminateNotification object:app];
   
}
- (void)applicationWillTerminate:(UIApplication *)application {
    /*When the application is entering the background we need to close the connection to the robot*/
    NSLog(@"TERMINATING...");
    [self stopRobot];
    [RKAbortMacroCommand sendCommand];
    [RKStabilizationCommand sendCommandWithState:(RKStabilizationStateOn)];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RKDeviceConnectionOnlineNotification object:nil];
    // Abort the Macros
    [RKAbortMacroCommand sendCommand];
    // Closing the connection will put Sphero back into its default state
    [[RKRobotProvider sharedRobotProvider] closeRobotConnection];
    [[[RKRobotProvider sharedRobotProvider] robot] disconnect];
 }
-(void)setupBackgroundForIndex:(NSInteger)dex{
    
    switch (dex) {
        case 0:
            background.image = [UIImage imageNamed:@"SbgSleep"];
            break;
        case 1:
            background.image = [UIImage imageNamed:@"SbgYellow"];
            break;
        case 2:
            background.image = [UIImage imageNamed:@"SbgLightBlue"];
            break;
        case 3:
            background.image = [UIImage imageNamed:@"sbgGreen"];
            break;
        case 4:
            background.image = [UIImage imageNamed:@"SbgPink"];
            break;
        case 5:
            background.image = [UIImage imageNamed:@"Sbg"];
            break;
        case 6:
            background.image = [UIImage imageNamed:@"SbgOrange"];
            break;
        case 7:
            background.image = [UIImage imageNamed:@"SbgBlue"];
            break;
        case 8:
            background.image = [UIImage imageNamed:@"SbgYellowTeal"];
            break;
        case 9:
            background.image = [UIImage imageNamed:@"SbgRedBlue"];
            break;
        default:
            break;
    }
    
    
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
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCurrentMacro:(RKMacroObject *)inMac{
    currentMacro = inMac;

}

- (IBAction)startButton:(UIButton *)sender {
    if ([startButton.titleLabel.text isEqualToString:@"Start"]){
        [startButton setTitle:@"Stop" forState:UIControlStateNormal];
       
        currentMacro = [allMacros objectAtIndex:index];
        [currentMacro playMacro];
        [RKSaveTemporaryMacroCommand sendCommandWithMacro:[currentMacro generateMacroData] flags:RKMacroFlagEndMarker];
        [RKRunMacroCommand sendCommandWithId:255];
           }
    else if ([startButton.titleLabel.text isEqualToString:@"Stop"]){
        [startButton setTitle:@"Start" forState:UIControlStateNormal];
        [self stopRobot];
       
    }
    else if ([startButton.titleLabel.text isEqualToString:@"Sleep"]){
     
        [currentMacro playMacro];
        
    }

   }
-(void)stopRobot{
    NSLog(@"stopping Robot");
    currentMacro = clearMacro;
    [currentMacro playMacro];
    [currentMacro stopMacro];
    [RKRollCommand sendStop];
    [RKRawMotorValuesCommand sendCommandWithLeftMode:0 leftPower:0 rightMode:0 rightPower:0];
}

-(void)setIndex:(NSInteger )dex{
    index = dex;
}

-(void)setAllMacros:(NSMutableArray *)all{
    allMacros = [[NSMutableArray alloc]init];
    allMacros = all;
}

-(void)viewWillDisappear:(BOOL)animated{
    [self stopRobot];
}

-(void)viewDidDisappear:(BOOL)animated{
    [self stopRobot];
}
///ROBOT STUFF///


-(void)connectToRobot
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRobotOnline) name:RKDeviceConnectionOnlineNotification object:nil];
    if ([[RKRobotProvider sharedRobotProvider] isRobotUnderControl])
    {
        [[RKRobotProvider sharedRobotProvider] openRobotConnection];
        [noSpheroView dismissModalLayerViewControllerAnimated:YES];
    }else
    {
        [[RKRobotProvider sharedRobotProvider] controlConnectedRobot];
    }
}


-(void)setupRobotConnection {
    NSLog(@"SETTING UP CONNECTION");
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
-(void)appDidBecomeActive:(NSNotification*)notification {
    //When the application becomes active after entering the background we try to connect to the robot/
    [self setupRobotConnection];
}
- (void)handleRobotOnline {
    //The robot is now online, we can begin sending commands
    if(!robotOnline) {
        // Send commands to Sphero Here:
       // dc = [RKDriveControl sharedDriveControl];
    }
    robotOnline = YES;
}
- (void)handleRobotOffline {
    if(robotOnline) {
        robotOnline = NO;
        //Put code to update UI for offline here
        [self showNoSpheroConnectedView];
    }
}
-(void)showNoSpheroConnectedView {
    alert = [[UIAlertView alloc] initWithTitle:@"Searching for Sphero" message:@"This app requires Sphero to function properly.  Make sure that the Bluetooth is currently turned on for this device.  If Sphero is not blinking, it may be asleep. Double-shake to  wake it up!" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Get a Sphero", nil];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(self.view.center.x, self.view.center.y+150)];
    [self.view addSubview:spinner];
    [spinner startAnimating];
    if (!isShowing)
    {
        [alert show];
        isShowing = true;
    }
    noSpheroViewShowing = YES;
}

-(void)handleDidGainControl:(NSNotification*)notification {
    NSLog(@"didGainControlNotification");
    [noSpheroView.view removeFromSuperview];
    [spinner removeFromSuperview];
    [alert dismissWithClickedButtonIndex:100 animated:YES];
    
    if(!robotInitialized) return;
    [[RKRobotProvider sharedRobotProvider] openRobotConnection];
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
        view.frame = CGRectMake(1000, 420, view.frame.size.width, view.frame.size.height);
        
    } completion:^(BOOL finished) {
        view.frame = CGRectMake(-60, 420, view.frame.size.width, view.frame.size.height);
        [self runSpinAnimationOnView:view duration:5 rotations:1 repeat:INFINITY];
        
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
