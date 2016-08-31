//
//  RateViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/9/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"

#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "JobHistoryViewController.h"

#import "BraintreeCore.h"
#import "BraintreeUI.h"
#import "BraintreePayPal.h"

@interface RateViewController : UIViewController<BTDropInViewControllerDelegate,BTAppSwitchDelegate, BTViewControllerPresentingDelegate>
{
    IBOutlet DLStarRatingControl *customStarImageControl;
    NSString *starrating;
    IBOutlet UITextView *reviewTxtview;
    NSString *final;
}
@property(nonatomic,retain)NSString *NotiDataflag;
@property (nonatomic, strong) BTPayPalDriver *payPalDriver;
@property (nonatomic, strong) BTAPIClient *braintreeClient;
@property(nonatomic,retain)NSMutableArray *getperamArray;
- (IBAction)cancelAction:(id)sender;
- (IBAction)submitAction:(id)sender;
@end
