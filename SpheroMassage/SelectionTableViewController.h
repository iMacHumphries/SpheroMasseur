//
//  SelectionTableViewController.h
//  SpheroMassage
//
//  Created by Benjamin Humphries on 3/28/14.
//  Copyright (c) 2014 Benjamin Humphries. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Vibrations.h"
#import <iAd/iAd.h>

@interface SelectionTableViewController : UITableViewController<UITabBarDelegate,UITableViewDataSource,ADBannerViewDelegate,UIActionSheetDelegate>{
   IBOutlet UITableView *tableView;
    NSMutableArray *contentArray;
    Vibrations *v;
    int lastIndex;
    int countDownTime;
    NSTimer *timer;
    UIAlertView *alert;
    IBOutlet ADBannerView *adView;
    BOOL bannerIsVisible;
    BOOL isShowing;
   
}
- (IBAction)info:(UIBarButtonItem *)sender;
@property (retain, nonatomic) IBOutlet ADBannerView *adView;
@property (nonatomic, assign) BOOL bannerIsVisible;
@property (retain,nonatomic) NSTimer *timer;
@property (retain,nonatomic) Vibrations *v;
@property (retain,nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic)NSMutableArray *contentArray;
-(void)putRobotToSleep;
@end
