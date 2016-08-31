//
//  TreckerViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/22/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "ExpertRateViewController.h"
#import <Stripe/Stripe.h>

@interface TreckerViewController : UIViewController<UIAlertViewDelegate,STPPaymentCardTextFieldDelegate>
{
    
    IBOutlet UIButton *stopButton;

    IBOutlet UILabel *timeLbl;
    NSString *final;
    NSMutableDictionary *paymentResponseDics;
    NSMutableArray *currentJobArray;
    IBOutlet UIView *paymentView;
    IBOutlet UIButton *payBtn;
}
- (IBAction)payBtnAction:(id)sender;
- (IBAction)paymentBackAction:(id)sender;

@property (strong, nonatomic) STPPaymentCardTextField *paymentTextField;
@property(assign)BOOL acceptCreditCards;
@property(nonatomic,retain)NSMutableArray *getperamArray;
@property(nonatomic,retain)NSString *environment;
- (IBAction)backAction:(id)sender;
- (IBAction)stopAction:(id)sender;
@end
