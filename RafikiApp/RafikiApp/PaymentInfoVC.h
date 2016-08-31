//
//  PaymentInfoVC.h
//  RafikiApp
//
//  Created by CI-05 on 4/20/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoneSignupVC.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
@interface PaymentInfoVC : UIViewController
{
    
    IBOutlet UITextField *nameTxt;
    IBOutlet UITextField *cardNumberTxt;
    IBOutlet UITextField *cvcTxt;
    IBOutlet UITextField *monthYearTxt;
    IBOutlet UIView *monYearView;
    IBOutlet UIPickerView *monthYearPickerView;
    
    NSMutableArray *monthArray;
    NSMutableArray *yearArray;
    NSString *monthStr;
    NSString *YearStr;
}
- (IBAction)DoneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (IBAction)backAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)skipAction:(id)sender;
@end
