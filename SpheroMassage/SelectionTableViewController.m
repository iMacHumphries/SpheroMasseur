//
//  SelectionTableViewController.m
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/28/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import "SelectionTableViewController.h"

@interface SelectionTableViewController ()

@end

@implementation SelectionTableViewController
@synthesize tableView;
@synthesize contentArray;
@synthesize v;
@synthesize timer;
@synthesize adView,bannerIsVisible;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        }
    return self;
}

- (void)viewDidLoad
{
     timer = [[NSTimer alloc]init];
    countDownTime = 10;
    v =[[Vibrations alloc]init];
    contentArray = [[NSMutableArray alloc] init];
    contentArray = [v getVibrationNames];
    
    [super viewDidLoad];
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sbg"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    UIImage *im = [UIImage imageNamed:@"spheroI"];
    UIImageView *sphere = [[UIImageView alloc] initWithImage:im];
    sphere.frame = CGRectMake(-60, 420, sphere.frame.size.width, sphere.frame.size.height);
    [self.view addSubview:sphere];
   // [self runSpinAnimationOnView:sphere duration:5 rotations:1 repeat:INFINITY];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    
    
    
    //---------------------------------Different than iPadMainMenuViewController----------------------------------------------//
    adView = [[ADBannerView alloc]initWithFrame:CGRectZero];
    adView.delegate = self;
    adView.frame = CGRectZero;
  //  adView.frame = CGRectOffset(adView.frame, 0, adView.frame.origin.y + 180.0f);
    // adView.frame =CGRectMake(adView.frame.origin.x, adView.frame.origin.y +50.0, adView.frame.size.width, adView.frame.size.height);
    // adView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifierPortrait];
    //adView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    /// [self.view addSubview:adView];
    bannerIsVisible = YES;
    //-----------------------------------------------------------------------------------------------------------------------//
    
    
    
}
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    if (!bannerIsVisible){
        //show
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        //banner.frame = CGRectOffset(banner.frame, 0, -50.0f);
        banner.alpha = 1.0;
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


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.imageView.image = [[v getColorUIImages] objectAtIndex:indexPath.row];
    cell.alpha = 0.5;
    cell.textLabel.text = [contentArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)setLastIndex:(int)ind{
    lastIndex = ind;
}
-(void)putRobotToSleep{
   
    countDownTime = 10;
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(countDown) userInfo:nil repeats: YES];
     alert = [[UIAlertView alloc]initWithTitle:@"Goodnight!" message:[NSString stringWithFormat:@"Sphero is going to sleep in %i",countDownTime] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alert show];
    
}
-(void)countDown{
    countDownTime = countDownTime -1;
    [alert setMessage:[NSString stringWithFormat:@"Sphero is going to sleep in %i",countDownTime]];
    NSLog(@"countdown %i",countDownTime);
   
    if (countDownTime <= 0) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
            }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
       if (buttonIndex == 0)
    {
        [timer invalidate];
        countDownTime = 10;
        

    }else {
        [RKMCSleep commandWithDelay:0];

    }
   
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detail"]){
        DetailViewController *detail = [segue destinationViewController];
        detail.theTitle = [contentArray objectAtIndex:tableView.indexPathForSelectedRow.row];
        [detail setCurrentMacro:[[v getAllVibrations] objectAtIndex:tableView.indexPathForSelectedRow.row]];
        NSInteger x = tableView.indexPathForSelectedRow.row;
        [detail setIndex:x];
        v =[[Vibrations alloc]init];
        [detail setAllMacros:[v getAllVibrations]];
    }
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
        view.frame = CGRectMake(1000, 420, view.frame.size.width, view.frame.size.height);
        
    } completion:^(BOOL finished) {
        view.frame = CGRectMake(-60, 420, view.frame.size.width, view.frame.size.height);
        [self runSpinAnimationOnView:view duration:5 rotations:1 repeat:INFINITY];
        
    }];
    
}
- (IBAction)info:(UIBarButtonItem *)sender {
    
    
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:@"Options" delegate:self
                                              cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Get Sphero!",@"Marz Software on Facebook",@"Rate Sphero Masseur",nil];
    [action showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing = YES;
    switch (buttonIndex) {
        case 0:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://store.gosphero.com"]];
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/MarzSoftware"]];
            break;
        case 2:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?type=Purple+Software&id=854838472"]];
            break;
            
    }
}

@end
