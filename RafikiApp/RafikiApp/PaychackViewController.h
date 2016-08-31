//
//  PaychackViewController.h
//  RafikiApp
//
//  Created by CI-05 on 2/4/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "PaychackCell.h"

#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#import "TrasactionViewController.h"
#import "PaymentDepositMethods.h"
@interface PaychackViewController : UIViewController
{
    
    IBOutlet UIButton *sliderButton;
    IBOutlet UIView *segmentView;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UITableView *payTbl;
    IBOutlet UIButton *transactionButton;
    IBOutlet UILabel *amountLbl;
    
    NSDate *thisWeek;
    NSDate *thisMonth;
    NSMutableArray *payChackAll;
    
    NSString *chackSegmentStr;
}
- (IBAction)addSettingPayAction:(id)sender;
- (IBAction)transcationAction:(id)sender;
- (IBAction)paychackSegmentAction:(id)sender;
@end
