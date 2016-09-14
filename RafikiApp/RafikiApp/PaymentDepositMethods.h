//
//  PaymentDepositMethods.h
//  RafikiApp
//
//  Created by CI-05 on 3/4/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "IQKeyboardManager.h"
#import "IQUIView+IQKeyboardToolbar.h"


@interface PaymentDepositMethods : UIViewController<UIActionSheetDelegate>
{
    
    IBOutlet UITableView *depositTbl;
    IBOutlet UIView *bankPopView;
    IBOutlet UITextField *bankAccountNoTxt;
    IBOutlet UITextField *banckAccountNameTxt;
    IBOutlet UITextField *backIFSCCodeTxt;
    IBOutlet UIButton *addBankButton;
    
    IBOutlet UIView *paypalPopView;
    IBOutlet UITextField *paypalIdTxt;
    IBOutlet UIButton *addPayPalButton;
    
    NSMutableDictionary *allDepositeRecDics;
    int upDateId;
}
- (IBAction)paypalAccountAddAction:(id)sender;
- (IBAction)bankAccountAddAction:(id)sender;
- (IBAction)addMethodAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end
