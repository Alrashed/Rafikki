//
//  DeskBoardController.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "PastJobCell.h"
#import "hireRequestCell.h"

#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "CommonShowJobView.h"
#import "TreckerViewController.h"
#import "JobHistoryViewController.h"

#import <Stripe/Stripe.h>
@interface DeskBoardController : UIViewController<STPPaymentCardTextFieldDelegate>
{
    
    IBOutlet UIButton *sliderButton;
    IBOutlet UITableView *deskTbl;
    NSString *chackDeskFlag;
    NSMutableArray *hireReqarray;
    NSMutableArray *ongoingReqarray;
    NSMutableArray *upcommingReqArray;
    NSMutableArray *pastReqArray;
    NSMutableArray *countedReqArray;
    long cancelTag;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UIView *segmentView;
    IBOutlet UILabel *totalCountedLbl;
    
    NSTimer *upcomingContDown;
    long acceptTag;
    IBOutlet UIView *paymentView;
    IBOutlet UIView *paymentPopView;
    IBOutlet UIImageView *paymentBg;
    IBOutlet UILabel *paymentTitleLb;
    IBOutlet UIImageView *lineImg;
    IBOutlet UIImageView *paymentIconImg;
    IBOutlet UIButton *paymentBtn;
    IBOutlet UILabel *paymentDiscripLbl;
    
}
@property (strong, nonatomic) IBOutlet STPPaymentCardTextField *paymentDetailTxt;
- (IBAction)paymentAction:(id)sender;
- (IBAction)jobHistoryAction:(id)sender;
- (IBAction)activityAction:(id)sender;
@property (retain, nonatomic) DVSwitch *switcher;
@end
