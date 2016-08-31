//
//  ExpertRateViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/11/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"

#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "ExpertHomeViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "JobHistoryViewController.h"
@interface ExpertRateViewController : UIViewController
{
    IBOutlet DLStarRatingControl *customStarImageControl;
    NSString *starrating;
    IBOutlet UITextView *reviewTxtview;
}

@property(nonatomic,retain)NSMutableArray *getperamArray;
@property(nonatomic,retain)NSString *NotiDataflag;
- (IBAction)cancelAction:(id)sender;
- (IBAction)submitAction:(id)sender;
@end
