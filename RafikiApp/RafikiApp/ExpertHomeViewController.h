//
//  ExpertHomeViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/8/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "PastJobCell.h"
#import "hireRequestCell.h"

#import "MBProgressHUD.h"
#import <MapKit/MapKit.h>
#import "ExpertRateViewController.h"

#import "JobHistoryViewController.h"
#import "UUDatePicker.h"


@interface ExpertHomeViewController : UIViewController<CLLocationManagerDelegate>
{
    IBOutlet UIButton *sliderButton;
    IBOutlet UITableView *deskTbl;
    NSString *chackDeskFlag;
    NSMutableArray *hireReqarray;
    NSMutableArray *ongoingReqarray;
    NSMutableArray *upCommingReqarray;
    NSMutableArray *pastReqArray;

    long cancelTag;
    long acceptTag;
    CLLocationManager *locationManager;

    IBOutlet UIView *segmentView;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UIView *changeTimePopView;
    IBOutlet UIButton *changeButton;
    IBOutlet UIButton *oldTimeButton;
    IBOutlet UIButton *newTimeButton;
    
    IBOutlet UIView *dateView;
    NSString *dateAndTimeStr;
    NSString *inviteIdStr;
    
    NSTimer *upcomingContDown;
}
- (IBAction)newTimeAction:(id)sender;

- (IBAction)doneAction:(id)sender;
- (IBAction)datePickerCancelAction:(id)sender;


- (IBAction)changeTimeAction:(id)sender;
- (IBAction)pastJobAction:(id)sender;
- (IBAction)segmentAction:(id)sender;
@property (retain, nonatomic) DVSwitch *switcher;
@end
